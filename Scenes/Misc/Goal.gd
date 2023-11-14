extends Area2D

@export var level: Global.Levels

func _on_body_entered(_body):
	Global.emit_signal('LevelClearedSignal', level)
