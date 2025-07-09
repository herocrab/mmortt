extends Node

@export var units : Dictionary = {}

func _ready() -> void:
	Logger.write("INFO", "UnitDb has " + str(units.size()) + " unit(s) in it.")
