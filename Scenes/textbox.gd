extends CanvasLayer

const READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var msg_text = $TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)

func _ready():
	hide_textbox()
	add_text("This text is going to be added")
	
func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	msg_text.text = ""
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func add_text(next_text):
	msg_text.text = next_text
	msg_text.visible_ratio = 0.0
	show_textbox()
	tween.tween_property(msg_text, "visible_ratio", 1.0, len(next_text) * READ_RATE)
