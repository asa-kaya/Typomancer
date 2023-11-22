class_name Spell
extends Resource

enum SpellType { ATTACK, HEAL, BUFF, DEBUFF }

@export var id: String
@export var name: String
@export var keywords: Array[String]
@export var type: SpellType
@export var damage: int
@export var statuses: Array[Status]

func cast():
	EventBus.damage_dealt.emit(damage)
	
	for status in statuses:
		EventBus.status_applied.emit(status)
