extends Node

class Table:
	var _all: Array = []
	var _keys: Dictionary = {}
	
	func _generate_keys():
		for i in range(len(_all)):
			self._keys[_all[i].id] = i
	
	func get_value(id: String):
		if self._keys.has(id):
			return self._all[self._keys[id]]
		return null
	
	func get_all_ids() -> Array[String]:
		var arr: Array[String] = []
		arr.assign(self._keys.keys())
		return arr

class Spells extends Table:
	func _init( ):
		var dir = DirAccess.open("res://spell_system/spells/")
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if not dir.current_is_dir():
					var r := ResourceLoader.load(dir.get_current_dir() + "/" + file_name)
					self._all.append(r as Spell)
				file_name = dir.get_next()
		else:
			assert(false, "An error occurred when trying to access the path.")
		self._generate_keys()

	func get_value(id: String) -> Spell:
		return super(id) as Spell
	
	func get_from_keyword(keyword: String) -> Spell:
		for spell in self._all:
			if (spell as Spell).keywords.has(keyword):
				return spell
		return null

var spells := Spells.new()
