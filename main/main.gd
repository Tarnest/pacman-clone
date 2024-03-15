class_name Main
extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var score_label: Label = $UI/Score

var score: int = 0:
	set(_score):
		score = _score
		score_label.text = str(score)

var astar_grid: AStarGrid2D
var cell_size := Vector2(8, 8)

func _ready() -> void:
	Globals.pellet_eaten.connect(on_pellet_eaten)
	Globals.power_pellet_eaten.connect(on_power_pellet_eaten)
	
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = cell_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var region_size := astar_grid.region.size
	var region_position := astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position := Vector2i(
				x + region_position.x,
				y + region_position.y
			)
			
			var tile_data := tile_map.get_cell_tile_data(0, tile_position)
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				astar_grid.set_point_solid(tile_position)
			
			
func on_pellet_eaten() -> void:
	score += 10

func on_power_pellet_eaten() -> void:
	score += 50

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
