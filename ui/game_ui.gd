extends CanvasLayer
@onready var timer_label: Label = %TimerLabel

var time_elapsed: float = 0.0

func _process(delta: float):
	time_elapsed += delta
	#formatar timer
	var time_elapsed_in_seconds: int = floori(time_elapsed)
	var seconds: int = time_elapsed_in_seconds % 60
	var minutes: int = time_elapsed_in_seconds / 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
