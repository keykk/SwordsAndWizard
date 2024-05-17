extends Node
var Player: PackedScene
#var config_controls
var player_position: Vector2
var player_damage: int = 0
var player_health: int

var enemy_pos

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

func _ready():
	load_input_map()
	#call_deferred("criar_config_controls")
	
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
