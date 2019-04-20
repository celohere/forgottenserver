function MonsterType.createLoot(self, corpse, modifier)
	if not corpse then
		return
	end

	if configKeys.RATE_LOOT == 0 then
		return
	end

	local owner = Player(corpse:getAttribute(ITEM_ATTRIBUTE_OWNER))

	if not owner or owner:getStamina() > 840 then
		for _, v in pairs(self:getLoot()) do
			local itemList = self:createLootItem(v, modifier)
			if itemList then
				for _, item in ipairs(itemList) do
					if item:isContainer() then
						local lootContainer = self:createLootContainer(item, v, modifier)
						if lootContainer then
							corpse:addItemEx(item)
						end
					else
						corpse:addItemEx(item, 1)
					end
				end
			end
		end

		if owner then
			local loot_msg = "Loot of " .. self:getNameDescription() .. ": " .. corpse:getContentDescription()

			if owner:getParty() then
				owner:getParty():broadcastLoot(loot_msg)
				owner:getParty():broadcastChannelLoot(loot_msg)
			else
				owner:sendTextMessage(MESSAGE_INFO_DESCR, loot_msg)
				owner:channelSay(nil, TALKTYPE_CHANNEL_O, loot_msg, 10)
			end
		end
	else
		local loot_msg = "Loot of " .. self:getNameDescription() .. ": nothing (due to low stamina)"

		if owner:getParty() then
			owner:getParty():broadcastLoot(loot_msg)
			owner:getParty():broadcastChannelLoot(loot_msg)
		else
			owner:sendTextMessage(MESSAGE_INFO_DESCR, loot_msg)
			owner:channelSay(nil, TALKTYPE_CHANNEL_O, loot_msg, 10)
		end
	end

	corpse:decay()
end

function MonsterType.createLootItem(self, lootBlock, modifier)
	local lootTable = {}
	local itemCount = 0

	local randvalue = math.random(0, 100000) / (configManager.getNumber(configKeys.RATE_LOOT) * modifier);
	if randvalue < lootBlock.chance then
		if (ItemType(lootBlock.itemId):isStackable()) then
			itemCount = randvalue % lootBlock.maxCount + 1;
		else
			itemCount = 1;
		end
	end

	while (itemCount > 0) do
		local n = math.min(itemCount, 100)
		itemCount = itemCount - n

		local item = Game.createItem(lootBlock.itemId, n)

		if item then
			if lootBlock.subType ~= -1 then
				item:transform(lootBlock.itemId, lootBlock.subType)
			end

			if lootBlock.actionId ~= -1 then
				item:setActionId(lootBlock.actionId)
			end

			if lootBlock.text and lootBlock.text ~= "" then
				item:setAttribute(ITEM_ATTRIBUTE_TEXT, lootBlock.text)
			end

			table.insert(lootTable, item)
		end
	end

	return #lootTable == 0 and nil or lootTable
end

function MonsterType.createLootContainer(self, parent, lootBlock, modifier)
	if #lootBlock.childLoot == 0 then
		return true
	end

	for _, v in pairs(lootBlock.childLoot) do
		if parent:getSize() < parent:getCapacity() then
			local itemList = self:createLootItem(v, modifier)
			if itemList then
				for _, item in ipairs(itemList) do
					if item:isContainer() then
						local lootContainer = self:createLootContainer(item, v, modifier)
						if lootContainer then
							parent:addItemEx(item)
						end
					else
						parent:addItem(item, 1)
					end
				end
			end
		end
	end

	return #parent > 0
end