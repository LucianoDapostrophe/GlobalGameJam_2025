extends AnimationPlayer

# Variables
var speed = 200

func _ready() -> void:
	$AnimationPlayer/CarpSpriteFrames.play("CarpIdleRight")  # Start with the "CarpIdleRight" animation

func _process(_delta):
# ===ANIMATIONS===
# Carp faces the direction that is pressed
	if Input.is_action_pressed("ui_right"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpWalkRight")
	if Input.is_action_pressed("ui_left"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpWalkLeft")
	if Input.is_action_pressed("ui_up"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpWalkUp")
	if Input.is_action_pressed("ui_down"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpWalkDown")
# Line up idle animations with direction that was just released
	if Input.is_action_just_released("ui_right"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpIdleRight")
	if Input.is_action_just_released("ui_left"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpIdleLeft")
	if Input.is_action_just_released("ui_up"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpIdleUp")
	if Input.is_action_just_released("ui_down"):
		$AnimationPlayer/CarpSpriteFrames.play("CarpIdleDown")
# ===DIRECTIONAL INPUT===

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
