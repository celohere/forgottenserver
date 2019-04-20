function onUse(cid, item, frompos, item2, topos) 
if item.actionid == item2.actionid then 
if item2.itemid == 1210 then 
doTransformItem(item2.uid,item2.itemid+1) 
elseif item2.itemid == 1211 then 
doTransformItem(item2.uid,item2.itemid-1) 

end 
else 
return 0 
end 
return 1 
end
