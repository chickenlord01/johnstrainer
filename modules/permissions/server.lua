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
                args = {"johnstrainer_online_players"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.PlayerRelated") then
            table.insert(tempTable,{
                label = "Player related options",
                args = {"johnstrainer_player_related"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.VehicleRelated") then
            table.insert(tempTable,{
                label = "Vehicle related options",
                args = {"johnstrainer_vehicle_options"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.WorldRelated") then
            table.insert(tempTable,{
                label = "World related options",
                args = {"johnstrainer_world_options"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.Recording") then
            table.insert(tempTable,{
                label = "Recording options",
                args = {"johnstrainer_recording_options"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.Menu.Misc") then
            table.insert(tempTable,{
                label = "Misc options",
                args = {"johnstrainer_misc_options"}
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
                args = {"johnstrainer_player_options"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerRelated.PlayerAppearance") then
            table.insert(tempTable,{
                label = "Player Appearance",
                args = {"johnstrainer_player_appearance"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerRelated.PlayerCharacters") then
            table.insert(tempTable,{
                label = "Player Characters",
                args = {"johnstrainer_player_characters"}
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
                args = {"johnstrainer_customize_ped"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerAppearance.SpawnPed") then
            table.insert(tempTable,{
                label = "Spawn ped",
                args = {"johnstrainer_spawn_ped"}
            })
        end
        if IsPlayerAceAllowed(source,"johnstrainer.PlayerAppearance.Saved") then
            table.insert(tempTable,{
                label = "Saved peds",
                args = {"johnstrainer_saved_ped"}
            })
        end
    end
    return tempTable
end)