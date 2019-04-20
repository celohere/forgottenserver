function onUse(cid, item, frompos, item2, topos)
	wall1 = {x=329, y=119, z=7, stackpos=1}
	getwall1 = getThingfromPos(wall1)

	if item.uid == 9010 and item.itemid == 1945 then
		doCreateItem(411,1,wall1)
		doTransformItem(item.uid,item.itemid+1)
	elseif item.uid == 9010 and item.itemid == 1946 then
		doRemoveItem(411,1,wall1)
		doTransformItem(item.uid,item.itemid-1)		
	else
		doPlayerSendCancel(cid,"Sorry, not possible.")
	end

	return 1
end