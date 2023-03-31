extends KinematicBody2D


var health = 10;
onready var healthBar = get_node("TextureProgress");

func _process(delta):
	if health == 1:
		self.queue_free();


func takeHit():
	health -= 1;
	healthBar.value -= 1;


func _on_Area2D_area_entered(area):
	takeHit();
