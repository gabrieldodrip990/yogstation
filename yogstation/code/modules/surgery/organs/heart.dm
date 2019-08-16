/obj/item/organ/heart/nanite
	name = "Nanite heart"
	desc = "A specialized heart constructed from nanites that helps coordinate nanites allowing them to regenerate quicker inside the body without any ill effects. Caution this organ will fail without nanites to sustain itself!"
	icon_state = "heart-c"
	synthetic = TRUE
	var/nanite_boost = 1

/obj/item/organ/heart/nanite/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	SEND_SIGNAL(owner, COMSIG_NANITE_ADJUST_VOLUME, -100) // nanites are more susceptible to EMP
	Stop()

/obj/item/organ/heart/nanite/on_life()
	. = ..()
	if(SEND_SIGNAL(owner, COMSIG_HAS_NANITES))
		SEND_SIGNAL(owner, COMSIG_NANITE_ADJUST_VOLUME, nanite_boost)
	else
		if(prob(25))
			to_chat(owner, "<span class = 'userdanger'>You feel your heart collapse in on itself!</span>")
		Stop() //doesnt restart with defib even after re adding nanites, im calling this a feature because the heart itself is made of nanites