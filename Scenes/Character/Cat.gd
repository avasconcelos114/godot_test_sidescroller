extends CharacterBody2D
class_name Cat

var lives = 9
var max_health = 3
var current_health = 3

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func received_damage(dmg: float):
	current_health -= dmg

	if current_health <= 0:
		lives -= 1
		Global.PlayerDied.emit()

func _physics_process(_delta):	
	if Global.is_paused:
		$AnimatedSprite2D.stop()
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * Global.time

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
	if !is_moving and is_on_floor():
		$AnimatedSprite2D.play("default")
	elif is_moving and is_on_floor():
		$AnimatedSprite2D.play("running")
	#elif !is_on_floor():
		#$AnimatedSprite2D.play("jumping")
	
	move_and_slide()
