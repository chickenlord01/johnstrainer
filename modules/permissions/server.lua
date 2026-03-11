local Permission = lib.class("Permission")
local Permissions = {}

function Permission:constructor(data)
    for k,v in pairs(data) do
        self[k] = v
    end
    Permissions[self.id] = self
    return self:setup()
end
function Permission:setup()end
function Permission:save()end