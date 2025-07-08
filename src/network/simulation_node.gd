extends Node

class_name SimulationNode

var id : int

func simulation_update(_simulation_tick: int) -> void:
    push_error("Simulation update must be overridden by all simulation nodes.")

func presentation_update(_delta: float) -> void:
    push_error("Presentation update must be overridden by all simulation nodes.")

func serialize() -> PackedByteArray:
    push_error("Serialize must be overridden by all simulation nodes.")
    return PackedByteArray()

func deserialize(_data: PackedByteArray) -> Dictionary:
    push_error("Deserialize must be overridden by all simulation nodes.")
    return {}