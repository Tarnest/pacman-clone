extends Node2D

var score: int = 0:
	set(_score):
		score = _score
		# TODO: add updates for score UI

func _ready() -> void:
	Globals.pellet_eaten.connect(on_pellet_eaten)
	Globals.power_pellet_eaten.connect(on_power_pellet_eaten)

func on_pellet_eaten() -> void:
	score += 10
	print("eaten")
	print(score)

func on_power_pellet_eaten() -> void:
	score += 50
	print("Power Pellet!")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
