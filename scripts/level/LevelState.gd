extends Node2D

onready var SOURCE_OF_TRUTH = get_node("../SOURCE_OF_TRUTH");

#Source of Truth Variables
var party;
var partyMembers;

#Level State Variables
var currentCharacter;
var currentCharacterClass;
var characterNumber = 0;

### Lifecycle
func _ready():
	establishParty();
	initialSetCurrentCharacter();
	
		
func _process(_delta):
	chooseCharacter();
	
### Logic
func establishParty():
	party = SOURCE_OF_TRUTH.getParty();
	partyMembers = SOURCE_OF_TRUTH.getPartyMembers();

func initialSetCurrentCharacter():
	currentCharacter = partyMembers[0];
	currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	

func chooseCharacter():
	if Input.is_action_just_pressed("character_1"):
		currentCharacter = partyMembers[0];
		characterNumber = 0;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
		print(SOURCE_OF_TRUTH.getPartyMembers());
	if Input.is_action_just_pressed("character_2"):
		currentCharacter = partyMembers[1];
		characterNumber = 1;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	if Input.is_action_just_pressed("character_3"):
		currentCharacter = partyMembers[2];
		characterNumber = 2;
		currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
	
	if Input.is_action_just_pressed("cycle_characters"):
		if characterNumber < 2:
			characterNumber += 1;
			currentCharacter = partyMembers[characterNumber];
			currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();
		else:
			characterNumber = 0;
			currentCharacter = partyMembers[characterNumber];
			currentCharacterClass = currentCharacter.get_node("class").returnCharacterClass();

func returnCurrentCharacter():
	return currentCharacter;
	
func returnCurrentCharacterClass():
	return currentCharacterClass;
