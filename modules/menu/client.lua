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
        {label = 'nothing here :(', args= {"whatareyoudoing"},close = false},
    }
}, function(selected, scrollIndex, args)
    if args[1] ~= "whatareyoudoing" then
        Trainer.Menu.previousMenu = 'johnstrainer_main'
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
    local options = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"main")
    if #options == 0 then return end

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

RegisterNetEvent('johnstrainer:menu:openMainMenu', function()
    if GetInvokingResource() ~= GetCurrentResourceName() then return end
    Trainer.Menu.openMenu("johnstrainer_main")
end)