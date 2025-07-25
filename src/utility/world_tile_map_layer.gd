extends TileMapLayer

class_name WorldTileMapLayer

var _camera : Camera2D
var _material : Material

func _ready():
    _initialize()

func _initialize() -> void:
    _camera = get_viewport().get_camera_2d()
    _material = self.material

func _process(_delta: float) -> void:
    var viewport_size = get_viewport().get_visible_rect().size
    material.set_shader_parameter("viewport_size", viewport_size)

    var camera_pos = _camera.get_screen_center_position() - get_viewport().size * 0.5 * _camera.zoom
    material.set_shader_parameter("camera_world_position", camera_pos)