extends Node2D
func _ready():
	var character = GameManager.Player.instantiate()
	character.position = Vector2(460, 242)
	#character.position.y = 4
	add_child(character)
