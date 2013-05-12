var const/tile_width  = 32
var const/tile_height = 32

atom
	proc/width()	return tile_width
	proc/height()	return tile_height
	proc/px(p)		return loc && tile_width  * (x - 1) + p * width()
	proc/py(p)		return loc && tile_height * (y - 1) + p * height()

	var px = 0
	var py = 0

	proc/reset_pos()
		px = px()
		py = py()

	New()
		..()
		reset_pos()

	movable
		width()		return bound_width
		height()	return bound_height
		px(p)		return loc && ..() + bound_x + step_x
		py(p)		return loc && ..() + bound_y + step_y

		proc/set_loc(atom/new_loc, new_step_x, new_step_y)
			loc = new_loc
			if(!isnull(step_x)) step_x = new_step_x
			if(!isnull(step_y)) step_y = new_step_y
			reset_pos()

		proc/move(dx, dy)
			step_size = max(abs(dx), abs(dy))
			if(dx)
				px += dx
				var rx = round(px)
				var ax = px()
				var mx = rx - ax
				if(mx)
					var d
					if(mx > 0)
						d = EAST
					else d = WEST
					if(!step(src, d, abs(mx)))
						bump(d)
						px = px()
					else . ++

			if(dy)
				py += dy
				var ry = round(py)
				var ay = py()
				var my = ry - ay
				if(my)
					var d
					if(my > 0)
						d = NORTH
					else d = SOUTH
					if(!step(src, d, abs(my)))
						bump(d)
						py = py()
					else . ++

		proc/bump(d)