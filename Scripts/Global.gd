extends Node

# Signals
signal PlayerDied
signal PlayerReceivedDamage
signal GameOverSignal
signal RestartFromCheckpointSignal
signal LevelClearedSignal

# Variables
enum Levels {
	Level1,
	Level2,
	Level3,
}

enum Collectibles {
	Fish,
	YarnBall,
	MilkBottle,
}

var time = 0
var is_paused = false

var scores : Dictionary = {
	Levels.Level1: {
		Collectibles.Fish: 0,
		Collectibles.YarnBall: 0,
		Collectibles.MilkBottle: 0,
	},
	Levels.Level2: {
		Collectibles.Fish: 0,
		Collectibles.YarnBall: 0,
		Collectibles.MilkBottle: 0,
	},
	Levels.Level3: {
		Collectibles.Fish: 0,
		Collectibles.YarnBall: 0,
		Collectibles.MilkBottle: 0,
	}
}

var last_checkpoint: Checkpoint
var current_level: Levels
var camera: Camera2D
var player: Cat

# Methods
func _ready():
	PlayerDied.connect(respawn_player)

func _physics_process(delta):
	if is_paused:
		time = 0
	else:
		time = delta

	# Toggle pause state only when a level is active
	if current_level != null and Input.is_action_just_pressed("pause"):
		is_paused = !is_paused

func respawn_player():
	if player.lives:
		player.position = last_checkpoint.position
		camera.position = last_checkpoint.position
	else:
		GameOverSignal.emit()

func set_pause_game(new_is_paused):
	is_paused = new_is_paused

func set_last_checkpoint(new_checkpoint: Checkpoint):
	last_checkpoint = new_checkpoint

func set_player(new_player: Cat):
	player = new_player

func set_camera(new_camera: Camera2D):
	camera = new_camera

func set_level(new_level: Levels):
	current_level = new_level

func add_score(type: Collectibles):
	if current_level != null:
		scores[current_level][type] += 1
