local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)     npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                         npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
    -- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
    if(npcHandler.focus ~= cid) then
        return false
    end

        player_gold = getPlayerItemCount(cid,2148)
        player_plat = getPlayerItemCount(cid,2152)*100
        player_crys = getPlayerItemCount(cid,2160)*10000
        player_money = player_gold + player_plat + player_crys
	bless1 = getPlayerBlessing(cid,1)
	bless2 = getPlayerBlessing(cid,2)
	bless3 = getPlayerBlessing(cid,3)
	bless4 = getPlayerBlessing(cid,4)
	less5 = getPlayerBlessing(cid,5)
	tbless = 'Sorry, but you already have this blessing.'
	pbless = 'Sorry, you need a premium account to buy blessings.' 
	obless = 'Do you have 10000 gold coins to buy this blessing?' 
	mbless = 'Sorry, but you need 10000 gold coins to buy this blessing.' 
	gbless = 'Now the Gods blessed you.'


if msgcontains(msg, 'job') or msgcontains(msg, 'Job') then
selfSay('Ohh... My job is easy, I sell only promotions,premium accounts!')

elseif msgcontains(msg, 'info') or msgcontains(msg, 'information') then
selfSay('Hummm... I heard about Pits of Inferno Quest! If you want to go you need find Giant Spider Island. But safeguard there is much Giant Spiders and Bone Beast! Later you need find hole with Dragon Lords, and run to teleport! Sorry, but i don\'t know nothing more about that.')

elseif msgcontains(msg, 'addon') or msgcontains(msg, 'addons') then
selfSay('Yes, yes! I know what\'s with them. You need talk to Jimmy. He can make for you some addons.')

elseif msgcontains(msg, 'outfit') then
selfSay('Ohh... Mine outfit is sweet! I kill Ferumbras with many other warriors and Jimmy make me hat from ferumbras hat and wand from soul stone.')

elseif msgcontains(msg, 'ferumbras') or msgcontains(msg, 'Ferumbras') then
selfSay('Yes, i kill him! He is very strong mage. In my team dead 5 warriors. But we kill him! We loot Ferumbras Hat! Later i get this item from lottery.')
      
	elseif msgcontains(msg, 'premium') or msgcontains(msg, 'pacc') or msgcontains(msg, 'Premium') or msgcontains(msg, 'premium account') or msgcontains(msg, 'Premium account') or msgcontains(msg, 'premmy') then
            selfSay('Do you want to buy 20 day\'s of premium account for 20k?')
            talk_state = 1

	elseif msgcontains(msg, 'promotion') or msgcontains(msg, 'promotion') then
		if getPlayerVocation(cid) > 4 then
 				selfSay('Sorry, you are already promoted.')
 				talk_state = 0
		elseif getPlayerLevel(cid) < 20 then
				selfSay('Sorry, you need level 20 to buy promotion.')
				talk_state = 0
		elseif not isPremium(cid) then
				selfSay('Sorry, you must be premium to buy promotion.')
				talk_state = 0
			else			
            	selfSay('Do you want to buy promotion for your vocation?')
            	talk_state = 2	
        	end
------------------------------------- confirm yes ------------------------------------------------
        elseif msgcontains(msg, 'yes') and talk_state == 1 then
                if doPlayerRemoveMoney(cid,20000) then
                    selfSay('Enjoy your new Premium Account!')
                    addPremium(cid,10)
                end
            else
                selfSay('Sorry, you don\'t have money.')
            end
            talk_state = 0

	elseif msgcontains(msg, 'yes') and talk_state == 2 then
                if doPlayerRemoveMoney(cid,20000) then
                    selfSay('Enjoy your new Vocation!')
                    doPlayerSetVocation(cid, getPlayerVocation(cid)+4)
                end
            else
                selfSay('Sorry, you don\'t have money.')
            end
            talk_state = 0
        
--------------------------------------- confirm no ---------------------------------------------
        elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 3) then
            selfSay('Ok than.')
            talk_state = 0
        end
    -- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())  