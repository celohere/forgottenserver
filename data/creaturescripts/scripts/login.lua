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

	-- Events
     player:registerEvent("pvpenfo")
     player:registerEvent("logoutdelay")
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("SvargrondArenaKill")
	player:registerEvent("broadcast_deaths")
	player:registerEvent("loot")
	return true
end
