class_name SpellSelectionItem
extends RichTextLabel

var spell : String = "" : set = _set_text

func _set_text(value: String):
	spell = value
	text = "[center]" + value
