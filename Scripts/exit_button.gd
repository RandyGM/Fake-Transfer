extends Button

@export var scene_name : String = "insertar_datos"


func _ready() -> void:
	self.pressed.connect(on_exit_pressed)
	
func on_exit_pressed() -> void:
	Transition.fade_out()
	await get_tree().create_timer(0.25).timeout
	var change_scene : String = "res://Scenes/" + scene_name + ".tscn"
	get_tree().change_scene_to_file(change_scene)
