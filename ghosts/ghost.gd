@tool
class_name Ghost
extends CharacterBody2D

@export var speed: int = 200
@export var ghost_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var scatter: Scatter = $StateMachine/Scatter
@onready var chase: Chase = $StateMachine/Chase

func _ready() -> void:
	scatter.scatter_finished.connect(state_machine.change_state.bind(chase))
	sprite.texture = ghost_texture