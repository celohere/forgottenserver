function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target:isItem() then
		return false
	end

	--Dreamer Challenge Quest
	if target.uid == 31234 then
		target:transform(1387)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		item:remove()
		return true
	end

	local random = math.random(10)
	if random >= 4 then --success 6% chance
		if target.itemid == 5466 then --Burn Sugar Cane
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			target:transform(5465)
			target:decay()
		elseif target.itemid == 1485 then --Light Up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(1484)
		end
	elseif random == 2 then --it remove the fire bug 2% chance
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif random == 1 then --it explode on the user 1% chance
		doTargetCombatHealth(0, cid, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say('OUCH!', TALKTYPE_MONSTER_SAY)
		item:remove(1)
	else
		toPosition:sendMagicEffect(CONST_ME_POFF) --it fails, but dont get removed 3% chance
	end
	return true
end
