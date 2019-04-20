local t = {
    -- location of the stairs to spawn
    stairPosition = {x = 329, y = 119, z = 7},
    -- staircase id
    stairId = 411,
    -- switches used
    switchIds = {[1945] = 1946, [1946] = 1945},
    seconds = 60
    
}

local function removeStairs(t)
    local stairs = getTileItemById(t.stairPosition, t.stairId).uid
    -- do stairs exist?
    if stairs then
        -- if they do remove them
        doRemoveItem(stairs)
    end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- if there is no staircase present lets continue
    if getTileItemById(t.stairPosition, t.stairId).uid == 0 then
        -- lets not make it important to know which state the switch is in
        if t.switchIds[item.itemid] then
            -- transform the switch
            doTransformItem(item.uid, t.switchIds[item.itemid])
            -- create the stairs
            doCreateItem(t.stairId, 1, t.stairPosition)
            -- execute the removeStairs function in 60 seconds and pass the whole table
            addEvent(removeStairs, t.seconds * 6000, t)
        end
    end
    return true
end
