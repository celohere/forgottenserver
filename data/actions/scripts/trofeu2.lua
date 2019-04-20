
function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 4442 then
   		queststatus = getPlayerStorageValue(cid,4442)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You got your Goblet!")
   			trofeu = doPlayerAddItem(cid,5806,1)
			nome = getCreatureName(cid)
			doSetItemSpecialDescription(trofeu, 'It is the silver goblet awarded to ' .. nome .. '. It is from Scrapper Arena dificulty.')
   			setPlayerStorageValue(cid,4442,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	else
		return 0
   	end
   	return 1
end