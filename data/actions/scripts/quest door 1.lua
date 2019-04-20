function onUse(cid, item, frompos, item2, topos)

item.uid = 8500 and item.itemid == 5132 and pos == {x=407, y=131, z=7} 
        if getPlayerStorageValue(cid,3001) == -1 then
            doTransformItem(item.uid,item.itemid+1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'Sorry, but you did not absorb enough energy!')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You absorbed enough energy! You may pass.')
        end
    end