extends Area2D

@export var collectible_type: Global.Collectibles

var time = 0
var frequency = 5
var default_position: Vector2

var fish_texture = preload("res://Assets/Sprites/Props/fish_collectible.png")
var milk_texture = preload("res://Assets/Sprites/Props/milk_collectible.png")

func _ready():
	_set_texture()
	default_position = position

func _physics_process(_delta):
	time += Global.time * frequency
	position.y = default_position.y + sin(time)

func _on_body_entered(_body):
	if collectible_type != null :
		Global.add_score(collectible_type)
		queue_free()

func _set_texture():
	if (collectible_type == Global.Collectibles.Fish):
		$Sprite2D.set_texture(fish_texture)
	elif collectible_type == Global.Collectibles.MilkBottle:
		$Sprite2D.set_texture(milk_texture)
