local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

		addon_need_premium = 'Sorry, you need a premium account to get addons.'
		addon_have_already = 'Sorry, you already have this addon.'
		addon_have_not_items = 'Sorry, you don\'t have these items.'
		addon_give = 'Here you are.'
		player_gold = getPlayerItemCount(cid,2148)
		player_plat = getPlayerItemCount(cid,2152)*100
		player_crys = getPlayerItemCount(cid,2160)*10000
		player_money = player_gold + player_plat + player_crys
		
		if msgcontains(msg, 'addons') then
			selfSay('I can give you Citizen, Hunter, Knight, Mage, Nobleman, Summoner, Warrior, Barbarian, Druid, Wizard, Oriental, Pirate, Assassin, Beggar, Shaman and Norseman addons.')
		elseif msgcontains(msg, 'help') then
			selfSay('To buy the first addon say \'first NAME addon\', for the second addon say \'second NAME addon\'.')
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'first citizen addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5878) >= 100 then
					selfSay('Did you bring me 100 minotaur leathers?')
					talk_state = 1
				else
					selfSay('I need 100 minotaur leather, to give you the first citizen addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 1 then
			talk_state = 0
			if getPlayerItemCount(cid,5878) >= 100 then
				addon = getPlayerStorageValue(cid,10001)
				if addon == -1 then
					if doPlayerTakeItem(cid,5878,100) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 128, 1)
						doPlayerAddOutfit(cid, 136, 1)
						setPlayerStorageValue(cid,10001,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'second citizen addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5890) >= 100 and getPlayerItemCount(cid,5902) >= 50 and getPlayerItemCount(cid,2480) >= 1 then
					selfSay('Did you bring me 100 chicken feathers, 50 honeycombs and the legion helmet?')
					talk_state = 2
				else
					selfSay('I need 100 chicken feathers, 50 honeycombs and a legion helmet, to give you the second citizen addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 2 then
			talk_state = 0
			if getPlayerItemCount(cid,5890) >= 100 and getPlayerItemCount(cid,5902) >= 50 and getPlayerItemCount(cid,2480) >= 1 then
				addon = getPlayerStorageValue(cid,10002)
				if addon == -1 then
					if doPlayerTakeItem(cid,5890,100) == 0 and doPlayerTakeItem(cid,5902,50) == 0 and doPlayerTakeItem(cid,2480,1) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 128, 2)
						doPlayerAddOutfit(cid, 136, 2)
						setPlayerStorageValue(cid,10002,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'first hunter addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5947) >= 1 and getPlayerItemCount(cid,5876) >= 100 and getPlayerItemCount(cid,5948) >= 100 and getPlayerItemCount(cid,5891) >= 5 and getPlayerItemCount(cid,5887) >= 1 and getPlayerItemCount(cid,5888) >= 1 and getPlayerItemCount(cid,5889) >= 1 then
					selfSay('Did you bring me the engraved crossbow, 100 lizard leathers, 100 red dragon leather, 5 enchanted chicken wings, royal steel, hell steel and draconian steel?')
					talk_state = 3
				else
					selfSay('I need a engraved crossbow, 100 lizard leathers, 100 red dragon leather, 5 enchanted chicken wings, royal steel, hell steel and draconian steel, to give you the first hunter addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 3 then
			talk_state = 0
			if getPlayerItemCount(cid,5947) >= 1 and getPlayerItemCount(cid,5876) >= 100 and getPlayerItemCount(cid,5948) >= 100 and getPlayerItemCount(cid,5891) >= 5 and getPlayerItemCount(cid,5887) >= 1 and getPlayerItemCount(cid,5888) >= 1 and getPlayerItemCount(cid,5889) >= 1 then
				addon = getPlayerStorageValue(cid,20002)
				if addon == -1 then
					if doPlayerTakeItem(cid,5947,1) == 0 and doPlayerTakeItem(cid,5876,100) == 0 and doPlayerTakeItem(cid,5948,100) == 0 and doPlayerTakeItem(cid,5891,5) == 0 and doPlayerTakeItem(cid,5887,1) == 0 and doPlayerTakeItem(cid,5888,1) == 0 and doPlayerTakeItem(cid,5889,1) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 129, 1)
						doPlayerAddOutfit(cid, 137, 1)
						setPlayerStorageValue(cid,20002,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'second hunter addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5875) >= 1 then
					selfSay('Did you bring me the sniper gloves?')
					talk_state = 4
				else
					selfSay('I need sniper gloves, to give you the second hunter addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 4 then
			talk_state = 0
			if getPlayerItemCount(cid,5875) >= 1 then
				addon = getPlayerStorageValue(cid,20001)
				if addon == -1 then
					if doPlayerTakeItem(cid,5875,1) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 129, 2)
						doPlayerAddOutfit(cid, 137, 2)
						setPlayerStorageValue(cid,20001,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'first knight addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5892) >= 1 and getPlayerItemCount(cid,5880) >= 100 then
					selfSay('Did you bring me the chunk of crude iron and 100 iron ores?')
					talk_state = 5
				else
					selfSay('I need a chunk of crude iron and 100 iron ores, to give you the first knight addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 5 then
			talk_state = 0
			if getPlayerItemCount(cid,5892) >= 1 and getPlayerItemCount(cid,5880) >= 100 then
				addon = getPlayerStorageValue(cid,30001)
				if addon == -1 then
					if doPlayerTakeItem(cid,5892,1) == 0 and doPlayerTakeItem(cid,5880,100) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 131, 1)
						doPlayerAddOutfit(cid, 139, 1)
						setPlayerStorageValue(cid,30001,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'second knight addon') then
			if isPremium(cid) then
				if getPlayerItemCount(cid,5893) >= 100 and getPlayerItemCount(cid,5924) >= 1 and getPlayerItemCount(cid,5885) >= 1 and getPlayerItemCount(cid,5887) >= 1 then
					selfSay('Did you bring me 100 behemoth fangs, the damaged steel helmet, warrior\'s sweat, and royal steel?')
					talk_state = 6
				else
					selfSay('I need 100 behemoth fangs, a damaged steel helmet, warrior\'s sweat and royal steel, to give you the second knight addon. Come back when you have them.')
					talk_state = 0
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 6 then
			talk_state = 0
			if getPlayerItemCount(cid,5893) >= 100 and getPlayerItemCount(cid,5924) >= 1 and getPlayerItemCount(cid,5885) >= 1 and getPlayerItemCount(cid,5887) >= 1 then
				addon = getPlayerStorageValue(cid,30002)
				if addon == -1 then
					if doPlayerTakeItem(cid,5893,100) == 0 and doPlayerTakeItem(cid,5924,1) == 0 and doPlayerTakeItem(cid,5885,1) == 0 and doPlayerTakeItem(cid,5887,1) == 0 then
						selfSay(addon_give)
						doPlayerAddOutfit(cid, 131, 2)
						doPlayerAddOutfit(cid, 139, 2)
						setPlayerStorageValue(cid,30002,1)
					end
				else
					selfSay(addon_have_already)
				end
			else
				selfSay(addon_have_not_items)
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'first mage addon') then
			if isPremium(cid) then
				if getPlayerSex(cid) == 0 then
					if getPlayerItemCount(cid,5958) >= 1 then
						selfSay('Did you bring me a winning lotery ticket?')
						talk_state = 7
					else
						selfSay('I need a winning lotery ticket, to give you the first mage addon. Come back when you have it.')
						talk_state = 0
					end
				elseif getPlayerSex(cid) == 1 then
					if getPlayerItemCount(cid,2181) >= 1 and getPlayerItemCount(cid,2182) >= 1 and getPlayerItemCount(cid,2183) >= 1 and getPlayerItemCount(cid,2185) >= 1 and getPlayerItemCount(cid,2186) >= 1 and getPlayerItemCount(cid,2187) >= 1 and getPlayerItemCount(cid,2188) >= 1 and getPlayerItemCount(cid,2189) >= 1 and getPlayerItemCount(cid,2190) >= 1 and getPlayerItemCount(cid,2191) >= 1 and getPlayerItemCount(cid,5904) >= 10 and getPlayerItemCount(cid,2193) >= 20 and getPlayerItemCount(cid,5809) >= 1 then
						selfSay('Did you bring me all the wands and rods, 10 magic sulphors, 20 ankhs and a soul stone?')
						talk_state = 7
					else
						selfSay('I need all kind of wands and rods, 10 magic sulphurs, 20 ankhs and a soul stone, to give you the first mage addon. Come back when you have it.')
						talk_state = 0
					end
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 7 then
			talk_state = 0
			if getPlayerSex(cid) == 0 then
				if getPlayerItemCount(cid,5958) >= 1 then
					addon = getPlayerStorageValue(cid,40001)
					if addon == -1 then
						if doPlayerTakeItem(cid,5958,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 141, 1)
							setPlayerStorageValue(cid,40001,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			elseif getPlayerSex(cid) == 1 then
				if getPlayerItemCount(cid,2181) >= 1 and getPlayerItemCount(cid,2182) >= 1 and getPlayerItemCount(cid,2183) >= 1 and getPlayerItemCount(cid,2185) >= 1 and getPlayerItemCount(cid,2186) >= 1 and getPlayerItemCount(cid,2187) >= 1 and getPlayerItemCount(cid,2188) >= 1 and getPlayerItemCount(cid,2189) >= 1 and getPlayerItemCount(cid,2190) >= 1 and getPlayerItemCount(cid,2191) >= 1 and getPlayerItemCount(cid,5904) >= 10 and getPlayerItemCount(cid,2193) >= 20 and getPlayerItemCount(cid,5809) >= 1 then
					addon = getPlayerStorageValue(cid,40001)
					if addon == -1 then
						if doPlayerTakeItem(cid,2181,1) == 0 and doPlayerTakeItem(cid,2182,1) == 0 and doPlayerTakeItem(cid,2183,1) == 0 and doPlayerTakeItem(cid,2185,1) == 0 and doPlayerTakeItem(cid,2186,1) == 0 and doPlayerTakeItem(cid,2187,1) == 0 and doPlayerTakeItem(cid,2188,1) == 0 and doPlayerTakeItem(cid,2189,1) == 0 and doPlayerTakeItem(cid,2190,1) == 0 and doPlayerTakeItem(cid,2191,1) == 0 and doPlayerTakeItem(cid,5904,10) == 0 and doPlayerTakeItem(cid,2193,20) == 0 and doPlayerTakeItem(cid,5809,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 130, 1)
							setPlayerStorageValue(cid,40001,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'second mage addon') then
			if isPremium(cid) then
				if getPlayerSex(cid) == 0 then
					if getPlayerItemCount(cid,5894) >= 70 and getPlayerItemCount(cid,5911) >= 20 and getPlayerItemCount(cid,5883) >= 40 and getPlayerItemCount(cid,5922) >= 35 and getPlayerItemCount(cid,5886) >= 10 and getPlayerItemCount(cid,5881) >= 60 and getPlayerItemCount(cid,5882) >= 40 and getPlayerItemCount(cid,5904) >= 15 and getPlayerItemCount(cid,5905) >= 30 then
						selfSay('Did you bring me 70 bat wings, 20 red pieces of cloth, 40 ape fur, 35 holy orchid, 10 spools of spider silk yarn, 60 lizard scales, 40 red dragon scales, 15 magic sulphurs and 30 vampire dusts?')
						talk_state = 8
					else
						selfSay('I need 70 bat wings, 20 red pieces of cloth, 40 ape fur, 35 holy orchid, 10 spools of spider silk yarn, 60 lizard scales, 40 red dragon scales, 15 magic sulphurs and 30 vampire dusts, to give you the second mage addon. Come back when you have it.')
						talk_state = 0
					end
				elseif getPlayerSex(cid) == 1 then
					if getPlayerItemCount(cid,5903) >= 1 then
						selfSay('Did you bring me the magician hat?')
						talk_state = 8
					else
						selfSay('I need a magician hat to give you the second mage addon. Come back when you have it.')
						talk_state = 0
					end
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 8 then
			talk_state = 0
			if getPlayerSex(cid) == 0 then
				if getPlayerItemCount(cid,5894) >= 70 and getPlayerItemCount(cid,5911) >= 20 and getPlayerItemCount(cid,5883) >= 40 and getPlayerItemCount(cid,5922) >= 35 and getPlayerItemCount(cid,5886) >= 10 and getPlayerItemCount(cid,5881) >= 60 and getPlayerItemCount(cid,5882) >= 40 and getPlayerItemCount(cid,5904) >= 15 and getPlayerItemCount(cid,5905) >= 30 then
					addon = getPlayerStorageValue(cid,40002)
					if addon == -1 then
						if doPlayerTakeItem(cid,5894,70) and doPlayerTakeItem(cid,5911,20) and doPlayerTakeItem(cid,5883,40) and doPlayerTakeItem(cid,5922,35) and doPlayerTakeItem(cid,5886,10) and doPlayerTakeItem(cid,5881,60) and doPlayerTakeItem(cid,5882,40) and doPlayerTakeItem(cid,5904,15) and doPlayerTakeItem(cid,5905,30) then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 141, 2)
							setPlayerStorageValue(cid,40002,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			elseif getPlayerSex(cid) == 1 then
				if getPlayerItemCount(cid,2323) >= 1 then
					addon = getPlayerStorageValue(cid,40002)
					if addon == -1 then
						if doPlayerTakeItem(cid,2323,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 130, 2)
							setPlayerStorageValue(cid,40002,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'first summoner addon') then
			if isPremium(cid) then
				if getPlayerSex(cid) == 1 then
					if getPlayerItemCount(cid,5958) >= 1 then
						selfSay('Did you bring me a winning lotery ticket?')
						talk_state = 9
					else
						selfSay('I need a winning lotery ticket, to give you the first summoner addon. Come back when you have it.')
						talk_state = 0
					end
				elseif getPlayerSex(cid) == 0 then
					if getPlayerItemCount(cid,2181) >= 1 and getPlayerItemCount(cid,2182) >= 1 and getPlayerItemCount(cid,2183) >= 1 and getPlayerItemCount(cid,2185) >= 1 and getPlayerItemCount(cid,2186) >= 1 and getPlayerItemCount(cid,2187) >= 1 and getPlayerItemCount(cid,2188) >= 1 and getPlayerItemCount(cid,2189) >= 1 and getPlayerItemCount(cid,2190) >= 1 and getPlayerItemCount(cid,2191) >= 1 and getPlayerItemCount(cid,5904) >= 10 and getPlayerItemCount(cid,2193) >= 20 and getPlayerItemCount(cid,5809) >= 1 then
						selfSay('Did you bring me all the wands and rods, 10 magic sulphors, 20 ankhs and a soul stone?')
						talk_state = 9
					else
						selfSay('I need all kind of wands and rods, 10 magic sulphurs, 20 ankhs and a soul stone, to give you the first summoner addon. Come back when you have it.')
						talk_state = 0
					end
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 9 then
			talk_state = 0
			if getPlayerSex(cid) == 1 then
				if getPlayerItemCount(cid,5958) >= 1 then
					addon = getPlayerStorageValue(cid,50001)
					if addon == -1 then
						if doPlayerTakeItem(cid,5958,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 133, 1)
							setPlayerStorageValue(cid,50001,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			elseif getPlayerSex(cid) == 0 then
				if getPlayerItemCount(cid,2181) >= 1 and getPlayerItemCount(cid,2182) >= 1 and getPlayerItemCount(cid,2183) >= 1 and getPlayerItemCount(cid,2185) >= 1 and getPlayerItemCount(cid,2186) >= 1 and getPlayerItemCount(cid,2187) >= 1 and getPlayerItemCount(cid,2188) >= 1 and getPlayerItemCount(cid,2189) >= 1 and getPlayerItemCount(cid,2190) >= 1 and getPlayerItemCount(cid,2191) >= 1 and getPlayerItemCount(cid,5904) >= 10 and getPlayerItemCount(cid,2193) >= 20 and getPlayerItemCount(cid,5809) >= 1 then
					addon = getPlayerStorageValue(cid,50001)
					if addon == -1 then
						if doPlayerTakeItem(cid,2181,1) == 0 and doPlayerTakeItem(cid,2182,1) == 0 and doPlayerTakeItem(cid,2183,1) == 0 and doPlayerTakeItem(cid,2185,1) == 0 and doPlayerTakeItem(cid,2186,1) == 0 and doPlayerTakeItem(cid,2187,1) == 0 and doPlayerTakeItem(cid,2188,1) == 0 and doPlayerTakeItem(cid,2189,1) == 0 and doPlayerTakeItem(cid,2190,1) == 0 and doPlayerTakeItem(cid,2191,1) == 0 and doPlayerTakeItem(cid,5904,10) == 0 and doPlayerTakeItem(cid,2193,20) == 0 and doPlayerTakeItem(cid,5809,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 138, 1)
							setPlayerStorageValue(cid,50001,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			end
------------------------------------------------ addon ------------------------------------------------
		elseif msgcontains(msg, 'second summoner addon') then
			if isPremium(cid) then
				if getPlayerSex(cid) == 1 then
					if getPlayerItemCount(cid,5894) >= 70 and getPlayerItemCount(cid,5911) >= 20 and getPlayerItemCount(cid,5883) >= 40 and getPlayerItemCount(cid,5922) >= 35 and getPlayerItemCount(cid,5886) >= 10 and getPlayerItemCount(cid,5881) >= 60 and getPlayerItemCount(cid,5882) >= 40 and getPlayerItemCount(cid,5904) >= 15 and getPlayerItemCount(cid,5905) >= 30 then
						selfSay('Did you bring me 70 bat wings, 20 red pieces of cloth, 40 ape fur, 35 holy orchid, 10 spools of spider silk yarn, 60 lizard scales, 40 red dragon scales, 15 magic sulphurs and 30 vampire dusts?')
						talk_state = 10
					else
						selfSay('I need 70 bat wings, 20 red pieces of cloth, 40 ape fur, 35 holy orchid, 10 spools of spider silk yarn, 60 lizard scales, 40 red dragon scales, 15 magic sulphurs and 30 vampire dusts, to give you the second summoner addon. Come back when you have it.')
						talk_state = 0
					end
				elseif getPlayerSex(cid) == 0 then
					if getPlayerItemCount(cid,5903) >= 1 then
						selfSay('Did you bring me the Ferumbrass\' hat?')
						talk_state = 10
					else
						selfSay('I need the famous Ferumbrass\' hat, to give you the second summoner addon. Come back when you have it.')
						talk_state = 0
					end
				end
			else
				selfSay(addon_need_premium)
				talk_state = 0
			end
------------------------------------------------ confirm yes ------------------------------------------------
		elseif msgcontains(msg, 'yes') and talk_state == 10 then
			talk_state = 0
			if getPlayerSex(cid) == 1 then
				if getPlayerItemCount(cid,5894) >= 70 and getPlayerItemCount(cid,5911) >= 20 and getPlayerItemCount(cid,5883) >= 40 and getPlayerItemCount(cid,5922) >= 35 and getPlayerItemCount(cid,5886) >= 10 and getPlayerItemCount(cid,5881) >= 60 and getPlayerItemCount(cid,5882) >= 40 and getPlayerItemCount(cid,5904) >= 15 and getPlayerItemCount(cid,5905) >= 30 then
					addon = getPlayerStorageValue(cid,50002)
					if addon == -1 then
						if doPlayerTakeItem(cid,5894,70) and doPlayerTakeItem(cid,5911,20) and doPlayerTakeItem(cid,5883,40) and doPlayerTakeItem(cid,5922,35) and doPlayerTakeItem(cid,5886,10) and doPlayerTakeItem(cid,5881,60) and doPlayerTakeItem(cid,5882,40) and doPlayerTakeItem(cid,5904,15) and doPlayerTakeItem(cid,5905,30) then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 133, 2)
							setPlayerStorageValue(cid,50002,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			elseif getPlayerSex(cid) == 0 then
				if getPlayerItemCount(cid,5903) >= 1 then
					addon = getPlayerStorageValue(cid,50002)
					if addon == -1 then
						if doPlayerTakeItem(cid,5903,1) == 0 then
							selfSay(addon_give)
							doPlayerAddOutfit(cid, 138, 2)
							setPlayerStorageValue(cid,50002,1)
						end
					else
						selfSay(addon_have_already)
					end
				else
					selfSay(addon_have_not_items)
				end
			end
						end
												end