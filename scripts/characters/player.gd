extends KinematicBody2D

#SourceOfTruth
onready var SOURCE_OF_TRUTH = get_node("../../SOURCE_OF_TRUTH");

#LevelState
export var currentCharacter = false;
var currentCharacterClass;
onready var levelState = get_node("../../LevelState");

#Turn-based Variables
onready var turnProgressBar = get_node("TurnProgressBar");
var canMove = false;

#Skills
onready var actionProgressBar = get_node("ActionProgressBar");

#Movement Variables
var playerPosition;
var mousePosition;
var convertedMousePosition;
onready var tileMap = get_node("../../TileMap")
onready var movementTilesNode = get_node("../../MovementTiles");
var viablePositions = [];

### Lifecycle Functions
func _ready():
	checkIfCurrent();
	playerPosition = tileMap.world_to_map(self.global_position);
	for item in movementTilesNode.get_children():
		viablePositions.append(tileMap.world_to_map(item.global_position));
		
func _process(_delta):
	checkIfCurrent();
	if canMove:
		getMousePosition();
		moveCharacter();
	setBackground();
		
### Logic Functions
func getMousePosition():
	mousePosition = SOURCE_OF_TRUTH.getMousePosition();
	convertedMousePosition = tileMap.world_to_map(mousePosition);
	
func moveCharacter():
	var globalMousePosition = tileMap.map_to_world(convertedMousePosition) - Vector2(-8, -10);
	var isViablePosition  = checkPositionViable(convertedMousePosition);
	
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
		
func exportCurrentState():
	return currentCharacter;
		
func setBackground():
	if currentCharacter:
		$SelectedBackground.set_visible(true);
	else:
		$SelectedBackground.set_visible(false);

func exportCanMove():
	return canMove;

func startAction():
	actionProgressBar.tweenActionProgress();


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
	turnProgressBar.value = 25
	
func _on_RogueTimer2_timeout():
	turnProgressBar.value = 50

func _on_RogueTimer3_timeout():
	turnProgressBar.value = 75

func _on_RogueTimer4_timeout():
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
