extends FlowContainer

signal ReloadSignal
signal ExitGameSignal

func _on_restart_button_down():
	ReloadSignal.emit()


func _on_rage_quit_button_down():
	ExitGameSignal.emit()
