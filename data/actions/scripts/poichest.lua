-- poi chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 9500 then
   		queststatus = getPlayerStorageValue(cid,9500)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Sprite Wand.")
   			doPlayerAddItem(cid,2453,1)
   			setPlayerStorageValue(cid,9500,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 9501 then
   		queststatus = getPlayerStorageValue(cid,9500)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Avenger.")
   			doPlayerAddItem(cid,6528,1)
   			setPlayerStorageValue(cid,9500,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
   	elseif item.uid == 9502 then
   		queststatus = getPlayerStorageValue(cid,9500)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Arbalest.")
   			doPlayerAddItem(cid,5803,1)
   			setPlayerStorageValue(cid,9500,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
	else
		return 0
   	end

   	return 1
end
