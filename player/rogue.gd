extends Node


var characterClass = "Rogue";
onready var timer1 = get_node("../RogueTimer1");
onready var timer2 = get_node("../RogueTimer2");
onready var timer3 = get_node("../RogueTimer3");

func returnCharacterClass():
	return characterClass;
	
func restartTimers():
	timer1.start();
	timer2.start();
	timer3.start();
