extends Node

onready var tileMap = get_node("../TileMap");
onready var movementTiles = get_node("../MovementTiles");
var tileArray = [];

var mousePosition;
var convertedMousePosition;

var party;
var partyMembers = [];
var partyMemberPositions = [];
var characterState = [];

func _ready():
	getParty();
	getPartyMembers();
	getPartyMemberPositions();
#func _process(_delta):
#	getCharacterState();
	

func getMousePosition():
	mousePosition = get_viewport().get_mouse_position();
	return mousePosition;
	
func getConvertedMousePosition():
	mousePosition = get_viewport().get_mouse_position();
	convertedMousePosition = tileMap.world_to_map(mousePosition);
	convertedMousePosition = tileMap.map_to_world(convertedMousePosition)
	return convertedMousePosition;

func getParty():
	party = get_node("../Party");
	return party;
	
func getPartyMembers():
	party = get_node("../Party");
	partyMembers = [];
	for member in party.get_children():
		if !(member.get_node("Class").exportHealth() <= 0):
			partyMembers.append(member);
	
	return partyMembers;
	
func getPartyMemberPositions():
	partyMemberPositions = [];
	for member in partyMembers:
		if !(member.get_node("Class").exportHealth() <= 0):
			var member_position = tileMap.world_to_map(member.get_global_position());
			partyMemberPositions.append(member_position);
	return partyMemberPositions;
		
func getTiles():
	tileArray = [];
	print(tileMap)
	for tile in movementTiles.get_children():
		tileArray.append(tile);
	return tileArray;

func getCharacterState():
	for character in partyMembers:
		characterState.append(character.exportCharacterState());
	print(characterState);
	

	
	
