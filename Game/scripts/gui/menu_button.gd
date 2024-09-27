extends TextureButton

@onready var label: Label = %Label
@onready var right: TextureRect = %Right
@onready var left: TextureRect = %Left

func _ready():
	hide_arrows()

func show_arrows():
	left.visible = true
	right.visible = true

func hide_arrows():
	left.visible = false
	right.visible = false


func _on_focus_entered() -> void:
	show_arrows()
	label.modulate = Color("#A2B9C1")


func _on_focus_exited() -> void:
	hide_arrows()
	label.modulate = Color(1.0,1.0,1.0,1.0)


func _on_mouse_entered() -> void:
	grab_focus()
