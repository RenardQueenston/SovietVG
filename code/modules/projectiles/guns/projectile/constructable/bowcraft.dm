/obj/item/weapon/bow_frame
	name = "bow frame"
	icon = 'icons/obj/weaponsmithing.dmi'
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/items_lefthand.dmi', "right_hand" = 'icons/mob/in-hand/right/items_righthand.dmi')
	item_state = "bow"
	w_class = W_CLASS_MEDIUM
	force = 2
	throwforce = 2

/obj/item/weapon/bow_frame/bow_frame1
    desc = "Wooden base of the bow."
    icon_state = "bow_frame"

/obj/item/weapon/bow_frame/bow_frame1/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/stack/cable_coil))
		to_chat(user, "You wrap \the [W] around \the [src] handle.")
		if(src.loc == user)
			user.drop_item(src, force_drop = 1)
			var/obj/item/weapon/bow_frame/bow_frame2/I = new (get_turf(user))
			user.put_in_hands(I)
		else
			new /obj/item/weapon/bow_frame/bow_frame2(get_turf(src.loc))
		qdel(src)
		qdel(W)

/obj/item/weapon/bow_frame/bow_frame2
	desc = "Wooden base of the bow. It has some wires wraped around the handle."
	icon_state = "bow_frame2"

/obj/item/weapon/bow_frame/bow_frame2/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/screwdriver))
		to_chat(user, "You make a hole for the strhing in \the [src].")
		if(src.loc == user)
			user.drop_item(src, force_drop = 1)
			var/obj/item/weapon/bow_frame/bow_frame3/I = new (get_turf(user))
			user.put_in_hands(I)
		else
			new /obj/item/weapon/bow_frame/bow_frame3(get_turf(src.loc))
		qdel(src)
		qdel(W)

/obj/item/weapon/bow_frame/bow_frame3
	desc = "Wooden base of the bow. It's handle is wraped and ends are drilled."
	icon_state = "bow_frame2"

/obj/item/weapon/bow_frame/bow_frame3/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/stack/cable_coil))
		to_chat(user, "You slipped \the [W] through \the [src]'s holes.")
		if(src.loc == user)
			user.drop_item(src, force_drop = 1)
			var/obj/item/weapon/bow_frame/bow_frame4/I = new (get_turf(user))
			user.put_in_hands(I)
		else
			new /obj/item/weapon/bow_frame/bow_frame4(get_turf(src.loc))
		qdel(src)
		qdel(W)

/obj/item/weapon/bow_frame/bow_frame4
	desc = "Nearly finished bow."
	icon_state = "bow_frame3"

/obj/item/weapon/bow_frame/bow_frame4/attackby(obj/item/weapon/W, mob/user)
	if(istype(W, /obj/item/weapon/wirecutters))
		to_chat(user, "You cut off extra wire with \the [W].")
		if(src.loc == user)
			user.drop_item(src, force_drop = 1)
			var/obj/item/weapon/bow_frame/bow_frame5/I = new (get_turf(user))
			user.put_in_hands(I)
		else
			new /obj/item/weapon/bow_frame/bow_frame5(get_turf(src.loc))
		qdel(src)
		qdel(W)

/obj/item/weapon/bow_frame/bow_frame5
	desc = "It remains only to tighten the string."
	icon_state = "bow_frame4"

/obj/item/weapon/bow_frame/bow_frame5/attack_self(mob/user as mob)
	to_chat(user, "You pulled the string.")
	user.drop_item(src, force_drop = 1)
	var/obj/item/weapon/crossbow/bow/I = new (get_turf(user))
	user.put_in_hands(I)
	qdel(src)