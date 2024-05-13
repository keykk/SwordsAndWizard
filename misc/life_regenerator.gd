extends Node2D

@export var regeneration_amount: int = 10

@onready var area2d: Area2D = $Area2D

func _ready():
	area2d.body_entered.connect(on_body_entered)
	
	
func on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		#var player: Enemyy = body
		body.heal(regeneration_amount)
		queue_free()
