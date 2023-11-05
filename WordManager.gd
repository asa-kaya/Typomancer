class_name WordManager
extends Node

@export var factory: WordFactory
@export var typed_input: TypedInputReceiver
@export var cooldown_timer: Timer

var _cooldown: int = 1
var _word_selection: Array[String] = []

signal on_match_found(word: String)
signal word_selection_word_added(word: String)
signal word_selection_remove_at(index: int)

func _ready():
	factory.add_word("wash")
	factory.add_word("cow")
	factory.add_word("man")
	
	cooldown_timer.wait_time = _cooldown
	
	add_word(factory.random_word())
	add_word(factory.random_word())

func add_word(word: String):
	if (not word.is_empty()):
		_word_selection.append(word)
		word_selection_word_added.emit(word)
		print(",".join(_word_selection))

func remove_word(word: String):
	var index := _word_selection.find(word)
	if index < len(_word_selection):
		_word_selection.remove_at(index)
		word_selection_remove_at.emit(index)

func _process_word_match(word: String):
	remove_word(word)
	add_word(factory.random_word())
	typed_input.set_process_mode(Node.PROCESS_MODE_DISABLED)
	cooldown_timer.start()
	on_match_found.emit(word)

func _on_typed_input_receiver_input_updated(str: String):
	if (cooldown_timer.is_stopped() and _word_selection.has(str)):
		_process_word_match(str)

func _on_word_factory_unused_words_exhausted():
	factory.reload(_word_selection)
	add_word(factory.random_word())

func _on_cooldown_timer_timeout():
	typed_input.reset()
	typed_input.set_process_mode(Node.PROCESS_MODE_INHERIT)
