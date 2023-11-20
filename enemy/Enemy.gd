class_name Enemy
extends Node2D

@export var enemy: EnemyData

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var action_timer: Timer = $ActionTimer

var _current_action: int = -1
var _current_hp: int

func _ready():
	EventBus.damage_dealt.connect(_on_damage_dealt)
	
	sprite.set_sprite_frames(enemy.sprite_frames)
	_current_hp = enemy.health
	_next_action()

func _next_action():
	_current_action = (_current_action + 1) % len(enemy.actions)
	action_timer.start(enemy.actions[_current_action])

func _execute_action():
	print("%s executed action %d" % [enemy.name, _current_action])
	_next_action()

func _on_action_timer_timeout():
	_execute_action()

func _on_damage_dealt(value: int):
	_current_hp -= value
	print("%s took %d damage" % [enemy.name, value])
	print("%s has %d / %d HP left" % [enemy.name, _current_hp, enemy.health])
