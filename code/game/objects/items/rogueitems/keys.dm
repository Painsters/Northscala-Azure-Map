
/obj/item/key
	name = "key"
	desc = "An unremarkable iron key."
	icon_state = "iron"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	lockhash = 0
	lockid = null
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK
	drop_sound = 'sound/items/gems (1).ogg'
	anvilrepair = /datum/skill/craft/blacksmithing

/obj/item/key/Initialize()
	. = ..()
	if(lockid)
		if(GLOB.lockids[lockid])
			lockhash = GLOB.lockids[lockid]
		else
			lockhash = rand(100,999)
			while(lockhash in GLOB.lockhashes)
				lockhash = rand(100,999)
			GLOB.lockhashes += lockhash
			GLOB.lockids[lockid] = lockhash

/obj/item/lockpick
	name = "lockpick"
	desc = "A small, sharp piece of metal to aid opening locks in the absence of a key."
	icon_state = "lockpick"
	icon = 'icons/roguetown/items/keys.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK
	destroy_sound = 'sound/items/pickbreak.ogg'

//custom key
/obj/item/key/custom
	name = "custom key"
	desc = "A custom key designed by a blacksmith."
	icon_state = "brownkey"

/obj/item/key/custom/attackby(obj/item/I, mob/user, params)

	if(!istype(I, /obj/item/rogueweapon/hammer))
		return

	var/input = (input(user, "What would you name this key?", "", "") as text)

	if(!input)
		return

	name = input + " key"
	to_chat(user, span_notice("You rename the key to [name]."))

//custom key blank
/obj/item/key_custom_blank//i'd prefer not to make a seperate item for this honestly
	name = "blank custom key"
	desc = "A key without its teeth carved in. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "brownkey"
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	lockhash = 0

/obj/item/key_custom_blank/attackby(obj/item/I, mob/user, params)

	if(!istype(I, /obj/item/rogueweapon/hammer))
		return

	var/input = input(user, "What would you like to set the key ID to?", "", 0) as num

	if(!input)
		return

	input = max(0, input)
	to_chat(user, span_notice("You set the key ID to [input]."))
	lockhash = 10000 + input //having custom lock ids start at 10000 leaves it outside the range that opens normal doors, so you can't make a key that randomly unlocks existing key ids like the church

/obj/item/key_custom_blank/attack_right(mob/user)

	if(istype(user.get_active_held_item(), /obj/item/key))
		var/obj/item/key/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You trace the teeth from [held] to [src]."))
	else if(istype(user.get_active_held_item(), /obj/item/customlock))
		var/obj/item/customlock/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You fine-tune [src] to the lock's internals."))
	else if(istype(user.get_active_held_item(), /obj/item/rogueweapon/hammer) && src.lockhash != 0)
		var/obj/item/key/custom/F = new (get_turf(src))
		F.lockhash = src.lockhash
		F.lockid = lockhash
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)


/obj/item/key/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockid = "lord"

