extends Camera2D

@export var scroll_speed: float = 50.0
@export var start_position_marker = Marker2D

func _ready():
	position = start_position_marker.position

func _physics_process(delta):
	var new_position = Vector2(scroll_speed * delta, 0)
	position += new_position
