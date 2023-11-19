extends Control

signal levelComplete
var isLevelComplete = false
@export var nextLevel = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	if nextLevel >= 4:
		$CanvasLayer/MenusPanel/LevelCompleteMenu/NextLevel.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Esc") and not isLevelComplete:
		_on_resume_pressed()
	
func _on_level_complete():
	isLevelComplete = true
	$CanvasLayer/MenusPanel.visible = true
	$CanvasLayer/MenusPanel/LevelCompleteMenu.visible = true
	get_tree().paused = true

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	get_tree().paused = false

func _on_resume_pressed():
	$CanvasLayer/MenusPanel.visible = not $CanvasLayer/MenusPanel.visible
	$CanvasLayer/MenusPanel/PauseMenu.visible = not $CanvasLayer/MenusPanel/PauseMenu.visible
	get_tree().paused = not get_tree().paused

func _on_next_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/level" + str(nextLevel) + ".tscn")
	get_tree().paused = false
