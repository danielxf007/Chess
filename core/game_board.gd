extends Node

class_name GameBoard

const _SECTION: String = "boards"
const _DIMS: Vector2i = Vector2i(8, 8)

var _board: Array

func create_empty_2D_array(empty_val) -> Array:
	var array: Array = []
	var row: Array
	for i in range(_DIMS.y):
		row = []
		for j in range(_DIMS.x):
			row.append(empty_val)
		array.append(row)
	return array

func _valid_row(i: int) -> bool:
	return i > 0 and i < _DIMS.y

func _valid_col(j: int) -> bool:
	return j > 0 and j < _DIMS.x

func coord_on_board(coord: Vector2i) -> bool:
	return _valid_row(coord.y) and _valid_col(coord.x)

func has_piece(coord: Vector2i) -> bool:
	return coord_on_board(coord) and _board[coord.y][coord.x] != null

func set_piece(piece: Dictionary, coord: Vector2i) -> void:
	_board[coord.y][coord.x] = piece

func get_piece(coord: Vector2i) -> Dictionary:
	return _board[coord.y][coord.x] if has_piece(coord) else null

func set_up(pieces_set_up: Array) -> void:
	var piece: Dictionary
	for piece_data in pieces_set_up:
		piece = {}
		for coord in piece_data["coords"]:
			piece["type"] = piece_data["type"]
			piece["color"] = piece_data["color"]
			set_piece(piece, coord)

func init(board_config: ConfigFile, game_type: String) -> void:
	_board = create_empty_2D_array({})
	set_up(board_config.get_value(_SECTION, game_type))

func move(from: Vector2i, to: Vector2i) -> void:
	set_piece(get_piece(from), to)
	set_piece({}, from)
