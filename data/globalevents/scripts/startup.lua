function onStartup()
    math.randomseed(os.mtime())

    -- Clearing the 'players_online' table
    db.asyncQuery("DELETE FROM `players_online` WHERE `world_id` = " .. configManager.getNumber(configKeys.WORLD_ID))

    -- Updating guild wars status and ending if they exceed the time limit
    db.asyncQuery("UPDATE `guild_wars` SET `status` = 4, `ended` = " .. os.time() .. " WHERE `status` = 1 AND (`started` + 3 * 60 * 60) < " .. os.time())

    -- Removing players marked for deletion and expired IP bans
    db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
    db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())

    -- Deleting canceled and rejected guilds
    db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 2")
    db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 3")

    -- Deleting guilds pending for too long (3 days)
    db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0 AND (`started` + 72 * 60 * 60) <= " .. os.time())

    -- Moving expired bans to ban history
    local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
    if resultId ~= false then
        repeat
            local accountId = result.getDataInt(resultId, "account_id")
            db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getDataString(resultId, "reason")) .. ", " .. result.getDataLong(resultId, "banned_at") .. ", " .. result.getDataLong(resultId, "expires_at") .. ", " .. result.getDataInt(resultId, "banned_by") .. ")")
            db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
        until not result.next(resultId)
        result.free(resultId)
    end

    -- Checking house auctions
    local resultId = db.storeQuery("SELECT `id`, `highest_bidder`, `last_bid`, (SELECT `balance` FROM `players` WHERE `players`.`id` = `highest_bidder`) AS `balance` FROM `" .. configManager.getString(configKeys.MYSQL_WORLD_DB) .. "`.`houses` WHERE `owner` = 0 AND `bid_end` != 0 AND `bid_end` < " .. os.time())
    if resultId ~= false then
        repeat
            local house = House(result.getDataInt(resultId, "id"))
            if house ~= nil then
                local highestBidder = result.getDataInt(resultId, "highest_bidder")
                local balance = result.getDataLong(resultId, "balance")
                local lastBid = result.getDataInt(resultId, "last_bid")
                if balance >= lastBid then
                    db.query("UPDATE `players` SET `balance` = " .. (balance - lastBid) .. " WHERE `id` = " .. highestBidder)
                    house:setOwnerGuid(highestBidder)
                end
                -- Updating 'houses' table
                db.asyncQuery("UPDATE `" .. configManager.getString(configKeys.MYSQL_WORLD_DB) .. "`.`houses` SET `last_bid` = 0, `bid_end` = 0, `highest_bidder` = 0, `bid` = 0 WHERE `id` = " .. house:getId())
            end
        until not result.next(resultId)
        result.free(resultId)
    end

    -- Update 'servers' table
	local resultId = db.storeQuery("SELECT * FROM `servers` WHERE `id` = " .. configManager.getNumber(configKeys.WORLD_ID))
	if resultId ~= false then
		db.asyncQuery("UPDATE `servers` SET `name` = '" .. configManager.getString(configKeys.SERVER_NAME) .. "', `ip` = '" .. configManager.getString(configKeys.IP) .. "', `port` = " .. configManager.getNumber(configKeys.GAME_PORT) .. " WHERE `id` = " .. configManager.getNumber(configKeys.WORLD_ID))
	else
		db.asyncQuery("INSERT INTO `servers` (`id`, `name`, `ip`, `port`, `world_id`) VALUES (" .. configManager.getNumber(configKeys.WORLD_ID) ..", '" .. configManager.getString(configKeys.SERVER_NAME) .. "', '" .. configManager.getString(configKeys.IP) .. "', " .. configManager.getNumber(configKeys.GAME_PORT) .. ", " .. configManager.getNumber(configKeys.WORLD_ID) ..")")
	end
end


