extends KinematicBody
class_name MovableObject

#####
# простой двигаемый обьект, который движется в любом направлении, передавая вектор в 
# _on_change_direction или публичный метод set_direction
#####


signal change_speed(speed)
signal change_state_direction()

export(Vector3) var velocity := Vector3.ZERO
export(Vector3) var up := Vector3.UP
export(float) var speed := 5.0
export(float) var accel := 10.0
export(bool) var enable_world_gravity := true

#в виде пакета сюда передаем подсцену, которая может быть чем угодно. Хоть куб, хоть машина
export(PackedScene) var model: PackedScene = null

var _direction := Vector3.ZERO
var _current_speed := 0.0

var _current_gravity := Vector3.ZERO

func _ready() -> void:
	if model :
		var new_model := model.instance()
		add_child(new_model)

func _change_direction(vec: Vector3) -> void :
	_direction = vec
	emit_signal("change_state_direction")

func _on_change_direction(vec: Vector3) -> void :
	_change_direction(vec)

func set_direction(vec: Vector3) -> void :
	_change_direction(vec)

func _physics_process(delta: float) -> void:
	
	_current_speed = move_toward(_current_speed, speed * _direction.length(), accel * delta)
	velocity =  _direction * _current_speed
	if enable_world_gravity :
		var state := PhysicsServer.body_get_direct_state(get_rid())
		if is_on_floor() :
			_current_gravity = Vector3.ZERO
		else :
			_current_gravity += state.total_gravity
		velocity += _current_gravity
	
	
	velocity = move_and_slide(velocity, up)
	emit_signal("change_speed", velocity.z)
