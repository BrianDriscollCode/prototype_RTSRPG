extends KinematicBody2D


onready var SOURCE_OF_TRUTH = get_node("../../SOURCE_OF_TRUTH");
onready var level = get_node("../../../Level");
onready var animationPlayer = get_node("AnimationPlayer");
var currentPosition;
var currentConvertedPosition;
onready var tileMap = get_node("../../TileMap");
var tiles;
var viablePositions;
var canMove = false;
var canAttack = false;
var adjacentTiles = [];
var arrow = preload("res://projectiles/Arrow.tscn");
var arrowDirection;
onready var movementTiles = get_node("../../MovementTiles");

var health = 10;
onready var healthBar = get_node("TextureProgress");

onready var timer3 = get_node("Timer3");

#Sounds
onready var shootArrowSound = get_node("shootArrowSound");
onready var pullBowSound = get_node("pullBowSound");

func _ready():
	var random = (randi() % 4 + 7);
	print(random)
	timer3.set_wait_time(random);
	tiles = tileMap.get_used_cells();	
	getCurrentPosition();
	getAdjacentTiles();
	var closestCharacterPosition = getClosestCharacterPosition(currentConvertedPosition);
	var direction = currentConvertedPosition - closestCharacterPosition;
	arrowDirection = direction;
	get_node("Bow").set_visible(false);
	viablePositions = movementTiles.exportViableTilePositions();

func _process(delta):
	if health == 1:
		self.queue_free();
	getCurrentPosition();
	checkTile();
	moveNPC();
	fireArrow();
	

	
func moveNPC():
	if canMove:
#		1 - left
#		2 - right
#		0 - up 
#		3- down
		var closestCharacterPosition = getClosestCharacterPosition(currentConvertedPosition);
		var direction = currentConvertedPosition - closestCharacterPosition;
		arrowDirection = direction;
		var nextPos = null;
		while (nextPos == null):
			var random = randi() % adjacentTiles.size();
			var chooser;
			if direction.x > 0:
				chooser = 1
			elif direction.x <= 0:
				chooser = 2
			for tilePosition in viablePositions:
				if tilePosition == adjacentTiles[random]:
					nextPos = tileMap.map_to_world(adjacentTiles[random]) - Vector2(-8, -7);
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
	print(partyMemberPositions, "party member positon")
	var closestCharacterPosition = partyMemberPositions[0]
	var closestDistance = (enemyPosition - closestCharacterPosition).length()

	for character in partyMemberPositions:
		var distance = (enemyPosition - character).length()
		if distance < closestDistance:
			closestCharacterPosition = character
			closestDistance = distance
		
	return closestCharacterPosition
	
func returnRandomCharacter() -> Vector2:
	var partyMemberPositions = SOURCE_OF_TRUTH.getPartyMemberPositions()
	print(partyMemberPositions, "party member positon")
	if partyMemberPositions.size() > 0:
		var randomChooser = randi() % partyMemberPositions.size();
		return partyMemberPositions[randomChooser]
	return Vector2(0,0)
	
			

func takeHit():
	health -= 5;
	healthBar.value -= 5;
	if health < 5:
		self.queue_free();

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
	
func fireArrow():
	if canAttack:
		animationPlayer.play("ShootArrow")
		returnRandomCharacter()

var new_Arrow_Direction = Vector2(0 ,0)

enum action {
	pickClosest,
	pickRandom
}

func instanceArrow():
	
	var goblinTargetChoice = randi() % 6;
	var currentAction;
	
	if goblinTargetChoice <= 4:
		currentAction = action.pickClosest;
	elif goblinTargetChoice == 5:
		currentAction = action.pickRandom;
	
	if canAttack && currentAction == action.pickClosest:
		print("attack closest")
		var currentArrow = arrow.instance();
		
#		**Closest Character Code
		var closestCharacterPosition = getClosestCharacterPosition(currentConvertedPosition);
		var direction = currentConvertedPosition - closestCharacterPosition;

		arrowDirection = direction;
		level.add_child(currentArrow);
		currentArrow.setStartPosition(self.global_position, -arrowDirection.normalized());
#		**Closest Character Code
		currentArrow.look_at(tileMap.map_to_world(getClosestCharacterPosition(currentConvertedPosition)))

		
	if canAttack && currentAction == action.pickRandom:
		print("attack random")
		var currentArrow = arrow.instance();

#		**Random Character Code
		var randomCharacterPosition = returnRandomCharacter();
		var direction = currentConvertedPosition - randomCharacterPosition;
#		**

		arrowDirection = direction;
		level.add_child(currentArrow);
		currentArrow.setStartPosition(self.global_position, -arrowDirection.normalized());

#		**Random Characeter Code
		currentArrow.look_at(tileMap.map_to_world(randomCharacterPosition))
#       LERP
#		new_Arrow_Direction = (getClosestCharacterPosition(self.global_position) - self.get_global_position())
#		var angle = currentArrow.get_angle_to(getClosestCharacterPosition(self.global_position));
#		var r = global_rotation;
#		currentArrow.global_rotation = lerp_angle(r, angle, 0.01)


func checkTile():
	if Input.is_action_just_pressed("right_click"):
		var mousePosition = SOURCE_OF_TRUTH.getMousePosition();
		mousePosition = tileMap.world_to_map(mousePosition);
#func getAllPositions():

func _on_Area2D_area_entered(area):
	takeHit();

func restartTimers():
	timer3.start();



func _on_Timer3_timeout():
	var random = randi() % 6
	if random <= 2:
		canMove = true;
	else:
		canAttack = true;


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ShootArrow":
		shootArrowSound.play();
		instanceArrow();
		animationPlayer.play("sheathe")
		canAttack = false;
		
