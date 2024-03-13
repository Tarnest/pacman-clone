extends Node

signal pellet_eaten
signal power_pellet_eaten

var pellets: int = 0:
	set(_pellets):
		pellets = _pellets
		pellet_eaten.emit()

var power_pellets: int = 0:
	set(_power_pellets):
		power_pellets = _power_pellets
		power_pellet_eaten.emit()
