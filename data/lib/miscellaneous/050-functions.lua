function isNumber(str)
     return tonumber(str) ~= nil
end
 
function getAccountNumberByPlayerName(name)
	local player = Player(name)
	if player ~= nil then
		return player:getAccountId()
	end

	local resultId = db.storeQuery("SELECT `account_id` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		local accountId = result.getNumber(resultId, "account_id")
		result.free(resultId)
		return accountId
	end
	return 0
end

function doAddExp(cid, amount, useExpStages, customColor, ...)
    local player = cid:getPlayer()
    if not player then
        return false
    else
        if useExpStages then amount = amount * Game.getExperienceStage(player:getLevel()) end
        if not customColor then customColor = TEXTCOLOR_WHITE_EXP end
        Game.sendAnimatedText(amount, getCreaturePosition(cid), customColor)
        return doPlayerAddExp(cid, amount)
    end
end
 
function doScanContainer(item, backpack, tables, count)
    if isContainer(item.uid) then
        for i = 0, getContainerSize(item.uid) do
            local item = getContainerItem(item.uid, i)
            if not(isContainer(item.uid)) then
                table.insert(tables, item.itemid)
                table.insert(count, item.type)
            else
                table.insert(backpack, item.itemid)
                doScanContainer(item, backpack, tables, count)
            end
        end
    end
end

function getMoneyCount(string)
	local b, e = string:find("%d+")
	local money = b and e and tonumber(string:sub(b, e)) or -1
	if isValidMoney(money) then
		return money
	end
	return -1
end

--function getBankMoney(cid, amount)
 --local player = Player(cid)
 --if player:getBankBalance() >= amount then
 -- player:setBankBalance(player:getBankBalance() - amount)
 -- player:sendTextMessage(MESSAGE_INFO_DESCR, "Paid " .. amount .. " gold from bank account. Your account balance is now " .. player:getBankBalance() .. " gold.")
 -- return true
-- end
 --return false
--end

function getMoneyWeight(money)
	local gold = money
	local crystal = math.floor(gold / 10000)
	gold = gold - crystal * 10000
	local platinum = math.floor(gold / 100)
	gold = gold - platinum * 100
	return (ItemType(2160):getWeight() * crystal) + (ItemType(2152):getWeight() * platinum) + (ItemType(2148):getWeight() * gold)
end

function getRealDate()
	local month = tonumber(os.date("%m", os.time()))
	local day = tonumber(os.date("%d", os.time()))

	if month < 10 then
		month = '0' .. month
	end
	if day < 10 then
		day = '0' .. day
	end
	return day .. '/' .. month
end

function getRealTime()
	local hours = tonumber(os.date("%H", os.time()))
	local minutes = tonumber(os.date("%M", os.time()))

	if hours < 10 then
		hours = '0' .. hours
	end
	if minutes < 10 then
		minutes = '0' .. minutes
	end
	return hours .. ':' .. minutes
end

function isValidMoney(money)
	return isNumber(money) and money > 0 and money < 4294967296
end

function iterateArea(func, from, to)
	for z = from.z, to.z do
		for y = from.y, to.y do
			for x = from.x, to.x do
				func(Position(x, y, z))
			end
		end
	end
end

function playerExists(name)
	local resultId = db.storeQuery('SELECT `name` FROM `players` WHERE `name` = ' .. db.escapeString(name))
	if resultId then
		result.free(resultId)
		return true
	end
	return false
end



