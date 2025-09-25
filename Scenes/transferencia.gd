extends Node2D

@onready var mercado_pago: Control = $CanvasLayer/MercadoPago
@onready var nu_bank: Control = $CanvasLayer/nu_bank

func _ready() -> void:
	Transition.fade_in()
	if DataTemp.ui_bank == "NU_MEXICO":
		nu_bank.visible = true
		mercado_pago.visible = false
	else:
		nu_bank.visible = false
		mercado_pago.visible = true

	reset_temp()

func reset_temp():
	DataTemp.CLABE_temp = ""
	DataTemp.account_temp = ""
	DataTemp.money_temp = ""
