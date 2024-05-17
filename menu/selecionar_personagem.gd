extends Control
@onready var wizard = $MarginContainer/VBoxContainer/HBoxContainer/wizard_btn/Wizard
@onready var warrior_blue = $MarginContainer/VBoxContainer/HBoxContainer/warrior_btn/WarriorBlue
@onready var touch_blue = $MarginContainer/VBoxContainer/HBoxContainer3/touch_btn/TouchBlue
@onready var pawn_red = $MarginContainer/VBoxContainer/HBoxContainer3/paw_btn/PawnRed
@onready var btn_start = $MarginContainer/VBoxContainer/VBoxContainer2/btn_start

@onready var btn_inicio = $MarginContainer/VBoxContainer/VBoxContainer/btn_inicio

var wizard_cd: float = 0.0
var is_wizard = false
var wizard_sprite: AnimatedSprite2D

var warrior_cd: float = 0.0
var is_warrior = false
var warrior_sprite: AnimationPlayer

var touch_cd: float = 0.0
var is_touch = false
var touch_sprite: AnimationPlayer

var paw_cd: float = 0.0
var is_paw = false
var paw_sprite: AnimationPlayer

func _ready():
	btn_inicio.grab_focus()
	wizard.get_node("HealthProgressBar").visible = false
	warrior_blue.get_node("HealthProgressBar").visible = false
	touch_blue.get_node("HealthProgressBar").visible = false
	pawn_red.get_node("HealthProgressBar").visible = false
	btn_start.disabled = true
	wizard_sprite = wizard.get_node("AnimatedSprite2D")
	warrior_sprite = warrior_blue.get_node("AnimationPlayer")
	touch_sprite = touch_blue.get_node("AnimationPlayer")
	paw_sprite = pawn_red.get_node("AnimationPlayer")

func _process(delta: float):
	wizard_animation_cd(delta)
	warrior_animation_cd(delta)
	touch_animation_cd(delta)
	paw_animation_cd(delta)

func wizard_animation_cd(delta: float) -> void:
	if is_wizard:
		wizard_cd -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if wizard_cd <= 0.0:
			is_wizard = false
			wizard_sprite.play("idle")
			
func warrior_animation_cd(delta: float) -> void:
	if is_warrior:
		warrior_cd -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if warrior_cd <= 0.0:
			is_warrior = false
			warrior_sprite.play("idle")
			
func touch_animation_cd(delta: float) -> void:
	if is_touch:
		touch_cd -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if touch_cd <= 0.0:
			is_touch = false
			touch_sprite.play("idle")
			
func paw_animation_cd(delta: float) -> void:
	if is_paw:
		paw_cd -= delta # 0.6 - 0.016    0.584
	
	# Atualizar cooldown do attack
		if paw_cd <= 0.0:
			is_paw = false
			paw_sprite.play("idle")

func _on_btn_inicio_pressed():
	get_tree().change_scene_to_file("res://menu/title_screen.tscn")
	pass # Replace with function body.


func _on_wizard_btn_pressed():
	btn_start.text = "INICIAR COM WIZARD"
	btn_start.disabled = false
	
	if !is_wizard:
		wizard_sprite.play("ataque")
		wizard_cd = 0.75
		is_wizard = true
	GameManager.Player = preload("res://player/wizard.tscn")
	pass # Replace with function body.


func _on_warrior_btn_pressed():
	btn_start.text = "INICIAR COM WARRIOR"
	btn_start.disabled = false
	
	if !is_warrior:
		warrior_sprite.play("ataque")
		warrior_cd = 0.6
		is_warrior = true
	
	GameManager.Player = preload("res://player/warrior_blue.tscn")
	pass # Replace with function body.


func _on_touch_btn_pressed():
	btn_start.text = "INICIAR COM TOUCH"
	btn_start.disabled = false
	
	if !is_touch:
		touch_sprite.play("ataque")
		touch_cd = 0.6
		is_touch = true
	
	GameManager.Player = preload("res://player/touch_blue.tscn")
	pass # Replace with function body.


func _on_paw_btn_pressed():
	btn_start.text = "INICIAR COM PAW"
	btn_start.disabled = false
	
	if !is_paw:
		paw_sprite.play("ataque")
		paw_cd = 0.6
		is_paw = true
	
	GameManager.Player = preload("res://player/pawn_red.tscn")
	pass # Replace with function body.


func _on_btn_start_pressed():
	get_tree().change_scene_to_file("res://jogo.tscn")
	pass # Replace with function body.
