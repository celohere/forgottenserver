--function by Armageddom--
function onStepIn(cid, item, frompos, item2, topos) 

playerpos = getPlayerPosition(cid)  

if item.uid == 3101 then

getThingfromPos(playerpos) 
doTransformItem(item.uid,item.itemid)
end 
end