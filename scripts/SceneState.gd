extends Node2D


var currentSceneState = "";
enum sceneState {
	free,
	battle,
	cutScene
}

# Called when the node enters the scene tree for the first time.
func _ready():
	currentSceneState = sceneState.free


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
