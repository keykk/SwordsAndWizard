extends AudioStreamPlayer2D
@export var playbacks: Array[AudioStreamMP3]
@onready var timer = %Timer

func _on_timer_timeout() -> void:
	var playback = playbacks.pick_random()
	stream = playback
	play()
	timer.start(randf_range(5.0,12.0))
	pass # Replace with function body.
