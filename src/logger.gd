extends Node

var _log_file: FileAccess
var _log_file_path: String

func initialize():
    _set_log_path()
    _open_log_file()

func _open_log_file():
    _log_file = FileAccess.open(_log_file_path, FileAccess.WRITE)
    if _log_file:
        write("INFO", "Logger started at: " + Time.get_datetime_string_from_system())
    else:
        write("ERROR", "Failed to open log file at " + _log_file_path + ".")
        push_error("Failed to open log file at " + _log_file_path + ".")

func _set_log_path():
    var network_context = "server" if Launcher.parameters["server"] == true else "client"
    _log_file_path = "res://log/" + network_context + "_" + Time.get_datetime_string_from_system().replace("-","_").replace(":","_") + ".log"

func write(level: String, message: String):
    if _log_file:
        _log_file.store_line("["+ level + "][" + Time.get_datetime_string_from_system() + "] " + message)
        _log_file.flush()