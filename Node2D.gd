extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction;

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(-1, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position += direction * 2
	
func setStartPosition(startingPosition, passedDirection):
	self.global_position = startingPosition;
	direction = passedDirection


func _on_Arrow_area_entered(area):
	self.queue_free()
