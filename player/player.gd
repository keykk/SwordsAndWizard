class_name Player
extends CharacterBody2D

@export_category("Personagem")
@export var speed: float = 3
@export var ataque_1: int = 40
@export var ataque_2: int = 60
#
#@export var explosion: PackedScene

@export var health: int = 200
@export var max_health: int = 200
@export var death_prefab: PackedScene
@export_category("Habilidades")
@export var ritu_scene: PackedScene
#@onready var sprite: Sprite2D = $Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ataque_magico: Area2D = $SwordArea
#@onready var ataque_magico_2: Area2D = $SwordArea2
@onready var health_progress_bar: ProgressBar = $HealthProgressBar
@onready var damage_digit_marker = $DamageDigitMarker
var input_vector: Vector2 = Vector2(0, 0)
var is_running: bool = false
var was_running: bool = false
var is_attacking: bool = false
var is_skill1: bool = false
var attack_cooldown: float = 0.0
var skill1_cooldown: float = 0.0
var atk: int = 0;
var damage_digit_prefab: PackedScene
var prefab: Array[PackedScene]

func _process(delta: float) -> void:
	GameManager.player_position = position
	GameManager.player_health = health
	#damage(GameManager.player_damage)
	#GameManager.player_damage = 0
	
	# Ler input
	read_input()
	
	# Processar ataque
	update_attack_cooldown(delta)
	if Input.is_action_just_pressed("attack") || Input.is_action_just_pressed("attack_2") || Input.is_action_just_pressed("attack_3") || Input.is_action_just_pressed("attack_special"):
		attack()
	
	#Processar animação e rotação de sprite
	play_idle_animation()
	
	if not is_attacking:
		rotate_sprite()	
	# Updage ProgressBar
	health_progress_bar.max_value = max_health
	health_progress_bar.value = health		

func _physics_process(delta: float) -> void:
	# Velocidade
	var target_velocity = input_vector * speed * 100
	
	if is_attacking:
		target_velocity *= 0.25
	
	velocity = lerp(velocity, target_velocity, 0.05)		
	move_and_slide()

func _ready():
	damage_digit_prefab = preload("res://misc/damage_digit.tscn")
	prefab.append(preload("res://misc/meat.tscn"))
	prefab.append(preload("res://misc/skull.tscn"))
	prefab.append(preload("res://misc/explosao.tscn")) 
func update_attack_cooldown(delta: float) -> void:
	if is_attacking:
		attack_cooldown -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if attack_cooldown <= 0.0:
			is_attacking = false
			is_running = false
			animation_player.play("idle")
			
	if is_skill1:
		skill1_cooldown -= delta
		
		if skill1_cooldown <= 0:
			is_skill1 = false
			
	
	
func read_input() -> void:
	# Vector
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Apagar deadzone do input vector
	var deadzone = 0.15
	if (abs(input_vector.x) < deadzone):
		input_vector.x = 0.0
	if (abs(input_vector.y) < deadzone):
		input_vector.y = 0.0
		
	# is_running
	was_running = is_running
	is_running = not input_vector.is_zero_approx()


func play_idle_animation() -> void:
	# Trocar animação
	if not is_attacking:
		if was_running != is_running:
			if is_running:
				animation_player.play("correr")
			else:
				animation_player.play("idle")


func rotate_sprite() -> void:
	# Girar sprite
	if input_vector.x > 0:
		# Desmarcar flip_h do Sprite2d
		#sprite.flip_h = false
		$Sprite2D.flip_h = false
	elif input_vector.x < 0:
		# Marcar flip_h do Sprite2d
		#sprite.flip_h = true
		$Sprite2D.flip_h = true
		

func attack() -> void:
	if is_attacking:
		return
	#tocar animação
	if Input.is_action_just_pressed("attack"):
		animation_player.play("ataque")
		atk = 1
		if !is_skill1:
			#var skill1 = ritu_scene.instantiate()
			#add_child(skill1)
			is_skill1 = true
			skill1_cooldown = 0.76
			pass
	elif Input.is_action_just_pressed("attack_2") == true || Input.is_action_just_pressed("attack_3") == true:
	
		atk = 2		
		animation_player.play("ataque_2")
	elif Input.is_action_just_pressed("attack_special"):
		pass
		
	# Cooldown
	attack_cooldown = 0.6
	#Marcar ataque
	is_attacking = true
	
	pass
	
func deal_damage_to_enemies() -> void:
	# Acessar todos os inimigos
	# Chamar a função "damage"
	#	Com "sword_damage" como primeiro parametro
	#sword_area.get_overlapping_areas() # AOE
	var bodies
	bodies = ataque_magico.get_overlapping_bodies()
		
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			if $Sprite2D.flip_h:
				attack_direction = Vector2.LEFT
			else:
				attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			if dot_product >= 0.3 and atk == 1:
				enemy.damage(ataque_1)
			elif dot_product < 0.3 and atk == 2:
				enemy.damage(ataque_2)
				
			pass
			
		pass
	atk = 0
	
func damage(amount: int) -> void:
	if amount == 0:
		return
	health -= amount
	#print("Dano ", amount,". Vida ",health)
	GameManager.player_health = health
	# Piscar inimigo
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	var damage_digit = damage_digit_prefab.instantiate()
	damage_digit.value = amount
	if damage_digit_marker:
		damage_digit.global_position = damage_digit_marker.global_position
	else:
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
	
	# Processar morte
	if health <= 0:
		die()
		
func die() -> void:
	var index = randf_range(0, prefab.size())
	var scene = prefab[index]
	var presunto = scene.instantiate()
	presunto.position = position
	get_parent().add_child(presunto)
		
	queue_free()

func heal(amount: int):
	health += amount
	if health > max_health:
		health = max_health
