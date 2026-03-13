--These are the default settings, changes made in game are found elsewhere

--groups type: table(string)
--status: allow or deny
return {
    --Commands
    ["command.opentrainer"] =              {groups = {"builtin.everyone"}, status = true},

    --Main menu
    ["johnstrainer.Menu.OnlinePlayers"] =  {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.Menu.PlayerRelated"] =  {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.Menu.VehicleRelated"] = {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.Menu.WorldRelated"] =   {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.Menu.Recording"] =      {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.Menu.Misc"] =           {groups = {"builtin.everyone"}, status = true},
}