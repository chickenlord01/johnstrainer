local menuPos = {}

lib.registerMenu({
    id = 'johnstrainer_main',
    title = 'Trainer Menu',
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        --print("Scroll: ", selected, scrollIndex, args)
    end,
    onSelected = function(selected, secondary, args)
        --[[if not secondary then
            print("Normal button")
        else
            if args.isCheck then
                print("Check button")
            end
 
            if args.isScroll then
                print("Scroll button")
            end
        end
        print(selected, secondary, json.encode(args, {indent=true}))]]
    end,
    onCheck = function(selected, checked, args)
        --print("Check: ", selected, checked, args)
    end,
    onClose = function(keyPressed)
        --[[print('Menu closed')
        if keyPressed then
            print(('Pressed %s to close the menu'):format(keyPressed))
        end]]
    end,
    options = {
        {label = 'nothing here :(', close = false},
    }
}, function(selected, scrollIndex, args)
    if args[1] == "johnstrainer_online_players" then
    elseif args[1] == "johnstrainer_player_options" then
    elseif args[1] == "johnstrainer_vehicle_options" then
    elseif args[1] == "johnstrainer_world_options" then
    elseif args[1] == "johnstrainer_recording_options" then
    elseif args[1] == "johnstrainer_misc_options" then
    end
end)

RegisterCommand('opentrainer', function()
    Trainer.Menu.GenerateMainOptions()
    lib.showMenu('johnstrainer_main')
end,false)

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