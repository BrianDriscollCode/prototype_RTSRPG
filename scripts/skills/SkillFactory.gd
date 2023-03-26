extends Node2D

#Level
onready var level = get_node("../../Level");

#SOURCE_OF_TRUTH
onready var SOURCE_OF_TRUTH = get_node("../SOURCE_OF_TRUTH");
onready var LevelState = get_node("../LevelState");

#spells
var burnFire = preload("res://player/skills/mage/BurnFire.tscn")
var explosion = preload("res://player/skills/mage/explosion.tscn")

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	wizardSpells("test");

		
func wizardSpells(spell):
	if Input.is_action_just_pressed("test_skill") && LevelState.returnCurrentCharacterClass() == "Wizard":
		var spellInstance = burnFire.instance();
		var wizard = get_node("../Party/Wizard");
		wizard.startAction();
		spellInstance.set_position(SOURCE_OF_TRUTH.getConvertedMousePosition() - Vector2(-8, -7));
		level.add_child(spellInstance);
		print(SOURCE_OF_TRUTH.getConvertedMousePosition())


