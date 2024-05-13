extends CharacterBody2D

@export var sword_damage: int = 20

@onready var sword_area: Area2D = $SwordArea

@onready var sprite: Sprite2D = $Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var attack_cooldown: float = 1
var is_attacking: bool = false
var is_running: bool = false
var was_running: bool = false
var atk: int = 0;

func _process(delta: float) -> void:
	# Ler input
	# Processar ataque
	update_attack_cooldown(delta)
	if ! is_attacking:
		var bodies = sword_area.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("player"):
				attack()

func update_attack_cooldown(delta: float) -> void:
	if is_attacking:
		attack_cooldown -= delta # 0.6 - 
	# Atualizar cooldown do attack
		if attack_cooldown <= 0.0:
			is_attacking = false
			is_running = false
			#animation_player.play("idle")

func attack() -> void:
	if is_attacking:
		return
	#tocar animação
	
	if atk == 0 || atk == 2:
		animation_player.play("ataque")
		atk = 1
	elif atk == 1:
		atk = 2	
		animation_player.play("ataque_2")
		
	# Cooldown
	#Marcar ataque
	attack_cooldown = 1;
	is_attacking = true
	#deal_damage_to_enemies()
	pass

func deal_damage_to_enemies() -> void:
	# Acessar todos os inimigos
	# Chamar a função "damage"
	#	Com "sword_damage" como primeiro parametro
	#sword_area.get_overlapping_areas() # AOE
	var bodies = sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			var enemy: Enemyy = body
			
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			if sprite.flip_h:
				attack_direction = Vector2.LEFT
			else:
				attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			enemy.damage(sword_damage)
			#if dot_product >= 0.5 and atk == 1:
				#enemy.damage(sword_damage)
			#elif dot_product <= 0.5 and dot_product >= -0.5 and atk == 2:
				#enemy.damage(sword_damage)
			pass
		pass
