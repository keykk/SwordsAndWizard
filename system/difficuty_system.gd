extends Node
@export var mob_spawner: MobSpawner
@export var Initial_spaw_rate: float = 60.0
@export var spawn_rate_per_minute: float = 30.0
@export var wave_duration: float = 20.0
@export var break_intensity: float = 0.5
var time: float = 0.0

func _process(delta: float) ->void:
	
	if GameManager.is_game_over:
		return
	
	time += delta
	
	#linear
	var spawm_rate = Initial_spaw_rate + spawn_rate_per_minute * (time / 60.0)
	# ondas
	var sin_wave = sin((time * TAU) / wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity, 1)
	
	spawm_rate *= wave_factor
	
	#aplica dificuldade
	mob_spawner.mobs_per_minute = spawm_rate
	pass
