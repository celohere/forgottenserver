dofile('data/lib/svargrondArenaQuest.lua')

function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	local pit = creature:getStorageValue(1009)
	if pit < 1 or pit > 10 then
		return true
	end

	local arena = creature:getStorageValue(1008)
	if arena < 1 then
		return true
	end

	if not isInArray(ARENA[arena].creatures, target:getName():lower()) then
		return true
	end

	-- Remove pillar and create teleport
	local pillarTile = Tile(PITS[pit].pillar)
	if pillarTile then
		local pillarItem = pillarTile:getItemById(SvargrondArena.itemPillar)
		if pillarItem then
			pillarItem:remove()

			local teleportItem = Game.createItem(SvargrondArena.itemTeleport, 1, PITS[pit].tp)
			if teleportItem then
				teleportItem:setActionId(30007)
			end

			SvargrondArena.sendPillarEffect(pit)
		end
	end

	creature:setStorageValue(1009, pit + 1)
	creature:say('Victory! Head through the new teleporter into the next room.', TALKTYPE_MONSTER_SAY)
	return true
end