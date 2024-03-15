class_name Player
extends CharacterBody2D

@export var speed: int = 50

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var ray: RayCast2D = $RayCast2D
@onready var top_area: Area2D = $Areas/Top
@onready var bottom_area: Area2D = $Areas/Bottom
@onready var left_area: Area2D = $Areas/Left
@onready var right_area: Area2D = $Areas/Right
@onready var current_area: Area2D = left_area

var direction: Vector2 = Vector2.ZERO
var new_direction: Vector2 = Vector2.LEFT
var ray_length: int = 10

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		new_direction = Vector2.UP
		current_area = top_area
	elif Input.is_action_just_pressed("move_down"):
		new_direction = Vector2.DOWN
		current_area = bottom_area
	elif Input.is_action_just_pressed("move_left"):
		new_direction = Vector2.LEFT
		current_area = left_area
	elif Input.is_action_just_pressed("move_right"):
		new_direction = Vector2.RIGHT
		current_area = right_area
	
	if !current_area.has_overlapping_bodies():
		direction = new_direction.normalized()
	
	match direction:
		Vector2.UP: sprite.rotation = deg_to_rad(-90)
		Vector2.DOWN: sprite.rotation = deg_to_rad(90)
		Vector2.LEFT: sprite.rotation = deg_to_rad(180)
		Vector2.RIGHT: sprite.rotation = deg_to_rad(0)
	
	velocity = direction * speed
	if velocity.length() > 0:
		animation_player.play("moving")
	
	ray.target_position = direction * ray_length
	if ray.is_colliding():
		animation_player.pause()
	
	move_and_slide()
