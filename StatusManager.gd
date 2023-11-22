extends Node

func apply(status: Status, to: Entity):
	match status.id:
		"POISON":
			var t := get_tree().create_timer(1)
			t.timeout.connect(func(): trigger(status, to))

func trigger(status: Status, to: Entity):
	match status.id:
		"POISON":
			print("%s took %d damage from poison" % [to.name, 1])
			if to.has_stacks(status):
				var t := get_tree().create_timer(1)
				t.timeout.connect(func(): trigger(status, to))
