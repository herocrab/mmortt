extends Node

class_name Host

@export var key: String = "defaultkey"
@export var nakama_service_ip: String = "127.0.0.1"
@export var nakama_service_port: int = 7350
@export var nakama_protocol: String = "http"

var _device_id: String
var _client: NakamaClient
var _session: NakamaSession
var _socket: NakamaSocket

var _refresh_interval: int = 600
var _refresh_timer: Timer

func _ready():
    _connect_to_nakama()
    _create_reauthentication_timer()

func _on_socket_ready():
    push_error("_on_socket_ready() is not overridden")

func _create_reauthentication_timer() -> void:
    _refresh_timer = Timer.new()
    _refresh_timer.wait_time = _refresh_interval
    _refresh_timer.one_shot = false
    _refresh_timer.timeout.connect(_reauthenticate_nakama)
    add_child(_refresh_timer)
    _refresh_timer.start()

func _reauthenticate_nakama() -> void:
    Logger.write("INFO", "Nakama client refreshing session.")
    _session = await _client.session_refresh_async(_session)
    if _session.is_exception():
        _session = await _client.authenticate_device_async(_device_id)
        Logger.write("ERROR", "Nakama client not able to re-authenticate.")

func _exit_tree() -> void:
    _client.session_logout_async(_session)
    Logger.write("INFO", "Nakama client session is logging out.")

func _connect_to_nakama():
    _device_id = OS.get_unique_id()
    _client = Nakama.create_client(key, nakama_service_ip, nakama_service_port, nakama_protocol, false, 0) #disable chatting logging
    _session = await _client.authenticate_device_async(_device_id)

    if _session.expired:
        Logger.write("INFO", "Nakama client session is expired, attempting to re-authenticate.")
        _reauthenticate_nakama()

    if _session.is_valid():
        Logger.write("INFO", "Nakama client has authenticated successfully.")
        _socket = Nakama.create_socket_from(_client)
        await _socket.connect_async(_session)

        if _socket.is_connected_to_host():
            Logger.write("INFO", "Nakama socket connected to real-time server.")
            _on_socket_ready()
        else:
            Logger.write("ERROR", "Nakama socket failed to connect to real-time server.")
    else:
        Logger.write("ERROR", "Nakama client has failed to authenticate.")