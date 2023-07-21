extends CanvasLayer

signal button_target_pressed()
signal button_global_pressed()
signal change_slider(value)


onready var _vslider_speed := $"%VSliderSpeed"
onready var _label_speed := $"%LabelSpeed"

export(float) var speed_label := 0.0 setget set_speed_label
func set_speed_label(val: float) -> void :
	speed_label = val
	if _label_speed :
		_label_speed.text = " /\\" if speed_label >= 0 else " \\/"
		_label_speed.text += str(speed_label)

export(float) var slider_value := 0.0 setget set_slider_value
func set_slider_value(val: float) -> void :
	slider_value = val
	if _vslider_speed :
		_vslider_speed.value = slider_value


func _on_pressed(idx: int) -> void :
	emit_signal("button_pressed_speed", idx)

func _on_VSliderSpeed_drag_ended(value_changed: bool) -> void:
	emit_signal("change_slider", _vslider_speed.value)


func _on_ButtonCameraTarget_pressed() -> void:
	emit_signal("button_target_pressed")


func _on_ButtonCameraGlobal_pressed() -> void:
	emit_signal("button_global_pressed")
