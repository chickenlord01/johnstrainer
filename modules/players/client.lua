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
        {label = 'nothing here :(', args = {"wat happen"}, close = false},
    }
}, function(selected, scrollIndex, args)
    if args[1] ~= "wat happen" then
        Trainer.Menu.previousMenu = 'johnstrainer_online_players'
        Trainer.Menu.openMenu(args[1])
    end
end)

Trainer.Menu.GenerateOnlinePlayers = function()
    local players = lib.callback.await("johnstrainer:player:getOnlinePlayers",false)
    if #players == 0 then return end
    local options = {}
    for _,v in pairs(players) do
        local menuId = "johnstrainer_online_player_"..v.id
        table.insert(options,{
            label = v.name.." | ID: "..v.id,
            args = {menuId}
        })

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
            Trainer.Menu.previousMenu = menuId
        end)
    end
    lib.setMenuOptions('johnstrainer_online_players', options)
end

Trainer.Menu.menuFunc["johnstrainer_online_players"] = function()
    return Trainer.Menu.GenerateOnlinePlayers()
end