extends Area2D

@export var tp_type: String = ""
var distance: int = 230

func _ready() -> void:
	body_entered.connect(on_object_entered)
	# TODO: fix ghost movement
	area_entered.connect(on_object_entered)

func on_object_entered(body: Node2D) -> void:
	match tp_type:
		"left": body.position.x += distance
		"right": body.position.x -= distance