/obj/item/key/lord/pre_attack(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockhash = C.lockhash
	if(istype(target, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/D = target
		if(D.masterkey)
			lockhash = D.lockhash

/obj/item/key/royal
	name = "Royal Key"
	desc = "The Key to the royal chambers. It even feels pretentious."
	icon_state = "ekey"
	lockid = "royal"

/obj/item/key/prince_rooms
	name = "Princely Key"
	desc = "The Key to the heirs chambers."
	icon_state = "ekey"
	lockid = "prince"

/obj/item/key/vault
	name = "vault key"
	desc = "This key opens the mighty vault."
	icon_state = "cheesekey"
	lockid = "vault"

/obj/item/key/councillor_rooms
	name = "councillor rooms key"
	desc = "This key opens the councillor's rooms."
	icon_state = "cheesekey"
	lockid = "councillor"

/obj/item/key/merchant
	name = "merchant's key"
	desc = "A merchant's key."
	icon_state = "cheesekey"
	lockid = "merchant"

/obj/item/key/shop
	name = "shop key"
	desc = "This key opens and closes a shop door."
	icon_state = "ekey"
	lockid = "shop"

/obj/item/key/townie // For use in round-start available houses in town. Do not use default lockID.
	name = "town dwelling Key"
	desc = "The key of some townie's home. Hope it's not lost."
	icon_state ="brownkey"
	lockid = "townie"

/obj/item/key/tavern
	name = "tavern key"
	desc = "This key should open and close any tavern door."
	icon_state = "hornkey"
	lockid = "tavern"

/obj/item/key/velder
	name = "elder's key"
	desc = "This key should open and close the elder's home."
	icon_state = "brownkey"
	lockid = "velder"

/obj/item/key/tavern/village
	lockid = "vtavern"

/obj/item/key/roomi/village
	lockid = "vroomi"

/obj/item/key/roomii/village
	lockid = "vroomii"

/obj/item/key/roomiii/village
	lockid = "vroomiii"

/obj/item/key/roomiv/village
	lockid = "vroomiv"

/obj/item/key/roomv/village
	lockid = "vroomv"

/obj/item/key/roomvi/village
	lockid = "vroomvi"

/obj/item/key/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockid = "roomi"

/obj/item/key/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockid = "roomii"

/obj/item/key/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockid = "roomiii"

/obj/item/key/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockid = "roomiv"

/obj/item/key/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockid = "roomv"

/obj/item/key/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockid = "roomvi"

/obj/item/key/fancyroomi
	name = "fancy room I key"
	desc = "The key to the fancy room I."
	icon_state = "brownkey"
	lockid = "fancyroomi"

/obj/item/key/fancyroomii
	name = "fancy room II key"
	desc = "The key to the fancy room II."
	icon_state = "brownkey"
	lockid = "fancyroomii"

/obj/item/key/fancyroomiii
	name = "fancy room III key"
	desc = "The key to the fancy room III."
	icon_state = "brownkey"
	lockid = "fancyroomiii"

/obj/item/key/roomhunt
	name = "room HUNT key"
	desc = "This is the HUNT key!"
	icon_state = "brownkey"
	lockid = "roomhunt"

//vampire mansion//
/obj/item/key/vampire
	name = "mansion key"
	desc = "The key to a vampire lord's castle."
	icon_state = "vampkey"
	lockid = "mansionvampire"
//

/obj/item/key/blacksmith
	name = "blacksmith key"
	desc = "This key opens a blacksmith's workshop."
	icon_state = "brownkey"
	lockid = "blacksmith"

/obj/item/key/blacksmith/town
	name = "town blacksmith key"
	lockid = "townblacksmith"

/obj/item/key/seamster
	name = "workshop key"
	desc = "This key opens the door to the tailor workshop."
	icon_state = "brownkey"
	lockid = "seamster"

/obj/item/key/walls
	name = "walls key"
	desc = "This is a rusty key."
	icon_state = "rustkey"
	lockid = "walls"

/obj/item/key/farm
	name = "farm key"
	desc = "This is a rusty key that'll open farm doors."
	icon_state = "rustkey"
	lockid = "farm"

/obj/item/key/butcher
	name = "butcher key"
	desc = "This is a rusty key that'll open butcher doors."
	icon_state = "rustkey"
	lockid = "butcher"

/obj/item/key/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockid = "church"

/obj/item/key/priest
	name = "priest's key"
	desc = "This is the master key of the church."
	icon_state = "cheesekey"
	lockid = "priest"

/obj/item/key/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockid = "tower"

/obj/item/key/mage
	name = "magicians's key"
	desc = "This is the court wizard's key. It watches you..."
	icon_state = "eyekey"
	lockid = "mage"

/obj/item/key/graveyard
	name = "crypt key"
	desc = "This rusty key belongs to the gravekeeper."
	icon_state = "rustkey"
	lockid = "graveyard"

/obj/item/key/artificer
	name = "artificer's key"
	desc = "This bronze key should open the Artificer's guild."
	icon_state = "brownkey"
	lockid = "artificer"

/obj/item/key/nightman
	name = "nightmaster's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "greenkey"
	lockid = "nightman"

/obj/item/key/nightmaiden
	name = "nightmaiden's key"
	desc = "This regal key opens a few doors within the castle."
	icon_state = "brownkey"
	lockid = "nightmaiden"

/obj/item/key/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc"

/obj/item/key/mercenary_boss
	name = "mercenary captain key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc_boss"

/obj/item/key/physician
	name = "physician key"
	desc = "The key smells of herbs, feeling soothing to the touch."
	icon_state = "greenkey"
	lockid = "physician"

/obj/item/key/puritan
	name = "puritan's key"
	desc = "This is an intricate key." // i have no idea what is this key about
	icon_state = "mazekey"
	lockid = "puritan"

/obj/item/key/confession
	name = "confessional key"
	desc = "This key opens the doors of the confessional."
	icon_state = "brownkey"
	lockid = "confession"

/obj/item/key/hand
	name = "hand's key"
	desc = "This regal key belongs to the Duke's Right Hand."
	icon_state = "cheesekey"
	lockid = "hand"

/obj/item/key/steward
	name = "steward's key"
	desc = "This key belongs to the court's greedy steward."
	icon_state = "cheesekey"
	lockid = "steward"

/obj/item/key/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockid = "archive"

/obj/item/key/manor
	name = "manor key"
	desc = "This key will open any manor doors."
	icon_state = "mazekey"
	lockid = "manor"

/obj/item/key/bog_gatehouse
	name = "bog gatehouse key"
	desc = "This key opens the bog gatehouse."
	icon_state = "spikekey"
	lockid = "bog_gatehouse"

/obj/item/key/bog_master
	name = "Warden's key"
	desc = "This key opens the Warden's office."
	icon_state = "spikekey"
	lockid = "bog_master"

/obj/item/key/town_barracks
	name = "town barracks key"
	desc = "This key opens the town barracks."
	icon_state = "spikekey"
	lockid = "town_barracks"

/obj/item/key/town_dungeon
	name = "town dungeon key"
	desc = "This key opens the town dungeon."
	icon_state = "spikekey"
	lockid = "town_dungeon"

/obj/item/key/town_armory
	name = "town armory key"
	desc = "This key opens the town armory."
	icon_state = "spikekey"
	lockid = "town_armory"

/obj/item/key/sheriff_office
	name = "sheriff's office key"
	desc = "This key opens the sheriff's office."
	icon_state = "spikekey"
	lockid = "sheriff_office"

/obj/item/key/keep_gatehouse
	name = "keep gatehouse key"
	desc = "This key opens the keep gatehouse."
	icon_state = "spikekey"
	lockid = "keep_gatehouse"

/obj/item/key/keep_barracks
	name = "keep barracks key"
	desc = "This key opens the keep barracks."
	icon_state = "spikekey"
	lockid = "keep_barracks"

/obj/item/key/keep_dungeon
	name = "keep dungeon key"
	desc = "This key opens the keep dungeon."
	icon_state = "spikekey"
	lockid = "keep_dungeon"

/obj/item/key/keep_dungeon_torture
	name = "keep dungeon torture room key"
	desc = "This key opens the keep dungeon torture room."
	icon_state = "spikekey"
	lockid = "keep_dungeon_torture"

/obj/item/key/keep_armory
	name = "keep armory key"
	desc = "This key opens the keep armory."
	icon_state = "spikekey"
	lockid = "keep_armory"

//grenchensnacker
/obj/item/key/porta
	name = "strange key"
	desc = "Was this key enchanted by a wizard locksmith...?"//what is grenchensnacker.
	icon_state = "eyekey"
	lockid = "porta"

//Goblins
/obj/item/key/goblin
	name = "goblin key"
	desc = "This key opens the fort's basic interior doors."
	icon_state = "mazekey"
	lockid = "gobbo"

/obj/item/key/goblinguard
	name = "goblin guard key"
	desc = "This key opens the fort barracks."
	icon_state = "spikekey"
	lockid = "gobbo_guards"

/obj/item/key/goblinchief
	name = "goblin chief key"
	desc = "This key opens the Chief's room and the vault."
	icon_state = "spikekey"
	lockid = "gobbo_chief"

//grenchensnacker
/obj/item/key/porta
	name = "strange key"
	desc = "Was this key enchanted by a wizard locksmith...?"//what is grenchensnacker.
	icon_state = "eyekey"
	lockid = "porta"

// Towner homes keys
/obj/item/roguekey/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockid = "lord"
	visual_replacement = /obj/item/roguekey/royal

/obj/item/roguekey/lord/Initialize()
	. = ..()
	if(SSroguemachine.key)
		qdel(src)
	else
		SSroguemachine.key = src

/obj/item/roguekey/lord/proc/anti_stall()
	src.visible_message(span_warning("The Key of Azure Peak crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.key = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/roguekey/lord/pre_attack(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockhash = C.lockhash
	if(istype(target, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/D = target
		if(D.masterkey)
			lockhash = D.lockhash

/obj/item/roguekey/royal
	name = "Royal Key"
	desc = "The Key to the royal chambers. It even feels pretentious."
	icon_state = "ekey"
	lockid = "royal"

/obj/item/roguekey/manor
	name = "manor key"
	desc = "This key will open any manor doors."
	icon_state = "mazekey"
	lockid = "manor"

/obj/item/roguekey/heir
	name = "heir room key"
	desc = "A highly coveted key belonging to the doors of the heirs of this realm."
	icon_state = "hornkey"
	lockid = "heir"

/obj/item/roguekey/garrison
	name = "town watch key"
	desc = "This key belongs to the town guards."
	icon_state = "spikekey"
	lockid = "garrison"

/obj/item/roguekey/warden
	name = "watchtower key"
	desc = "This key belongs to the wardens."
	icon_state = "spikekey"
	lockid = "warden"

/obj/item/roguekey/dungeon
	name = "dungeon key"
	desc = "This key should unlock the rusty bars and doors of the dungeon."
	icon_state = "rustkey"
	lockid = "dungeon"

/obj/item/roguekey/vault
	name = "vault key"
	desc = "This key opens the mighty vault."
	icon_state = "cheesekey"
	lockid = "vault"

/obj/item/roguekey/sheriff
	name = "guard captain's key"
	desc = "This key belongs to the captain of the guard."
	icon_state = "cheesekey"
	lockid = "sheriff"

/obj/item/roguekey/bailiff
	name = "bailiff's key"
	desc = "This key belongs to the bailiff."
	icon_state = "cheesekey"
	lockid = "sheriff"

/obj/item/roguekey/merchant
	name = "merchant's key"
	desc = "A merchant's key."
	icon_state = "cheesekey"
	lockid = "merchant"

/obj/item/roguekey/shop
	name = "shop key"
	desc = "This key opens and closes a shop door."
	icon_state = "ekey"
	lockid = "shop"

/obj/item/roguekey/townie // For use in round-start available houses in town. Do not use default lockID.
	name = "Town Dwelling Key"
	desc = "The key of some townie's home. Hope it's not lost."
	icon_state ="brownkey"
	lockid = "townie"

/obj/item/roguekey/tavern
	name = "tavern key"
	desc = "This key should open and close any tavern door."
	icon_state = "hornkey"
	lockid = "tavern"

/obj/item/roguekey/tavernkeep
	name = "innkeep's key"
	desc = "This key opens and closes the innkeep's bedroom."
	icon_state = "greenkey"
	lockid = "innkeep"

/obj/item/roguekey/velder
	name = "elder's key"
	desc = "This key should open and close the elder's home."
	icon_state = "brownkey"
	lockid = "velder"

/obj/item/roguekey/tavern/village
	lockid = "vtavern"

/obj/item/roguekey/roomi/village
	lockid = "vroomi"

/obj/item/roguekey/roomii/village
	lockid = "vroomii"

/obj/item/roguekey/roomiii/village
	lockid = "vroomiii"

/obj/item/roguekey/roomiv/village
	lockid = "vroomiv"

/obj/item/roguekey/roomv/village
	lockid = "vroomv"

/obj/item/roguekey/roomvi/village
	lockid = "vroomvi"

/obj/item/roguekey/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockid = "roomi"

/obj/item/roguekey/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockid = "roomii"

/obj/item/roguekey/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockid = "roomiii"

/obj/item/roguekey/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockid = "roomiv"

/obj/item/roguekey/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockid = "roomv"

/obj/item/roguekey/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockid = "roomvi"

/obj/item/roguekey/roomhunt
	name = "room HUNT key"
	desc = "This is the HUNT key!"
	icon_state = "brownkey"
	lockid = "roomhunt"

//vampire mansion//
/obj/item/roguekey/vampire
	name = "mansion key"
	desc = "The key to a vampire lord's castle."
	icon_state = "vampkey"
	lockid = "mansionvampire"
//

/obj/item/roguekey/blacksmith
	name = "blacksmith key"
	desc = "This key opens a blacksmith's workshop."
	icon_state = "brownkey"
	lockid = "blacksmith"

/obj/item/roguekey/blacksmith/town
	name = "town blacksmith key"
	lockid = "townblacksmith"

/obj/item/roguekey/walls
	name = "walls key"
	desc = "This is a rusty key."
	icon_state = "rustkey"
	lockid = "walls"

/obj/item/roguekey/farm
	name = "farm key"
	desc = "This is a rusty key that'll open farm doors."
	icon_state = "rustkey"
	lockid = "farm"

/obj/item/roguekey/butcher
	name = "butcher key"
	desc = "This is a rusty key that'll open butcher doors."
	icon_state = "rustkey"
	lockid = "butcher"

/obj/item/roguekey/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockid = "church"

/obj/item/roguekey/priest
	name = "priest's key"
	desc = "This is the master key of the church."
	icon_state = "cheesekey"
	lockid = "priest"

/obj/item/roguekey/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockid = "tower"

/obj/item/roguekey/mage
	name = "magicians's key"
	desc = "This is the court wizard's key. It watches you..."
	icon_state = "eyekey"
	lockid = "mage"

/obj/item/roguekey/graveyard
	name = "crypt key"
	desc = "This rusty key belongs to the gravekeeper."
	icon_state = "rustkey"
	lockid = "graveyard"

/obj/item/roguekey/artificer
	name = "artificer's key"
	desc = "This bronze key should open the Artificer's guild."
	icon_state = "brownkey"
	lockid = "artificer"

/obj/item/roguekey/tailor
	name = "tailor's key"
	desc = "This key opens the tailor's shop. There is a thin thread wrapped around it."
	icon_state = "brownkey"
	lockid = "tailor"

/obj/item/roguekey/nightman
	name = "bathmaster's key"
	desc = "This regal key opens the bathmaster's office - and his vault."
	icon_state = "greenkey"
	lockid = "nightman"

/obj/item/roguekey/nightmaiden
	name = "bathhouse key"
	desc = "This regal key opens doors inside the bath-house."
	icon_state = "brownkey"
	lockid = "nightmaiden"

/obj/item/roguekey/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = "merc"

/obj/item/roguekey/physician
	name = "physician key"
	desc = "The key smells of herbs, feeling soothing to the touch."
	icon_state = "greenkey"
	lockid = "physician"

/obj/item/roguekey/puritan
	name = "puritan's key"
	desc = "This is an intricate key." // i have no idea what is this key about
	icon_state = "mazekey"
	lockid = "puritan"

/obj/item/roguekey/inquisition
	name = "inquisition key"
	desc = "This key opens the doors leading into the church's basement, where the inquisition dwells."
	icon_state = "brownkey"
	lockid = "inquisition"

/obj/item/roguekey/inhumen
	name = "ancient key"
	desc = "A ancient, rusty key. There's no telling where this leads."
	icon_state = "rustkey"
	lockid = "inhumen"

/obj/item/roguekey/hand
	name = "hand's key"
	desc = "This regal key belongs to the Grand Duke's Right Hand."
	icon_state = "cheesekey"
	lockid = "hand"

/obj/item/roguekey/steward
	name = "steward's key"
	desc = "This key belongs to the court's greedy steward."
	icon_state = "cheesekey"
	lockid = "steward"

/obj/item/roguekey/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockid = "archive"

//grenchensnacker
/obj/item/roguekey/porta
	name = "strange key"
	desc = "Was this key enchanted by a wizard locksmith...?"//what is grenchensnacker.
	icon_state = "eyekey"
	lockid = "porta"

/obj/item/roguekey/houses
	name = ""
	icon_state = ""
	lockid = ""

/obj/item/roguekey/houses/house1
	name = "house i key"
	icon_state = "brownkey"
	lockid = "house1"

/obj/item/roguekey/houses/house2
	name = "house ii key"
	icon_state = "brownkey"
	lockid = "house2"

/obj/item/roguekey/houses/house3
	name = "house iii key"
	icon_state = "brownkey"
	lockid = "house3"

/obj/item/roguekey/houses/house4
	name = "house iv key"
	icon_state = "brownkey"
	lockid = "house4"

/obj/item/roguekey/houses/house5
	name = "house v key"
	icon_state = "brownkey"
	lockid = "house5"

/obj/item/roguekey/houses/house6
	name = "house vi key"
	icon_state = "brownkey"
	lockid = "house6"

//Apartment and shop keys
/obj/item/roguekey/apartments
	name = ""
	icon_state = ""
	lockid = ""

/obj/item/roguekey/apartments/apartment1
	name = "apartment i key"
	icon_state = "brownkey"
	lockid = "apartment1"

/obj/item/roguekey/apartments/apartment2
	name = "apartment ii key"
	icon_state = "brownkey"
	lockid = "apartment2"

/obj/item/roguekey/apartments/apartment3
	name = "apartment iii key"
	icon_state = "brownkey"
	lockid = "apartment3"

/obj/item/roguekey/apartments/apartment4
	name = "apartment iv key"
	icon_state = "brownkey"
	lockid = "apartment4"

/obj/item/roguekey/apartments/stall1
	name = "stall i key"
	icon_state = "brownkey"
	lockid = "stall1"

/obj/item/roguekey/apartments/stall2
	name = "stall ii key"
	icon_state = "brownkey"
	lockid = "stall2"

/obj/item/roguekey/apartments/stall3
	name = "stall iii key"
	icon_state = "brownkey"
	lockid = "stall3"

/obj/item/roguekey/apartments/stall4
	name = "stall iv key"
	icon_state = "brownkey"
	lockid = "stall4"

/obj/item/roguekey/apartments/stable1
	name = "stable i key"
	icon_state = "brownkey"
	lockid = "stable1"

/obj/item/roguekey/apartments/stable2
	name = "stable ii key"
	icon_state = "brownkey"
	lockid = "stable2"

/obj/item/roguekey/apartments/stable3
	name = "stable iii key"
	icon_state = "brownkey"
	lockid = "stable3"


