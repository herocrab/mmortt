extends Node2D

class_name ViewportAttendant

signal viewport_changed(size)

var _last_size: Vector2

func _ready() -> void:
    _last_size = get_viewport().get_visible_rect().size

func _process(_delta) -> void:
    var current_size = get_viewport().get_visible_rect().size
    if current_size != _last_size:
        emit_signal("viewport_changed", current_size)
        _last_size = current_size
