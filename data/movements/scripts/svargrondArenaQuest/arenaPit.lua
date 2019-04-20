dofile('data/lib/svargrondArenaQuest.lua')

local condition = Condition(CONDITION_OUTFIT, CONDITIONID_COMBAT)
condition:setTicks(120000)
condition:setOutfit({lookType = 111})

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if item.actionid == 30008 then
		player:addCondition(condition)
		SvargrondArena.cancelEvents(player.uid)
		player:setStorageValue(1009, 0)
		player:teleportTo(SvargrondArena.kickPosition)
		player:say('Coward!', TALKTYPE_MONSTER_SAY)
		return true
	end

	local pitId = player:getStorageValue(1009)
	local arenaId = player:getStorageValue(1008)
	if pitId > 10 then
		player:teleportTo(SvargrondArena.rewardPosition)
		player:getPosition():sendMagicEffect(arenaId == 1 and CONST_ME_FIREWORK_BLUE or arenaId == 2 and CONST_ME_FIREWORK_YELLOW or CONST_ME_FIREWORK_RED)
		player:setStorageValue(1009, 0)
		player:setStorageValue(SvargrondArena.getActionIdByArena(arenaId), 1)
		player:setStorageValue(1008, player:getStorageValue(1008) + 1)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Congratulations! You completed ' .. ARENA[arenaId].name .. ' arena, you should take your reward now.')
		player:say(arenaId == 1 and 'Welcome back, little hero!' or arenaId == 2 and 'Congratulations, brave warrior!' or 'Respect and honour to you, champion!', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(ARENA[arenaId].questLog, 2)
		SvargrondArena.cancelEvents(player.uid)
		return true
	end

	local occupant = SvargrondArena.getPitOccupant(pitId, player)
	if occupant then
		player:sendTextMessage(MESSAGE_INFO_DESCR, occupant:getName() .. ' is currently in the next arena pit. Please wait until ' .. (occupant:getSex() == 0 and 's' or '') .. 'he is done fighting.')
		player:teleportTo(fromPosition)
		return true
	end

	SvargrondArena.cancelEvents(player.uid)
	SvargrondArena.resetPit(pitId)
	SvargrondArena.scheduleKickPlayer(player.uid, pitId)
	Game.createMonster(ARENA[arenaId].creatures[pitId], PITS[pitId].summon, false, true)

	player:teleportTo(PITS[pitId].center)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:say('Fight!', TALKTYPE_MONSTER_SAY)
	return true
end