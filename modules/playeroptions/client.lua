lib.registerMenu({
    id = 'johnstrainer_player_related',
    title = 'Player Related options',
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        --print("Scroll: ", selected, scrollIndex, args)
    end,
    onSelected = function(selected, secondary, args)
        Trainer.Menu.menuPos["johnstrainer_player_related"] = selected
    end,
    onCheck = function(selected, checked, args)
        --print("Check: ", selected, checked, args)
    end,
    onClose = function(keyPressed)
        Trainer.Menu.onClose(false,keyPressed)
    end,
    options = {
        {label = 'nothing here :(', args= {"whatareyoudoing"},close = false},
    }
}, function(selected, scrollIndex, args)
    if args[1] ~= "whatareyoudoing" then
        Trainer.Menu.previousMenu = 'johnstrainer_player_related'
        Trainer.Menu.openMenu(args[1])
    end
end)

Trainer.Menu.GeneratePlayerRelatedOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"player_related")
    if #options == 0 then return end
    for _,v in pairs(options) do
        lib.registerMenu({
            id = v.args[1],
            title = v.label,
            position = 'top-right',
            onSideScroll = function(selected, scrollIndex, args)
                --print("Scroll: ", selected, scrollIndex, args)
            end,
            onSelected = function(selected, secondary, args)
                Trainer.Menu.menuPos[v.args[1]] = selected
            end,
            onCheck = function(selected, checked, args)
                --print("Check: ", selected, checked, args)
            end,
            onClose = function(keyPressed)
                Trainer.Menu.onClose(false,keyPressed)
            end,
            options = {
                {label = 'nothing here :(', args= {"whatareyoudoing"},close = false},
            }
        }, function(selected, scrollIndex, args)
            if args[1] ~= "whatareyoudoing" then
                Trainer.Menu.previousMenu = v.args[1]
                Trainer.Menu.openMenu(args[1])
            end
        end)
    end
    lib.setMenuOptions('johnstrainer_player_related', options)
end
Trainer.Menu.menuFunc["johnstrainer_player_related"] = Trainer.Menu.GeneratePlayerRelatedOptions

Trainer.Menu.GeneratePlayerOptions = function()
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"player_options")
    if #options == 0 then return end

    lib.setMenuOptions('johnstrainer_player_options', options)
end
Trainer.Menu.menuFunc["johnstrainer_player_options"] = Trainer.Menu.GeneratePlayerOptions