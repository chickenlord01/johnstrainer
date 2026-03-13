--Start of connection
local PlayerClass = lib.class("PlayerClass")
Trainer.Player = {
    PlayersTable = {}
}

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local _source = source

    --Start of default player deferrals
    deferrals.defer()
    Wait(0)
    deferrals.update("Hello "..playerName..": We are checking your player identifiers, please wait!")

    Wait(100)
    local idents = Trainer.Player.GenerateIdentifierTable(_source)

    if not idents.license then print("Player dropped while connecting: "..playerName,"No license identifier.") deferrals.done("No game license found. Please ensure you have a legitimate copy of GTA V.") end
    --Wait(2000)

    deferrals.update("Hello "..playerName..": All of your identifiers are good to go, please wait for the server to accept your connection!")

    PlayerClass:new({
        id = idents.license,
        identifiers = idents,
        name = playerName
    })
    Wait(500)

    print("Player Connecting: "..playerName)
    
    --End of default player deferrals

    --Totally necessary wait
    --Wait(5000)

    --Finishes defering the client and allows connection
    --deferrals.done("no")
    deferrals.done()
end)



function PlayerClass:constructor(data)
    if Trainer.Player.PlayersTable[data.id] then return end
    for k,v in pairs(data) do
        self[k] = v
    end

    Trainer.Player.PlayersTable[self.id] = self
    return self:setup()
end
function PlayerClass:setup()end
function PlayerClass:getLicense()
    return self.id
end
function PlayerClass:updateData(data,key)
    if key == 'delete' then return self:remove() end
    if key then
        self[key] = data
    else
        for k,v in pairs(data) do
            if v ~= 'delete' then
                self[k] = v
            else
                self[k] = nil
            end
        end
    end
    return self:update()
end
function PlayerClass:getData(admin)
    local tempData = {}
    if not admin then
        for k,v in pairs(self) do
            if type(v) ~= "function" and k ~= "private" and k ~= "identifiers" then
                tempData[k] = v
            end
        end
    else
        for k,v in pairs(self) do
            if type(v) ~= "function" and k ~= "private" then
                tempData[k] = v
            end
        end
    end
    return tempData
end
function PlayerClass:update()
    --[[add database saving here for player data]]
    return true
end
function PlayerClass:remove()
    Trainer.Player.PlayersTable[self.id] = nil
    return true
end

Trainer.Player.GenerateIdentifierTable = function(source)
    local idents = {}
    for _,v in pairs(GetPlayerIdentifiers(source)) do
        local colon = string.find(v,":")-1
        idents[string.sub(v,1,colon)] = string.gsub(v,string.sub(v,1,colon+1),"")
    end
    return idents
end

Trainer.Player.GetPlayerClassFromSource = function(source)
    for _,v in pairs(Trainer.Player.PlayersTable) do
        if v.source == source then
            return v
        end
    end
    return false
end

Trainer.Player.GetPlayerLicenseFromSource = function(source)
    for _,v in pairs(Trainer.Player.PlayersTable) do
        if v.source == source then
            return v:getLicense()
        end
    end
    return false
end

Trainer.Player.GetOnlinePlayers = function(source)
    if not IsPlayerAceAllowed(source,"johnstrainer_online_players") then Trainer.Notification.SendNotification(source,{type = 'error',description = "No permission to this menu."}) return {} end
    local temp = {}
    for _,v in pairs(Trainer.Player.PlayersTable) do
        if v.source then
            table.insert(temp,{
                id = v.source,
                name = v.name
            })
        end
    end
    table.sort(temp,function (a,b) return a.id < b.id end)
    return temp
end
lib.callback.register('johnstrainer:player:getOnlinePlayers',Trainer.Player.GetOnlinePlayers)

lib.callback.register('johnstrainer:player:connected', function(source)
    local player = Trainer.Player.GetPlayerClassFromSource(source)
    if not player then
        local lic = GetPlayerIdentifierByType(source, 'license')
        player = Trainer.Player.PlayersTable[string.sub(lic,9)]
    end
    return player:updateData(source,"source")
end)

AddEventHandler("playerDropped", function(reason)
    local player = source
    local playerClass = Trainer.Player.GetPlayerClassFromSource(player)
    if playerClass then
        playerClass:updateData(nil,'source')
    end
    print("Player dropped: "..player,reason)
end)

CreateThread(function()
    for _,v in pairs(GetPlayers()) do
        local idents = Trainer.Player.GenerateIdentifierTable(v)
        PlayerClass:new({
            id = idents.license,
            identifiers = idents,
            name = GetPlayerName(v)
        })
    end
end)