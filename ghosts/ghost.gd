@tool
class_name Ghost
extends Area2D

enum GhostType {
	RED,
	PINK,
	BLUE,
	ORANGE
}

@export var speed: float = 0.75
@export var ghost_texture: Texture2D
@export var main: Main
@export var player: Player
@export var ghost_type: GhostType = GhostType.RED
@export var blinky: Ghost

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var scatter: GhostScatter = $StateMachine/Scatter
@onready var chase: GhostChase = $StateMachine/Chase
@onready var forward_ray: RayCast2D = %ForwardRay
@onready var left_ray: RayCast2D = %LeftRay
@onready var right_ray: RayCast2D = %RightRay

var ray_length := 15
var direction := Vector2.ZERO

func _ready() -> void:
	if not Engine.is_editor_hint():
		scatter.scatter_finished.connect(state_machine.change_state.bind(chase))
	sprite.texture = ghost_texture
