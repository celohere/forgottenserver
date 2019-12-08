local holeId = {
    294, 369, 370, 383, 392, 408, 409, 410, 427, 428, 430, 462, 469, 470, 482,
    484, 485, 489, 924, 3135, 3136
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end
	
	if not tile:getGround() then
		return false
	end

	if table.contains(ropeSpots, tile:getGround():getId()) then
		if Tile(toPosition:moveUpstairs()):hasFlag(TILESTATE_PROTECTIONZONE) and player:isPzLocked() then
			player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
			return true
		end
		player:teleportTo(toPosition, false)
		return true
	elseif table.contains(holeId, target.itemid) then
		toPosition.z = toPosition.z + 1
		tile = Tile(toPosition)
		if tile then
			local thing = tile:getTopVisibleThing()
			if thing:isPlayer() then
				if Tile(toPosition:moveUpstairs()):hasFlag(TILESTATE_PROTECTIONZONE) and thing:isPzLocked() then
					return false
				end
				return thing:teleportTo(toPosition, false)
			end
			if thing:isItem() and thing:getType():isMovable() then
				return thing:moveTo(toPosition:moveUpstairs())
			elseif thing:isCreature() then
                return thing:teleportTo(toPosition:moveUpstairs())
			end
		end
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end
	return false
end
