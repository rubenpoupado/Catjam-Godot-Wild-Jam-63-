extends Node2D

const WAIT_DURATION = 1.0

@onready var object = $platform as AnimatableBody2D
@export var speed = 5.0
@export var distance = 64*5

var follow = Vector2.ZERO
var platform_center = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	move_object()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	object.position = object.position.lerp(follow, 0.5)
	
func move_object():
	var direction = Vector2.RIGHT * distance 
	var duration = direction.length()/float(speed*platform_center)
	
	var platform_tween = create_tween().set_loops()
	platform_tween.tween_property(self, "follow", direction, duration).set_delay(WAIT_DURATION)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(WAIT_DURATION)
