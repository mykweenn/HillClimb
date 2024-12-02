extends Path2D

func _ready():
	generate_road()

func generate_road():
	var curve = Curve2D.new()
	
	var road_length = 20000  # Длина дороги
	var segment_size = 50   # Шаг между точками
	var base_height = 200   # Базовый уровень дороги

	# Разбивка дороги на участки
	var segments = [
		{ "type": "straight", "length": 1000 },
		{ "type": "hills", "length": 6000, "amplitude": 10, "frequency": 0.02 },
		{ "type": "valleys", "length": 600, "amplitude": 80, "frequency": 0.05 },
		{ "type": "straight", "length": 4000 }
	]
	
	var x = 0  # Текущая позиция по X
		
	for segment in segments:
		match segment["type"]:
			"straight":
				# Прямая дорога
				for i in range(0, segment["length"], segment_size):
					curve.add_point(Vector2(x, base_height))
					x += segment_size
			
			"hills":
				# Холмы
				for i in range(0, segment["length"], segment_size):
					var y = sin(x * segment["frequency"]) * segment["amplitude"] + base_height
					curve.add_point(Vector2(x, y))
					x += segment_size
			
			"valleys":
				# Ямы (глубокие холмы с иной амплитудой)
				for i in range(0, segment["length"], segment_size):
					var y = cos(x * segment["frequency"]) * segment["amplitude"] + base_height
					curve.add_point(Vector2(x, y))
					x += segment_size
	
	# Применяем кривую к Path2D
	self.curve = curve
