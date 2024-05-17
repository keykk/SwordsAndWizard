extends Node2D

@export var creatures: Array[PackedScene]
@export var mobs_per_minute: float = 60.0
@onready var path_follow_2d:PathFollow2D = %PathFollow2D
var cooldown: float = 0.0
func _ready():
	pass

func _process(delta: float):
	if GameManager.player_health <= 0:
		return
	# frequencia:monstro por minutos
	# temporarizador
	cooldown -= delta
	if cooldown > 0:
		return
	
	var interval = 60.0 / mobs_per_minute
	cooldown = interval

	#checar terreno valido
	var point = get_point()
	var world_state = get_world_2d().direct_space_state
	
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	#parameters.collision_mask = 0b1001
	var result: Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty(): return
	
	
	var index = randf_range(0, creatures.size())
	var creature_scene = creatures[index]
	var creature = creature_scene.instantiate()
	creature.global_position = get_point()
	get_parent().add_child(creature)
	pass
	
func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
