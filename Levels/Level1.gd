extends Node2D

func _ready():
	# First checkpoint is the player's spawn point
	Global.set_last_checkpoint($PlayerSpawn)

func _on_area_2d_body_entered(body):
	Global.player.kill_player()
