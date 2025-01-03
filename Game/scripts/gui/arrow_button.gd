extends TextureButton

@onready var label: Label = %Label
@onready var right: TextureRect = %Right
@onready var left: TextureRect = %Left

@export var color: Color
@export var focus_color: Color

func _ready():
	label.modulate = color
	hide_arrows()

func show_arrows():
	left.visible = true
	right.visible = true

func hide_arrows():
	left.visible = false
	right.visible = false


func _on_focus_entered() -> void:
	show_arrows()
	label.modulate = focus_color


func _on_focus_exited() -> void:
	hide_arrows()
	label.modulate = color


func _on_mouse_entered() -> void:
	grab_focus()
