local config = {
itemid = 2178, -- ID Do Item
many = 1, -- Quantidade
pos = {x=276, y=98, z=8}, -- Posição do item
tepos = {x=297, y=100, z=8} -- Para onde vai ao teleportar
}
function onUse(cid, item, frompos, item2, topos)
if getTileItemById(config.pos, config.itemid) and doRemoveItem(getTileItemById(config.pos, config.itemid).uid, config.many) then
doTeleportThing(cid, config.tepos)
else
doPlayerSendTextMessage(cid, 20, "Perhaps you need some kind of stone.")
end
return true
end