dofile('data/lib/svargrondArenaQuest.lua')

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local arenaId = player:getStorageValue(1008) - 1
	if player:getStorageValue(ARENA[arenaId].reward.trophyStorage) ~= 1 then
		local rewardPosition = player:getPosition()
		rewardPosition.y = rewardPosition.y - 1

		local rewardItem = Game.createItem(ARENA[arenaId].reward.trophy, 1, rewardPosition)
		if rewardItem then
			rewardItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format(ARENA[arenaId].reward.desc, player:getName()))
		end

		player:setStorageValue(ARENA[arenaId].reward.trophyStorage, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	end

	item:transform(425)
	return true
end