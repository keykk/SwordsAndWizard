extends Node2D

var default_input_map = {
	"move_left": [88]
}
var input_map = {}
		
func _ready():
	if has_save_file():
		input_map = load_input_map()
	else:
		input_map = default_input_map
	var character = GameManager.Player.instantiate()
	character.position = Vector2(460, 242)
	#character.position.y = 4
	add_child(character)
	
func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		# Verifique se a tecla pressionada está mapeada para a ação de pulo
		if "move_left" in input_map and key_event.keycode in input_map["move_left"] and key_event.pressed:
			# Lógica para pular aqui
			print("Pular!")
	
# Função para carregar as configurações de entrada salvas
func load_input_map():
	# Lógica para carregar as configurações de um arquivo ou de outra fonte de dados
	# Retorna as configurações carregadas
	return self

# Função para verificar se há um arquivo de configuração salvo
func has_save_file():
	# Lógica para verificar se o arquivo de configuração está presente
	return false  # Exemplo simplificado, você deve implementar a lógica real aqui

# Lógica para salvar as configurações de entrada
func save_input_map():
	pass
