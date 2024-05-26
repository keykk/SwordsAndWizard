extends Node
@export var skill_dink: PackedScene
var player_position: Vector2 = Vector2(521, 422)

func ativar_habilidade():
	var habilidade = skill_dink.instantiate()
	player_position = get_parent().position
	habilidade.position = player_position
	habilidade.position.y = habilidade.position.y - 150
	
	var def = habilidade.scale.x
	if get_parent().input_vector.y < 0:
		habilidade.rotation_degrees = -90
	elif get_parent().input_vector.y > 0: 
		habilidade.rotation_degrees = 90
	elif get_parent().get_node("Sprite2D").flip_h:
		habilidade.scale.x *= -1
	else:
		habilidade.scale.x = def
		pass
	
	get_parent().get_parent().add_child(habilidade)
	pass
