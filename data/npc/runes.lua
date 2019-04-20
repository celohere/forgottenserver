local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')
shopModule:addBuyableItem({'magic lightwand'}, 2163, 400, 'magic lightwand')

shopModule:addBuyableItemContainer({'bp sd', 'bp of sd', 'bp of sudden death'}, 2003, 2268, 150000, 100, 'backpack of sudden death runes')
shopModule:addBuyableItemContainer({'bp uh', 'bp of uh'}, 2002, 2273, 100000, 100, 'backpack of ultimate healing runes')
shopModule:addBuyableItemContainer({'bp explosion', 'bp of explosion'}, 2001, 2313, 130000, 100, 'backpack of explosion runes')
shopModule:addBuyableItemContainer({'bp mana fluid', 'bp of mana fluid'}, 2001, 2006, 2000, 7, 'backpack of mana fluid')

shopModule:addBuyableItem({'life fluid', 'lifefluid'}, 2006, 45, 10, 'vial of lifefluid')
shopModule:addBuyableItem({'mana fluid', 'manafluid'}, 2006, 50, 7, 'vial of manafluid')

shopModule:addBuyableItem({'intense healing'}, 2265, 35, 1, 'intense healing rune')
shopModule:addBuyableItem({'ultimate healing'}, 2273, 50, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'uh'}, 2273, 50, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'magic wall'}, 2293, 40, 3, 'magic wall rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 20, 3, 'destroy field rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 20, 10, 'light magic missile rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 30, 10, 'heavy magic missile rune')
shopModule:addBuyableItem({'hmm'}, 2311, 30, 10, 'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 40, 4, 'great fireball rune')
shopModule:addBuyableItem({'gfb'}, 2304, 40, 4, 'great fireball rune')
shopModule:addBuyableItem({'explosion'}, 2313, 65, 6, 'explosion rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 75, 3, 'sudden death rune')
shopModule:addBuyableItem({'sd'}, 2268, 75, 3, 'sudden death rune')
shopModule:addBuyableItem({'death arrow'}, 2263, 300, 3, 'death arrow rune')
shopModule:addBuyableItem({'paralyze'}, 2278, 700, 1, 'paralyze rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 70, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 70, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 70, 1, 'chameleon rune')
shopModule:addBuyableItem({'desintegrate'}, 2310, 35, 3, 'desintegrate rune')

shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 500, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 1000, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of plague', 'plague'}, 2188, 5000, 'wand of plague')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 10000, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 15000, 'wand of inferno')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 500, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 'moonlight rod')
shopModule:addBuyableItem({'volcanic rod', 'volcanic'}, 2185, 5000, 'volcanic rod')
shopModule:addBuyableItem({'quagmire rod', 'quagmire'}, 2181, 10000, 'quagmire rod')
shopModule:addBuyableItem({'tempest rod', 'tempest'}, 2183, 15000, 'tempest rod')

shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 250, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 500, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of plague', 'plague'}, 2188, 2500, 'wand of plague')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 5000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'},2187, 7500, 'wand of inferno')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 250,'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 500, 'moonlight rod')
shopModule:addSellableItem({'volcanic rod', 'volcanic'}, 2185, 2500, 'volcanic rod')
shopModule:addSellableItem({'quagmire rod', 'quagmire'}, 2181, 5000, 'quagmire rod')
shopModule:addSellableItem({'tempest rod', 'tempest'}, 2183, 7500, 'tempest rod')

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	local vocationId = player:getVocation():getId()
	local items = {
		[1] = 2190,
		[2] = 2182,
		[5] = 2190,
		[6] = 2182
	}

	if msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand') then
		if isInArray({1, 2, 5, 6}, vocationId) then
			if player:getStorageValue(30002) == -1 then
				selfSay('So you ask me for a {' .. ItemType(items[vocationId]):getName() .. '} to begin your advanture?', cid)
				npcHandler.topic[cid] = 1
			else
				selfSay('What? I have already gave you one {' .. ItemType(items[vocationId]):getName() .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			player:addItem(items[vocationId], 1)
			player:setStorageValue(30002, 1)
			selfSay('Here you are young adept, take care yourself.', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		selfSay('Ok then.', cid)
		npcHandler.topic[cid] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
