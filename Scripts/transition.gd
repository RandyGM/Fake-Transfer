extends CanvasLayer

@onready var anim_transition : AnimationPlayer = $AnimationPlayer

func fade_in() -> void:
	anim_transition.play("Fade")
	await anim_transition.animation_finished

func fade_out() -> void:
	anim_transition.play_backwards("Fade")
	await anim_transition.animation_finished
