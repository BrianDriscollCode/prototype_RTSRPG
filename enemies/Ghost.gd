extends KinematicBody2D


onready var SOURCE_OF_TRUTH = get_node("../../SOURCE_OF_TRUTH")
var health = 3;
onready var healthBar = get_node("TextureProgress");
var currentPosition;
var currentConvertedPosition;
onready var tileMap = get_node("../../TileMap");
var tiles;
var canMove = false;
var adjacentTiles = [];

onready var timer3 = get_node("Timer3");

func _ready():
	var random = (randi() % 4 + 7);
	print(random)
	timer3.set_wait_time(random);
	tiles = tileMap.get_used_cells();	
	getCurrentPosition();
	getAdjacentTiles();
	

func _process(delta):
	if health == 1:
		self.queue_free();
	getCurrentPosition();
	checkTile();
	moveNPC();
	

	
func moveNPC():
	if canMove:
#		1 - left
#		2 - right
#		0 - up 
#		3- down
		var closestCharacterPosition = getClosestCharacterPosition(currentConvertedPosition);
		var direction = currentConvertedPosition - closestCharacterPosition;
		print(direction, " -direction");
#		var random = randi() % adjacentTiles.size();
		var chooser;
		if direction.x > 0:
			chooser = 1
		elif direction.x <= 0:
			chooser = 2
		var nextPos = tileMap.map_to_world(adjacentTiles[chooser]) - Vector2(-8, -7);
		self.set_global_position(nextPos);
		canMove = false;
		restartTimers();
		getAdjacentTiles();
		

#func getClosestCharacterPosition():
#	var partyMemberPositions = SOURCE_OF_TRUTH.getPartyMemberPositions();
#	var closestCharacterPosition = Vector2(0,0);
#	for character in partyMemberPositions:
#		var temp = character - currentConvertedPosition
#		print(temp, " -temp")
#		print(closestCharacterPosition, " -Closest character position")
#		if closestCharacterPosition < temp || closestCharacterPosition == Vector2(0,0):
#			closestCharacterPosition = character;
#	print(closestCharacterPosition)
func getClosestCharacterPosition(enemyPosition: Vector2) -> Vector2:
	var partyMemberPositions = SOURCE_OF_TRUTH.getPartyMemberPositions()
	print(partyMemberPositions, " -partyMemberPositions")
	var closestCharacterPosition = partyMemberPositions[0]
	var closestDistance = (enemyPosition - closestCharacterPosition).length()

	for character in partyMemberPositions:
		var distance = (enemyPosition - character).length()
		if distance < closestDistance:
			closestCharacterPosition = character
			closestDistance = distance
		

	return closestCharacterPosition
			

func takeHit():
	health -= 1;
	healthBar.value -= 1;

func getCurrentPosition():
	currentPosition = self.get_global_position();
	currentConvertedPosition = tileMap.world_to_map(currentPosition);

func getAdjacentTiles():
	adjacentTiles = [];
	getCurrentPosition();
	for tilePos in tiles:
		var diff = currentConvertedPosition - tilePos
		if (abs(diff.x) + abs(diff.y) == 1):
			adjacentTiles.append(tilePos);
	

func checkTile():
	if Input.is_action_just_pressed("right_click"):
		var mousePosition = SOURCE_OF_TRUTH.getMousePosition();
		mousePosition = tileMap.world_to_map(mousePosition);
#func getAllPositions():

func _on_Area2D_area_entered(area):
	takeHit();

func restartTimers():
	timer3.start();

func _on_Timer_timeout():
	pass # Replace with function body.


func _on_Timer2_timeout():
	pass # Replace with function body.


func _on_Timer3_timeout():
	canMove = true;
