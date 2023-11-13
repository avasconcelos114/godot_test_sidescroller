extends Node2D

var level_1 = preload("res://Levels/Level1.tscn")
var level_2 = preload("res://Levels/Level2.tscn")
var level_3 = preload("res://Levels/Level3.tscn")
var player_scene = preload("res://Scenes/Character/Cat.tscn")

func get_current_level():
	var currentLevel = Global.Levels.Level1

	if currentLevel == Global.Levels.Level1:
		return level_1.instantiate()
	elif currentLevel == Global.Levels.Level2:
		return level_2.instantiate()
	elif currentLevel == Global.Levels.Level3:
		return level_3.instantiate()

func _start_game():
	var level = get_current_level()
	add_child(level)

	# Spawn in player
	var spawn_point = level.find_child("PlayerSpawn")
	var player = player_scene.instantiate()
	add_child(player)
	Global.set_player(player)

	player.position = spawn_point.position


func _on_title_screen_start_game_signal():
	_start_game()
	$CanvasLayer/TitleScreen.visible = false
	$CanvasLayer/PlayerStatOverlay.visible = true


func _on_title_screen_exit_game_signal():
	get_tree().quit()
