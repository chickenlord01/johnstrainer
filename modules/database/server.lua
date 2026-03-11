--Setup database usage
local dbType = GetConvar("johnstrainer.databaseType","kvp")
if Trainer.framework == "johnsframework" then dbType = "johnsframework" end