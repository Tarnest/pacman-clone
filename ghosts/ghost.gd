@tool
class_name Ghost
extends Area2D

@export var speed: float = 0.75
@export var ghost_texture: Texture2D
@export var main: Main
@export var player: Player

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var scatter: Scatter = $StateMachine/Scatter
@onready var chase: Chase = $StateMachine/Chase

func _ready() -> void:
	if not Engine.is_editor_hint():
		scatter.scatter_finished.connect(state_machine.change_state.bind(chase))
	sprite.texture = ghost_texture
