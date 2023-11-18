class_name WordManager
extends Node

@export var factory: WordFactory
@export var typed_input: TypedInputReceiver
@export var cooldown_timer: Timer

var _word_selection: Array[String] = []

signal on_match_found(word: String)
signal word_selection_word_added(word: String)
signal word_selection_remove_at(index: int)
signal word_selection_modified(index: int, new_word: String)
signal typed_input_updated(str: String)

func init(word_bank: Array[String]):
	factory.init(word_bank)
	
	add_word(factory.random_word())
	add_word(factory.random_word())

func add_word(word: String):
	if (not word.is_empty()):
		_word_selection.append(word)
		word_selection_word_added.emit(word)

func remove_word(word: String):
	var index := _word_selection.find(word)
	if index < len(_word_selection):
		_word_selection.remove_at(index)
		word_selection_remove_at.emit(index)

func find_word(word: String) -> int:
	return _word_selection.find(word)

func replace_word_at(index: int, new_word: String):
	if index < 0 or index >= len(_word_selection):
		return
	factory.return_used_word(_word_selection[index])
	_word_selection[index] = new_word
	word_selection_modified.emit(index, new_word)

func _process_word_match(word: String):
	replace_word_at(find_word(word), factory.random_word())
	typed_input.reset()
	on_match_found.emit(word)

func _on_typed_input_receiver_input_updated(str: String):
	typed_input_updated.emit(str)
	
	if (_word_selection.has(str)):
		_process_word_match(str)
