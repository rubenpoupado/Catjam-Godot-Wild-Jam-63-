extends Camera2D

@export var limitTop = -900
@export var limitLeft = -500
@export var limitRight = 1250
@export var limitBottom = 1000
@export var _zoom = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_top = limitTop
	limit_left = limitLeft
	limit_right = limitRight
	limit_bottom = limitBottom
	zoom = Vector2(_zoom, _zoom)
	limit_smoothed = true
	make_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
