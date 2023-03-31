extends Node


var characterClass = "Knight";
onready var parent = get_node("../../Knight");

onready var timer1 = get_node("../KnightTimer1");
onready var timer2 = get_node("../KnightTimer2");
onready var timer3 = get_node("../KnightTimer3");
onready var timer4 = get_node("../KnightTimer4");
onready var timer5 = get_node("../KnightTimer5");
onready var timer6 = get_node("../KnightTimer6");


onready var sword = get_node("Sword");
onready var swordAnimation = get_node("Sword/AnimationPlayer");
onready var swordCollision= get_node("SwordArea/SwordCollider");


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

	
func _process(delta):
	if Input.is_action_just_pressed("test_skill") && currentCharacter && currentSkill == "Sword":
		swordAnimation.play("Sword");
		swordCollision.set_disabled(false);
	checkIfCurrent();
	showCharacterActionsMenu();
	showSpecificHandChooser();
	toggleChooser();
	currentSkill = parent.exportCurrentSkill();
	print(currentSkill)
		
func aggregateCharacterActions():
	for item in characterActionsMenu.get_children():
		characterActions.append(item);
	currentSelectedAction = characterActions[0].exportName(); 
		
func showCharacterActionsMenu():
	if currentCharacter:
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
	if currentCharacter:
		handChoosers[chooserPosition].set_visible(true);
	elif !currentCharacter:
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
	swordCollision.set_disabled(true);
