extends Node

var passedLvl = 1
var Stones = 0
var coins = 400


func _ready():
	print(Global.passedLvl)

# Save data by key
func _save_data():
	Bridge.storage.set(["passedLvl", "coins"], [Global.passedLvl, Global.coins])
