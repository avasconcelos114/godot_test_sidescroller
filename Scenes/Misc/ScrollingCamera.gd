extends Camera2D

@export var start_position_marker = Marker2D

var initial_position: Vector2

func _ready():
	Global.set_camera(self)
	position = start_position_marker.position
	initial_position = position
	
	# Reset camera to beginning of level when player hits restart
	Global.RestartFromCheckpointSignal.connect(_reset_camera)
	
func _physics_process(_delta):
	var new_position = Vector2(Global.camera_speed * Global.time, 0)
	position += new_position

func _reset_camera():
	position = initial_position
