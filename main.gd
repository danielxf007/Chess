extends Node

var config = ConfigFile.new()
var board_config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = config.load("res://game_configs/temp.cfg") & board_config.load("res://boards_config/standard.cfg")
	var mv_gen: MoveDataGenerator = NGMoveDataGenerator.new()
	var game_board: GameBoard = GameBoard.new()
	var pieces_view: PiecesView = PiecesView.new()
	var bg: Background = Background.new()
	pieces_view.init(game_board)
	var moves: Dictionary
	# If the file didn't load, ignore it.
	if err == OK:
		print("readed config file")
		moves = mv_gen.get_move_data(config)
		game_board.init(board_config, "standard")
		add_child(bg)
		add_child(pieces_view)
		bg.global_translate(Vector2(96, 96))
		pieces_view.global_translate(Vector2(96, 96))
	else:
		print(err)
		print("could not read config file")
	print("hello")
