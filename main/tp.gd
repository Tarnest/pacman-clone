extends Area2D

@export var tp_type: String = ""
var distance: int = 230

func _ready() -> void:
	body_entered.connect(on_body_entered)	

func on_body_entered(body: Node2D) -> void:
	match tp_type:
		"left": body.position.x += distance
		"right": body.position.x -= distance
