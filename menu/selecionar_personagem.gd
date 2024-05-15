extends Control
@onready var wizard = $MarginContainer/VBoxContainer/HBoxContainer/wizard_btn/Wizard
@onready var warrior_blue = $MarginContainer/VBoxContainer/HBoxContainer/warrior_btn/WarriorBlue
@onready var touch_blue = $MarginContainer/VBoxContainer/HBoxContainer3/touch_btn/TouchBlue
@onready var pawn_red = $MarginContainer/VBoxContainer/HBoxContainer3/paw_btn/PawnRed
@onready var btn_start = $MarginContainer/VBoxContainer/VBoxContainer2/btn_start


func _ready():
	wizard.get_node("HealthProgressBar").visible = false
	warrior_blue.get_node("HealthProgressBar").visible = false
	touch_blue.get_node("HealthProgressBar").visible = false
	pawn_red.get_node("HealthProgressBar").visible = false
	btn_start.disabled = true


func _on_btn_inicio_pressed():
	get_tree().change_scene_to_file("res://menu/title_screen.tscn")
	pass # Replace with function body.


func _on_wizard_btn_pressed():
	btn_start.text = "INICIAR COM WIZARD"
	btn_start.disabled = false
	GameManager.Player = preload("res://player/wizard.tscn")
	pass # Replace with function body.


func _on_warrior_btn_pressed():
	btn_start.text = "INICIAR COM WARRIOR"
	btn_start.disabled = false
	GameManager.Player = preload("res://player/warrior_blue.tscn")
	pass # Replace with function body.


func _on_touch_btn_pressed():
	btn_start.text = "INICIAR COM TOUCH"
	btn_start.disabled = false
	GameManager.Player = preload("res://player/touch_blue.tscn")
	pass # Replace with function body.


func _on_paw_btn_pressed():
	btn_start.text = "INICIAR COM PAW"
	btn_start.disabled = false
	GameManager.Player = preload("res://player/pawn_red.tscn")
	pass # Replace with function body.


func _on_btn_start_pressed():
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.
