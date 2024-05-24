class_name Enemy
extends Node2D
@export var explosion: PackedScene
@export var max_health: int = 150
@export var health: int = max_health
@export var death_prefab: PackedScene
@export var sword_damage: int = 20
@onready var damage_digit_marker = %DamageDigitMarker

var damage_digit_prefab: PackedScene
var prefab: Array[PackedScene]
#
func _ready():
	damage_digit_prefab = preload("res://misc/damage_digit.tscn")
	prefab.append(preload("res://misc/meat.tscn"))
	prefab.append(preload("res://misc/skull.tscn"))
	prefab.append(preload("res://misc/explosao.tscn")) 

func damage(amount: int) -> void:
	health -= amount
	#print("Dano ", amount,". Vida ",health)
	
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
	GameManager.enemy_pos = self.position
		
	#var index = randf_range(0, prefab.size())
	#var scene = prefab[index]
	#var presunto = scene.instantiate()
	#presunto.position = position
	#get_parent().add_child(presunto)
	call_deferred("DropDead")
		
	queue_free()
func DropDead():
	var index = randf_range(0, prefab.size())
	var scene = prefab[index]
	var presunto = scene.instantiate()
	presunto.position = position
	get_parent().add_child(presunto)
	
func deal_damage_to_enemies() -> void:
	var bodies = $SwordArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			body.damage(sword_damage)
	pass
