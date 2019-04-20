function Party.broadcastChannelLoot(self, loot_msg)
	local members = self:getMembers()
	table.insert(members, self:getLeader())

	for _, member in pairs(members) do
		member:channelSay(nil, TALKTYPE_CHANNEL_O, loot_msg, 10)
	end
end