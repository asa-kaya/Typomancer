class_name Enemy
extends Entity

@export var enemy: EnemyData

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var action_timer: Timer = $ActionTimer

var _current_action: int = -1

func _ready():
	sprite.set_sprite_frames(enemy.sprite_frames)
	self._max_hp = enemy.health
	self._name = enemy.name
	self._target = $"../Player"
	
	super()
	_next_action()

func _next_action():
	_current_action = (_current_action + 1) % len(enemy.actions)
	action_timer.start(enemy.actions[_current_action])

func _execute_action():
	print("%s executed action %d" % [enemy.name, _current_action])
	
	if _target != null:
		_target.take_damage(2)
	_next_action()

func _on_action_timer_timeout():
	_execute_action()
