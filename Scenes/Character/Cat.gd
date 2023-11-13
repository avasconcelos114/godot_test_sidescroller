extends CharacterBody2D
class_name Cat

var lives = 3
var max_health = 3
var current_health = 3

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.set_camera($Camera2D)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var is_moving = false

	if direction != 0:
		is_moving = true
		velocity.x = direction * SPEED
		# Turn to correct direction
		$AnimatedSprite2D.set_flip_h(direction == 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		is_moving = false
	
	# Play appropriate animations
	#if !is_moving and is_on_floor():
		#$AnimatedSprite2D.play("idle")
	#elif is_moving and is_on_floor():
		#$AnimatedSprite2D.play("running")
	#elif !is_on_floor():
		#$AnimatedSprite2D.play("jumping")
	
	move_and_slide()
