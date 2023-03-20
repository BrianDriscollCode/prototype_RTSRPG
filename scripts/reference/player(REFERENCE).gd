#extends KinematicBody2D
#
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
#var SPEED = 50;
#var character_motion = Vector2(0, 0);
#onready var tileMap = get_node("../TileMap").get_used_cells()
#onready var playerPosition = get_node("../TileMap").world_to_map(self.global_position);
#var nextCoordinate;
#var nextPosition;
#
#func _ready():
#	pass # Replace with function body.
#
#func _physics_process(delta):
#	basic_movement();
#	move_and_slide(character_motion, Vector2(0, -1))
#
#func basic_movement():
#	if Input.is_action_just_pressed("move_right"):
#		playerPosition = get_node("../TileMap").world_to_map(self.global_position);
#		print(playerPosition);
#		nextCoordinate = Vector2(playerPosition.x + 1, playerPosition.y);
#		for item in tileMap:
#			if item == nextCoordinate:
#				nextPosition = get_node("../TileMap").map_to_world(item);
#				print(nextPosition)

#		self.position.y = nextPosition.y;
#		self.position.x = nextPosition.x;
		
		
		
#	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_up"):
#		character_motion.x = SPEED;
#		character_motion.y = -SPEED;
#		return
#
#	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_down"):
#		character_motion.x = SPEED;
#		character_motion.y = SPEED;
#		return
#
#	if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_up"):
#		character_motion.x = -SPEED;
#		character_motion.y = -SPEED;
#		return
#
#	if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_down"):
#		character_motion.x = -SPEED;
#		character_motion.y = SPEED;
#		return
#
#	if Input.is_action_pressed("move_right"):
#		character_motion.x = SPEED;
#		character_motion.y = 0;
#	elif Input.is_action_pressed("move_left"):
#		character_motion.x = -SPEED;
#		character_motion.y = 0;
#	elif Input.is_action_pressed("move_down"):
#		character_motion.x = 0;
#		character_motion.y = SPEED;
#	elif Input.is_action_pressed("move_up"):
#		character_motion.x = 0;
#		character_motion.y = -SPEED;
#	else:
#		character_motion = Vector2(0,0);
#


func _on_Area2D_body_entered(body):
	print("Player entered aggro range")
