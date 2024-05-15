extends Control
@onready var start_btn = $MarginContainer/HBoxContainer/VBoxContainer/start_btn

#func _unhandled_input(event):
func _ready():
	start_btn.grab_focus()
#	pass
	

func _on_start_btn_pressed():
	#get_tree().change_scene_to_file("res://jogo.tscn")
	get_tree().change_scene_to_file("res://menu/selecionar_personagem.tscn")
	pass # Replace with function body.


func _on_credits_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()
