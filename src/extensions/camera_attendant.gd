extends Node

class_name CameraAttendant

@export var camera : Camera2D

signal camera_position_changed(camera, position)

var _last_position: Vector2

func _ready() -> void:
    camera.make_current()
    _last_position = camera.global_position

func _process(_delta) -> void:
    var global_position = camera.global_position
    if global_position != _last_position:
        emit_signal("camera_position_changed", camera, global_position)
        _last_position = global_position
