extends CharacterBody2D

var speed = 300.0

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
