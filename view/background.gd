extends Node2D

class_name Background

const _DIMS: Vector2i = Vector2i(8, 8)
const _CELL_DIMS: Vector2 = Vector2(64, 64)

var _square_0 = load("res://assets/square_0.png")
var _square_1 = load("res://assets/square_1.png")

func _ready():
	var texture: Texture2D
	var texture_sz: Vector2
	var sprite: Sprite2D
	var sprite_scale: Vector2 = Vector2()
	var current_pos: Vector2 = Vector2()
	var flag_0: bool = false
	var flag_1: bool
	for i in range(_DIMS.y):
		flag_1 = flag_0
		current_pos.x = 0
		for j in range(_DIMS.x):
			sprite = Sprite2D.new()
			if flag_1:
				texture = _square_1
			else:
				texture = _square_0
			texture_sz = texture.get_size()
			sprite_scale.x = _CELL_DIMS.x/texture_sz.x
			sprite_scale.y = _CELL_DIMS.x/texture_sz.y
			sprite.texture = texture
			sprite.scale = sprite_scale
			add_child(sprite)
			sprite.global_translate(current_pos)
			current_pos.x+=(_CELL_DIMS.x)
			flag_1 = not flag_1
		flag_0 = not flag_0
		current_pos.y+=(_CELL_DIMS.y)

