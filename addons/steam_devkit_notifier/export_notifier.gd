@tool
extends EditorExportPlugin

var is_linux: bool = false
var is_export_listener_enabled: bool = false
var is_listening_for_linux_only: bool = false

func _init():
    DevkitMessenger.devkit_listen_for_linux_only.connect(_on_devkit_listen_for_linux_only)
    DevkitMessenger.devkit_toggle_export_listener.connect(_on_devkit_toggle_export_listener)

func _on_devkit_listen_for_linux_only(state: bool) -> void:
    is_listening_for_linux_only = state

func _on_devkit_toggle_export_listener(state: bool) -> void:
    is_export_listener_enabled = state

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
    if features.find("linux") != -1:
        is_linux = true
    else:
        is_linux = false

func _export_end() -> void:
    if is_export_listener_enabled:
        if is_listening_for_linux_only:
            if is_linux:
                DevkitMessenger.devkit_export_ended.emit()
        else:
            DevkitMessenger.devkit_export_ended.emit()
