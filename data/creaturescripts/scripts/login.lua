function onLogin(player)
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "! Say !buypremium to buy premmy days"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	local playerId = player:getId()

        local time = 10 -- 10 seconds cooldown until they can logout
        setPlayerStorageValue(cid, 3333, os.time()+time)

	-- Stamina
	nextUseStaminaTime[player.uid] = 0


	-- STAMINA DEVIDO A QUEDAS START
   
	--local stamina_full = 42 * 60 -- config. 42 = horas
 	-- if player:getStamina() >= stamina_full then
	--  player:sendCancelMessage("Your stamina is already full.")
	-- elseif player:getPremiumDays() < 1 then
	--   player:sendCancelMessage("You must have a premium account.")
	-- else
	--  player:setStamina(stamina_full)
	-- player:sendTextMessage(MESSAGE_INFO_DESCR, "Your stamina has been refilled.")      
	-- end
   
	-- STAMINA DEVIDO A QUEDAS END

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end
	
	-- Outfits
	if not player:isPremium() then
		if player:getSex() == PLAYERSEX_FEMALE then
			local outfit = player:getOutfit()
			if outfit.lookType > 139 then
				player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
			end
		else
			local outfit = player:getOutfit()
			if outfit.lookType > 131 then
				player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
			end
		end
	end

	-- Premium system
	if player:isPremium() then
		player:setStorageValue(43434, 1)
	elseif player:getStorageValue(43434) == 1 then
		player:setStorageValue(43434, 0)
		player:teleportTo({x = 160, y = 54, z = 7})
		player:setTown(Town("Motherland"))
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Your premium time has expired.")
	end

 -- for global with rookgaard
 -- Premium system
 --   local rookTownId = 6
 --   local thaisTownId = 2

 --   if player:isPremium() and player:getStorageValue(43434) ~= 1 then
 --       player:setStorageValue(43434, 1)
 --   elseif not player:isPremium() and player:getStorageValue(43434) == 1 then
 --       if player:getVocation():getId() == 0 then
 --           player:setTown(Town(rookTownId))
 --       else
 --           player:setTown(Town(thaisTownId))
 --       end
 --       player:sendTextMessage(22, "Your premium time has expired.")
 --       player:setStorageValue(43434, -1)        
 --       player:teleportTo(player:getTown():getTemplePosition())
 --   end

	-- Events
	player:registerEvent("pvpenfo")
	player:registerEvent("logoutdelay")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("broadcast_deaths")
	player:registerEvent("loot")
	return true
end
