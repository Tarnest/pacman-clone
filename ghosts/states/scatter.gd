class_name Scatter
extends State

signal scatter_finished

@export var actor: Ghost
@onready var scatter_timer: Timer = $ScatterTimer

var direction := Vector2.RIGHT

func _ready() -> void:
	scatter_timer.timeout.connect(on_scatter_timer_timeout)

func _enter() -> void:
	set_physics_process(true)
	scatter_timer.start()

func _exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	actor.velocity = direction.normalized() * actor.speed
	actor.move_and_slide()

func on_scatter_timer_timeout() -> void:
	scatter_finished.emit()
