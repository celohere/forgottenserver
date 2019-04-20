local array_guildhall = {1, 25, 186, 86, 87}
 
function onSay(player, words, param)
    local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE)
    if housePrice == -1 then
        return true
    end
 
    if not player:isPremium() then
        player:sendCancelMessage("You need a premium account.")
        return false
    end
 
    local position = player:getPosition()
    position:getNextPosition(player:getDirection())
 
    local tile = Tile(position)
    local house = tile and tile:getHouse()
    if house == nil then
        player:sendCancelMessage("You have to be looking at the door of the house you would like to buy.")
        return false
    end
 
    if house:getOwnerGuid() > 0 then
        player:sendCancelMessage("This house already has an owner.")
        return false
    end
 
    if player:getHouse() then
        player:sendCancelMessage("You are already the owner of a house.")
        return false
    end
 
    local price = house:getTileCount() * housePrice
   
   
    if isInArray(array_guildhall, house:getId()) then
        if not player:getGuild() then
            player:sendCancelMessage("You must be a guild leader to buy a guild hall.")
        return false
        end
   
    check_leader = true
   
    local array_levels = {}
    for i = 1, #array_levels do
        local RANK = player:getGuild():getRankByLevel(array_levels[i])
            if RANK and player:getGuildLevel() < array_levels[i] then
                check_leader = false
                break
            end
    end
   
    if check_leader ~= true then
        player:sendCancelMessage("You must be a guild leader to buy a guild hall.")
    return false
    end
   
    end
   
    if player:removeMoney(price) then
        house:setOwnerGuid(player:getGuid())
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully bought this house, be sure to have the money for the rent in the bank.")
    else
        if player:getItemCount(2157) * 1000000 >= price then
            local nuggs_left = (price / 1000000) - player:getItemCount(2157)
            player:removeItem(2157, player:getItemCount(2157))
            player:addItem(2157, nuggs_left)
            house:setOwnerGuid(player:getGuid())
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully bought this house, be sure to have the money for the rent in the bank.")
        else
            player:sendCancelMessage("You do not have enough money.")
        return false
        end
    end
    return false
end