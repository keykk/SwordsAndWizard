extends Node
var Player: PackedScene

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

func _ready():
	load_input_map()

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
				InputMap.action_erase_event(action, input_mouse_button)	
				InputMap.action_add_event(action, input_mouse_button)
				
				pass
			else:
				InputMap.action_erase_event(action, tecla)	
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
