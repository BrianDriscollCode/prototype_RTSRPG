extends Node2D

onready var SOURCE_OF_TRUTH = get_node("../SOURCE_OF_TRUTH"); 

var currentCharacter;
var currentCharacterClass;
onready var levelState = get_node("../LevelState");

var arrowIndicators = preload("res://ui/ArrowIndicator.tscn");

#Tiles and Mouse Position
var mousePosition;
var convertedMousePosition;
var highlightTiles = [];
onready var tileMap = get_node("../TileMap");

#Player position and move positions
var playerPosition;
var convertedPlayerPosition;
var viableMove = false;

func _ready():
	for item in self.get_children():
		item.set_visible(false)
		highlightTiles.append(item);
	getCurrentPlayer();


func _process(_delta):
	matchToTile();
	getCurrentPlayer();
	showPlayerMovementRange();
	checkIfMoveViable();
	showArrows()
	
func showArrows():
	var arrows = arrowIndicators.instance();
#	tileMap.add_child(arrowIndicators);
	

func matchToTile():
	mousePosition = SOURCE_OF_TRUTH.getMousePosition();
	convertedMousePosition = tileMap.world_to_map(mousePosition)
	# Loop through tiles to see which matches mouse position, thne make visible
	for item in highlightTiles:
		item.set_visible(false)
		if convertedMousePosition == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
			if viableMove:
				item.set_self_modulate(Color(1, 35, 1, 0.01))
			else:
				item.set_self_modulate(Color(90, 1, 1, 0.01))
		else:
			item.set_self_modulate(Color(6, 22, 1, 0.01))
	
func getCurrentPlayer():
	currentCharacter = levelState.returnCurrentCharacter();
	currentCharacterClass = levelState.returnCurrentCharacterClass();
	
func showPlayerMovementRange():
	viableMove = false;
	playerPosition = currentCharacter.global_position;
	convertedPlayerPosition = tileMap.world_to_map(playerPosition);
	var allMoves = aggregateViablePlayerMoves(currentCharacterClass);
	
	var canMove = getCanCharacterMove();

	for item in highlightTiles:
		var currentTile = tileMap.world_to_map(item.global_position);
		if canMove:
			if convertedPlayerPosition == currentTile:
				item.set_visible(true)
			for position in allMoves:
				if position == currentTile:
					item.set_visible(true);
	
func aggregateViablePlayerMoves(characterClass):
	var right1;
	var right2;
	var right3;
	var left1;
	var left2;
	var left3;
	var up1;
	var up2;
	var up3;
	var down1;
	var down2;
	var down3;
	
	if characterClass == "Wizard": 
		right1 = convertedPlayerPosition + Vector2(1, 0)
		right2 = convertedPlayerPosition + Vector2(2, 0)
		left1 = convertedPlayerPosition - Vector2(1, 0)
		left2 = convertedPlayerPosition - Vector2(2, 0)
		up1 = convertedPlayerPosition + Vector2(0, 1)
		up2 = convertedPlayerPosition + Vector2(0, 2)
		down1 = convertedPlayerPosition - Vector2(0, 1)
		down2 = convertedPlayerPosition - Vector2(0, 2)
		return [right1, right2, left1, left2, up1, up2, down1, down2];
	
	if characterClass == "Knight": 
		right1 = convertedPlayerPosition + Vector2(1, 0)
		left1 = convertedPlayerPosition - Vector2(1, 0)
		up1 = convertedPlayerPosition + Vector2(0, 1)
		down1 = convertedPlayerPosition - Vector2(0, 1)
		return [right1, left1, up1, down1];
		
	if characterClass == "Rogue": 
		right1 = convertedPlayerPosition + Vector2(1, 0)
		right2 = convertedPlayerPosition + Vector2(2, 0)
		right3 = convertedPlayerPosition + Vector2(3, 0)
		left1 = convertedPlayerPosition - Vector2(1, 0)
		left2 = convertedPlayerPosition - Vector2(2, 0)
		left3 = convertedPlayerPosition - Vector2(3, 0)
		up1 = convertedPlayerPosition + Vector2(0, 1)
		up2 = convertedPlayerPosition + Vector2(0, 2)
		up3 = convertedPlayerPosition + Vector2(0, 3)
		down1 = convertedPlayerPosition - Vector2(0, 1)
		down2 = convertedPlayerPosition - Vector2(0, 2)
		down3 = convertedPlayerPosition - Vector2(0, 3)
		return [right1, right2, right3, left1, left2, left3, up1, up2, up3, down1, down2, down3];
	
func checkIfMoveViable(): 
	var allViableMoves = aggregateViablePlayerMoves(currentCharacterClass);
	for move in allViableMoves:
		if convertedMousePosition == move:
			viableMove = true;

func exportViableMove():
	return viableMove;
	
func getCanCharacterMove():
	return currentCharacter.exportCanMove();
	
func exportConvertedPlayerPosition():
	return convertedPlayerPosition;
	
func exportViableTilePositions():
	var viableTilesArray = [];
	for tile in highlightTiles:
		viableTilesArray.append(tileMap.world_to_map(tile.get_global_position()))
	return viableTilesArray;
		
