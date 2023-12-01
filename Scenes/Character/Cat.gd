extends CharacterBody2D
class_name Cat

var lives = 9

const SPEED = 180.0
const ACCELERATION = 13.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damping = 0.5

func kill_player():
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
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		# Turn to correct direction
		$AnimatedSprite2D.set_flip_h(direction == 1)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
		is_moving = false
	
	# Play appropriate animations
	if !is_moving and is_on_floor():
		$AnimatedSprite2D.play("default")
	elif is_moving and is_on_floor():
		$AnimatedSprite2D.play("running")

	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var object = collision.get_collider()
		if object is CharacterBody2D:
			var normal = collision.get_normal()
			var bounce_multiplier = 10
			velocity.x = normal.x * SPEED
			velocity.y = JUMP_VELOCITY
