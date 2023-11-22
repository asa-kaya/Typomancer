class_name Player
extends Entity

@export var health: int
@export var _spell_scale: float: set = _set_spell_scale
@export var _spell_position: Node2D

func _ready():
	self._name = "Player"
	self._max_hp = health
	self._target = $"../Enemy"
	super()

func multiply_spell_scale(multiplier: float):
	_spell_scale *= multiplier

func _set_spell_scale(value: float):
	_spell_scale = value
	queue_redraw()
	print("spell scale:" + str(_spell_scale))

func _draw():
	draw_circle(_spell_position.get_position(), sqrt(_spell_scale/PI), Color.AQUAMARINE)
