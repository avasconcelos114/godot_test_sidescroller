extends FlowContainer

signal LoadNextLevelSignal

func _ready():
	Global.LevelClearedSignal.connect(_load_level_stats)
	
func _load_level_stats():
	var fish_tracker = $HFlowContainer/VBoxContainer/HBoxContainer/MarginContainer/FishCollected
	var milk_tacker = $HFlowContainer/VBoxContainer2/HBoxContainer/MarginContainer/MilkCollected

	print(Global.scores[Global.current_level][Global.Collectibles.MilkBottle])
	fish_tracker.text = Global.scores[Global.current_level][Global.Collectibles.Fish]
	milk_tacker.text = Global.scores[Global.current_level][Global.Collectibles.MilkBottle]

func _on_button_button_down():
	LoadNextLevelSignal.emit()
