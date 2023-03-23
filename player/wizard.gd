extends Node


var characterClass = "Wizard";
onready var parent = get_node("../../Wizard");
var currentCharacter;


#Character Actions
onready var characterActionsMenu = get_node("CharacterActionsMenu");
var characterActions = [];

#Choosers
onready var choosersGroup = get_node("choosersGroup");
var handChoosers = [];
var chooserPosition = 0;


#Timers
onready var timer1 = get_node("../WizardTimer1");
onready var timer2 = get_node("../WizardTimer2");
onready var timer3 = get_node("../WizardTimer3");
onready var timer4 = get_node("../WizardTimer4");
onready var timer5 = get_node("../WizardTimer5");
onready var timer6 = get_node("../WizardTimer6");
onready var timer7 = get_node("../WizardTimer7");
onready var timer8 = get_node("../WizardTimer8");
onready var timer9 = get_node("../WizardTimer9");
onready var timer10 = get_node("../WizardTimer10");

func _ready():
	checkIfCurrent();
	aggregateCharacterActions();
	aggregateChoosers();
	
	
func _process(_delta):
	checkIfCurrent();
	showCharacterActionsMenu();
	showSpecificHandChooser();
	toggleChooser();
		
func aggregateCharacterActions():
	for item in characterActionsMenu.get_children():
		characterActions.append(item);
		
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
		if chooserPosition < 2:
			handChoosers[chooserPosition].set_visible(false);
			chooserPosition += 1;
			handChoosers[chooserPosition].set_visible(true);
		else:
			handChoosers[chooserPosition].set_visible(false);
			chooserPosition = 0;
			handChoosers[chooserPosition].set_visible(true);
	elif Input.is_action_just_pressed("skill_toggle") && !currentCharacter:
		handChoosers[chooserPosition].set_visible(false);

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
	timer8.start();
	timer9.start();
	timer10.start();

