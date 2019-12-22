--Basic
function isValidMoney(money)
	return isNumber(money) and money > 0 and money < 4294967296
end

function titleCase(str)
    return (str:gsub("^%l", string.upper))
end

function getMoneyCount(string)
	local b, e = string:find("%d+")
	local money = b and e and tonumber(string:sub(b, e)) or -1
	if isValidMoney(money) then
		return money
	end
	return -1
end

function getMoneyWeight(money)
	local gold = money
	local crystal = math.floor(gold / 10000)
	gold = gold - crystal * 10000
	local platinum = math.floor(gold / 100)
	gold = gold - platinum * 100
	return (ItemType(2160):getWeight() * crystal) + (ItemType(2152):getWeight() * platinum) + (ItemType(2148):getWeight() * gold)
end

function getAccountNumberByPlayerName(name)
	local player = Player(name)
	if player then
		return player:getAccountId()
	end

	local resultId = db.storeQuery("SELECT `account_id` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		local accountId = result.getDataInt(resultId, "account_id")
		result.free(resultId)
		return accountId
	end

	return 0
end

-- Game --
function Game.getPlayersByIPAddress(ip, mask)
	if not mask then mask = 0xFFFFFFFF end
	local masked = bit.band(ip, mask)
	local result = {}
	for _, player in ipairs(Game.getPlayers()) do
		if bit.band(player:getIp(), mask) == masked then
			result[#result + 1] = player
		end
	end
	return result
end

function Game.getPlayersByAccountNumber(accountNumber)
	local result = {}
	for _, player in ipairs(Game.getPlayers()) do
		if player:getAccountId() == accountNumber then
			result[#result + 1] = player
		end
	end
	return result
end

function Game.getHouseByPlayerGUID(playerGUID)
	for _, house in ipairs(Game.getHouses()) do
		if house:getOwnerGuid() == playerGUID then
			return house
		end
	end
	return nil
end

-- Player --
function Player.withdrawMoney(self, amount)
	local balance = self:getBankBalance()
	if amount > balance or not self:addMoney(amount) then
		return false
	end

	self:setBankBalance(balance - amount)
	return true
end

function Player.depositMoney(self, amount)
	if not self:removeMoney(amount) then
		return false
	end

	self:setBankBalance(self:getBankBalance() + amount)
	return true
end

function Player.transferMoneyTo(self, target, amount)
	local balance = self:getBankBalance()
	if amount > balance then
		return false
	end

	local targetPlayer = Player(target)
	if targetPlayer then
		targetPlayer:setBankBalance(targetPlayer:getBankBalance() + amount)
	else
		if not playerExists(target) then
			return false
		end
		db.query("UPDATE `players` SET `balance` = `balance` + '" .. amount .. "' WHERE `name` = " .. db.escapeString(target))
	end

	self:setBankBalance(self:getBankBalance() - amount)
	return true
end

function Player.getBlessings(self)
	local blessings = 0
	for i = 1, 5 do
		if self:hasBlessing(i) then
			blessings = blessings + 1
		end
	end
	return blessings
end

function Player.isMage(self)
	return isInArray({1, 2, 5, 6}, self:getVocation():getId())
end

function Player.getHighestSkillLevel(self)
	local ret = 0
	local clubLevel = self:getSkillLevel(SKILL_CLUB)
	local swordLevel = self:getSkillLevel(SKILL_SWORD)
	local axeLevel = self:getSkillLevel(SKILL_AXE)
	local distLevel = self:getSkillLevel(SKILL_DISTANCE)

	if clubLevel > swordLevel and clubLevel > axeLevel then
		ret = 1
	elseif swordLevel > clubLevel and swordLevel > axeLevel then
		ret = 2
	elseif axeLevel > clubLevel and axeLevel > swordLevel then
		ret = 3
	elseif distLevel > swordLevel and distLevel > axeLevel and distLevel > clubLevel then
		ret = 10
	end

	return self:getSkillLevel(ret)
end

function Player.isPromoted(self)
	local vocation = self:getVocation()
	if vocation:getId() == 0 or vocation:getPromotion():getId() == 0 then
		return true
	end

	return false
end

function Player.addExperienceStage(self, experience, sendText, useMult)
	if useMult then
		experience = experience * Game.getExperienceStage(self:getLevel())
	end

	return self:addExperience(experience, sendText)
end

-- Tile --
function Tile.relocateTo(self, toPosition)
	if self:getPosition() == toPosition then
		return false
	end

	if not Tile(toPosition) then
		return false
	end

	for i = self:getThingCount() - 1, 0, -1 do
		local thing = self:getThing(i)
		if thing then
			if thing:isItem() then
				if ItemType(thing:getId()):isMovable() then
					thing:moveTo(toPosition)
				end
			elseif thing:isCreature() then
				thing:teleportTo(toPosition)
			end
		end
	end
	return true
end

function Tile.isPz(self)
	return self:hasFlag(TILESTATE_PROTECTIONZONE)
end

function Tile.isHouse(self)
	local house = self:getHouse()
	return house and true or false
end

-- Vocation --
function Vocation.getBase(self)
	local demotion = self:getDemotion()
	while demotion do
		local tmp = demotion:getDemotion()
		if not tmp then
			return demotion
		end
		demotion = tmp
	end
	return self
end

function Vocation.getPromotionId(self)
	local promotion = self:getPromotion()
	return promotion and promotion:getId() or 0
end

-- Others --
function formatOsTime(time)
	local time = time - os.time()
	local hours = math.floor(time / 3600)
	
	minutes = math.floor((time - (3600 * hours)) / 60)

	return "" .. hours .. " hours and " .. minutes .. " minutes"
end
