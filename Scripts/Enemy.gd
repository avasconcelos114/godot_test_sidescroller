extends CharacterBody2D
class_name Enemy

@export var path: PathFollow2D
@export var patrol_time := 5

# Patrol vars
var timer: Timer
var path_progress = 0
var is_alive = true
var tween: Tween

func _ready():
	# Create timer to patrol along path
	timer = Timer.new()
	timer.wait_time = patrol_time
	timer.one_shot = false
	add_child(timer)
	timer.start()
	timer.timeout.connect(move_along_path)

func _physics_process(_delta):
	if Global.is_paused:
		tween.stop()
		$AnimatedSprite2D.stop()
		return

	if is_alive:
		move_and_slide()

func move_along_path():
	tween = get_tree().create_tween()
	path_progress = 0 if path_progress else 1
	$AnimatedSprite2D.flip_h = path_progress == 0
	tween.tween_property(path, 'progress_ratio', path_progress, 3)

func _on_receive_damage_zone_body_entered(body):
	if body is Cat:
		is_alive = false
		$CollisionShape2D.call_deferred('set_disabled', true)
		$DealDamageZone.call_deferred('set_monitoring', false)
		$DealDamageZone2.call_deferred('set_monitoring', false)
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()

func _on_deal_damage_zone_body_entered(body):
	if body is Cat and is_alive:
		Global.player.kill_player()

func _on_deal_damage_zone_2_body_entered(body):
	if body is Cat and is_alive:
		Global.player.kill_player()
