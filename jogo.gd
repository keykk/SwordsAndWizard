extends Node2D
@export var game_over_ui_template: PackedScene		
func _ready():
	var character = GameManager.Player.instantiate()
	var camera: Camera2D
	var mob_spaw
	var TransformeCamera: RemoteTransform2D
	var Transf_mob_spaw: RemoteTransform2D
	var DifficutySystem: Node
	GameManager.monsters_defeated_counter = 0
	GameManager.time_elapsed = 0.0
	GameManager.time_elapsed_string = "00:00"
	
	GameManager.game_over.connect(trigger_game_over)
	
	character.position = Vector2(460, 242)
	# verifica se existe e retorna
	mob_spaw = find_node_of_type(get_tree().get_root(), "Node2D", "MobSpaw") 
	DifficutySystem = find_node_of_type(get_tree().get_root(), "Node", "DifficutySystem") 
	# se não existe, cria
	if !mob_spaw:
		mob_spaw = load("res://system/mob_spaw.tscn")
		mob_spaw = mob_spaw.instantiate()
		add_child(mob_spaw)
		pass
	#verifica se ja existe camera e retorna a mesma
	camera = find_node_of_type(get_tree().get_root(), "Camera2D", "Camera2D")
	
	# se não existe camera , cria uma
	if !camera:
		camera = Camera2D.new()
		add_child(camera)
		pass
	DifficutySystem.mob_spawner = mob_spaw
	#cria e adiciona no player RemoteTransform2D para a camera
	TransformeCamera = RemoteTransform2D.new()
	Transf_mob_spaw = RemoteTransform2D.new()
	character.add_child(TransformeCamera)
	character.add_child(Transf_mob_spaw)
	
	TransformeCamera.remote_path = camera.get_path()
	Transf_mob_spaw.remote_path = mob_spaw.get_path()
	
	##Config da camera
	TransformeCamera.update_position = true
	TransformeCamera.update_rotation = false
	TransformeCamera.update_scale = false
	TransformeCamera.use_global_coordinates = true
	
	##Config mob spaw
	Transf_mob_spaw.update_position = true
	Transf_mob_spaw.update_rotation = false
	Transf_mob_spaw.update_scale = false
	Transf_mob_spaw.use_global_coordinates = true
	
	#character.add_child(TransformeCamera)	
	add_child(character)
	
#func check_for_camera2d(node):
	#for i in range(node.get_child_count()):
		#var child = node.get_child(i)
		#if child is Camera2D:
			#return true
		#elif child.get_child_count() > 0:
			#var result = check_for_camera2d(child)
			#if result:
				#return true
	#return false

func find_node_of_type(node, type_name, node_name):
	for child in node.get_children():
		if is_instance_valid(child) and child.get_class() == type_name and child.get_name() == node_name:
			return child
		elif child.get_child_count() > 0:
			var result = find_node_of_type(child, type_name, node_name)
			if result:
				return result
	return null
	
func trigger_game_over():	
	var game_ui = find_node_of_type(get_tree().get_root(), "Node", "Node")
	if game_ui:
		game_ui.queue_free()
		game_ui = null
	var game_over_ui: GameOverUI = game_over_ui_template.instantiate()
	add_child(game_over_ui)
	
	
	pass
