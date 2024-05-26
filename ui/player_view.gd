extends CanvasLayer
@onready var hp_bar:TextureProgressBar = %HpBar
@onready var lbl_hp = %LblHp
@onready var lbl_nivel = %lbl_nivel
@onready var exp_bar = %ExpBar
@onready var lbl_exp = %lbl_exp

func _ready():
	hp_bar.max_value = GameManager.player_max_health
	exp_bar.max_value = GameManager.exp_needed
	exp_bar.value = 0
	pass
	
func _process(delta):
	if hp_bar.max_value != GameManager.player_max_health:
		hp_bar.max_value = GameManager.player_max_health
	hp_bar.value = GameManager.player_health
	lbl_hp.text = str(hp_bar.value) + ' / ' + str(hp_bar.max_value)	
	
	lbl_nivel.text = str(GameManager.current_level)
	
	#EXP
	if exp_bar.max_value != GameManager.exp_needed:
		exp_bar.max_value = GameManager.exp_needed
	exp_bar.value = GameManager.current_exp
	lbl_exp.text = '[LEVEL: ' + str(GameManager.current_level) + '] - ' + str(exp_bar.value) + ' / ' + str(exp_bar.max_value)
