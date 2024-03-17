class_name GhostChase
extends GhostState

var orange_ghost_corner := Vector2i(1, 28)
var tile_size := 8.0

func _physics_process(_delta: float) -> void:
	var tile_map := actor.main.tile_map
	var player_direction := Vector2i(actor.player.ray.target_position.normalized())
	var player := actor.player
	
	# TODO: Add a way to estimate the tile ghost paths towards
	
	match actor.ghost_type:
		actor.GhostType.RED: path_end = tile_map.local_to_map(player.position)
		actor.GhostType.PINK:
			path_end = tile_map.local_to_map(actor.player.position) + player_direction * 4
			var tile_data := tile_map.get_cell_tile_data(0, path_end)
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				path_end = tile_map.local_to_map(actor.player.position)
		actor.GhostType.BLUE: 
			var blinky_to_player := tile_map.local_to_map(player.position) + player_direction * 2 - tile_map.local_to_map(actor.blinky.position)
			path_end = tile_map.local_to_map(blinky_to_player * 2)
			var tile_data := tile_map.get_cell_tile_data(0, path_end)
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				path_end = tile_map.local_to_map(actor.player.position)
		actor.GhostType.ORANGE:
			var distance_from_player := actor.position.distance_to(actor.player.position)
			if not distance_from_player < tile_size * 8:
				path_end = tile_map.local_to_map(actor.player.position)
			else:
				path_end = orange_ghost_corner
	
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, actor.speed)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	_move()
