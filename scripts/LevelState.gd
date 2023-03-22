extends Node2D

onready var party = get_node("../Party");
var currentCharacter;
var currentCharacterClass;
var characterNumber = 0;
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
	currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	

func chooseCharacter():
	if Input.is_action_just_pressed("character_1"):
		currentCharacter = allCharacters[0];
		characterNumber = 0;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	if Input.is_action_just_pressed("character_2"):
		currentCharacter = allCharacters[1];
		characterNumber = 1;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	if Input.is_action_just_pressed("character_3"):
		currentCharacter = allCharacters[2];
		characterNumber = 2;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	
	if Input.is_action_just_pressed("cycle_characters"):
		if characterNumber < 2:
			characterNumber += 1;
			currentCharacter = allCharacters[characterNumber];
			currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
		else:
			characterNumber = 0;
			currentCharacter = allCharacters[characterNumber];
			currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();

func returnCurrentCharacter():
	return currentCharacter;
	
func returnCurrentCharacterClass():
	return currentCharacterClass;
