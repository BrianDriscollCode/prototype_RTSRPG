extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var children;


# Called when the node enters the scene tree for the first time.
func _ready():
	for item in self.get_children ():
		print(item);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
