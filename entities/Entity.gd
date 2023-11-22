class_name Entity
extends Node2D

var _max_hp: int
var _current_hp: int
var _name: String
var _target: Entity
var _statuses: Array[Status]

func _ready():
	_current_hp = _max_hp
	EventBus.damage_dealt.connect(_on_damage_dealt)
	EventBus.health_restored.connect(_on_health_restored)
	EventBus.buff_applied.connect(_on_buff_applied)
	EventBus.debuff_applied.connect(_on_debuff_applied)

func take_damage(value: int):
	_current_hp -= value
	print("%s took %d damage" % [_name, value])
	print("%s has %d / %d HP left" % [_name, _current_hp, _max_hp])

func apply_status(status: Status):
	_statuses.append(status)
	StatusManager.apply(status, self)

func has_stacks(status: Status) -> bool:
	return _statuses.any(func(s): return s.id == status.id)

func _on_damage_dealt(caster: Entity, value: int):
	if caster == self:
		_target.take_damage(value)

func _on_health_restored(caster: Entity, value: int):
	if caster == self:
		_current_hp += value

func _on_buff_applied(caster: Entity, status: Status):
	if caster == self:
		apply_status(status)

func _on_debuff_applied(caster: Entity, status: Status):
	if caster == self:
		_target.apply_status(status)
