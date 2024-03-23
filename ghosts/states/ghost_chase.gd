class_name GhostChase
extends GhostState

@onready var player: Player = actor.player

var tile_map: TileMap
var orange_ghost_corner := Vector2i(1, 28)
var tile_size := 8.0
var player_direction: Vector2i

func _physics_process(_delta: float) -> void:
	player_direction = Vector2i(actor.player.ray.target_position.normalized())
	tile_map = actor.main.tile_map
	
	# TODO: Add a way to estimate the tile ghost paths towards
	
	match actor.ghost_type:
		actor.GhostType.RED: red()
		actor.GhostType.PINK: pink()
		actor.GhostType.BLUE: blue()
		actor.GhostType.ORANGE: orange()
	
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, actor.speed)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	_move()

func red() -> void:
	path_end = tile_map.local_to_map(player.position)

func pink() -> void:
	path_end = tile_map.local_to_map(actor.player.position) + player_direction * 4
	var tile_data := tile_map.get_cell_tile_data(0, path_end)
	if tile_data == null or not tile_data.get_custom_data("walkable"):
		path_end = tile_map.local_to_map(actor.player.position)

func blue() -> void:
	var blinky_to_player := tile_map.local_to_map(player.position) + player_direction * 2 - tile_map.local_to_map(actor.blinky.position)
	path_end = tile_map.local_to_map(blinky_to_player * 2)
	var tile_data := tile_map.get_cell_tile_data(0, path_end)
	if tile_data == null or not tile_data.get_custom_data("walkable"):
		path_end = tile_map.local_to_map(actor.player.position)

func orange() -> void:
	var distance_from_player := actor.position.distance_to(actor.player.position)
	if not distance_from_player < tile_size * 8:
		path_end = tile_map.local_to_map(actor.player.position)
	else:
		path_end = orange_ghost_corner

func estimate(target_tile: Vector2i, modifier: Vector2i = Vector2i.ZERO) -> Vector2i:
	var decrease_length := tile_size
	var current_tile := tile_map.local_to_map(global_position) + modifier
	var possible_tile := target_tile
	
	while true:
		var tile_data := tile_map.get_cell_tile_data(0, possible_tile)
		if tile_data != null and tile_data.get_custom_data("walkable"):
			break
		else:
			var current_to_possible := Vector2(current_tile)
			var len := current_to_possible.distance_to(possible_tile)
			var new_tile := 8
			
			possible_tile = possible_tile
	
	return Vector2i.ZERO
