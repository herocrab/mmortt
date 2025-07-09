extends Node

class_name UnitDb

@export var units : Dictionary = {}

enum Uid {
	SQUARE = 0,
	CIRCLE = 1
}

func _ready() -> void:
	Logger.write("INFO", "UnitDb has " + str(units.size()) + " unit(s) in it.")
