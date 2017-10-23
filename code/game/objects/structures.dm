/obj/structure
	icon = 'icons/obj/structures.dmi'
	penetration_dampening = 5
	var/climb_time = 20
	var/climb_stun = 2
	var/climbable = FALSE
	var/mob/structureclimber

/obj/structure/blob_act(var/destroy = 0)
	..()
	if(destroy || (prob(50)))
		qdel(src)

/obj/structure/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if(prob(50))
				qdel(src)
				return
		if(3.0)
			return

/obj/structure/projectile_check()
	return PROJREACT_OBJS

/obj/structure/kick_act(mob/living/carbon/human/H)
	if(H.locked_to && isobj(H.locked_to) && H.locked_to != src)
		var/obj/O = H.locked_to
		if(O.onBuckledUserKick(H, src))
			return //don't return 1! we will do the normal "touch" action if so!

	playsound(get_turf(src), 'sound/effects/grillehit.ogg', 50, 1) //Zth: I couldn't find a proper sound, please replace it

	H.visible_message("<span class='danger'>[H] kicks \the [src].</span>", "<span class='danger'>You kick \the [src].</span>")
	if(prob(70))
		H.apply_damage(rand(2,4), BRUTE, pick(LIMB_RIGHT_LEG, LIMB_LEFT_LEG, LIMB_RIGHT_FOOT, LIMB_LEFT_FOOT))

	if(!anchored && !locked_to)
		var/strength = H.get_strength()
		var/kick_dir = get_dir(H, src)

		if(!Move(get_step(loc, kick_dir))) //The structure that we kicked is up against a wall - this hurts our foot
			H.apply_damage(rand(2,4), BRUTE, pick(LIMB_RIGHT_LEG, LIMB_LEFT_LEG, LIMB_RIGHT_FOOT, LIMB_LEFT_FOOT))

		if(strength > 1) //Strong - kick further
			spawn()
				sleep(3)
				for(var/i = 2 to strength)
					if(!Move(get_step(loc, kick_dir)))
						break
					sleep(3)

//24.03.17
//copied from TG's PR from 2014 ~~~sir DonBastardo
//corrected - molesto441
/obj/structure/MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
	. = ..()
	if(!climbable)
		return
	if(ismob(O) && user == O && iscarbon(user))
		if(user.canmove)
			climb_structure(user)
			return
	if ( istype(O, /obj/item/weapon) || user.get_active_hand() == O ) //last means user have any item in hands

		if(user.drop_item(O))
			if(O.loc != src.loc)
				step(O, get_dir(O, src))
	else
		to_chat(user, "<span class='warning'>You should free your hands to clim onto [src].</span>") //replase visible_message anything that is better
		return
	return

/obj/structure/proc/can_touch(mob/user)
	if (!user)
		return 0
	if (isrobot(user))
		to_chat(user, "<span class='notice'>You need hands for this.</span>")
		return 0
	if(!Adjacent(user))
		return 0
	if (user.locked_to || user.anchored) //dunno if it works
		to_chat(user, "<span class='notice'>You need your hands and legs free for this.</span>")
		return 0
	if (user.stat || user.paralysis || user.sleeping || user.lying || user.incapacitated() )
		to_chat(user, "<span class='notice'>You are too weak to do that.</span>")
		return 0
	return 1

/obj/structure/proc/do_climb(mob/user)//changed from /atom/movable to /mob/user couse of first dosent have flying falue
	if(climbable && can_touch(user))
		user.flying = 1
		density = 0
		. = step(user,get_dir(user,src.loc))//param in Cross will me Mob with flying
		density = 1
		user.flying = 0

/obj/structure/proc/climb_structure(mob/user)
	src.add_fingerprint(user)
	to_chat(user,"<span class='warning'>You start climbing onto [src]...</span>")
	visible_message("<span class='warning'>[user] starts climbing onto [src].</span>")
	var/adjusted_climb_time = climb_time
	if(user.restrained()) //climbing takes twice as long when restrained.
		adjusted_climb_time *= 2
	if(isalien(user))
		adjusted_climb_time *= 0.25 //aliens are terrifyingly fast
	structureclimber = user
	if(do_mob(user, user, adjusted_climb_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_climb(user))
				to_chat(user,"<span class='warning'>You climb onto [src].</span>")
				visible_message("<span class='warning'>[user] climbs onto [src].</span>")
				add_logs(user, src, "climbed onto")
				user.SetStunned(climb_stun)
				. = 1
			else
				to_chat(user, "<span class='warning'>You fail to climb onto [src].</span>")
	structureclimber = null

/obj/structure/animationBolt(var/mob/firer)
	new /mob/living/simple_animal/hostile/mimic/copy(loc, src, firer, duration=SPELL_ANIMATION_TTL)
