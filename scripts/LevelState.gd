extends Node2D

onready var party = get_node("../Party");
var currentCharacter;
var allCharacters = [];

### Lifecycle
func _ready():
	loadCharactersIntoArray();
		
func _process(delta):
	chooseCharacter();
	
### Logic
func loadCharactersIntoArray():
	for item in party.get_children():
		allCharacters.append(item);
	currentCharacter = allCharacters[0];

func chooseCharacter():
	if Input.is_action_just_pressed("character_1"):
		currentCharacter = allCharacters[0];
	if Input.is_action_just_pressed("character_2"):
		currentCharacter = allCharacters[1];

func returnCurrentCharacter():
	return currentCharacter;
