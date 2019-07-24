function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
    if target.actionid == 101 then
        if target.itemid == 354 or target.itemid == 355 then
            target:transform(392)
            target:decay()
            toPosition:sendMagicEffect(CONST_ME_POFF)
        end
    end
end
