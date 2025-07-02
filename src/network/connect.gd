extends NetworkState

class_name Connect

@export var key: String = "defaultkey"
@export var nakama_service_ip: String = "127.0.0.1"
@export var nakama_service_port: int = 7350
@export var nakama_protocol: String = "http"

var _refresh_interval: int = 600
var _refresh_timer: Timer

func _enter_state() -> void:
	_connect_to_nakama()
	_create_reauthentication_timer()

func _create_reauthentication_timer() -> void:
	_refresh_timer = Timer.new()
	_refresh_timer.wait_time = _refresh_interval
	_refresh_timer.one_shot = false
	_refresh_timer.timeout.connect(_reauthenticate_nakama)
	add_child(_refresh_timer)
	_refresh_timer.start()

func _reauthenticate_nakama() -> void:
	Logger.write("INFO", "Nakama client refreshing session.")
	Host.session = await Host.client.session_refresh_async(Host.session)
	if Host.session.is_exception():
		Host.session = await Host.client.authenticate_device_async(Host.device_id)
		Logger.write("ERROR", "Nakama client has failed to connect.")

func _exit_tree() -> void:
	if Host.client != null and Host.session != null:
		Host.client.session_logout_async(Host.session)
		Logger.write("INFO", "Nakama client session is logging out.")

func _connect_to_nakama():
	Host.device_id = OS.get_unique_id()
	Host.client = Nakama.create_client(key, nakama_service_ip, nakama_service_port, nakama_protocol, false, 0) #disable chatting logging
	Host.session = await Host.client.authenticate_device_async(Host.device_id)

	if Host.session is NakamaSession:
		if Host.session.expired:
			Logger.write("INFO", "Nakama client session is expired, attempting to re-authenticate.")
			_reauthenticate_nakama()

		if Host.session.is_valid():
			Logger.write("INFO", "Nakama client has authenticated successfully.")
			Host.socket = Nakama.create_socket_from(Host.client)
			await Host.socket.connect_async(Host.session)

			if Host.socket.is_connected_to_host():
				Logger.write("INFO", "Nakama socket connected to real-time server.")
				var state_machine = get_state_machine()
				state_machine.current_state = next_state
			else:
				Logger.write("ERROR", "Nakama socket failed to connect to real-time server.")
		else:
			Logger.write("ERROR", "Nakama client has failed to authenticate.")
	else:
		Logger.write("ERROR", "Nakama client has failed to connect.")

