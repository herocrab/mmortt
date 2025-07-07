extends Node

class_name Navigation

var _astar: AStarGrid2D

func load_tile_map_layer(tile_map_layer: TileMapLayer):
    _astar = AStarGrid2D.new()

    var used_rect = tile_map_layer.get_used_rect()
    var origin = used_rect.position
    var size = used_rect.size

    _astar.region = Rect2i(origin, size)
    _astar.cell_size = Vector2(1, 1)
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

func get_grid_path(from: Vector2i, to: Vector2i) -> PackedVector2Array:
    return _astar.get_id_path(from, to, true)

func get_world_path(from: Vector2i, to: Vector2i) -> PackedVector2Array:
    var path = _astar.get_id_path(from, to, true)
    var world_path = []
    for point in path:
        var world_pos = point * 50
        world_path.append(world_pos)
    return world_path
