extends RichTextLabel

@export var typing_speed: float = 0.01
var is_typing: bool = false
var previous_visible_characters = 0

func typewriter_effect(new_text: String):
	text = new_text
	visible_characters = 0
	previous_visible_characters =0
	is_typing = true
	for i in range(text.length()):
		if not is_typing:
			break
		await get_tree().create_timer(typing_speed).timeout
		visible_characters += 1
		if visible_characters > previous_visible_characters + 5:
			SoundManager.play_typing()
			previous_visible_characters = visible_characters
	is_typing = false


func skip_effect():
	is_typing = false
	visible_characters = text.length()
