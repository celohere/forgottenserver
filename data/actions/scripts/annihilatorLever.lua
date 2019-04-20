local playerPosition = {
		{x = 194, y = 118, z = 9},
		{x = 193, y = 118, z = 9},
		{x = 192, y = 118, z = 9},
		{x = 191, y = 118, z = 9}
	}
local newPosition = {

		{x = 194, y = 118, z = 10},
		{x = 193, y = 118, z = 10},
		{x = 192, y = 118, z = 10},
		{x = 191, y = 118, z = 10}
	}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		local players = {}
		for _, position in ipairs(playerPosition) do
			local topPlayer = Tile(position):getTopCreature()
			if topPlayer == nil or not topPlayer:isPlayer() or topPlayer:getLevel() < 100 or topPlayer:getStorageValue(30015) ~= -1 then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
				return false
			end
			players[#players + 1] = topPlayer
		end

		for i, targetPlayer in ipairs(players) do
			Position(playerPosition[i])
			targetPlayer:teleportTo(newPosition[i], false)
			targetPlayer:getPosition()
		end
		item:transform(1946)
	elseif item.itemid == 1946 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_NOTPOSSIBLE))
	end
	return true
end

