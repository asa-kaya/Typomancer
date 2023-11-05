extends Node2D

@export var incantation_label: RichTextLabel
@export var spell_selection_container: Container
@export var spell_selection_item_prefab: PackedScene


func _on_typed_input_receiver_input_updated(str: String):
	incantation_label.set_text("[center]" + str)

func _on_word_manager_on_match_found(word):
	var default_color := incantation_label.modulate
	incantation_label.set_modulate(Color.WHITE)
	var tween := get_tree().create_tween()
	tween.tween_property(incantation_label, "modulate", Color(1, 1, 1, .1), 1)
	tween.tween_callback(func(): incantation_label.set_modulate(default_color))

func _on_word_manager_word_selection_word_added(word):
	var o := spell_selection_item_prefab.instantiate()
	(o as SpellSelectionItem).spell = word
	spell_selection_container.add_child(o)

func _on_word_manager_word_selection_remove_at(index):
	spell_selection_container.remove_child(spell_selection_container.get_child(index))



