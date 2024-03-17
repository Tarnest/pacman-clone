class_name GhostChase
extends GhostState

func _physics_process(_delta: float) -> void:
	match actor.ghost_type:
		actor.GhostType.RED: path_end = actor.main.tile_map.local_to_map(actor.player.position)
		actor.GhostType.PINK:
			path_end = actor.main.tile_map.local_to_map(actor.player.position) + Vector2i(actor.player.ray.target_position.normalized() * 4)
			var tile_data := actor.main.tile_map.get_cell_tile_data(0, path_end)
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				path_end = actor.main.tile_map.local_to_map(actor.player.position)
		actor.GhostType.BLUE: pass
		actor.GhostType.ORANGE: pass
	
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, actor.speed)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	_move()
