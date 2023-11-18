class_name SpellSelectionItem
extends RichTextLabel

static var match_color := "yellow"
static var mismatch_color := "darkred"

var spell : String = "" : set = _set_text

func compare_and_highlight(str: String):
	if str.is_empty():
		text = "[center]" + spell
		return
	
	var slice_index := 0
	for i in range(len(str)):
		if str[i] != spell[i] or i == len(spell):
			break
		slice_index += 1
	
	var match_substr := spell.left(slice_index)
	var mismatch_substr := spell.left(len(str)).right(-slice_index) if slice_index > 0 else spell.left(len(str))
	var neutral_substr := spell.right(-len(str))
	text = "[center][color=%s]%s[/color][color=%s]%s[/color]%s" % [match_color, match_substr, mismatch_color, mismatch_substr, neutral_substr]

func _set_text(value: String):
	spell = value
	text = "[center]" + value
