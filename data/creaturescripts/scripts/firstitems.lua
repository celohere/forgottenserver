function onLogin(cid)
	local storage = 30055 -- storage value
	
	local sorcItems = {
			2457, -- Stell Helmet
			2489, -- Dark Armor
			2190, -- Wand of vortex
			2516, -- Dragon Shield
			2647, -- Plate legs
			2643, -- Leather boots
			1988, -- Brown backpack
			2050 -- torch
		}
	local druidItems = {
			2457, -- Stell Helmet
			2489, -- Dark Armor
			2516, -- Dragon Shield
			2182, -- Snakebite rod
			2647, -- Plate Legs
			2643, -- Leather boots
			1988, -- Brown backpack
			2050 -- torch
		}
	local pallyItems = {
			2457, -- Stell Helmet
			2489, -- Dark Armor
		      2516, -- Dragon shield
			2389, -- Spear
			2647, -- Plate Legs
			2643, -- Leather boots
			1988, -- Brown backpack
		}
	local kinaItems = {
			2457, -- Stell Helmet
			2489, -- dark armor
			2516, -- Dragon shield
			2383, -- Spike Sword
			2647, -- Plate Legs
			2643, -- Leather boots
			1988, -- Brown backpack
			2050 -- torch
		}
	
	if getPlayerStorageValue(cid, storage) == -1 then
		setPlayerStorageValue(cid, storage, 1)
		if getPlayerVocation(cid) == 1 then
			-- Sorcerer
			for i = 1, table.getn(sorcItems), 1 do
				doPlayerAddItem(cid, sorcItems[i], 1, FALSE)
			end
		
		elseif getPlayerVocation(cid) == 2 then
			-- Druid
			for i = 1, table.getn(druidItems), 1 do
				doPlayerAddItem(cid, druidItems[i], 1, FALSE)
			end
		
		elseif getPlayerVocation(cid) == 3 then
			-- Paladin
			for i = 1, table.getn(pallyItems), 1 do
				doPlayerAddItem(cid, pallyItems[i], 1, FALSE)
			end
			-- 8 arrows
			doPlayerAddItem(cid, 2544, 8, FALSE)
		
		elseif getPlayerVocation(cid) == 4 then
			-- Knight
			for i = 1, table.getn(kinaItems), 1 do
				doPlayerAddItem(cid, kinaItems[i], 1, FALSE)
			end
		end
		     
		-- Common for all
		doPlayerAddItem(cid, 2674, 5, FALSE) -- 5 apples
		doPlayerAddItem(cid, 2120, 1, FALSE) -- 1 rope
		doPlayerAddItem(cid, 2554, 1, FALSE) -- 1 shovel
	end
	return true
end
