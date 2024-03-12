extends Node

signal pellet_eaten

var pellets: int = 0:
	set(_pellets):
		pellets = _pellets
		pellet_eaten.emit()
