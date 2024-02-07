@tool
extends EditorPlugin

var dock = preload("dock.tscn").instantiate()

const ExportNotifierPlugin = preload("export_notifier.gd")
var export_notifier_plugin = ExportNotifierPlugin.new()

var has_loaded = false

func _enter_tree() -> void:
	if has_loaded:
		return
	if !ProjectSettings.has_setting("autoload/DevkitMessenger"):
		add_autoload_singleton("DevkitMessenger", "devkit_messenger.gd")
	add_control_to_dock(DOCK_SLOT_LEFT_BR, dock)
	add_export_plugin(export_notifier_plugin)
	has_loaded = true

func _exit_tree() -> void:
	remove_control_from_docks(dock)
	remove_export_plugin(export_notifier_plugin)
	remove_autoload_singleton("DevkitMessenger")
	dock.free()
