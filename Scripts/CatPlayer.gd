extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -320.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var maxjumpCooldown = 1
var jumpCooldown = 0

@onready var animationTree : AnimationTree = $AnimationTree

func _ready():
	animationTree.active = true
	
func _process(delta):
	update_animation_parameters()
	
func _physics_process(delta):
	jumpCooldown += delta
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			$CatSprite.flip_h = true
		else:
			$CatSprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
			
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		if Input.is_action_just_pressed("Jump") and jumpCooldown >= maxjumpCooldown:
			jumpCooldown = 0
			velocity.y = JUMP_VELOCITY
	move_and_slide()

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animationTree["parameters/conditions/isIdle"] = true
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = false
	if velocity.x and is_on_floor():
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = true
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = false
	if velocity.y < 0:
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = true
		animationTree["parameters/conditions/isFalling"] = false
	if velocity.y > 0:
		animationTree["parameters/conditions/isIdle"] = false
		animationTree["parameters/conditions/isRunning"] = false
		animationTree["parameters/conditions/isJumping"] = false
		animationTree["parameters/conditions/isFalling"] = true
