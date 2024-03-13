extends Node2D

func _ready() -> void:
	Globals.pellet_eaten.connect(on_pellet_eaten)
	Globals.power_pellet_eaten.connect(on_power_pellet_eaten)

func on_pellet_eaten() -> void:
	print("eaten")
	print(Globals.pellets)

func on_power_pellet_eaten() -> void:
	print("Power Pellet!")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
