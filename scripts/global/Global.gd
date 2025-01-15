extends Node

var passedLvl = 1
var Stones = 0
var coins = 400


# Save data by key
func _ready():
	Bridge.storage.set(["passedLvl", "Stones", "coins"], [Global.passedLvl, Global.Stones, Global.coins], Callable(self, "_on_storage_set_completed"))

func _on_storage_set_completed(success):
	print("On Storage Set Completed, success: ", success)
