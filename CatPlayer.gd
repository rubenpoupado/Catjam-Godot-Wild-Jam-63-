extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Animations & State
const IDLE_ANIM = preload("res://Sprites/WhiteCatIdle.png")
const RUN_ANIM = preload("res://Sprites/WhiteCatRun.png")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		falling = true

	# Handle Jump.
	if is_on_floor():
		if falling:
			$AnimationPlayer.current_animation = "CatPlayer_Fall"
			falling = false
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
			$AnimationPlayer.current_animation = "CatPlayer_Jump"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.current_animation = "CatPlayer_Run"
		if direction < 0:
			$CatSprite.flip_h = true
		else:
			$CatSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.current_animation = "CatPlayer_Idle"

	move_and_slide()
