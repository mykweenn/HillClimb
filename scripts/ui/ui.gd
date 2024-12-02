extends CanvasLayer

func stars_anim():
	match Global.Stones:
		3:
			$stars/AnimationPlayer.play("1_start")
		4:
			$stars/AnimationPlayer.play("2_start")
		5:
			$stars/AnimationPlayer.play("3_start")
