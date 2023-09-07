extends Node2D

class_name PiecesView

const _DIMS: Vector2i = Vector2i(8, 8)
const _CELL_DIMS: Vector2 = Vector2(64, 64)
const _TEXTURE_DIMS: Vector2 = Vector2(64, 64)

var _pieces_node: Node2D
var _game_board: GameBoard
var _board_view: Array
var _textures: Dictionary = {
	"b": {
		"pawn": load("res://assets/chess-pack/chess-pawn-black.png"),
		"knight": load("res://assets/chess-pack/chess-knight-black.png"),
		"bishop": load("res://assets/chess-pack/chess-bishop-black.png"),
		"rook": load("res://assets/chess-pack/chess-rook-black.png"),
		"queen": load("res://assets/chess-pack/chess-queen-black.png"),
		"king": load("res://assets/chess-pack/chess-king-black.png")
	},
	"w": {
		"pawn": load("res://assets/chess-pack/chess-pawn-white.png"),
		"knight": load("res://assets/chess-pack/chess-knight-white.png"),
		"bishop": load("res://assets/chess-pack/chess-bishop-white.png"),
		"rook": load("res://assets/chess-pack/chess-rook-white.png"),
		"queen": load("res://assets/chess-pack/chess-queen-white.png"),
		"king": load("res://assets/chess-pack/chess-king-white.png")
	}
}

func create_board_view() -> void:
	_board_view = []
	var row: Array
	var sprite: Sprite2D
	var current_pos: Vector2 = Vector2()
	for i in range(_DIMS.y):
		row = []
		current_pos.x = 0
		for j in range(_DIMS.x):
			sprite = Sprite2D.new()
			_pieces_node.add_child(sprite)
			sprite.global_position = current_pos
			row.append(sprite)
			current_pos.x+=(_CELL_DIMS.x)
		_board_view.append(row)
		current_pos.y+=(_CELL_DIMS.y)

func init(game_board: GameBoard) -> void:
	_pieces_node = Node2D.new()
	add_child(_pieces_node)
	_game_board = game_board
	create_board_view()

func update() -> void:
	var texture: Texture2D
	var piece_data: Dictionary
	var sprite: Sprite2D
	var color: String
	var type: String
	var texture_dims: Vector2
	var sprite_scale: Vector2 = Vector2()
	for i in range(_DIMS.y):
		for j in range(_DIMS.x):
			sprite = _board_view[i][j]
			piece_data = _game_board._board[i][j]
			if piece_data=={}:
				sprite.texture = null
			else:
				color = piece_data["color"]
				type = piece_data["type"]
				texture = _textures[color][type]
				texture_dims = texture.get_size()
				sprite_scale.x = _TEXTURE_DIMS.x/texture_dims.x
				sprite_scale.y = _TEXTURE_DIMS.x/texture_dims.y
				sprite.texture = texture
				sprite.scale = sprite_scale

func _ready():
	update()
