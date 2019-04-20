  local config = {
    bridgePositions = {
        {position = Position(418, 419, 9), groundId = 424}
    },
    leverPositions = {
        Position(419, 426, 9)
    },
    relocatePosition = Position(418, 420, 9),
    relocateMonsterPosition = Position(418, 420, 9),
    bridgeId = 1284
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