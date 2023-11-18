class_name Enemy
extends Node2D

@export var data: EnemyData

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var action_timer: Timer = $ActionTimer

var _current_action: int = -1

func _ready():
	sprite.set_sprite_frames(data.sprite_frames)
	_next_action()

func _next_action():
	_current_action = (_current_action + 1) % len(data.actions)
	action_timer.start(data.actions[_current_action])

func _execute_action():
	print("%s executed action %d" % [data.name, _current_action])
	_next_action()

func _on_action_timer_timeout():
	_execute_action()
