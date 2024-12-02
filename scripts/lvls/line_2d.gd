extends Line2D

@onready var line = $"."

# Параметры уровня
var level_length = 20000     # Длина уровня (в пикселях)
var straight_length = 2000   # Длина прямых участков
var hill_length = 3000       # Длина холмов/ям
var amplitude = 80          # Амплитуда холмов/ям
var frequency = 0.02       # Частота волн
var min_y = 200            # Минимальная высота дороги
var max_y = 500            # Максимальная высота дороги

func _ready() -> void:
	generate_road()

# Функция генерации уровня
func generate_road():
	var points = []  # Массив точек дороги
	var current_x = 0
	var current_y = 0  # Начальная позиция по Y

	# Генерация дороги
	while current_x < level_length:
		if current_x % (straight_length + hill_length) < straight_length:
			# Генерация прямого участка
			var segment_length = straight_length
			for i in range(segment_length):
				points.append(Vector2(current_x, current_y))
				current_x += 1
		else:
			# Генерация холма/ямы
			var segment_length = hill_length
			for i in range(segment_length):
				current_y = min_y + amplitude * sin(i * frequency) + (max_y - min_y) / 2
				points.append(Vector2(current_x, current_y))
				current_x += 1

	line.points = points
