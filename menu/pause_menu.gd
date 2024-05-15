extends CanvasLayer
@onready var resume_btn = $menu_holder/resume_btn
@onready var text_edit = $menu_holder/TextEdit
func _ready():
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()
		pass
	pass

func _on_resume_btn_pressed():
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


func _on_text_edit_gui_input(event):
	GameManager.clear_input_map()
	var t = 0;
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed:
			var last_key_pressed = key_event.as_text_key_label()
			t = key_event.keycode
			
			text_edit.text = str(key_event.keycode)#last_key_pressed
			GameManager.input_map["attack"] = [key_event.keycode]
	elif event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.pressed:
			text_edit.text = str(mouse_event.button_index)
			GameManager.input_map["attack"] = [mouse_event.button_index]
	GameManager.load_input_map()
	pass # Replace with function body.
