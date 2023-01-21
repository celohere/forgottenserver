function onCastSpell(creature, variant, isHotkey)
	local position = Variant.getPosition(variant)
	local tile = Tile(position)
	if tile then
		local corpse = tile:getTopDownItem()
		if corpse then
			local itemType = corpse:getType()
			if itemType:isCorpse() and itemType:isMovable() then
				if #creature:getSummons() < 2 and creature:getSkull() ~= SKULL_BLACK then
					local monster = Game.createMonster("Skeleton", position)
					if monster then
						corpse:remove()
						monster:setMaster(creature)
						position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
						return true
					end
				else
					creature:sendCancelMessage("You cannot control more creatures.")
					creature:getPosition():sendMagicEffect(CONST_ME_POFF)
					return false
				end
			end
		end
	end

	creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	return false
end
