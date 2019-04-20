function onSay(cid, words, param)
	local player = Player(cid)

	if player:getCondition(CONDITION_INFIGHT) then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You need to be out of fight.")
		return false
	end

	local party = player:getParty()
	if not party then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are not in a party.")
		return false
	end

	if not player == party:getLeader() then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Only party leader can enable/disable shared experience.")
		return false
	end

	local boolean = not(party:isSharedExperienceActive())
	if party:setSharedExperience(boolean) then
		for _, pid in ipairs(party:getMembers()) do
			pid:sendTextMessage(MESSAGE_INFO_DESCR, "Shared Experience has been "..(boolean and "activated" or "deactivated")..".")
		end
	end
	return false
end
