class_name Scatter
extends State

signal scatter_finished

@export var actor: Ghost
@onready var scatter_timer: Timer = $ScatterTimer

var direction := Vector2.RIGHT
var is_moving := false
var new_position: Vector2

func _ready() -> void:
	scatter_timer.timeout.connect(on_scatter_timer_timeout)

func _enter() -> void:
	set_physics_process(true)
	scatter_timer.start()

func _exit() -> void:
	set_physics_process(false)

func on_scatter_timer_timeout() -> void:
	scatter_finished.emit()

func move() -> void:
	var astar_grid := actor.main.astar_grid
	var tile_map := actor.main.tile_map
	
	var path := astar_grid.get_id_path(
		tile_map.local_to_map(actor.global_position),
		tile_map.local_to_map(actor.player.global_position)
	)
	
	path.pop_front()
	
	if path.is_empty():
		print_debug("Can't find path")
		return
	
	new_position = Vector2(actor.global_position)

func _physics_process(_delta: float) -> void:
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, 1)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	move()
