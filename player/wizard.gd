extends Node


var characterClass = "Wizard";
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
