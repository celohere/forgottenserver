function onStepIn(cid, item, pos)
    if item.uid == 10001 then
        if getPlayerStorageValue(cid,1234561) == -1 then
            setPlayerStorageValue(cid,1234561,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Verminor큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Veminor큦 spirit.')
        end
    elseif item.uid == 10002 then
        if getPlayerStorageValue(cid,1234562) == -1 then
            setPlayerStorageValue(cid,1234562,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Infernatil큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Infernatil큦 spirit.')
        end
    elseif item.uid == 10003 then
        if getPlayerStorageValue(cid,1234563) == -1 then
            setPlayerStorageValue(cid,1234563,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Tafariel큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Tafariel큦 spirit.')
        end
    elseif item.uid == 10004 then
        if getPlayerStorageValue(cid,1234564) == -1 then
            setPlayerStorageValue(cid,1234564,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Apocalypse큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Apocalypse큦 spirit.')
        end
    elseif item.uid == 10005 then
        if getPlayerStorageValue(cid,1234565) == -1 then
            setPlayerStorageValue(cid,1234565,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Pumin큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Pumin큦 spirit.')
        end
    elseif item.uid == 10006 then
        if getPlayerStorageValue(cid,1234566) == -1 then
            setPlayerStorageValue(cid,1234566,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Bazir큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Bazir큦 spirit.')
        end
    elseif item.uid == 10007 then
        if getPlayerStorageValue(cid,1234567) == -1 then
            setPlayerStorageValue(cid,1234567,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Ashfalor큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Ashfalor큦 spirit.')
        end
    elseif item.uid == 22222 and item.itemid == 1223 and pos == {x=295, y=480, z=11} then
        if getPlayerStorageValue(cid,1234561) == -1 or getPlayerStorageValue(cid,1234562) == -1 or getPlayerStorageValue(cid,1234563) == -1 or getPlayerStorageValue(cid,1234564) == -1 or getPlayerStorageValue(cid,1234565) == -1 then
            doTransformItem(item.uid,item.itemid+1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'Sorry, but you did not absorb enough energy!')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You absorbed enough energy! You may pass.')
        end
    end
    return 1
end