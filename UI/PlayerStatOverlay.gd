extends MarginContainer

func _ready():
	Global.PlayerDied.connect(update_lives)
	Global.RestartFromCheckpointSignal.connect(update_lives)

func update_lives():
	$VBoxContainer/LifeWrapper/RemainingLivesMarker.text = "x %s" % Global.player.lives
