local Permission = lib.class("Permission")
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
function Permission:setup()end
function Permission:save()end