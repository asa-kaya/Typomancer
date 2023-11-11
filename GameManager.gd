extends Node2D

@export var word_manager: WordManager
@export var player: Player
@export var incantation_label: RichTextLabel
@export var spell_selection_container: Container
@export var spell_selection_item_prefab: PackedScene

var spells: CastleDB

func _ready():
	var spells_table: Array[String]
	spells_table.assign(DB.table_spells.all.map(func(spell): return spell.incantation))
	word_manager.init(spells_table)

func _on_typed_input_receiver_input_updated(str: String):
	incantation_label.set_text("[center]" + str)

func _on_word_manager_on_match_found(word):
	var default_color := incantation_label.modulate
	incantation_label.set_modulate(Color.WHITE)
	var tween := get_tree().create_tween()
	tween.tween_property(incantation_label, "modulate", Color(1, 1, 1, .1), 1)
	tween.tween_callback(func(): incantation_label.set_modulate(default_color))
	
	var multiplier: float = DB.table_spells.get_value(word).size_multiplier
	player.multiply_spell_scale(multiplier)

func _on_word_manager_word_selection_word_added(word):
	var o := spell_selection_item_prefab.instantiate()
	(o as SpellSelectionItem).spell = word
	spell_selection_container.add_child(o)

func _on_word_manager_word_selection_remove_at(index):
	spell_selection_container.remove_child(spell_selection_container.get_child(index))

func _on_word_manager_word_selection_modified(index, new_word):
	(spell_selection_container.get_child(index) as SpellSelectionItem).spell = new_word
