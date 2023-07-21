extends IController
class_name Controller

################
#
# Контроллер общается с любым узлом, передавая ему сигналы direction. 
# Это нормализированный вектор движения. Перегружая IController, мы можем в целом
# задать любое поведение
#
################


const SPEED_MAX := 1.0
const SPEED_MIN := -1.0


export(float, -1, 1) var speed_1 := 0.0
export(float, -1, 1) var speed_2 := 0.3
export(float, -1, 1) var speed_3 := 0.6
export(float, -1, 1) var speed_4 := 1.0

# По мимо клавишь 1-4, мы можем крутить так же колесеко мыши, что бы шагово уваличивать или уменьшать скорость
export(float, 0, 1.0) var speed_step := 0.1

var current_speed := 0.0 setget set_current_speed
func set_current_speed(val: float) -> void :
	current_speed = clamp(val, SPEED_MIN, SPEED_MAX)
	set_direction(Vector3(0, 0, current_speed))

func _ready() -> void:
	emit_signal("change_current_speed", current_speed)


func get_direction() -> Vector3 :
	return Vector3(0, 0, current_speed)

func set_direction(val: Vector3) :
	emit_signal("change_direction", Vector3(0, 0, current_speed))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton :
		if event.is_pressed() :
			if event.button_index == BUTTON_WHEEL_UP:
				set_current_speed(current_speed + speed_step)
			if event.button_index == BUTTON_WHEEL_DOWN :
				set_current_speed(current_speed - speed_step)


func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("controller_1") :
		set_current_speed(speed_1)
	
	if Input.is_action_just_pressed("controller_2") :
		set_current_speed(speed_2)
	
	if Input.is_action_just_pressed("controller_3") :
		set_current_speed(speed_3)
	
	if Input.is_action_just_pressed("controller_4") :
		set_current_speed(speed_4)
	

