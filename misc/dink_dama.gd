extends AnimatedSprite2D
@export var explosao: PackedScene
@onready var area_2d = $Area2D

func _ready():
	area_2d.body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D):
	if body.is_in_group("enemies"):
		apagar_parent()
		call_deferred("explode", body)
	
		pass
	pass
	
	
func explode(body):
	var explodir = explosao.instantiate()
	explodir.position = body.position
	explodir.scale = scale
	explodir.damage_amount = 20
	explodir.damage_no_player = 5
	get_parent().get_parent().add_child(explodir)
	pass	
	
	
func apagar_parent():
	get_parent().queue_free()
