@tool
extends EditorExportPlugin

func _export_end() -> void:
    DevkitMessenger.devkit_export_ended.emit()
