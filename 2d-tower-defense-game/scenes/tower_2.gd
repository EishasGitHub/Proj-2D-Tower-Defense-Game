extends StaticBody2D


func get_tile_position() -> Vector2i:
	var tilemap = get_node("../../TileMap2")
	var local_pos = tilemap.to_local(global_position)
	return tilemap.local_to_map(local_pos)
