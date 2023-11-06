class_name WordFactory
extends Node

var _word_bank: Array[String] = []
var _unused_words: Array[String] = []

func add_word(word: String):
	_word_bank.append(word.to_upper())
	_word_bank.sort()	
	_unused_words.append(word.to_upper())
	_unused_words.sort()

func remove_word(word):
	var index := _word_bank.bsearch(word)
	if index < len(_word_bank):
		_word_bank.remove_at(index)

func use_word(word: String):
	var index := _unused_words.bsearch(word)
	if index < len(_unused_words):
		_unused_words.remove_at(index)
		return word
	else:
		return ""

func random_word() -> String:
	var index := randi() % len(_unused_words)
	var word := _unused_words[index]
	_unused_words.remove_at(index)
	
	return word

func return_used_word(word: String):
	_unused_words.append(word)
	_unused_words.sort()
