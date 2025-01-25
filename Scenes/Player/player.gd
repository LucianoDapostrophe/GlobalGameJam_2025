extends CharacterBody2D

# Variables
var speed = 200
@export var nearby_object: Area2D = null

func _ready() -> void:
	$CarpSpriteFrames.play("CarpIdleRight")  # Start with the "CarpIdleRight" animation
#Connect signals for object interactions
	$PlayerInteractionRange.connect("area_entered", Callable(self, "_on_InteractionArea_body_entered"))
	$PlayerInteractionRange.connect("area_exited", Callable(self, "_on_InteractionArea_body_entered"))
	
func _process(_delta:float) -> void:
	pass


func _physics_process(_delta):
#Reset Velocity
	velocity = Vector2.ZERO
#Character Movement
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	else:
		velocity.x = 0
# Normalize velocity to maintain consistent speed when moving diagonally
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed
# Apply movement
	move_and_slide()
# Update animations
	update_animation()
#Check for interaction input
	if Input.is_action_just_pressed("ui_accept") and nearby_object:
		nearby_object.interact()

func _on_InteractionArea_body_entered(body):
	if body.is_in_group("interactables"):  # Ensure the object is interactable
		nearby_object = body  # Store the reference to the interactable object

func _on_InteractionArea_body_exited(body):
	if body == nearby_object:
		nearby_object = null  # Clear the reference when leaving the interaction area
	
func update_animation():
# Line up idle animations with direction that was just released
	if Input.is_action_just_released("ui_right"):
		$CarpSpriteFrames.play("CarpIdleRight")
	if Input.is_action_just_released("ui_left"):
		$CarpSpriteFrames.play("CarpIdleLeft")
	if Input.is_action_just_released("ui_up"):
		$CarpSpriteFrames.play("CarpIdleUp")
	if Input.is_action_just_released("ui_down"):
		$CarpSpriteFrames.play("CarpIdleDown")
	# Determine direction based on velocity
	if abs(velocity.x) > abs(velocity.y):  # Horizontal movement
		if velocity.x > 0:
			$CarpSpriteFrames.play("CarpWalkRight")
			$CarpSpriteFrames.flip_h = false #ensure sprite faces right
		elif velocity.x < 0:
			$CarpSpriteFrames.play("CarpWalkLeft")
			
	else: #Vertical Movement
		if velocity.y > 0:
			$CarpSpriteFrames.play("CarpWalkDown")
		elif velocity.y < 0:
			$CarpSpriteFrames.play("CarpWalkUp")
