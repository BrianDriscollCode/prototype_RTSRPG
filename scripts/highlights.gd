extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var chosenCharacter = 0;
var mousePosition;
var convertedMousePosition;
var highlightTiles = [];
onready var tileMap = get_node("../TileMap");
onready var tiles = get_node("../TileMap").get_used_cells();

onready var playerPosition;
var convertedPlayerPosition;



func _ready():
	for item in self.get_children():
		item.set_visible(false)
		item.set_modulate(Color(1, 1, 1, 0.5))
		highlightTiles.append(item);


func _process(delta):
	matchToTile()
	showPlayerMovementRange()
	

func matchToTile():
	mousePosition = get_viewport().get_mouse_position()
	convertedMousePosition = tileMap.world_to_map(mousePosition)
	# Loop through tiles to see which matches mouse position, thne make visible
	for item in highlightTiles:
		item.set_visible(false)
		if convertedMousePosition == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
			
func showPlayerMovementRange():
	var right1; var right2; var left1; var left2; var up1; var up2; var down1; var down2
	playerPosition = get_node("../Party/Player").global_position;
	convertedPlayerPosition = tileMap.world_to_map(playerPosition);
	right1 = convertedPlayerPosition + Vector2(1, 0)
	right2 = convertedPlayerPosition + Vector2(2, 0)
	left1 = convertedPlayerPosition - Vector2(1, 0)
	left2 = convertedPlayerPosition - Vector2(2, 0)
	up1 = convertedPlayerPosition + Vector2(0, 1)
	up2 = convertedPlayerPosition + Vector2(0, 2)
	down1 = convertedPlayerPosition - Vector2(0, 1)
	down2 = convertedPlayerPosition - Vector2(0, 2)
	
	for item in highlightTiles:
		if convertedPlayerPosition == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if right1 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if right2 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if left1 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if left2 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if up1 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if up2 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if down1 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)
		if down2 == tileMap.world_to_map(item.global_position):
			item.set_visible(true)

	
