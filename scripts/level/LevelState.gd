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
	if Input.is_action_just_pressed("right_click"):
		print(get_global_mouse_position());
	
### Logic
func establishParty():
	party = SOURCE_OF_TRUTH.getParty();
	partyMembers = SOURCE_OF_TRUTH.getPartyMembers();

func initialSetCurrentCharacter():
	currentCharacter = partyMembers[0];
	currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass();
	

func chooseCharacter():
	establishParty();
	
	if Input.is_action_just_pressed("cycle_up"):
		if partyMembers.size() == 3:
			if characterNumber < 2:
				characterNumber += 1;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass();
			else:
				characterNumber = 0;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass()
				
		if partyMembers.size() == 2:
			if characterNumber < 1:
				characterNumber += 1;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass();
			else:
				characterNumber = 0;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass()
		
	if Input.is_action_just_pressed("cycle_down"):
		if partyMembers.size() == 3:
			if characterNumber < 1:
				characterNumber = 2;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass();
			else:
				characterNumber -= 1;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass()
				
		if partyMembers.size() == 2:
			if characterNumber < 1:
				characterNumber += 1;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass();
			else:
				characterNumber -= 1;
				currentCharacter = partyMembers[characterNumber];
				currentCharacterClass = currentCharacter.get_node("Class").returnCharacterClass()
		
		

func returnCurrentCharacter():
	return currentCharacter;
	
func returnCurrentCharacterClass():
	return currentCharacterClass;
