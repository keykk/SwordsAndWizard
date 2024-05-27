extends Control
@onready var start_btn = %start_btn

#func _unhandled_input(event):
func _ready():
	start_btn.grab_focus()
	#var pai = get_tree().get_root()
	#pai.move_child(GameManager.config_controls, 2)
	GameManager.base_exp = 100   # Base de experiência
	GameManager.exponent = 2     # Exponente que define a curva de dificuldade
	GameManager.current_level = 1
	GameManager.current_exp = 0
	GameManager.exp_needed = 100
	GameManager.enemies_qtd = 0;
	pass

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://menu/selecionar_personagem.tscn")
	pass # Replace with function body.


func _on_credits_btn_pressed():
	OS.shell_open("https://github.com/keykk/SwordsAndWizard.git")
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_config_btn_pressed():
	get_tree().change_scene_to_file("res://menu/config_screen.tscn")
	pass # Replace with function body.
