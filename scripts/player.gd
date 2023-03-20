extends KinematicBody2D


#LevelState
export var currentCharacter = false;
onready var levelState = get_node("../../LevelState");

#Turn-based Variables
onready var step1Timer = get_node("step1");
onready var step2Timer = get_node("step2");
onready var step3Timer = get_node("step3");
onready var turnProgressBar = get_node("TurnProgressBar");
var canMove = false;

#Movement Variables
var playerPosition;
var mousePosition;
onready var tileMap = get_node("../../TileMap")
onready var viablePositionsObject = get_node("../../ViablePositions");
var viablePositions = [];

### Lifecycle Functions
func _ready():
	checkIfCurrent();
	print("test");
		
	playerPosition = tileMap.world_to_map(self.global_position);
	for item in viablePositionsObject.get_children():
		viablePositions.append(tileMap.world_to_map(item.global_position));
		
	
func _process(delta):
	checkIfCurrent();
	if canMove:
		getMousePosition();
		moveCharacter();
		
		
### Logic Functions
func getMousePosition():
	mousePosition = get_viewport().get_mouse_position();
	mousePosition = tileMap.world_to_map(mousePosition);
	
func moveCharacter():
	var globalMousePosition = tileMap.map_to_world(mousePosition) - Vector2(-8, -10);
	var isViablePosition  = checkPositionViable(mousePosition);
	if Input.is_action_just_pressed("left_click") && isViablePosition && currentCharacter:
		self.global_position = globalMousePosition;
		canMove = false;
		resetTurnProgress();

func checkPositionViable(position):
	for item in viablePositions:
		if item == position:
			return true;
	return false;
	
func resetTurnProgress():
	turnProgressBar.value = 0;
	canMove = false;
	step1Timer.start();
	step2Timer.start();
	step3Timer.start();
	
func checkIfCurrent(): 
	if (levelState.returnCurrentCharacter() == self):
		currentCharacter = true;
		print(currentCharacter);
	else: 
		currentCharacter = false;
		print(currentCharacter)

### Signals
func _on_step1_timeout():
	turnProgressBar.value = 33;


func _on_step2_timeout():
	turnProgressBar.value = 66


func _on_step3_timeout():
	turnProgressBar.value = 100;
	canMove = true;
