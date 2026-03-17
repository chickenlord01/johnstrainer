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

    --Player Related
    ["johnstrainer.PlayerRelated.PlayerOptions"] =     {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerRelated.PlayerAppearance"] =  {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerRelated.PlayerCharacters"] =  {groups = {"builtin.everyone"}, status = true},

    --Player Options
    ["johnstrainer.PlayerOptions.God"] =                   {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.Invisible"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.UnlimitedStamina"] =      {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.FastRun"] =               {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.FastSwim"] =              {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.Superjump"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.NoRagdoll"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.NeverWanted"] =           {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.SetWanted"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.ClearBlood"] =            {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.SetBlood"] =              {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.Ignored"] =               {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.StayInVehicle"] =         {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.MaxHealth"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.MaxArmor"] =              {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.CleanPlayer"] =           {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.DryPlayer"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.WetPlayer"] =             {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.VehicleAutoPilotMenu"] =  {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.Freeze"] =                {groups = {"builtin.everyone"}, status = true},
    ["johnstrainer.PlayerOptions.Scenarios"] =             {groups = {"builtin.everyone"}, status = true},

}