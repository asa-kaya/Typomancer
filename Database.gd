extends Node

class Spells:
	class Row:
		var id: String  = ""
		var name: String = ""
		var keywords: Array[String] = []
		var type: int = 0
		var damage: int = 0
		
		func _init(_id: String, _name: String, _keywords: Array[String], _type: int, _damage: int):
			self.id = _id
			self.name = _name
			self.keywords = _keywords
			self.damage = _type
			self.type = _damage

	func _init( ):
		var dir = DirAccess.open("res://spell_system/spells/")
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					print("Found directory: " + file_name)
				else:
					var r := ResourceLoader.load(dir.get_current_dir() + "/" + file_name)
					print((r as Spell).id + " loaded")
				file_name = dir.get_next()
		else:
			assert(false, "An error occurred when trying to access the path.")
#		self._generate_keys( )
#
#	func get_value( id:String ) -> Spells.Row:
#		if self.keys.has( id ):
#			return self.all[self.keys[id]]
#		return null
#
#	func get_index( id:String ) -> int:
#		if self.keys.has( id ):
#			return self.keys[id]
#		return -1

var spells := Spells.new()
