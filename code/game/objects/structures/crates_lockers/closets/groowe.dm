/obj/structure/closet/groowe
	name = "groowe"
	desc = "It's a groowe. R.I.P."
	icon = 'icons/obj/structures/cemetery.dmi'
	icon_state = "groowe"
	density = 0
	welded = 1
	icon_closed = "groowe"
	icon_opened = "grooweopen"
	wall_mounted = 1 //never solid (You can always pass over it)
	health = 1000

/obj/structure/closet/groowe/attackby(obj/item/weapon/W as obj, mob/user as mob) //Diggig/burrying groowies
	if(src.opened)
		if(W.loc != user) // This should stop mounted modules ending up outside the module.
			return
		if(istype(W, /obj/item/weapon/pickaxe/shovel))
			src.toggle(user)      //act like they were dragged onto the closet
			src.welded = 1
		else
			usr.drop_item()
			if(W)
				W.loc = src.loc
	else if(istype(W, /obj/item/weapon/pickaxe/shovel))
		src.welded = 0
		src.toggle(user)
		src.update_icon()
		for(var/mob/M in viewers(src))
			M.show_message("<span class='warning'>[src] has been [welded?"buried":"dug"] by [user.name].</span>", 3, "You hear digging.", 2)
	return

/obj/structure/closet/groowe/attack_hand(mob/user as mob)
	src.add_fingerprint(user)

/obj/item/weapon/pickaxe/showel/attack_self(mob/user as mob) //Maknig groowe with showel
	new /obj/structure/closet/groowe( user.loc )
	to_chat(viewers(user), "<span class='danger'>[user] dug groowe with his [src.name]!</span>")
	to_chat(user, "You dug the groowe with \the [src].")