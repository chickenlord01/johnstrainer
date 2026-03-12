--Setup database usage
local dbType = GetConvar("johnstrainer.databaseType","kvp")
local dbLoc = GetConvar("johnstrainer.databaseLocation","local")
if Trainer.framework == "johnsframework" then dbType = "johnsframework" end

if dbLoc == "remote" then
    
end