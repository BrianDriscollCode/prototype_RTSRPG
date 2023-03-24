extends Node

onready var tileMap = get_node("../TileMap");
onready var movementTiles = get_node("../MovementTiles");
var tileArray = [];

var mousePosition;
var convertedMousePosition;

var party;
var partyMembers = [];

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
		partyMembers.append(member);
	
	return partyMembers;

func getTiles():
	tileArray = [];
	print(tileMap)
	for tile in movementTiles.get_children():
		tileArray.append(tile);
	return tileArray;

		
	
	

	
	
