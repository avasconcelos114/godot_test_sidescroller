extends Panel

signal LoadNextLevelSignal

func _ready():
	Global.LevelClearedSignal.connect(_load_level_stats)

func _load_level_stats(level):
	var fish_tracker = $HFlowContainer/VBoxContainer/HBoxContainer/MarginContainer/FishCollected
	var milk_tacker = $HFlowContainer/VBoxContainer2/HBoxContainer/MarginContainer/MilkCollected
	fish_tracker.text = str(Global.scores[level][Global.Collectibles.Fish])
	milk_tacker.text = str(Global.scores[level][Global.Collectibles.MilkBottle])

func _on_button_button_down():
	LoadNextLevelSignal.emit()
