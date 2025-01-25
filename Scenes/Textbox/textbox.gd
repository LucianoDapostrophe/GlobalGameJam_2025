extends CanvasLayer

const READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var msg_text = $TextboxContainer/MarginContainer/HBoxContainer/Text

enum State {
	READY,
	READING,
	FINISHED
}

var tween
var current_state = State.READY
var text_queue = []

func _ready():	
	print("Starting state ready")
	hide_textbox()
	queue_text("First text queued")
	queue_text("second text queued")
	queue_text("third text queued")
	queue_text("fourth text queued")
	
func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
			else:
				hide_textbox()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				tween.kill()
				msg_text.visible_ratio = 1.0
				on_tween_finished()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				clear_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func clear_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	msg_text.text = ""

func hide_textbox():
	clear_textbox()
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	msg_text.text = next_text
	msg_text.visible_ratio = 0.0
	change_state(State.READING)
	tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).bind_node(self)
	tween.connect("finished", on_tween_finished)
	show_textbox()
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
		
