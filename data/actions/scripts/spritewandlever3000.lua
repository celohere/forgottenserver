local config = {
    bridgePositions = {
        {position = Position(329, 119, 7), groundId = 424}
    },
    leverPositions = {
        Position(320, 137, 7)
    },
    relocatePosition = Position(329, 118, 7),
    relocateMonsterPosition = Position(329, 118, 7),
    bridgeId = 432
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local leverLeft, lever = item.itemid == 1945
    for i = 1, #config.leverPositions do
        lever = Tile(config.leverPositions[i]):getItemById(leverLeft and 1945 or 1946)
        if lever then
            lever:transform(leverLeft and 1946 or 1945)
        end
    end

    local tile, tmpItem, bridge
    if leverLeft then
        for i = 1, #config.bridgePositions do
            bridge = config.bridgePositions[i]
            tile = Tile(bridge.position)

            tmpItem = tile:getGround()
            if tmpItem then
                tmpItem:transform(config.bridgeId)
            end

            if bridge.itemId then
                tmpItem = tile:getItemById(bridge.itemId)
                if tmpItem then
                    tmpItem:remove()
                end
            end
        end
    else
        for i = 1, #config.bridgePositions do
            bridge = config.bridgePositions[i]
            tile = Tile(bridge.position)

            tile:relocateTo(config.relocatePosition, true, config.relocateMonsterPosition)
            tile:getGround():transform(bridge.groundId)
            Game.createItem(bridge.itemId, 1, bridge.position)
        end

    end
    return true
end