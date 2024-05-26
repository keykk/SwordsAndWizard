extends Node
@export var skill: PackedScene

func ativar_habilidade():
	var habilidade = skill.instantiate()
	get_parent().add_child(habilidade)
	pass
