extends Area2D

signal pellet_eaten

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin_Eater"):
		pellet_eaten.emit()
		queue_free()
