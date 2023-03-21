extends Node2D

#Current Player
var currentCharacter;
onready var levelState = get_node("../LevelState");

#Tiles and Mouse Position
var mousePosition;
var convertedMousePosition;
var highlightTiles = [];
onready var tileMap = get_node("../TileMap");
onready var tiles = get_node("../TileMap").get_used_cells();

#Player position and move positions
var playerPosition;
var convertedPlayerPosition;
var right1; var right2; var left1; var left2; var up1; var up2; var down1; var down2
var viableMove = false;

func _ready():
	for item in self.get_children():
		item.set_visible(false)
		highlightTiles.append(item);
	getCurrentPlayer();


func _process(delta):
	matchToTile();
	getCurrentPlayer();
	showPlayerMovementRange();
	checkIfMoveViable();
	

func matchToTile():
	mousePosition = get_viewport().get_mouse_position()
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
	
func showPlayerMovementRange():
	viableMove = false;
	playerPosition = currentCharacter.global_position;
	convertedPlayerPosition = tileMap.world_to_map(playerPosition);
	var allMoves = aggregateViablePlayerMoves();
	
	var canMove = getCanCharacterMove();

	for item in highlightTiles:
		var currentTile = tileMap.world_to_map(item.global_position);
		if canMove:
			if convertedPlayerPosition == currentTile:
				item.set_visible(true)
			if right1 == currentTile:
				item.set_visible(true)
			if right2 == currentTile:
				item.set_visible(true)
			if left1 == currentTile:
				item.set_visible(true)
			if left2 == currentTile:
				item.set_visible(true)
			if up1 == currentTile:
				item.set_visible(true)
			if up2 == currentTile:
				item.set_visible(true)
			if down1 == currentTile:
				item.set_visible(true)
			if down2 == currentTile:
				item.set_visible(true)

	
func aggregateViablePlayerMoves():
	right1 = convertedPlayerPosition + Vector2(1, 0)
	right2 = convertedPlayerPosition + Vector2(2, 0)
	left1 = convertedPlayerPosition - Vector2(1, 0)
	left2 = convertedPlayerPosition - Vector2(2, 0)
	up1 = convertedPlayerPosition + Vector2(0, 1)
	up2 = convertedPlayerPosition + Vector2(0, 2)
	down1 = convertedPlayerPosition - Vector2(0, 1)
	down2 = convertedPlayerPosition - Vector2(0, 2)
	
	return [right1, right2, left1, left2, up1, up2, down1, down2];
	
func checkIfMoveViable(): 
	var allViableMoves = aggregateViablePlayerMoves();
	for item in allViableMoves:
		if convertedMousePosition == item:
			viableMove = true;

func exportViableMove():
	return viableMove;
	
func getCanCharacterMove():
	return currentCharacter.exportCanMove();
		
