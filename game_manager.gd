extends Node

signal game_over

var Player: PackedScene
#var config_controls

var base_exp = 100   # Base de experiência
var exponent = 2     # Exponente que define a curva de dificuldade
var current_level = 1
var current_exp = 0
var exp_needed = 100

var player_position: Vector2
var player_damage: int = 0
var player_health: int
var player_max_health: int
var is_game_over: bool = false
var enemy_pos
var time_elapsed: float = 0.0
var time_elapsed_string: String
var monsters_defeated_counter: int = 0
var input_map = {
	"move_left": [KEY_LEFT, KEY_A],
	"move_right": [KEY_RIGHT, KEY_D],
	"move_up": [KEY_UP, KEY_W],
	"move_down": [KEY_DOWN, KEY_S],
	"attack": [MOUSE_BUTTON_LEFT],
	"attack_2": [MOUSE_BUTTON_RIGHT]
}

var default_input_map = {
	"move_left": [KEY_LEFT, KEY_A],
	"move_right": [KEY_RIGHT, KEY_D],
	"move_up": [KEY_UP, KEY_W],
	"move_down": [KEY_DOWN, KEY_S],
	"attack": [MOUSE_BUTTON_LEFT],
	"attack_2": [MOUSE_BUTTON_RIGHT]
}

var enemies_qtd: int = 0

func _ready():
	load_input_map()
	#call_deferred("criar_config_controls")

func _process(delta):
	
	time_elapsed += delta
	#formatar timer
	var time_elapsed_in_seconds: int = floori(time_elapsed)
	var seconds: int = time_elapsed_in_seconds % 60
	var minutes: int = time_elapsed_in_seconds / 60
	time_elapsed_string = "%02d:%02d" % [minutes, seconds]
	
func criar_config_controls():
	#config_controls = preload("res://menu/config_screen.tscn")
	#config_controls = config_controls.instantiate()
	#get_tree().root.add_child(GameManager.config_controls)
	#GameManager.set_index(99)
	#GameManager.config_controls.visible = false
	#
	#var title_menu = GameManager.find_node_of_type(get_tree().get_root(), "Control", "TitleScreen")	
	#if title_menu:
		#title_menu.start_btn.grab_focus()
	pass	
	
# Função para carregar as configurações de entrada salvas
func load_input_map():
	#vincular mapa
	for action in input_map.keys():
		var keys = input_map[action]
		for key in keys:
			var tecla = InputEventKey.new()
			tecla.keycode = key
			
			var input_mouse_button = InputEventMouseButton.new()
			
			if key == 1 || key == 2:
				input_mouse_button.pressed = true
				input_mouse_button.button_index = key
				InputMap.action_add_event(action, input_mouse_button)
				
				pass
			else:
				InputMap.action_add_event(action, tecla)	
	#print(str(input_map))

# Lógica para salvar as configurações de entrada
func clear_input_map():
	# desvincular antigo
	for action in input_map.keys():
		var keys = input_map[action]
		for key in keys:
			var tecla = InputEventKey.new()
			tecla.keycode = key
			
			var input_mouse_button = InputEventMouseButton.new()
			
			if key == 1 || key == 2:
				input_mouse_button.pressed = true
				input_mouse_button.button_index = key
				InputMap.action_erase_event(action, input_mouse_button)	
				
				pass
			else:
				InputMap.action_erase_event(action, tecla)	
	pass
	
func find_node_of_type(node, type_name: String, node_name: String):
	for child in node.get_children():
		if is_instance_valid(child) and child.get_class() == type_name and child.get_name() == node_name:
			return child
		elif child.get_child_count() > 0:
			var result = find_node_of_type(child, type_name, node_name)
			if result:
				return result
	return null



func experience_for_next_level(current_level):
	return base_exp * pow(current_level, exponent)

func add_experience(amount):
	current_exp += amount
	#print("Experiência atual: ", current_exp)
	while current_exp >= exp_needed:
		current_exp -= exp_needed
		level_up()
		
func level_up():
	current_level += 1
	player_health = player_max_health
	exp_needed = experience_for_next_level(current_level)
	#print("Nível atual: ", current_level, " - Experiência necessária para o próximo nível: ", exp_needed)

func end_game():
	if is_game_over: return
	is_game_over = true
	game_over.emit()
	
	
func reset():
	player_position = Vector2.ZERO
	is_game_over = false
	monsters_defeated_counter = 0
	time_elapsed = 0.0
	time_elapsed_string = "00:00"
	enemies_qtd = 0
	
	#RESETAR EXP
	base_exp = 100   # Base de experiência
	exponent = 2     # Exponente que define a curva de dificuldade
	current_level = 1
	current_exp = 0
	exp_needed = 100
	
	for connnection in game_over.get_connections():
		game_over.disconnect(connnection.callable)
	pass
