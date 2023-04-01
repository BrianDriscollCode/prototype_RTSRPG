extends Node


var characterClass = "Knight";
onready var parent = get_node("../../Knight");

onready var timer1 = get_node("../KnightTimer1");
onready var timer2 = get_node("../KnightTimer2");
onready var timer3 = get_node("../KnightTimer3");
onready var timer4 = get_node("../KnightTimer4");
onready var timer5 = get_node("../KnightTimer5");
onready var timer6 = get_node("../KnightTimer6");

var canAttack = false;
onready var sword = get_node("Sword");
onready var swordAnimation = get_node("Sword/AnimationPlayer");
onready var swordCollision= get_node("SwordArea/SwordCollider");
onready var stabEffect = get_node("StabEffect");

onready var animatedSprite = get_node("../AnimatedSprite");

#choosers
onready var characterActionsMenu = get_node("CharacterActionsMenu");
var currentSelectedAction;
var characterActions = [];
var currentCharacter = false;
onready var choosersGroup = get_node("choosersGroup");
var handChoosers = [];
var chooserPosition = 0;
var currentSkill;
	

func _ready():
	checkIfCurrent();
	aggregateCharacterActions();
	aggregateChoosers();
	currentSkill = parent.exportCurrentSkill();
	sword.set_visible(false);
	stabEffect.set_visible(false);
	

	
func _process(delta):
	if Input.is_action_just_pressed("test_skill") && currentCharacter && currentSkill == "Sword" && canAttack:
		swordAnimation.play("stab");
		sword.set_visible(true);
		animatedSprite.play("stab");
		parent.resetTurnProgress();
		toggleAttackStatus();
		
	checkIfCurrent();
	showCharacterActionsMenu();
	showSpecificHandChooser();
	toggleChooser();
	currentSkill = parent.exportCurrentSkill();
		
func aggregateCharacterActions():
	for item in characterActionsMenu.get_children():
		characterActions.append(item);
	currentSelectedAction = characterActions[0].exportName(); 
		
func showCharacterActionsMenu():
	if currentCharacter && canAttack == true:
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
	if currentCharacter && canAttack == true:
		handChoosers[chooserPosition].set_visible(true);
	elif !currentCharacter || canAttack == false:
		handChoosers[chooserPosition].set_visible(false);
		
func toggleChooser():
	if Input.is_action_just_pressed("skill_toggle") && currentCharacter:
		if chooserPosition < 1:
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

func returnCharacterClass():
	return characterClass;

func returnCurrentSelectedAction():
	return currentSelectedAction;

func restartTimers():
	timer1.start();
	timer2.start();
	timer3.start();
	timer4.start();
	timer5.start();
	timer6.start();


func _on_AnimationPlayer_animation_finished(anim_name):
	stabEffect.set_visible(true);
	stabEffect.play("default");
	stabEffect.frame = 0
	swordCollision.set_disabled(false);


func _on_StabEffect_animation_finished():
	stabEffect.set_visible(false);
	animatedSprite.play("default");
	swordCollision.set_disabled(true);
	sword.set_visible(false);
