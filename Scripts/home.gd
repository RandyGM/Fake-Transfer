extends Node2D

@onready var iniciar: Button = $CanvasLayer/Control/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Iniciar
@onready var salir: Button = $CanvasLayer/Control/PanelContainer/MarginContainer/MarginContainer2/Salir
@onready var download_btn : Button = $CanvasLayer/Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/DownloadBtn
@onready var cancel_btn : Button = $CanvasLayer/Popup/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/CancelBtn
@onready var control: Control = $CanvasLayer/Control
@onready var popup: Control = $CanvasLayer/Popup
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var http: HTTPRequest = HTTPRequest.new()

const VERSION = "1.0.0" # tu versión local
const API_URL = "https://api.github.com/repos/TU_USUARIO/TU_REPO/releases/latest"

var is_update : bool = false
var download_url : String = ""

func _ready() -> void:
	Transition.fade_in()
	iniciar.pressed.connect(on_start_pressed)
	salir.pressed.connect(on_quit_pressed)
	download_btn.pressed.connect(on_download_pressed)
	cancel_btn.pressed.connect(on_cancel_pressed)
	
	# agregar el HTTPRequest al árbol
	add_child(http)
	http.request_completed.connect(_on_request_completed)

	# pedir a GitHub el último release
	http.request(API_URL)


func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var data = JSON.parse_string(body.get_string_from_utf8())
		if typeof(data) == TYPE_DICTIONARY:
			var latest_version = data["tag_name"]
			var assets = data["assets"]

			if latest_version != VERSION:
				is_update = true
				# obtener el link de descarga del primer asset
				for asset in assets:
					if asset["name"].ends_with(".apk") or asset["name"].ends_with(".pck"):
						download_url = asset["browser_download_url"]
						break
				# mostrar popup
				popup.visible = true
				anim.play("Popup_in")


func on_start_pressed() -> void:
	Transition.fade_out()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Scenes/insertar_datos.tscn")
	
func on_quit_pressed() -> void:
	get_tree().quit()
	
func on_download_pressed() -> void:
	if is_update and download_url != "":
		print("Descargando:", download_url)
		# aquí puedes iniciar otra request para bajar el archivo
		# ejemplo:
		# http.request(download_url)
	else:
		print("No hay actualización disponible")
	
func on_cancel_pressed() -> void:
	anim.play("Popup_out")
	await get_tree().create_timer(0.25).timeout
	popup.visible = false
