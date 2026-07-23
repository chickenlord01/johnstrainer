local Permission = lib.class("Permission")
local defaultPermissions = require("utils.configuration.permissions")
Trainer.Permissions = {
    PermissionsTable = {}
}

function Permission:constructor(data)
    if Trainer.Permissions.PermissionsTable[data.id] then return end
    for k,v in pairs(data) do
        self[k] = v
    end
    Trainer.Permissions.PermissionsTable[self.id] = self
    return self:setup()
end
function Permission:setup()
    return self:applyPermissions()
end
function Permission:applyPermissions()
    for _,v in pairs(self.groups) do
        lib.addAce(v,self.id,self.status)
    end
    return true
end
function Permission:removePermissions()
    for _,v in pairs(self.groups) do
        lib.removeAce(v,self.id,self.status)
    end
    return true
end
function Permission:save()end

CreateThread(function()
    for k,v in pairs(defaultPermissions) do
        Permission:new({
            id = k,
            groups = v.groups,
            status = v.status
        })
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _,v in pairs(Trainer.Permissions.PermissionsTable) do
            v:removePermissions()
        end
    end
end)

lib.callback.register('johnstrainer:permissions:getMenuOptionPermissions', function(source,menu,data)
    local tempTable = {}
    if menu == "main" then
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.OnlinePlayers") then
            table.insert(tempTable,{
                label = "Online players",
                args = {"johnstrainer:onlineplayers"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.PlayerRelated") then
            table.insert(tempTable,{
                label = "Player related options",
                args = {"johnstrainer:playerrelated"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.VehicleRelated") then
            table.insert(tempTable,{
                label = "Vehicle related options",
                args = {"johnstrainer:vehicleoptions"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.WorldRelated") then
            table.insert(tempTable,{
                label = "World related options",
                args = {"johnstrainer:worldoptions"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.Recording") then
            table.insert(tempTable,{
                label = "Recording options",
                args = {"johnstrainer:recordingoptions"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.Misc") then
            table.insert(tempTable,{
                label = "Misc options",
                args = {"johnstrainer:miscoptions"}
            })
        end
    elseif menu == "online_player" then
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Teleport") then
            table.insert(tempTable,{
                label = "Teleport",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Summon") then
            table.insert(tempTable,{
                label = "Summon",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Waypoint") then
            table.insert(tempTable,{
                label = "Waypoint",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Spectate") then
            table.insert(tempTable,{
                label = "Spectate",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.SendMessage") then
            table.insert(tempTable,{
                label = "SendMessage",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Kill") then
            table.insert(tempTable,{
                label = "Kill",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Kick") then
            table.insert(tempTable,{
                label = "Kick",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Ban") then
            table.insert(tempTable,{
                label = "Ban",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Identifiers") then
            table.insert(tempTable,{
                label = "Identifiers",
                args = {}
            })
        end
        --[[if IsPlayerAceAllowed(source,"johnstrainer.OnlinePlayers.Unban") then
            table.insert(tempTable,{
                label = "Unban",
                args = {}
            })
        end]]
    elseif menu == "player_related" then
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerRelated.PlayerOptions") then
            table.insert(tempTable,{
                label = "Player Options",
                args = {"johnstrainer:playeroptions"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerRelated.PlayerAppearance") then
            table.insert(tempTable,{
                label = "Player Appearance",
                args = {"johnstrainer:playerappearance"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerRelated.PlayerCharacters") then
            table.insert(tempTable,{
                label = "Player Characters",
                args = {"johnstrainer:playercharacters"}
            })
        end
    elseif menu == "player_options" then
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.God") then
            table.insert(tempTable,{
                label = "God mode",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.Invisible") then
            table.insert(tempTable,{
                label = "Invisible",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.UnlimitedStamina") then
            table.insert(tempTable,{
                label = "Unlimited stamina",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.FastRun") then
            table.insert(tempTable,{
                label = "Fast run",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.FastSwim") then
            table.insert(tempTable,{
                label = "Fast swim",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.Superjump") then
            table.insert(tempTable,{
                label = "Super jump",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.NoRagdoll") then
            table.insert(tempTable,{
                label = "No ragdoll",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.NeverWanted") then
            table.insert(tempTable,{
                label = "Never wanted",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.SetWanted") then
            table.insert(tempTable,{
                label = "Set wanted",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.ClearBlood") then
            table.insert(tempTable,{
                label = "Clear blood",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.SetBlood") then
            table.insert(tempTable,{
                label = "Set blood",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.Ignored") then
            table.insert(tempTable,{
                label = "Entity ignores player",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.StayInVehicle") then
            table.insert(tempTable,{
                label = "Stay in vehicle",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.MaxHealth") then
            table.insert(tempTable,{
                label = "Max health",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.MaxArmor") then
            table.insert(tempTable,{
                label = "Max armor",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.CleanPlayer") then
            table.insert(tempTable,{
                label = "Clean player",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.DryPlayer") then
            table.insert(tempTable,{
                label = "Dry player",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.WetPlayer") then
            table.insert(tempTable,{
                label = "Wet player",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.VehicleAutoPilotMenu") then
            table.insert(tempTable,{
                label = "Vehicle auto-pilot",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.Freeze") then
            table.insert(tempTable,{
                label = "Freeze player",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerOptions.Scenarios") then
            table.insert(tempTable,{
                label = "Scenarios",
                args = {}
            })
        end
    elseif menu == "player_appearance" then
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerAppearance.Customize") then
            table.insert(tempTable,{
                label = "Customize ped",
                args = {"johnstrainer:customizeped"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerAppearance.SpawnPed") then
            table.insert(tempTable,{
                label = "Spawn ped",
                args = {"johnstrainer:spawnped"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerAppearance.Saved") then
            table.insert(tempTable,{
                label = "Saved peds",
                args = {"johnstrainer:savedpeds"}
            })
        end
    elseif menu == "Misc" then
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.ClearArea") then
            table.insert(tempTable,{
                label = "Clear Area",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.TeleportToWp") then
            table.insert(tempTable,{
                label = "Telepot to way point",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source,"johnstrainer.Misc.TeleportToCoord") then
            table.insert(tempTable,{
                label = "Telepot to coords",
                args = {}
            })
        end
          if IsPlayerAceAllowed(source,"johnstrainer.Misc.ShowCoordinates") then
            table.insert(tempTable,{
                label = "Show Coordinates",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source,"johnstrainer.Misc.ShowLocation") then
            table.insert(tempTable,{
                label = "Show Location",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source,"johnstrainer.Misc.JoinQuitNotif") then
            table.insert(tempTable,{
                label = "Join, Quit Notification",
                args = {}
            })
        end
           if IsPlayerAceAllowed(source,"johnstrainer.Misc.DeathNotifs") then
            table.insert(tempTable,{
                label = "Death Notification",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.NightVision") then
            table.insert(tempTable,{
                label = "Toggel NightVision",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.ThermalVision") then
            table.insert(tempTable,{
                label = "Toggel ThermalVision",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.LocationBlips") then
            table.insert(tempTable,{
                label = "Show Location Blips",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.OverheadNames") then
            table.insert(tempTable,{
                label = "Toggle Player names",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.PlayerBlips") then
            table.insert(tempTable,{
                label = "Show PlayerBlips",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.TeleportLocations") then
            table.insert(tempTable,{
                label = "Teleport to Locations",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.TeleportSaveLocation") then
            table.insert(tempTable,{
                label = "Teleport to Saved Location",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.ConnectionMenu") then
            table.insert(tempTable,{
                label = "IDFK",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.RestoreAppearance") then
            table.insert(tempTable,{
                label = "Restore Appearance",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.RestoreWeapons") then
            table.insert(tempTable,{
                label = "Restores Weapons",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.DriftMode") then
            table.insert(tempTable,{
                label = "Drift Mode",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.EntitySpawner") then
            table.insert(tempTable,{
                label = "Entity Spawner",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Misc.DevTools") then
            table.insert(tempTable,{
                label = "Dev Tools",
                args = {}
            })
        end
    elseif menu=="World" then
        if IsPlayerAceAllowed(source,"johnstrainer.World.TimeOptions.Menu") then
            table.insert(tempTable,{
                label = "Time Options",
                args = {"johnstrainer:TimeOptions"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.World.WeatherOptions.Menu") then
            table.insert(tempTable,{
                label = "Weather Options",
                args = {"johnstrainer:WeatherOptions"}
            })
        end
    
    elseif menu=="Time Options" then
        if IsPlayerAceAllowed(source, "johnstrainer.Time.FreezeTime") then
            table.insert(tempTable,{
                label = "Freeze Time",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source, "johnstrainer.Time.SetTime") then
            table.insert(tempTable,{
                label = "Set Time",
                args = {}
            })
        end
    elseif menu=="Weather Options" then
        if IsPlayerAceAllowed(source, "johnstrainer.Weather.SetWeather") then
            table.insert(tempTable,{
                label = "Set Weather",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source, "johnstrainer.Weather.Blackout") then
            table.insert(tempTable,{
                label = "Blackout",
                args = {}
            })
        end
        if IsPlayerAceAllowed(source, "johnstrainer.Weather.VehicleBlackout") then
            table.insert(tempTable,{
                label = "Vehicle Blackout",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source, "johnstrainer.Weather.RemoveClouds") then
            table.insert(tempTable,{
                label = "Remove Clouds",
                args = {}
            })
        end
          if IsPlayerAceAllowed(source, "johnstrainer.Weather.RandomizeClouds") then
            table.insert(tempTable,{
                label = "Randomize Clouds",
                args = {}
            })
        end
         if IsPlayerAceAllowed(source, "johnstrainer.Weather.Dynamic") then
            table.insert(tempTable,{
                label = "Dynamic",
                args = {}
            })
        end
    end
    return tempTable
end)
