extends SimulationNode

class_name Player

func _init(player_id: int):
	id = player_id

func simulation_update(_simulation_tick: int):
	pass

func presentation_update(_delta: float):
	pass

func serialize() -> PackedByteArray:
	return PackedByteArray()

func deserialize(_data: PackedByteArray) -> Dictionary:
	return {}
