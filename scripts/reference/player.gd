extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var SPEED = 50;
var character_motion = Vector2(0, 0);



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	basic_movement();
	move_and_slide(character_motion, Vector2(0, -1))
	
func basic_movement():
	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_up"):
		character_motion.x = SPEED;
		character_motion.y = -SPEED;
		return
	
	if Input.is_action_pressed("move_right") && Input.is_action_pressed("move_down"):
		character_motion.x = SPEED;
		character_motion.y = SPEED;
		return
		
	if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_up"):
		character_motion.x = -SPEED;
		character_motion.y = -SPEED;
		return
	
	if Input.is_action_pressed("move_left") && Input.is_action_pressed("move_down"):
		character_motion.x = -SPEED;
		character_motion.y = SPEED;
		return
	
	if Input.is_action_pressed("move_right"):
		character_motion.x = SPEED;
		character_motion.y = 0;
		print("press right");
	elif Input.is_action_pressed("move_left"):
		character_motion.x = -SPEED;
		character_motion.y = 0;
	elif Input.is_action_pressed("move_down"):
		character_motion.x = 0;
		character_motion.y = SPEED;
	elif Input.is_action_pressed("move_up"):
		character_motion.x = 0;
		character_motion.y = -SPEED;
	else:
		character_motion = Vector2(0,0);
	
