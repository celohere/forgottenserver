dofile('data/lib/svargrondArenaQuest.lua')

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(1008) < 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'This door seems to be sealed against unwanted intruders.')
		return true
	end

	-- Doors to rewards
	if isInArray({SvargrondArena.actionGreenhorn, SvargrondArena.actionScrapper, SvargrondArena.actionWarlord}, item.uid) then
		if player:getStorageValue(item.uid) <= 0 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, 'It\'s locked.')
			return true
		end

		-- Cannot use opened door
		if item.itemid == 5133 then
			return false
		end
		item:transform(item.itemid + 1)
		player:teleportTo(toPosition, true)
	end
	return true
end