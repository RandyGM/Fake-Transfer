extends Control

@onready var user_name: Label = $PanelContainer/MarginContainer/VBoxContainer/user_name
@onready var money_label: Label = $PanelContainer/MarginContainer/VBoxContainer/money_label
@onready var time_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/time_label

func _ready() -> void:
	user_name.text = DataTemp.name_temp
	money_label.text = format_money(DataTemp.money_temp)
	time_label.text = get_formatted_datetime()

func get_formatted_datetime() -> String:
	var dt = Time.get_datetime_dict_from_system()

	var dias = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"]
	var meses = ["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic"]

	var dia_semana = dias[dt.weekday]
	var mes = meses[dt.month - 1]

	var hora = dt.hour % 12
	if hora == 0:
		hora = 12
	var ampm = "am" if dt.hour < 12 else "pm"

	return "%s, %02d %s %d %02d:%02d:%02d %s" % [
		dia_semana,
		dt.day,
		mes,
		dt.year,
		hora,
		dt.minute,
		dt.second,
		ampm
	]

func format_money(value: String) -> String:
	var amount = float(value)
	var int_part = int(amount)
	var decimal_part = int(round((amount - int_part) * 100))

	var str_num := str(int_part)
	var result := ""
	var count := 0
	for i in range(str_num.length() - 1, -1, -1):
		result = str_num[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	var decimals := "%02d" % decimal_part
	return "$" + result + "." + decimals
