extends Node

var canAttack = false;
var characterClass = "Rogue";
onready var timer1 = get_node("../RogueTimer1");
onready var timer2 = get_node("../RogueTimer2");
onready var timer3 = get_node("../RogueTimer3");
onready var timer4 = get_node("../RogueTimer4");

var health = 10;
onready var healthBar = get_node("../healthProgressBar");

func returnCharacterClass():
	return characterClass;
	
func returnCurrentSelectedAction():
	return "none";
	
func toggleAttackStatus():
	canAttack = !canAttack;
	
func restartTimers():
	timer1.start();
	timer2.start();
	timer3.start();
	timer4.start();

func exportHealth(): 
	return health;
	
func exportAttackStatus():
	return canAttack;
	
func _on_Area2D_area_entered(area):
	healthBar.value -= 10;
	health -= 10;
