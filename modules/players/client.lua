while not Trainer.Menu do Wait(0) end

CreateThread(function()
    lib.callback.await("johnstrainer:player:connected",false)
end)


lib.registerMenu({
    id = 'johnstrainer_online_players',
    title = 'Online Players',
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        --print("Scroll: ", selected, scrollIndex, args)
    end,
    onSelected = function(selected, secondary, args)
        Trainer.Menu.menuPos['johnstrainer_online_players'] = selected
    end,
    onCheck = function(selected, checked, args)
        --print("Check: ", selected, checked, args)
    end,
    onClose = function(keyPressed)
        Trainer.Menu.onClose(false,keyPressed)
    end,
    options = {
        {label = 'nothing here :(', close = false},
    }
}, function(selected, scrollIndex, args)
end)

Trainer.Menu.GenerateOnlinePlayers = function()
    local players = lib.callback.await("johnstrainer:player:getOnlinePlayers",false)
    for _,v in pairs(players) do
        local menuId = "johnstrainer_online_player_"..v.id
        lib.registerMenu({
            id = menuId,
            title = v.name,
            position = 'top-right',
            onSideScroll = function(selected, scrollIndex, args)
                --print("Scroll: ", selected, scrollIndex, args)
            end,
            onSelected = function(selected, secondary, args)
                Trainer.Menu.menuPos[menuId] = selected
            end,
            onCheck = function(selected, checked, args)
                --print("Check: ", selected, checked, args)
            end,
            onClose = function(keyPressed)
                Trainer.Menu.onClose(false,keyPressed)
            end,
            options = {
                {label = 'nothing here :(', close = false},
            }
        }, function(selected, scrollIndex, args)
        end)
    end
end