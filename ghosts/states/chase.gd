class_name Chase
extends State

@export var actor: Ghost

var is_moving := false
var old_position := Vector2i.ZERO
var new_position: Vector2

func _enter() -> void:
	set_physics_process(true)

func _exit() -> void:
	set_physics_process(false)

func move() -> void:
	# TODO: only let ghost move forward
	
	var astar_grid := actor.main.astar_grid
	var tile_map := actor.main.tile_map
	
	if Vector2i(global_position) != old_position:
		var tile_to_ignore := tile_map.local_to_map(old_position)
		astar_grid.set_point_solid(tile_to_ignore, true)
	
	var path := astar_grid.get_id_path(
		tile_map.local_to_map(actor.global_position),
		tile_map.local_to_map(actor.player.global_position)
	)
	
	path.pop_front()
	
	if path.is_empty():
		print_debug("Can't find path")
		return
	
	old_position = tile_map.local_to_map(actor.global_position)
	new_position = tile_map.map_to_local(path[0])
	
	is_moving = true

func _physics_process(_delta: float) -> void:
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, _delta * actor.speed)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	move()
