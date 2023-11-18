class_name TypedInputReceiver
extends Node

var _input: String = "" : set = _set_input
var alphabet_regex: RegEx

signal input_updated(str: String)

func _ready():
	alphabet_regex = RegEx.new()
	alphabet_regex.compile("[a-zA-Z]")
	
func _unhandled_key_input(event):
	if event is InputEventKey and event.is_pressed():
		var key_event := event as InputEventKey
		var txt : String = OS.get_keycode_string(event.keycode)
		
		if alphabet_regex.search(txt).get_string() == txt: #if letter
			_input += txt
		elif len(_input) > 0 and key_event.keycode == KEY_BACKSPACE:
			_input = _input.left(-1)
		elif len(_input) > 0 and key_event.keycode == KEY_SPACE:
			_input = ""

func reset():
	_input = ""

func _set_input(value: String):
	_input = value
	input_updated.emit(value)
