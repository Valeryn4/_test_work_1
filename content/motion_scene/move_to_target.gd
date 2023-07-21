extends Spatial

export(float) var target_distance := 20.0
export(NodePath) var target_path := NodePath()
export(float) var speed := 100.0

func _physics_process(delta: float) -> void:
	var target := get_node_or_null(target_path) as Spatial
	if target :
		var distance := target.global_transform.origin.distance_to(global_transform.origin)
		if distance > 0.0 :
			var sp := speed * delta * (distance / target_distance)
			global_transform.origin = global_transform.origin.move_toward(
				target.global_transform.origin, sp
			)
