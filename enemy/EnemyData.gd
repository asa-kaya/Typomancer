class_name EnemyData
extends Resource

@export var name: String
@export var health: int
@export var actions: Array[int]
@export var sprite_frames: SpriteFrames

'''
func _init(_name = "Enemy", _health = 0, _actions = [], _sprite_frames = null):
	name = _name
	health = _health
	actions = _actions
	sprite_frames = _sprite_frames
'''
