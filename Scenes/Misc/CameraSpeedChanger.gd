extends Area2D

@export var new_speed := 50
@export var should_spawn_boss := false
@export var boss_speed := 0

func _on_body_entered(body):
	if body is Cat:
		Global.camera_speed = new_speed
		if should_spawn_boss:
			Global.emit_signal("SpawnBossSignal", boss_speed)

		if boss_speed:
			Global.emit_signal("UpdateBossSpeedSignal", boss_speed)
