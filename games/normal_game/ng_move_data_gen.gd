extends "res://core/move_data_gen.gd"

class_name NGMoveDataGenerator

func expand_mutually_exclusive(mv: Dictionary) -> Array:
	var scalar_range: Array = mv["scalar_range"].duplicate()
	scalar_range.erase(0)
	var expansion: Array = []
	for i in scalar_range:
		expansion.append(mv["basis"][0]*i)
		expansion.append(mv["basis"][1]*i)
	return expansion

func expand_all(mv: Dictionary) -> Array:
	var scalar_range: Array = mv["scalar_range"].duplicate()
	var expansion: Array = []
	for i in scalar_range:
		for j in scalar_range:
			expansion.append(mv["basis"][0]*i + mv["basis"][1]*j)
	expansion.erase(Vector2i())
	return expansion

func expand_basis(mv: Dictionary) -> Array:
	var expansion: Array
	match mv["combination_type"]:
		"mutually_exclusive":
			expansion = expand_mutually_exclusive(mv)
		"all":
			expansion = expand_all(mv)
	return expansion

func make_move_data(data: Array) -> Array:
	var move_data: Array = []
	var new_data: Dictionary
	for mv in data:
		new_data = {}
		if mv["expand"]:
			new_data["moves"] = expand_basis(mv)
		else:
			new_data["moves"] = mv["basis"]
		new_data["pre_move_validations"] = mv["pre_move_validations"]
		new_data["post_move_validations"] = mv["post_move_validations"]
		new_data["post_move_actions"] = mv["post_move_actions"]
		move_data.append(new_data)
	return move_data

func get_move_data(_game_config: ConfigFile) -> Dictionary:
	var move_data: Dictionary = {}
	var section_keys = _game_config.get_section_keys(_SECTION)
	for key in section_keys:
		move_data[key] = make_move_data(_game_config.get_value(_SECTION, key))
	return move_data
