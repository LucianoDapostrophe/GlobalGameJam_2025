extends StaticBody2D

@export var default_texture: Texture2D
@export var interacted_texture: Texture2D

var is_interactable = false 

func _ready():
	$InteractionArea.area_entered.connect(Callable(self, "_on_area_entered"))
	$InteractionArea.area_exited.connect(Callable(self, "_on_area_exited"))
	$Sprite2D.texture = default_texture

func interact():
	if is_interactable:
		print("Chest opened")
		$Sprite2D.texture = interacted_texture

func _on_area_entered(body):
	print("Area entered by: ", body.name)
	if body.name == "Player":
		is_interactable = true

func _on_area_exited(body):
	print("Area exited by: ", body.name)
	if body.name == "Player":
		is_interactable = false


func _on_interaction_area_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.
