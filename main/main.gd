extends Node2D

@onready var pellets := $Pellets.get_children()

func _ready() -> void:
	for pellet in pellets:
		pellet.connect("pellet_eaten", on_pellet_eaten)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()

func on_pellet_eaten() -> void:
	print("eaten")
