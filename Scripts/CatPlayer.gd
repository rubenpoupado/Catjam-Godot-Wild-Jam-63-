extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -320.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isParkouring = false
var isSliding = false

@onready var animationTree : AnimationTree = $AnimationTree

func _ready():
	animationTree.active = true
	
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction and not isParkouring:
		velocity.x = direction * SPEED
		if direction < 0:
			$CatSprite.flip_h = true
		else:
			$CatSprite.flip_h = false
	elif not isParkouring:
		velocity.x = move_toward(velocity.x, 0, SPEED)
			
	if not is_on_floor():
		velocity.y += gravity * delta
		if is_on_wall():
			isSliding = true
		if isSliding and Input.is_action_just_pressed("Jump"):
			$CatSprite.flip_h = not $CatSprite.flip_h
			velocity.y = JUMP_VELOCITY * 1.5
			if $CatSprite.flip_h:
				velocity.x = -SPEED * 1.5
			else:
				velocity.x = SPEED * 1.5
			isParkouring = true
	else:
		isParkouring = false
		isSliding = false
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
			
	move_and_slide()
func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animationTree["parameters/conditions/isIdle"] = true
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = false
	elif velocity.x and is_on_floor():
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = true
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = false
	elif velocity.y < 0:
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = true
		animationTree["parameters/conditions/isFalling"] = false
	elif velocity.y > 0:
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = true
