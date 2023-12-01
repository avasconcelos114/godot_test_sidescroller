extends CharacterBody2D
class_name Cone

@export var navigation_agent: NavigationAgent2D
@export var movement_speed := 80

var ACCELERATION = 15

func _physics_process(_delta):
	if Global.is_paused:
		return

	var direction = Global.player.global_position - global_position
	direction = direction.normalized()
	velocity.x = move_toward(velocity.x, direction.x * movement_speed, ACCELERATION)
	velocity.y = move_toward(velocity.y, direction.y * movement_speed, ACCELERATION)
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body is Cat:
		Global.player.kill_player()
