class_name Spell
extends Resource

enum SpellType { ATTACK, BUFF, DEBUFF, STATUS }

@export var id: String
@export var name: String
@export var keywords: Array[String]
@export var type: SpellType
@export var damage: int

func cast():
	EventBus.damage_dealt.emit(damage)
	EventBus.status_applied.emit(null)
