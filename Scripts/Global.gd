extends Node

# Signals
signal PlayerDied
signal PlayerReceivedDamage

# Structs
enum Levels {
	Level1,
	Level2,
	Level3,
}

# Variables
var last_checkpoint: Checkpoint
var camera: Camera2D
var player: Cat

# Methods
func set_player(new_player: Cat):
	player = new_player

func set_camera(new_camera: Camera2D):
	camera = new_camera
