extends Area2D





func _ready():
	pass # Replace with function body.


func _on_Skill_Expiration_Timer_timeout():
	self.queue_free();
