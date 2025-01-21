extends Area2D

signal collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Function to handle collision with the player
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "2DPlayer":  
		$AudioStreamPlayer2D.play()
		queue_free()  # Remove the collectible from the scene






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
