extends CharacterBody2D

# Variables
var speed = 200

func _ready() -> void:
	$CarpSpriteFrames.play("CarpIdleRight")  # Start with the "CarpIdleRight" animation

func _process(_delta):
# ===ANIMATIONS===
# Carp faces the direction that is pressed
	if Input.is_action_pressed("ui_right"):
		$CarpSpriteFrames.play("CarpWalkRight")

	if Input.is_action_pressed("ui_left"):
		$CarpSpriteFrames.play("CarpWalkLeft")

	if Input.is_action_pressed("ui_up"):
		$CarpSpriteFrames.play("CarpWalkUp")

	if Input.is_action_pressed("ui_down"):
		$CarpSpriteFrames.play("CarpWalkDown")

# Line up idle animations with direction that was just released
	if Input.is_action_just_released("ui_right"):
		$CarpSpriteFrames.play("CarpIdleRight")
	if Input.is_action_just_released("ui_left"):
		$CarpSpriteFrames.play("CarpIdleLeft")
	if Input.is_action_just_released("ui_up"):
		$CarpSpriteFrames.play("CarpIdleUp")
	if Input.is_action_just_released("ui_down"):
		$CarpSpriteFrames.play("CarpIdleDown")
# ===DIRECTIONAL INPUT===

func _physics_process(_delta):
#Reset Velocity
	print ("Velocity:", velocity)
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
		
	move_and_slide()
