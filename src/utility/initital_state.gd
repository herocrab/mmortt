extends StateMachineState

class_name InitialState

@export var next_state: StateMachineState

func _ready():
    Logger.write("INFO", "Network host has entered the INITIAL state.")
    var state_machine = get_state_machine()
    state_machine.current_state = next_state
