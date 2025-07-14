extends Node

var _astar: AStarGrid2D
var _tile_size_fixed: int

func load_tile_map_layer(tile_map_layer: TileMapLayer):
	_astar = AStarGrid2D.new()

	var tile_size = tile_map_layer.tile_set.tile_size
	_tile_size_fixed = tile_size.x * FixedMath.FIXED_ONE

	var used_rect = tile_map_layer.get_used_rect()
	var origin = used_rect.position
	var size = used_rect.size

	_astar.region = Rect2i(origin, size)
	_astar.cell_size = tile_size
	_astar.update()

	var is_not_walkable_count = 0
	for y in range(size.y):
		for x in range(size.x):
			var local_pos = Vector2i(x, y)
			var grid_pos = origin + local_pos
			var tile_data = tile_map_layer.get_cell_tile_data(grid_pos)
			var is_walkable := true

			if tile_data:
				if tile_data.has_custom_data("walkable"):
					is_walkable = tile_data.get_custom_data("walkable")
				else:
					is_walkable = false
			else:
				is_walkable = false

			if not is_walkable:
				is_not_walkable_count += 1
			_astar.set_point_solid(grid_pos, not is_walkable)

	_astar.update()
	Logger.write("INFO", "AStarGrid2D loaded with " + str(is_not_walkable_count) + " not walkable tiles.")

# Get the fixed world position, from the fixed grid position
func from_fixed_grid_to_fixed_world_pos(grid_pos: Vector2i) -> Vector2i:
	var x := grid_pos.x * _tile_size_fixed
	var y := grid_pos.y * _tile_size_fixed
	return Vector2i(x, y)

# Get the fixed grid position, from the fixed world position
func from_fixed_world_to_fixed_grid_pos(world_pos_fixed: Vector2i) -> Vector2i:
	var x := world_pos_fixed.x / _tile_size_fixed
	var y := world_pos_fixed.y / _tile_size_fixed
	return Vector2i(x, y)

# Get the presentation world position, from the fixed grid psoition
func from_fixed_grid_pos_to_presentation_world_pos(grid_pos: Vector2i) -> Vector2:
	return _astar.get_point_position(grid_pos)

# Get the fixed grid path, from fixed grid start and stop
func get_fixed_grid_path_from_fixed_grid_start_stop(start: Vector2i, stop: Vector2i) -> Array[Vector2i]:
	return _astar.get_id_path(start, stop, true)

# Get the fixed world path, from the fixed grid start and stop
func get_fixed_world_path_from_fixed_grid_start_stop(start: Vector2i, stop: Vector2i) -> Array[Vector2i]:
	var grid_path = get_fixed_grid_path_from_fixed_grid_start_stop(start, stop)
	var world_path_fixed = []
	for point in grid_path:
		var world_point = from_fixed_grid_to_fixed_world_pos(point)
		world_path_fixed.append(world_point)
	return world_path_fixed

# Get the presentation world path, from the fixed grid starta nd stop
func get_presentation_world_path_from_fixed_grid_start_stop(start: Vector2i, stop: Vector2i) -> PackedVector2Array:
	return _astar.get_point_path(start, stop)
