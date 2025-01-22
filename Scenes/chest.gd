extends Sprite2D

var is_interactable = false

func interact():
	if is_interactable:
		print("Chest opened")


func _on_interaction_area_area_entered(body):
	print("Area entered by: ", body.name)
	if body.name == "Player":
		is_interactable = true
		

func _on_interaction_area_area_exited(body):
	print("Area exited by: ", body.name)
	if body.name == "Player":
		is_interactable = false
