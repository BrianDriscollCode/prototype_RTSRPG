extends Area2D


onready var animation = get_node("AnimatedSprite");


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play();
	

func _on_Skill_Expiration_Timer_timeout():
	self.queue_free();
