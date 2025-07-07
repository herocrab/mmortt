extends StateMachineState

class_name NetworkState

@export var next_state: StateMachineState

func _to_next_state():
	var state_machine = get_state_machine()
	state_machine.current_state = next_state