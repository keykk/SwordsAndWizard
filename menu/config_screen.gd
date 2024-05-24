extends CanvasLayer
@onready var btn_baixo = %btn_baixo
@onready var box_controls = %BoxControls
@onready var box_control = %BoxControl
@onready var btn_tecla = %btn_tecla
@onready var btn_esquerda = %btn_esquerda
@onready var btn_direita = %btn_direita
@onready var btn_cima = %btn_cima
@onready var btn_atk = %btn_atk
@onready var btn_atk_2 = %btn_atk2
@onready var btn_begin = %btn_begin

var btn_misterioso: Button
var funcao: String
var cod_key: int
var tecla: String

var map_string = {
	"ESQUERDA":"move_left",
	"DIREITA":"move_right",
	"CIMA":"move_up",
	"BAIXO":"move_down",
	"ATAQUE":"attack",
	"ATAQUE 2":"attack_2"
}

func _unhandled_input(event):
	if (not visible):
		return
	
	if event.is_action_pressed("ui_cancel"):
		if (not is_instance_valid(btn_misterioso)):
			_on_btn_begin_pressed()
			return
		box_control.visible = false
		enable_focus_and_buttons(box_controls)
		btn_misterioso.grab_focus()
		if cod_key > 0:
			btn_misterioso.text = funcao + " [" + tecla + "]"
			
			var funcao_tecla = map_string[funcao]
			GameManager.clear_input_map()
			GameManager.input_map[funcao_tecla] = [cod_key]
			GameManager.load_input_map()
			btn_misterioso = null
			#print(funcao_tecla)
			pass
		pass
	pass
func _ready():
	btn_esquerda.grab_focus()
	box_control.visible = false
	exibe_controles_default()
	pass

func _input(event):
	if box_control.visible:
		if not event.is_action_pressed("ui_cancel"):
			if event is InputEventKey:
				var key_event = event as InputEventKey
				if key_event.pressed and key_event.keycode != 4194305:
					var last_key_pressed = key_event.as_text()
					btn_tecla.text = funcao + " [" + last_key_pressed + "]"
					cod_key = key_event.keycode
					tecla = last_key_pressed
					#print(last_key_pressed + ' - ' + str(key_event.keycode))#last_key_pressed
			elif event is InputEventMouseButton:
				var mouse_event = event as InputEventMouseButton
				if mouse_event.pressed:
					btn_tecla.text = funcao + " [" + mouse_event.as_text() + "]"
					cod_key = mouse_event.button_index
					tecla = mouse_event.as_text()
					#GameManager.input_map["attack"] = [mouse_event.button_index]
					pass
				pass
		pass
		
	pass
	
func disable_focus_and_buttons(node):
	# Desativa o foco do próprio nó
	if node is Control:
		node.focus_mode = Control.FOCUS_NONE
	
	# Desativa o próprio nó se for um botão
	if node is Button:
		node.disabled = true
	
	# Desativa o foco e desativa os botões e nós filhos
	for child in node.get_children():
		disable_focus_and_buttons(child)
		
func enable_focus_and_buttons(node):
	# Desativa o foco do próprio nó
	if node is Control:
		node.focus_mode = Control.FOCUS_ALL
	
	# Desativa o próprio nó se for um botão
	if node is Button:
		node.disabled = false
	
	# Desativa o foco e desativa os botões e nós filhos
	for child in node.get_children():
		enable_focus_and_buttons(child)

func select_botao(btn: Button, funcao_: String):
	btn_tecla.text = "[" + funcao_ + "] PRECIONE A TECLA DESEJADA"
	box_control.visible = true
	disable_focus_and_buttons(box_controls)
	btn_misterioso = btn
	funcao = funcao_
	cod_key = 0
	tecla = ""

func _on_btn_esquerda_pressed():
	select_botao(btn_esquerda, "ESQUERDA")
	pass # Replace with function body.

func _on_btn_direita_pressed():
	select_botao(btn_direita, "DIREITA")
	pass # Replace with function body.


func _on_btn_cima_pressed():
	select_botao(btn_cima, "CIMA")
	pass # Replace with function body.


func _on_btn_baixo_pressed():
	select_botao(btn_baixo, "BAIXO")
	pass # Replace with function body.


func _on_btn_atk_pressed():
	select_botao(btn_atk, "ATAQUE")
	pass # Replace with function body.


func _on_btn_atk_2_pressed():
	select_botao(btn_atk_2, "ATAQUE 2")
	pass # Replace with function body.


func _on_btn_default_pressed():
	GameManager.clear_input_map()
	GameManager.input_map = GameManager.default_input_map
	GameManager.load_input_map()
	exibe_controles_default()
	pass # Replace with function body.


func _on_btn_begin_pressed():
	visible = false
	#gambiarra
	var game_pause = GameManager.find_node_of_type(get_tree().get_root(), "CanvasLayer", "pause_menu")
	if not game_pause:
		get_tree().change_scene_to_file("res://menu/title_screen.tscn")
	else: 
		game_pause.visible = true
		game_pause.resume_btn.grab_focus()	
	#
	#var title_menu = GameManager.find_node_of_type(get_tree().get_root(), "Control", "TitleScreen")	
	#if title_menu:
		#title_menu.start_btn.grab_focus()
	pass # Replace with function body.

func exibe_controles_default():
	for key in map_string:
		var temp_btn: Button
		if key == "ATAQUE":
			temp_btn = btn_atk
		elif key == "ATAQUE 2":
			temp_btn = btn_atk_2
		elif key == "ESQUERDA":
			temp_btn = btn_esquerda
		elif key == "DIREITA":
			temp_btn = btn_direita
		elif key == "CIMA":
			temp_btn = btn_cima
		elif key == "BAIXO":
			temp_btn = btn_baixo
		else:
			continue		
		var btn_func = map_string[key]
		var txt_btn: String = ""
		for teclas in GameManager.input_map[btn_func]:
			if teclas == 1 || teclas == 2:
				var mouse = InputEventMouseButton.new()
				mouse.button_index = teclas
				if txt_btn == "":
					txt_btn += mouse.as_text()
				else: txt_btn += ', ' + mouse.as_text()
				pass
			else:
				var tecla2 = InputEventKey.new()
				tecla2.keycode = teclas
				if txt_btn == "":
					txt_btn += tecla2.as_text()
				else: txt_btn += ', ' + tecla2.as_text()	
				pass
			temp_btn.text = key + ' [' + txt_btn + ']'	
			pass
		pass
		temp_btn = null
	pass
