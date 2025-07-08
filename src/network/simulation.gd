extends Node

var _simulation_players : Dictionary = {}
var _simulation_player_id_index = 0
var _simulation_tick : int = 0

func reset():
	_simulation_players = {}
	_simulation_player_id_index = 0
	_simulation_tick = 0
	Logger.write("INFO", "Server simulation has been reset.")

func create_simulation_player() -> Player:
	var player = Player.new(_simulation_player_id_index)
	_simulation_players[player.id] = player
	_simulation_player_id_index += 1
	_simulation_players.sort()
	Logger.write("INFO", "Server simulation as created player " + str(player.id) + ".")
	return player

func remove_simulation_player(player: SimulationNode):
	if player.id in _simulation_players.keys():
		_simulation_players.erase(player.id)
		_simulation_players.sort()
		Logger.write("INFO", "Server simulation as removed player " + str(player.id) + ".")

func _physics_process(_delta: float) -> void:
	_simulation_update()

func update(delta: float):
	_presentation_update(delta)

func _simulation_update():
	for player in _simulation_players.values():
		player.simulation_update(_simulation_tick)
	_simulation_tick += 1

func _presentation_update(delta: float):
	for player in _simulation_players.values():
		player.presentation_update(delta)
