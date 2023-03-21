extends KinematicBody2D


#LevelState
export var currentCharacter = false;
var currentCharacterClass;
onready var levelState = get_node("../../LevelState");

#Turn-based Variables
onready var step1Timer = get_node("RogueTimer1");
onready var step2Timer = get_node("RogueTimer2");
onready var step3Timer = get_node("RogueTimer3");
onready var turnProgressBar = get_node("TurnProgressBar");
var canMove = false;

#Movement Variables
var playerPosition;
var mousePosition;
onready var tileMap = get_node("../../TileMap")
onready var movementTilesNode = get_node("../../movementTiles");
var viablePositions = [];

### Lifecycle Functions
func _ready():
	checkIfCurrent();
	print("test");
		
	playerPosition = tileMap.world_to_map(self.global_position);
	for item in movementTilesNode.get_children():
		viablePositions.append(tileMap.world_to_map(item.global_position));
		
		
	
func _process(delta):
	checkIfCurrent();
	if canMove:
		getMousePosition();
		moveCharacter();
	setBackground();
		
		
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
	var isViable = movementTilesNode.exportViableMove();
	
	for item in viablePositions:
		if item == position && isViable:
			return true;
	return false;
	
func resetTurnProgress():
	turnProgressBar.value = 0;
	canMove = false;
	get_node("class").restartTimers();
	
func checkIfCurrent(): 
	if (levelState.returnCurrentCharacter() == self):
		currentCharacter = true;
	else: 
		currentCharacter = false;
		
func setBackground():
	if currentCharacter:
		$SelectedBackground.set_visible(true);
	else:
		$SelectedBackground.set_visible(false);

func exportCanMove():
	return canMove;

### Signals

##Knight Timers
func _on_KnightTime1_timeout():
	turnProgressBar.value = 16


func _on_KnightTime2_timeout():
	turnProgressBar.value = 33


func _on_KnightTime3_timeout():
	turnProgressBar.value = 49


func _on_KnightTime4_timeout():
	turnProgressBar.value = 65

func _on_KnightTime5_timeout():
	turnProgressBar.value = 84

func _on_KnightTime6_timeout():
	turnProgressBar.value = 100
	canMove = true;


##Rogue Timers
func _on_RogueTimer1_timeout():
	turnProgressBar.value = 33
	
func _on_RogueTimer2_timeout():
	turnProgressBar.value = 66

func _on_RogueTimer3_timeout():
	turnProgressBar.value = 100
	canMove = true;

##Wizard Timers


func _on_WizardTimer1_timeout():
	turnProgressBar.value = 10

func _on_WizardTimer2_timeout():
	turnProgressBar.value = 20

func _on_WizardTimer3_timeout():
	turnProgressBar.value = 30

func _on_WizardTimer4_timeout():
	turnProgressBar.value = 40

func _on_WizardTimer5_timeout():
	turnProgressBar.value = 50

func _on_WizardTimer6_timeout():
	turnProgressBar.value = 60

func _on_WizardTimer7_timeout():
	turnProgressBar.value = 70

func _on_WizardTimer8_timeout():
	turnProgressBar.value = 80

func _on_WizardTimer9_timeout():
	turnProgressBar.value = 90

func _on_WizardTimer10_timeout():
	turnProgressBar.value = 100
	canMove = true;
