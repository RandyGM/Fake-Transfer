extends Node2D

@onready var name_line : LineEdit = $Control/PanelContainer/MarginContainer/VBoxContainer/NameLine
@onready var clabe_line : LineEdit = $Control/PanelContainer/MarginContainer/VBoxContainer/CLABELine
@onready var account_option : OptionButton = $Control/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/AccountOption
@onready var money_line : LineEdit = $Control/PanelContainer/MarginContainer/VBoxContainer/MoneyLine
@onready var ui_bank_option : OptionButton = $Control/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/UIBankOption

@onready var Enviar : Button = $Control/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Enviar

func _ready() -> void:
	Transition.fade_in()
	Enviar.pressed.connect(on_button_pressed)
	name_line.text = DataTemp.name_temp
	
func on_button_pressed() -> void:
	DataTemp.name_temp = name_line.text
	DataTemp.CLABE_temp = clabe_line.text
	DataTemp.account_temp = account_option.get_item_text(account_option.selected)
	DataTemp.money_temp = money_line.text
	DataTemp.ui_bank = ui_bank_option.get_item_text(ui_bank_option.selected)
	
	Transition.fade_out()
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file("res://Scenes/transferencia.tscn")
