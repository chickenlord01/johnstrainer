--Initialise all the needed things and stuff
if not Trainer then Trainer = {} end
if GetResourceState("johnsframework") ~= "missing" then Trainer.framework = "johnsframework" end

local convars = require("utils.configuration.convars")
for k,v in pairs(convars) do
    ExecuteCommand("setr "..k.. " "..v)
end