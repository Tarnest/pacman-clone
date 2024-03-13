class_name Chase
extends State

@export var actor: Ghost

var direction := Vector2.DOWN

func _enter() -> void:
	set_physics_process(true)

func _exit() -> void:
	set_physics_process(false)

func _physics_process(_delta: float) -> void:
	actor.velocity = direction.normalized() * actor.speed
	actor.move_and_slide()
