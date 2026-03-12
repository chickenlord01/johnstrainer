Trainer.Menu = {
    menuPos = {},
    menuFunc = {}
}
Trainer.Menu.menuPos = {}

lib.registerMenu({
    id = 'johnstrainer_main',
    title = 'Trainer Menu',
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        --print("Scroll: ", selected, scrollIndex, args)
    end,
    onSelected = function(selected, secondary, args)
        Trainer.Menu.menuPos["johnstrainer_main"] = selected
    end,
    onCheck = function(selected, checked, args)
        --print("Check: ", selected, checked, args)
    end,
    onClose = function(keyPressed)
        Trainer.Menu.onClose(true)
    end,
    options = {
        {label = 'nothing here :(', args["whatareyoudoing"],close = false},
    }
}, function(selected, scrollIndex, args)
    if not args[1] == "whatareyoudoing" then
        Trainer.Menu.openMenu(args[1])
    end
end)

RegisterCommand('opentrainer', function()
    Trainer.Menu.openMenu('johnstrainer_main')
end,false)

Trainer.Menu.menuFunc["johnstrainer_main"] = function()
    Trainer.Menu.GenerateMainOptions()
    return true
end

Trainer.Menu.GenerateMainOptions = function()
    --perms wip
    --local permissions = lib.callback.await("johnstrainer:permissions:getPermissions",false)
    local options = {}
    table.insert(options,{
        label = "Online players",
        args = {"johnstrainer_online_players"}
    })
    table.insert(options,{
        label = "Player related options",
        args = {"johnstrainer_player_options"}
    })
    table.insert(options,{
        label = "Vehicle related options",
        args = {"johnstrainer_vehicle_options"}
    })
    table.insert(options,{
        label = "World related options",
        args = {"johnstrainer_world_options"}
    })
    table.insert(options,{
        label = "Recording options",
        args = {"johnstrainer_recording_options"}
    })
    table.insert(options,{
        label = "Misc options",
        args = {"johnstrainer_misc_options"}
    })

    lib.setMenuOptions('johnstrainer_main', options)
end

Trainer.Menu.openMenu = function(menuId)
    if not Trainer.Menu.menuPos[menuId] then Trainer.Menu.menuPos[menuId] = 0 end
    if Trainer.Menu.menuFunc[menuId] then Trainer.Menu.menuFunc[menuId]() end
    lib.showMenu(menuId,Trainer.Menu.menuPos[menuId])
end

Trainer.Menu.onClose = function(closeAll,key)
    if closeAll or not Trainer.Menu.previousMenu or not key or key == "Escape" then
        lib.hideMenu(false)
        Trainer.Menu.previousMenu = nil
        return true
    end
    Trainer.Menu.openMenu(Trainer.Menu.previousMenu)
end