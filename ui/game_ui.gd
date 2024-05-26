extends CanvasLayer
@onready var timer_label: Label = %TimerLabel
@onready var main_menu = %MainMenu
@onready var lbl_abates = %lbl_abates
@onready var lbl_inimigos = %lbl_inimigos



func _ready():
	main_menu.visible = false

func _process(delta: float):
	lbl_abates.text = '(' + str(GameManager.monsters_defeated_counter) + ') ABATES'
	lbl_inimigos.text = '(' + str(GameManager.enemies_qtd) + ') INIMIGOS'
	timer_label.text = GameManager.time_elapsed_string
	pass


func _on_button_pressed():
	if main_menu.visible:
		main_menu.visible = false
	else: main_menu.visible = true
	pass # Replace with function body.
