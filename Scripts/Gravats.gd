extends RigidBody



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _integrate_forces(state):
	var target_position = get_parent().get_node("StaticBodyPlanete").get_global_transform().origin
	look_follow(state, get_global_transform(), target_position)
	


func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
	var cur_dir = current_transform.basis.xform(Vector3(0, 0, 1))
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)

	state.set_angular_velocity(up_dir * (rotation_angle / state.get_step()))
