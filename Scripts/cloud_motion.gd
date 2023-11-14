extends ParallaxLayer


@export var cloud_speed = -50

func _process(delta):
	motion_offset.x += cloud_speed * delta
