extends NetworkState

class_name Select

@export_group("Player Defaults")
@export var loadout : Dictionary = {}
@export var abilities: Dictionary = {}
@export var use_defaults: bool = true

@export_group("Client State Replication")
@export var join : Join

func _enter_state() -> void:
    _log_state()
    _select_loadout_and_abilities()
    _to_next_state()

func _log_state():
    Logger.write("INFO", "Client has entered the SELECT state.")

func _select_loadout_and_abilities():
    join.make_selection(loadout, abilities)

func _exit_state() -> void:
    Logger.write("INFO", "Client has selected units and abilities.")