class_name Entity
extends Node2D

var damage_mitigation: float

var _max_hp: int
var _current_hp: int
var _name: String
var _target: Entity
var _statuses: Array[Status]

signal before_damage_taken(damage: int)

func _ready():
	_current_hp = _max_hp
	EventBus.damage_dealt.connect(_on_damage_dealt)
	EventBus.health_restored.connect(_on_health_restored)
	EventBus.buff_applied.connect(_on_buff_applied)
	EventBus.debuff_applied.connect(_on_debuff_applied)

func take_damage(value: int) -> int:
	before_damage_taken.emit(value)
	var dmg := maxi(0, roundi(value * (1 - damage_mitigation)))
	_current_hp -= dmg
	print("%s took %d damage" % [_name, dmg])
	print("%s has %d / %d HP left" % [_name, _current_hp, _max_hp])
	
	damage_mitigation = 0
	
	if _current_hp <= 0:
		_on_death()
	
	return _current_hp

func apply_status(status: Status):
	_statuses.append(status)
	StatusManager.apply(status, self)

func has_stacks(status: Status) -> bool:
	return _statuses.any(func(s): return s.id == status.id)

func remove_stacks(status: Status, amount: int):
	for i in range(len(_statuses), 0, -1):
		var s := _statuses[i-1]
		if s.id == status.id:
			_statuses.remove_at(i-1)
			amount -= 1
		if amount < 1:
			break

func _on_damage_dealt(caster: Entity, value: int):
	if caster == self and value != 0:
		_target.take_damage(value)

func _on_health_restored(caster: Entity, value: int):
	if caster == self:
		_current_hp = clampi(_current_hp + value, 0, _max_hp)
		print("%s has restored %d HP" % [_name, value])
		print("%s has %d / %d HP left" % [_name, _current_hp, _max_hp])

func _on_buff_applied(caster: Entity, status: Status):
	if caster == self:
		apply_status(status)

func _on_debuff_applied(caster: Entity, status: Status):
	if caster == self:
		_target.apply_status(status)

func _on_death():
	print("%s died" % _name)
	queue_free()
