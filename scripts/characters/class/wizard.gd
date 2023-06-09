extends Node

onready var SOURCE_OF_TRUTH = get_node("../../../SOURCE_OF_TRUTH");
onready var level = get_node("../../../../Level");

var characterClass = "Wizard";
onready var parent = get_node("../../Wizard");
var currentCharacter;
onready var animatedSprite = get_node("../AnimatedSprite");

var health = 10;
onready var healthBar = get_node("../healthProgressBar");

#Character Actions
var actionProgressBar = preload("res://ui/ActionProgressBar.tscn");
onready var characterActionsMenu = get_node("CharacterActionsMenu");
var characterActions = [];
var currentSelectedAction;
var actionInProgress = false;
var selectedPosition;
var canAttack = false;

#Choosers
onready var choosersGroup = get_node("choosersGroup");
var handChoosers = [];
var chooserPosition = 0;
var currentSkill;

#spells
var burnFire = preload("res://player/skills/mage/BurnFire.tscn")
var explosion = preload("res://player/skills/mage/explosion.tscn")

#Animation
onready var animationPlayer = get_node("../AnimationPlayer");

#Sounds
onready var HitVoice = get_node("../HitVoice");

#Timers
onready var timer1 = get_node("../WizardTimer1");
onready var timer2 = get_node("../WizardTimer2");
onready var timer3 = get_node("../WizardTimer3");
onready var timer4 = get_node("../WizardTimer4");
onready var timer5 = get_node("../WizardTimer5");
onready var timer6 = get_node("../WizardTimer6");
onready var timer7 = get_node("../WizardTimer7");

func _ready():
	checkIfCurrent();
	aggregateCharacterActions();
	aggregateChoosers();
	currentSkill = parent.exportCurrentSkill();
	
	
func _process(_delta):
	checkIfCurrent();
	showCharacterActionsMenu();
	showSpecificHandChooser();
	toggleChooser();
	startAction();
	currentSkill = parent.exportCurrentSkill();
	
func startAction():
	if currentCharacter && Input.is_action_just_pressed("test_skill") && !actionInProgress && currentSkill == "BurnFire" && canAttack:
		canAttack = false;
		parent.resetTurnProgress();
		actionInProgress = true
		animatedSprite.play("cast")
		selectedPosition = SOURCE_OF_TRUTH.getConvertedMousePosition();
		var progressBarInstance = actionProgressBar.instance();
		progressBarInstance.set_position(Vector2(-8,-18));
		parent.add_child(progressBarInstance);
		progressBarInstance.set_visible(true);
		var tween = get_tree().create_tween();
		tween.tween_property(progressBarInstance, "value", 100, 3).set_trans(Tween.TRANS_LINEAR);
		yield(tween, "finished");
		progressBarInstance.queue_free();
		animatedSprite.play("finish_cast");
		animatedSprite.connect("animation_finished", self, "playDefault");
		actionInProgress = false;
		restartTimers();

func playDefault():
	burnFire();
	animatedSprite.play("default");
	animatedSprite.disconnect("animation_finished", self, "playDefault")
	
func burnFire():
	var spellInstance = burnFire.instance();
	spellInstance.set_position(selectedPosition - Vector2(-8, -7));
	level.add_child(spellInstance);

func printWords():
	actionProgressBar.queue_free();
		
func aggregateCharacterActions():
	for item in characterActionsMenu.get_children():
		characterActions.append(item);
	currentSelectedAction = characterActions[0].exportName(); 
		
func showCharacterActionsMenu():
	if currentCharacter && canAttack:
		for item in characterActions:
			item.set_visible(true);
	else:
		for item in characterActions:
			item.set_visible(false);
			
func checkIfCurrent():
	currentCharacter = parent.exportCurrentState();
	
func aggregateChoosers():
	for item in choosersGroup.get_children():
		handChoosers.append(item);		

func showSpecificHandChooser():
	if currentCharacter && canAttack:
		handChoosers[chooserPosition].set_visible(true);
	elif !currentCharacter || !canAttack:
		handChoosers[chooserPosition].set_visible(false);
		
func toggleChooser():
	if Input.is_action_just_pressed("skill_toggle") && currentCharacter && canAttack:
		if chooserPosition < 2:
			handChoosers[chooserPosition].set_visible(false);
			chooserPosition += 1;
			handChoosers[chooserPosition].set_visible(true);
			currentSelectedAction = characterActions[chooserPosition].exportName(); 
		else:
			handChoosers[chooserPosition].set_visible(false);
			chooserPosition = 0;
			handChoosers[chooserPosition].set_visible(true);
			currentSelectedAction = characterActions[chooserPosition].exportName(); 
	elif Input.is_action_just_pressed("skill_toggle") && !currentCharacter:
		handChoosers[chooserPosition].set_visible(false);
		
func toggleAttackStatus():
	canAttack = !canAttack;
		
func exportHealth(): 
	return health;	
	
func exportAttackStatus():
	return canAttack;
		
func returnCurrentSelectedAction():
	return currentSelectedAction;

func returnCharacterClass():
	return characterClass;

func restartTimers():
	timer1.start();
	timer2.start();
	timer3.start();
	timer4.start();
	timer5.start();
	timer6.start();
	timer7.start();



func _on_Area2D_area_entered(area):
	healthBar.value -= 10;
	HitVoice.play();
	animationPlayer.play("hit");
	health -= 10;
	if health < 10:
		animatedSprite.set_playing(false);
		animationPlayer.play("Death");
	
