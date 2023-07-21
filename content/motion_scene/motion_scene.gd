extends Spatial


onready var _camera_target := $"%CameraTarget"
onready var _camera_global := $"%CameraGlobal"

onready var _vslider_speed := $"%VSliderSpeed"
onready var _label_speed := $"%LabelSpeed"

onready var _controller := $MovableObject/Controller

onready var _gui := $GUI

func _on_GUI_button_global_pressed() -> void:
	_camera_global.current = true


func _on_GUI_button_target_pressed() -> void:
	_camera_target.current = true


func _on_GUI_change_slider(value: float) -> void:
	_controller.current_speed = value


func _on_Controller_change_direction(vec: Vector3) -> void:
	_gui.slider_value = vec.z


func _on_MovableObject_change_speed(speed: float) -> void:
	_gui.speed_label = speed

