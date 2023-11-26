class_name Spell
extends Resource

enum SpellType { ATTACK, HEAL, BUFF, DEBUFF }

@export var id: String
@export var name: String
@export var keywords: Array[String]
@export var type: SpellType
@export var damage: int
@export var statuses: Array[Status]

func cast(caster: Entity):
	if type == SpellType.ATTACK || type == SpellType.DEBUFF:
		EventBus.damage_dealt.emit(caster, damage)
		for status in statuses:
			EventBus.debuff_applied.emit(caster, status.id)
	
	if type == SpellType.HEAL || type == SpellType.BUFF:
		EventBus.health_restored.emit(caster, damage)
		for status in statuses:
			EventBus.buff_applied.emit(caster, status.id)
