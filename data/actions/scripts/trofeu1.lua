
function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 4441 then
   		queststatus = getPlayerStorageValue(cid,4441)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You got your Goblet!")
   			trofeu = doPlayerAddItem(cid,5807,1)
			nome = getCreatureName(cid)
			doSetItemSpecialDescription(trofeu, 'It is the bronze goblet awarded to ' .. nome .. '. It is from Greenhorn Arena dificulty.')
   			setPlayerStorageValue(cid,4441,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	else
		return 0
   	end
   	return 1
end