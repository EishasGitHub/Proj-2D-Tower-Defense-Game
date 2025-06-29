extends CharacterBody2D

var speed = 200.0
var damage = 30

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		body.take_damage(damage)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
