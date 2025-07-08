extends Node

var _log_file: FileAccess
var _log_file_path: String
var _log_to_std_out: bool = true

func initialize():
    _set_log_path()
    _open_log_file()

func _open_log_file() -> void:
    _log_file = FileAccess.open(_log_file_path, FileAccess.WRITE)
    if _log_file:
        write("INFO", "Logger started.")
    else:
        write("ERROR", "Failed to open log file at " + _log_file_path + ".")
        push_error("Failed to open log file at " + _log_file_path + ".")

func _set_log_path() -> void:
    var network_context = "server" if Launcher.parameters["server"] == true else "client"
    _log_file_path = "res://log/" + network_context + "_" + Time.get_datetime_string_from_system().replace("-","_").replace(":","_") + ".log"

func write(level: String, message: String) -> void:
    if _log_file:
        var full_message = "["+ level + "][" + Time.get_datetime_string_from_system() + "] " + message
        _log_file.store_line(full_message)
        _log_file.flush()
        if _log_to_std_out:
            print(full_message)

func _exit_tree() -> void:
    _log_file.close()