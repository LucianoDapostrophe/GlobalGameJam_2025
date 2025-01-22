extends CanvasLayer

const READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var msg_text = $TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY

func _ready():
	print("Starting state ready")
	hide_textbox()
	add_text("This text is going to be added")
	
func _process(delta: float):
	match current_state:
		State.READY:
			pass
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				tween.stop()
				msg_text.visible_ratio = 1.0
				on_tween_finished()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()
	
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
	change_state(State.READING)
	show_textbox()
	tween.connect("finished", on_tween_finished)
	tween.tween_property(msg_text, "visible_ratio", 1.0, len(next_text) * READ_RATE)
	
func on_tween_finished():
	end_symbol.text = "V"
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to ready")
		State.READING:
			print("Changing state to reading")
		State.FINISHED:
			print("Changing state to finished")
		
