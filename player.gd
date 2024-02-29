extends CharacterBody2D

@export var speed: int = 200
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("move_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("move_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("move_right"):
		direction = Vector2.RIGHT
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
