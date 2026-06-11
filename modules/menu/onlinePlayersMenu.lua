local Menu = require("modules.menu.menuObject")
local MainMenu = require("modules.menu.mainMenu")

local OnlinePlayerMenu = Menu:new("johnstrainer:onlineplayer","Player",{
    parent = "johnstrainer:onlineplayers",
    position = 'top-right',
    onPressed = function(selected, scrollIndex, args)
        
    end,
    onShow = function(args)
        GenerateOnlinePlayerOptions(args)
    end
})
local OnlinePlayersMenu = Menu:new("johnstrainer:onlineplayers","Online Players",{
    parent = "johnstrainer:main",
    position = 'top-right',
    onPressed = function(selected, scrollIndex, args)
        print(json.encode(args))
        OnlinePlayerMenu:showMenu(args)
    end,
    onShow = function()
        GenerateOnlinePlayers()
    end
})
GenerateOnlinePlayers = function()
    local players = lib.callback.await("johnstrainer:player:getOnlinePlayers",false)
    if #players == 0 then return end
    local options = {}
    for _,v in pairs(players) do
        table.insert(options,{
            label = v.name.." | ID: "..v.id,
            args = v
        })
    end
    OnlinePlayersMenu:setOptions(options)
end

GenerateOnlinePlayerOptions = function(playerData)
    local permissions = lib.callback.await("johnstrainer:permissions:getMenuOptionPermissions",false,"online_player",playerData.id)
    if #permissions == 0 then return end

    OnlinePlayerMenu:setOptions(permissions)
end

return OnlinePlayersMenu,OnlinePlayerMenu