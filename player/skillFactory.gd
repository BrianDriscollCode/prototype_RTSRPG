extends Node2D

#Level
onready var level = get_node("../../../../Level");

#SOURCE_OF_TRUTH
onready var SOURCE_OF_TRUTH = get_node("../../../SOURCE_OF_TRUTH");
onready var LevelState = get_node("../../../LevelState");

#spells
var burnFire = preload("res://player/skills/mage/BurnFire.tscn")
var explosion = preload("res://player/skills/mage/explosion.tscn")

func _ready():
	pass # Replace with function body.

func burnFire():
	var spellInstance = burnFire.instance();
	spellInstance.set_position(SOURCE_OF_TRUTH.getConvertedMousePosition() - Vector2(-8, -7));
	level.add_child(spellInstance);


