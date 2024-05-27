extends Node
@export var skill: PackedScene
var attack_cooldown: float = 0.0
var is_attacking: bool = false

func ativar_habilidade():
	if is_attacking:
		return
		
	var habilidade = skill.instantiate()
	get_parent().add_child(habilidade)
	
	attack_cooldown = 7.0
	is_attacking = true
	pass

func _process(delta):
	update_attack_cooldown(delta)

func update_attack_cooldown(delta: float) -> void:
	if is_attacking:
		attack_cooldown -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if attack_cooldown <= 0.0:
			is_attacking = false
