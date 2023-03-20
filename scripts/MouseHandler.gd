extends Node2D


var mousePosition;
var convertedMousePosition;
onready var tiles = get_node("../TileMap2").get_used_cells();
onready var tileMap = get_node("../TileMap2")
onready var coloredTiles = get_node("../TileMapGreen/Sprite")

var removedCell;

func _process(delta):
	mousePosition = get_viewport().get_mouse_position();
	convertedMousePosition = get_node("../TileMap2").world_to_map(mousePosition);
#	print(convertedMousePosition)
	matchToTile(convertedMousePosition);
	if Input.is_action_just_pressed("move_right"):
		print(get_node("../TileMap2").world_to_map(coloredTiles.global_position))
	
	
	
func matchToTile(convertedMousePosition):
	var tile = tileMap.get_cellv(convertedMousePosition)
#	if tile > 0:
		#get_node("../TileMap2").set_cellv(convertedMousePosition, 0)
	if convertedMousePosition == get_node("../TileMap2").world_to_map(coloredTiles.global_position):
		coloredTiles.visible = true
		coloredTiles.set_modulate(Color(244, 1, 1, 0.3))

		

#func removeTileFromPosition(convertedMousePosition):			
#	for item in tiles:
#		if mousePosition == item:
#			tileMap.set_cell(item.x, item.y, -1)
#			removedCell = item;
