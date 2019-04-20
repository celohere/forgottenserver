-- Crédits God Of Pain from Otland

function onLogout(player)
    if player:getStorageValue(111111) <= os.time() then
        player:setStorageValue(111111, os.time() + 5) -- 5 seconds
    else
        player:sendCancelMessage("Please wait five seconds to logout again.")
        return false
    end
    return true
end