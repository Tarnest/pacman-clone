class_name GhostScatter
extends GhostState

signal scatter_finished

@onready var scatter_timer: Timer = $ScatterTimer

var corner: Vector2i

func _ready() -> void:
	scatter_timer.timeout.connect(on_scatter_timer_timeout)

func _enter() -> void:
	set_physics_process(true)
	scatter_timer.start()
	
	match actor.ghost_type:
		actor.GhostType.RED: corner = Vector2i(26, 1)
		actor.GhostType.PINK: corner = Vector2i(1, 1)
		actor.GhostType.BLUE: corner = Vector2i(26, 28)
		actor.GhostType.ORANGE: corner = Vector2i(1, 28)
	
	path_end = corner

func on_scatter_timer_timeout() -> void:
	scatter_finished.emit()

func _physics_process(_delta: float) -> void:
	if is_moving:
		actor.global_position = actor.global_position.move_toward(new_position, actor.speed)
		
		if actor.global_position != new_position:
			return
		
		is_moving = false
	
	_move()
