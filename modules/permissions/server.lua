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