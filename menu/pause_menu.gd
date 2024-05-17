extends CanvasLayer
@onready var resume_btn = %resume_btn

var conf_control: CanvasLayer

func _ready():
	visible = false
	conf_control = get_parent().get_node("configScreen")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if not conf_control.visible:
			visible = true
			get_tree().paused = true
			resume_btn.grab_focus()
		pass
	pass

func _on_resume_btn_pressed():
	if not conf_control.visible:
		get_tree().paused = false
	visible = false
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().paused = false
	kill_all_characters()
	get_tree().change_scene_to_file("res://menu/title_screen.tscn")
	pass # Replace with function body.
	
func kill_all_characters():
	for node in get_tree().get_current_scene().get_children():
		# Verificar se o nó é uma instância de CharacterBody2D
		if node is CharacterBody2D:
		# "Matar" (remover) o nó da cena
			node.queue_free() 


func _on_btn_config_pressed():
	visible = false
	
	conf_control.visible = true
	conf_control.btn_esquerda.grab_focus()
	pass # Replace with function body.
