extends Node2D
@export var damage_amount: int = 50
@export var damage_no_player:int = 20

@onready var area2d: Area2D = $Area2D

func _ready():
	area2d.body_entered.connect(on_body_entered)
	
	
func on_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		body.damage(damage_amount)
	if body.is_in_group("player"):
		body.damage(damage_no_player)
