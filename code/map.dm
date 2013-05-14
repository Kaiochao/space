world/view = 10

atom icon = 'icons.dmi'

turf
	space
		icon_state = "space"
		New() if(prob(30)) new /obj/star (src)

	grass
		icon_state = "grass"
		density = 1

	sky icon_state = "sky"

obj/star
	icon_state = "star"
	New()
		pixel_x = rand(31)
		pixel_y = rand(31)
