extends Control

@onready var user_name: Label = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Sprite2D2/User_Name
@onready var para_label: Label = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ParaLabel
@onready var account_label: Label = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/AccountLabel
@onready var money_label: Label = $PanelContainer/MarginContainer/VBoxContainer/PanelContainer2/MarginContainer/VBoxContainer/MoneyLabel

func _ready() -> void:
	user_name.text = DataTemp.name_temp[0]
	para_label.text = "Para " + DataTemp.name_temp
	account_label.text = "A su cuenta de " + str(DataTemp.account_temp)
	money_label.text = "$ " + format_with_commas(DataTemp.money_temp)

func format_with_commas(value: String) -> String:
	var num = int(value)
	var result := ""
	var str_num := str(num)
	var count := 0

	for i in range(str_num.length() - 1, -1, -1):
		result = str_num[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	return result
