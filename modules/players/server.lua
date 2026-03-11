--Start of connection
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local _source = source
    local steam,license,discord,license2,fivem,ip,xbl
    --Start of default player deferrals
    deferrals.defer()
    Wait(0)
    deferrals.update("Hello "..playerName..": We are checking your player identifiers, please wait!")

    Wait(100)

    for k,v in pairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("license2:")) == "license2:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
          fivem = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
          ip = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
          xbl = v
        end
    end

    Wait(2000)

    deferrals.update("Hello "..playerName..": All of your identifiers are good to go, please wait for the server to accept your connection!")

    Wait(500)

    print("Player Connecting: "..playerName)
    end
    --End of default player deferrals

    --Totally necessary wait
    Wait(5000)

    --Finishes defering the client and allows connection
    --deferrals.done("no")
    deferrals.done()
end)

-- creates a player class to store player data and functions
Character = lib.class("Character")
characters = {}
local PlayerObj = lib.class("PlayerObj")
players = {}

local playerDB = DataBase:new({
    id = "players",
    label = "PlayerObj data",
    onUpdate = function(data,key)
        if players[key] then
            players[key]:updateData(data,true)
        end
    end
})
local characterDB = DataBase:new({
    id = "characters",
    label = "Character data",
    onUpdate = function(data,key)
        if characters[key] then
            characters[key]:updateData(data,true)
        end
    end
})

function Character:constructor(data)
    self.id = data.id
    self.accounts = data.accounts or {}
    self.player = data.player
    self.permissions = data.permissions or {}
    self.metadata = data.metadata or {
        trust = data.trust,
        displayname = data.displayname
    }
    characters[self.id] = self
    self:setup()
end
-- I have no idea what I am doing with this player class but I will figure it out eventually







--[[AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local player = source
    local steam,license,discord
    local playerinfo = {}
    
    deferrals.defer()
    deferrals.update("Checking player data...")
    for k,v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    Wait(1000)
    playerinfo.steam = steam
    playerinfo.license = license
    playerinfo.discord = discord

    if not players[license] then
        PlayerObj:new({
            id = license,
            source = player,
            metadata = {
                displayname = playerName,
                identifiers = playerinfo
            }
        })
    elseif players[license] then
        players[license]:updateMetadata("identifiers",playerinfo,nil,true)
        players[license]:updateSource(player,true)
    end
    Wait(500)
    TriggerEvent('johns:playerLoaded')
    deferrals.done()
end)

AddEventHandler("playerDropped", function(reason)
    local player = source
    local lic = framework.GetPlayerLicense(player)

    local shit = players[lic]
    shit:updateSource()
end)]]