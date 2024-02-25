@tool
extends Control

const API_BASE_URL = "http://127.0.0.1"
const API_PATH_NOTIFICATION = "/post_event"
const API_PORT = "32010"
const CONFIG_FILE = "user://devkit.cfg"

@export_category("References")
@export var title_name_input: LineEdit
@export var auto_upload_switch: CheckButton
@export var linux_only_switch: CheckButton
@export var notification_request: HTTPRequest

var title_name: String = ""


func _ready():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err == OK:
		title_name = config.get_value("dock", "title_name")
		title_name_input.text = config.get_value("dock", "title_name")
		auto_upload_switch.button_pressed = config.get_value("dock", "auto_upload")
		linux_only_switch.button_pressed = config.get_value("dock", "linux_only")
	init_signals()


# Initialize signals
func init_signals():
	if DevkitMessenger.devkit_export_ended.is_connected(_on_notify_devkit) == false:
		DevkitMessenger.devkit_export_ended.connect(_on_notify_devkit)


# Handle unloading
func _exit_tree():
	if DevkitMessenger.devkit_export_ended.is_connected(_on_notify_devkit):
		DevkitMessenger.devkit_export_ended.disconnect(_on_notify_devkit)


# Send notification
func send_notification():
	var json_body = JSON.stringify({"type": "build", "status": "success", "name": title_name})
	var URL = API_BASE_URL + ":" + API_PORT + API_PATH_NOTIFICATION

	notification_request.request(
		URL, ["Content-Type: application/json"], HTTPClient.METHOD_POST, json_body
	)


# Signals
func _on_notification_request_completed(result, response_code, headers, body):
	if response_code == 200:
		print("Notification send!")
	else:
		print("Notification failed!")


func _on_notify_devkit():
	send_notification()


func _on_send_button_pressed():
	send_notification()


func _on_save_button_pressed():
	var config = ConfigFile.new()
	config.set_value("dock", "title_name", title_name_input.text)
	config.set_value("dock", "auto_upload", auto_upload_switch.button_pressed)
	config.set_value("dock", "linux_only", linux_only_switch.button_pressed)
	config.save(CONFIG_FILE)


func _on_notify_linux_check_button_pressed():
	DevkitMessenger.devkit_listen_for_linux_only.emit(linux_only_switch.button_pressed)


func _on_auto_notify_check_button_pressed():
	DevkitMessenger.devkit_toggle_export_listener.emit(auto_upload_switch.button_pressed)


func _on_title_name_input_text_changed(new_text: String):
	title_name = new_text


func _on_open_devkit_client_pressed():
	OS.shell_open("steam://rungameid/943760")
