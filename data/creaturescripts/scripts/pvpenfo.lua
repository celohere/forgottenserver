function onPrepareDeath(cid, deathList)
        local tile = getTileInfo(getPlayerPosition(cid))
        if(tile.hardcore == false) then
                local pl_count = table.getn(deathList)
                local j = 0
                for _, pid in ipairs(deathList) do
                        if (isPlayer(cid) and isPlayer(pid) and getPlayerLevel(cid) > getPlayerLevel(pid)) then
                                local priorita = 1 - (j * 0.1)
                                local exp = 0
                                if (pl_count > 2) then
                                        exp = math.floor((((1 - (getPlayerLevel(pid) * 1.0) / getPlayerLevel(cid)) * 0.05 * getPlayerExperience(cid)) / pl_count) * priorita)
                                else
                                        exp = math.floor((((1 - (getPlayerLevel(pid) * 1.0) / getPlayerLevel(cid)) * 0.05 * getPlayerExperience(cid)) / (pl_count + 2)) * priorita)
                                end
                                doPlayerAddExp(pid, exp)
                                local pos = getPlayerPosition(pid)
                                doPlayerSendTextMessage(pid, MESSAGE_EXPERIENCE, "You gained " .. exp .. " experience for killing higher level than you.", exp, COLOR_WHITE, pos)
                                for _, spec in ipairs(getSpectators(pos, 7, 5, false)) do
                                        if (isPlayer(spec) and spec ~= pid) then
                                                doPlayerSendTextMessage(spec, MESSAGE_EXPERIENCE, getCreatureName(pid) .. " gained " .. exp .. " experience for killing " .. getCreatureName(cid) .. ".", exp, COLOR_WHITE, pos)
                                        end
                                end

                        end
                        j = j + 1
                end
        end
        return true
end