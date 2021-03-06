//	generate an icon filled with rotations as icon states named after the angle rotated
proc/rotate_icon(icon as icon, state = "", dt = 1)
	var icon/result = icon(icon, state)
	for(var/angle in 0 to 360 step dt)
		if(!angle || angle == 360) continue
		var icon/rotated = icon(icon, state)
		rotated.Turn(angle)
		result.Insert(rotated, "[angle]")
	return result

//	to convert an angle to the icon state that can be used in an icon generated by the rotater
proc/angle2state(angle, dt = 1)
	return "[round(clamp_angle(angle), dt)]"

//	keep an angle within [0, 360)
proc/clamp_angle(angle)
	. = angle
	while(. >= 360) . -= 360
	while(. <    0) . += 360