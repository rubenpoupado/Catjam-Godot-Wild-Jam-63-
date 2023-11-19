@tool
extends Node2D

const WAIT_DURATION = 1.0

@onready var object = $saw as Area2D
@export var speed = 5.0
@export var distance = 64*5
@export var horizontal_flag = false

var follow = Vector2.ZERO
var platform_center = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		move_object()

func _process(delta):
	queue_redraw()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not Engine.is_editor_hint():
		object.position = object.position.lerp(follow, 0.5)
	
func move_object():
	var direction = Vector2.RIGHT * distance if horizontal_flag else Vector2.UP * distance
	var duration = direction.length()/float(speed*platform_center)
	
	var platform_tween = create_tween().set_loops()
	platform_tween.tween_property(self, "follow", direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(WAIT_DURATION)

func _draw():
	if Engine.is_editor_hint():
		draw_line(Vector2(position.x-platform_center-global_position.x, position.y-global_position.y), Vector2(position.x+platform_center-global_position.x + distance, position.y-global_position.y), Color.RED, 1.5)
	
