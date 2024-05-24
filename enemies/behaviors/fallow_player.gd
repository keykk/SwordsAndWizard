extends Node

@export var speed: float = 1

@export var sword_damage: int = 20
var health_progress_bar: ProgressBar
var sword_area: Area2D

var enemy2: Enemy
var animation_player: AnimationPlayer
var sprite: Sprite2D

var input_vector: Vector2 = Vector2(0, 0)
var player_position: Vector2 = Vector2(0, 0)

var enemy: CharacterBody2D

var attack_cooldown: float = 0
var is_attacking: bool = false
var is_running: bool = false
var was_running: bool = false
var atk: int = 0;

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("Sprite2D")
	animation_player = enemy.get_node("AnimationPlayer")
	sword_area = enemy.get_node("SwordArea")
	health_progress_bar = enemy.get_node("HealthProgressBar")

func _process(delta):
	update_attack_cooldown(delta)
	var bodies = sword_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			attack()
	health_progress_bar.max_value = enemy.max_health
	health_progress_bar.value = enemy.health
func _physics_process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	player_position = GameManager.player_position
	var difference = player_position - enemy.position
	input_vector =difference.normalized()
	
	enemy.velocity = input_vector * speed * 100
	
	if !is_attacking:
		if GameManager.player_health <= 0:
			animation_player.play("idle")
			return
		animation_player.play("correr")
		enemy.move_and_slide()
	rotate_sprite()
	
	pass
	
func rotate_sprite() -> void:
	# Girar sprite
	if input_vector.x > 0:
		# Desmarcar flip_h do Sprite2d
		sprite.flip_h = false
	elif input_vector.x < 0:
		# Marcar flip_h do Sprite2d
		sprite.flip_h = true

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
	
	#if atk == 0 || atk == 2:
	animation_player.play("ataque")
	atk = 1
	#elif atk == 1:
		#atk = 2	
		#animation_player.play("ataque_2")
		
	# Cooldown
	#Marcar ataque
	attack_cooldown = 0.6;
	is_attacking = true
	#deal_damage_to_enemies()
	pass	
	
#func deal_damage_to_enemies() -> void:
	## Acessar todos os inimigos
	## Chamar a função "damage"
	##	Com "sword_damage" como primeiro parametro
	##sword_area.get_overlapping_areas() # AOE
	##var bodies = sword_area.get_overlapping_bodies()
	##for body in bodies:
		##if body.is_in_group("player"):
			##var enemy: Enemyy = body
			##
			##var direction_to_enemy = (enemy.position - enemy.position).normalized()
			##var attack_direction: Vector2
			##if sprite.flip_h:
				##attack_direction = Vector2.LEFT
			##else:
				##attack_direction = Vector2.RIGHT
			##var dot_product = direction_to_enemy.dot(attack_direction)
			##enemy.damage(sword_damage)
			##if dot_product >= 0.5 and atk == 1:
				##enemy.damage(sword_damage)
			##elif dot_product <= 0.5 and dot_product >= -0.5 and atk == 2:
				##enemy.damage(sword_damage)
		#pass
