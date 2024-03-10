extends CharacterBody2D

@export var speed: int = 50
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var direction: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		direction = Vector2.UP
		rotation = deg_to_rad(-90)
	elif Input.is_action_just_pressed("move_down"):
		direction = Vector2.DOWN
		rotation = deg_to_rad(90)
	elif Input.is_action_just_pressed("move_left"):
		direction = Vector2.LEFT
		rotation = deg_to_rad(180)
	elif Input.is_action_just_pressed("move_right"):
		direction = Vector2.RIGHT
		rotation = deg_to_rad(0)
	
	velocity = direction.normalized() * speed
	
	if velocity.length() > 0:
		animation_player.play("moving")
	
	move_and_slide()
