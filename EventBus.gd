extends Node

#TODO: find a way to add a receiver for 
signal damage_dealt(caster: Entity, value: int)
signal health_restored(caster: Entity, value: int)
signal buff_applied(caster: Entity, value: Status)
signal debuff_applied(caster: Entity, value: Status)
