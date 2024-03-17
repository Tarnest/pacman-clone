class_name GhostState
extends State

@export var actor: Ghost

var new_position: Vector2
var is_moving := false
var path_end := Vector2i.ZERO

func _move() -> void:
	if path_end == Vector2i.ZERO:
		print_debug("path_end not set")
		return
	
	var astar_grid := actor.main.astar_grid
	var tile_map := actor.main.tile_map
	
	var tile_behind := tile_map.local_to_map(actor.global_position) - Vector2i(actor.direction)
	
	astar_grid.set_point_solid(tile_behind, true)
	
	var path := astar_grid.get_id_path(
		tile_map.local_to_map(actor.global_position),
		path_end
	)
	
	astar_grid.set_point_solid(tile_behind, false)
	
	path.pop_front()
	
	if path.is_empty():
		if not actor.forward_ray.is_colliding():
			actor.direction = actor.forward_ray.target_position.normalized()
		elif not actor.left_ray.is_colliding():
			actor.direction = actor.left_ray.target_position.normalized()
		elif not actor.right_ray.is_colliding():
			actor.direction = actor.right_ray.target_position.normalized()
		
		new_position = tile_map.map_to_local(tile_map.local_to_map(actor.global_position) + Vector2i(actor.direction))
	else:
		new_position = tile_map.map_to_local(path[0])
		actor.direction = actor.global_position.direction_to(new_position).normalized()
	
	actor.forward_ray.target_position = actor.direction * actor.ray_length
	actor.left_ray.target_position = actor.direction.rotated(PI/2) * actor.ray_length
	actor.right_ray.target_position = actor.direction.rotated(-PI/2) * actor.ray_length
	
	is_moving = true

func _enter() -> void:
	set_physics_process(true)

func _exit() -> void:
	set_physics_process(false)
