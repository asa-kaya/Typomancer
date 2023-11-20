class_name Spell
extends Resource

enum SpellType { ATTACK, BUFF, DEBUFF, STATUS }

@export var id: String
@export var name: String
@export var keywords: Array[String]
@export var type: SpellType
@export var damage: int

signal damage_dealt(value: int)
signal status_applied(value: String)

func cast():
	damage_dealt.emit(damage)
	status_applied.emit(null)
