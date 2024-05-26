extends Node2D
@export var damage_amount:float = 20.0

@onready var area2d: Area2D = $Area2D

func deal_damage():
	var bodies = area2d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			body.damage(damage_amount)
	pass
