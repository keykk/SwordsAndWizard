extends Node
@export var skill: PackedScene
var player_position: Vector2 = Vector2(521, 422)
var attack_cooldown: float = 0.0
var is_attacking: bool = false

func ativar_habilidade():
	if is_attacking:
		return
	var habilidade = skill.instantiate()
	player_position = get_parent().position
	habilidade.position = player_position
	
	var def = habilidade.scale.x
	if get_parent().input_vector.y < 0:
		habilidade.rotation_degrees = -90
	elif get_parent().input_vector.y > 0: 
		habilidade.rotation_degrees = 90
	elif get_parent().get_node("AnimatedSprite2D").flip_h:
		habilidade.scale.x *= -1
	else:
		habilidade.scale.x = def
		pass
	
	get_parent().get_parent().add_child(habilidade)
	attack_cooldown = 10.0
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
