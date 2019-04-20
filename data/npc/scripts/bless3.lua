local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)			 npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)	 npcHandler:onCreatureSay(cid, type, msg) end
function onThink()						 npcHandler:onThink() end
-- OTServ event handling functions end

function creatureSayCallback(cid, type, msg)
	-- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
	if(npcHandler.focus ~= cid) then
		return false
	end

	if msgcontains(msg, 'blessing') or msgcontains(msg, 'blessings') or msgcontains(msg, 'help') then
		selfSay('I can Bless you, just say \'bless\', it cost 10000 gold coins each.')
	elseif getPlayerPremiumDays(cid) > 0 then
		if msgcontains(msg, 'first bless') then
			selfSay('Do you want to buy the first blessing for 10000 gold?')
			talk_state = 1
		elseif msgcontains(msg, 'second bless') then
			selfSay('Do you want to buy the second blessing for 10000 gold?')
			talk_state = 2
		elseif msgcontains(msg, 'third bless') then
			selfSay('Do you want to buy the third blessing for 10000 gold?')
			talk_state = 3
		elseif msgcontains(msg, 'bless') then
			selfSay('Do you want to buy the fourth blessing for 10000 gold?')
			talk_state = 4
		elseif msgcontains(msg, 'fifth bless') then
			selfSay('Do you want to buy the fifth blessing for 10000 gold?')
			talk_state = 5
		elseif talk_state > 0 then
			if msgcontains(msg, 'yes') then
				if getPlayerBlessing(cid, talk_state) then
					selfSay('A god has already blessed you with this blessing.')
				else
					if doPlayerRemoveMoney(cid, 10000) == 1 then
						doPlayerAddBlessing(cid, talk_state)
						selfSay('You have been blessed by one of the five gods!')
					else
						selfSay('You don\'t have enough money.')
					end
				end
				talk_state = 0
			elseif msgcontains(msg, 'no') then
				selfSay('Then not.')
				talk_state = 0
			end
		end
	else
		selfSay('You need a premium account to buy \'blessings\', there\'s nothing else you can do here..')
	end
	return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())