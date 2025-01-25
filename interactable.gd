extends Area2D

@export var default_texture: Texture2D
@export var interacted_texture: Texture2D

func _ready():
	$Sprite2D.texture = default_texture

func interact():
	print("Interacted with object!")
	$Sprite2D.texture = interacted_texture
	$AudioStreamPlayer2D.play()
