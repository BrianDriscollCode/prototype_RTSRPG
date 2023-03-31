extends Node


var characterClass = "Knight";
onready var timer1 = get_node("../KnightTimer1");
onready var timer2 = get_node("../KnightTimer2");
onready var timer3 = get_node("../KnightTimer3");
onready var timer4 = get_node("../KnightTimer4");
onready var timer5 = get_node("../KnightTimer5");
onready var timer6 = get_node("../KnightTimer6");


onready var sword = get_node("Sword");
onready var swordAnimation = get_node("Sword/AnimationPlayer");

func _ready():
	print("Ready");

	
func _process(delta):
	if Input.is_action_just_pressed("test_skill"):
		swordAnimation.play("Sword");
		print("Sword Attacked");

func returnCharacterClass():
	return characterClass;

func returnCurrentSelectedAction():
	return "none";

func restartTimers():
	timer1.start();
	timer2.start();
	timer3.start();
	timer4.start();
	timer5.start();
	timer6.start();
