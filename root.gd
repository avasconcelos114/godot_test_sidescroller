extends Node2D

var level_1 = preload("res://Levels/Level1.tscn")
var level_2 = preload("res://Levels/Level2.tscn")
var level_3 = preload("res://Levels/Level3.tscn")
var player_scene = preload("res://Scenes/Character/Cat.tscn")
var cone_scene = preload("res://Scenes/Enemies/Cone.tscn")

var loaded_level: Node2D

func _ready():
	var currentLevel = Global.Levels.Level1
	Global.set_level(currentLevel)
	
	# Show game over screen on player death
	Global.GameOverSignal.connect(_show_game_over_screen)
	# Show level cleared screen
	Global.LevelClearedSignal.connect(_show_level_cleared_screen)
	# Boss listeners
	Global.SpawnBossSignal.connect(_spawn_boss)
	Global.UpdateBossSpeedSignal.connect(_update_boss_speed)
	Global.PlayerDied.connect(_despawn_boss)

func _physics_process(_delta):
	$CanvasLayer/PausedScreen.visible = Global.is_paused

func _start_game():
	if loaded_level:
		loaded_level.queue_free()

	var level = get_current_level()
	loaded_level = level
	add_child(level)
	_spawn_player(level)

func get_current_level():
	if Global.current_level == Global.Levels.Level1:
		return level_1.instantiate()
	elif Global.current_level == Global.Levels.Level2:
		return level_2.instantiate()
	elif Global.current_level == Global.Levels.Level3:
		return level_3.instantiate()

func _spawn_player(level: Node2D):
	var player = player_scene.instantiate()
	add_child(player)
	Global.set_player(player)

	var spawn_point = level.find_child("PlayerSpawn")
	Global.set_last_checkpoint(spawn_point)
	player.position = spawn_point.position

func _quit_game():
	get_tree().quit()

# Connected Signal Listeners
func _show_game_over_screen():
	$CanvasLayer/PlayerStatOverlay.visible = false
	$CanvasLayer/GameOverScreen.visible = true

func _show_level_cleared_screen(level):
	Global.set_pause_game(true)
	$CanvasLayer/PlayerStatOverlay.visible = false
	$CanvasLayer/LevelClearedScreen.visible = true
	if level == Global.Levels.Level1:
		Global.set_level(Global.Levels.Level2)
	elif level == Global.Levels.Level2:
		Global.set_level(Global.Levels.Level3)

# UI Triggered Signals
func _on_title_screen_start_game_signal():
	_start_game()
	$CanvasLayer/TitleScreen.visible = false
	$CanvasLayer/PlayerStatOverlay.visible = true

func _on_title_screen_exit_game_signal():
	_quit_game()

func _on_game_over_screen_exit_game_signal():
	_quit_game()

func _on_game_over_screen_reload_signal():
	_spawn_player(loaded_level)
	Global.RestartFromCheckpointSignal.emit()
	$CanvasLayer/GameOverScreen.visible = false
	$CanvasLayer/PlayerStatOverlay.visible = true

func _on_level_cleared_screen_load_next_level_signal():
	$CanvasLayer/PlayerStatOverlay.visible = true
	$CanvasLayer/LevelClearedScreen.visible = false
	_start_game()
	Global.set_pause_game(false)

func _spawn_boss(speed: float):
	if Global.boss:
		return

	var cone = cone_scene.instantiate()
	cone.movement_speed = speed
	var spawn_point = get_tree().get_first_node_in_group("BossSpawnPoint") as Marker2D
	cone.position = spawn_point.position
	add_child(cone)
	Global.set_boss(cone)

func _despawn_boss():
	if Global.boss:
		Global.boss.queue_free()
		Global.boss = null

func _update_boss_speed(speed):
	Global.boss.movement_speed = speed
