extends FlowContainer

signal StartGameSignal
signal ExitGameSignal


func _on_start_game_button_button_down():
	StartGameSignal.emit()


func _on_exit_game_button_down():
	ExitGameSignal.emit()
