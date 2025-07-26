extends TileMapLayer

class_name WorldTileMapLayer

@export var camera_attendant_name : String = "CameraAttendant"
@export var viewport_attendnant_name : String = "ViewportAttendant"

var _material : Material

func _ready():
	_initialize()

func _initialize() -> void:
	var server = Launcher.parameters["server"]
	if not server:
		_material = self.material
		var camera_attendant = get_tree().root.find_child(camera_attendant_name, true, false)
		camera_attendant.connect("camera_position_changed", _on_camera_position_changed)
		var viewport_attendant = get_tree().root.find_child(viewport_attendnant_name, true, false)
		viewport_attendant.connect("viewport_changed", _on_viewport_changed)

func _on_camera_position_changed(camera, _position) -> void:
	var camera_pos = camera.get_screen_center_position() - self.get_viewport().size * 0.5 * camera.zoom
	_material.set_shader_parameter("camera_world_position", camera_pos)

func _on_viewport_changed(size: Vector2) -> void:
	_material.set_shader_parameter("viewport_size", size)
