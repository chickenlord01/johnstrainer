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

lib.callback.register('johnstrainer:permissions:getMenuOptionPermissions', function(source,menu)
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
                args = {"johnstrainer_player_options"}
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
    end
    return tempTable
end)