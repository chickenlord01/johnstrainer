--These are the default settings, changes made in game are found elsewhere

--groups type: table(string)
--status type: boolean
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

    --Online Players
    ["johnstrainer.OnlinePlayers.Teleport"] =     {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Waypoint"] =     {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Spectate"] =     {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.SendMessage"] =  {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Summon"] =       {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Kill"] =         {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Kick"] =         {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Ban"] =          {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Unban"] =        {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.OnlinePlayers.Identifiers"] =  {groups = {"builtin.everyone"}, status = true},

}