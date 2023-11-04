extends Node2D

@export var incantation_label: RichTextLabel

func _on_typed_input_receiver_input_updated(str: String):
	incantation_label.set_text("[center]%s[/center]" % str)

func _on_word_manager_on_match_found(word):
	var default_color := incantation_label.modulate
	incantation_label.set_modulate(Color.WHITE)
	var tween := get_tree().create_tween()
	tween.tween_property(incantation_label, "modulate", Color(1, 1, 1, .1), 1)
	tween.tween_callback(func(): incantation_label.set_modulate(default_color))
