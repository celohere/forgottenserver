local WATER_BORDER_FIRST = 4644 -- border ID begins here
local WATER_BORDER_LAST = 4655 -- and ends here
-- better make this into a table if you want more IDs to give water

local ITEM_RUM_FLASK = 5553
local TYPE_EMPTY = 0
local TYPE_WATER = 1
local TYPE_BLOOD = 2
local TYPE_BEER = 3
local TYPE_SLIME = 4
local TYPE_LEMONADE = 5
local TYPE_MILK = 6
local TYPE_MANA_FLUID = 7
local TYPE_LIFE_FLUID = 10
local TYPE_OIL = 11
local TYPE_URINE = 13
local TYPE_COCONUT_MILK = 14
local TYPE_WINE = 15
local TYPE_MUD = 19
local TYPE_FRUIT_JUICE = 21
local TYPE_LAVA = 26
local TYPE_RUM = 27
local TYPE_SWAMP = 28
local TYPE_TEA = 35

local distillery = {[5513] = 5469, [5514] = 5470}
local oilLamps = {[2046] = 2044}
local casks = {[1771] = TYPE_WATER, [1772] = TYPE_BEER, [1773] = TYPE_WINE}

local alcoholDrinks = {TYPE_BEER, TYPE_WINE, TYPE_RUM}

local poisonDrinks = {TYPE_SLIME, TYPE_SWAMP}


local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 60000)

local poison = Condition(CONDITION_POISON)
poison:setParameter(CONDITION_PARAM_DELAYED, true)
poison:setParameter(CONDITION_PARAM_MINVALUE, -50)
poison:setParameter(CONDITION_PARAM_MAXVALUE, -120)
poison:setParameter(CONDITION_PARAM_STARTVALUE, -5)
poison:setParameter(CONDITION_PARAM_TICKINTERVAL, 4000)
poison:setParameter(CONDITION_PARAM_FORCEUPDATE, true)

local burn = createConditionObject(CONDITION_FIRE)
setConditionParam(burn, CONDITION_PARAM_DELAYED, true) -- Condition will delay the first damage from when it's added
setConditionParam(burn, CONDITION_PARAM_MINVALUE, -70) -- Minimum damage the condition can do at total
setConditionParam(burn, CONDITION_PARAM_MAXVALUE, -150) -- Maximum damage
setConditionParam(burn, CONDITION_PARAM_STARTVALUE, -10) -- The damage the condition will do on the first hit
setConditionParam(burn, CONDITION_PARAM_TICKINTERVAL, 10000) -- Delay between damages
setConditionParam(burn, CONDITION_PARAM_FORCEUPDATE, true) -- Re-update condition when adding it(ie. min/max value)

local fluidType = {3, 4, 5, 7, 10, 11, 13, 15, 19 ,21 ,26 ,27 ,28 ,35}

local fluidMessage = {
    [2] = "Aaaah...",
	[3] = "Aah...",
	[4] = "Urgh!",
	[5] = "Mmmh.",
	[7] = "Aaaah...",
	[11] = "Urgh!",
	[13] = "Urgh!",
	[15] = "Aah...",
	[19] = "Urgh!",
	[21] = "Mmmh...",
	[26] = "Urgh!",
	[27] = "Urgh!",
	[28] = "Urgh!",
	[35] = "Mmmh."
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetType = ItemType(target.itemid)
	if targetType:isFluidContainer() then
		if target.type == 0 and item.type ~= 0 then
			target:transform(target.itemid, item.type)
			item:transform(item.itemid, 0)
			return true
		elseif target.type ~= 0 and item.type == 0 then
			target:transform(target.itemid, 0)
			item:transform(item.itemid, target.type)
			return true
		end
	end

	if target.itemid == 1 then
		if item.type == 0 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, 'It is empty.')

		elseif target.uid == player.uid then
			if isInArray({3, 15, 27}, item.type) then
				player:addCondition(drunk)

			elseif item.type == 4 then
				player:addCondition(poison)

			elseif item.type == 7 then
				player:addMana(math.random(50, 150))
				doSendMagicEffect(toPosition,CONST_ME_MAGIC_BLUE)

			elseif item.type == 2 then
				player:addHealth(60)
				doSendMagicEffect(toPosition,CONST_ME_MAGIC_BLUE)
			end

			player:say(fluidMessage[item.type] or "Gulp.", TALKTYPE_MONSTER_SAY)
			item:transform(item.itemid, 0)
		else
			local pool = Game.createItem(2016, item.type, toPosition)
			if pool then
				pool:decay()
			end
			item:transform(item.itemid, 0)
		end
   -- fill with water if itemEx is between the first and last ID we specified
   if(targetType >= WATER_BORDER_FIRST and target.itemid <= WATER_BORDER_LAST) then
    doChangeTypeItem(item.type, TYPE_WATER)
    return true
   end
   -- the rest is business as usual
   local fluidEx = getFluidSourceType(itemEx.itemid)
   if(fluidEx ~= false) then
    doChangeTypeItem(item.uid, fluidEx)
    return true
   end
   doPlayerSendCancel(cid, "It is empty.")
   return true
  end
  if(item.type == TYPE_OIL and oilLamps[itemEx.itemid] ~= nil) then
   doTransformItem(itemEx.uid, oilLamps[itemEx.itemid])
   doChangeTypeItem(item.uid, TYPE_NONE)
   return true
  end
  if(hasProperty(itemEx.uid, CONST_PROP_BLOCKSOLID)) then
   return false
  end


			local pool = Game.createItem(2016, item.type, toPosition)
			if pool then
				pool:decay()
			end
		
		item:transform(item.itemid, 0)

	return true
end
