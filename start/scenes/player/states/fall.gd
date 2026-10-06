extends PlayerState

func _enter() -> void:
	#Change animation to fall
	obj.change_animation("fall")

func _update(_delta: float) -> void:
	control_jump()
	var is_moving: bool = control_moving()
	if obj.is_on_floor():
		if not is_moving and not control_jump():
			change_state(fsm.states.idle)
