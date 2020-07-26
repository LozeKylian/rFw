local weapons = {  
    "WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB",  
    "WEAPON_CROWBAR", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50",  
    "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE",  
    "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN",  
    "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE",  
    "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",  
    "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV",  
    "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_FLARE", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE",  
    "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL",  
    "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE",  
    "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_RAILGUN", "WEAPON_COMBATPDW",  
    "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_FLASHLIGHT", "WEAPON_MACHETE", "WEAPON_MACHINEPISTOL",  
    "WEAPON_SWITCHBLADE", "WEAPON_REVOLVER", "WEAPON_COMPACTRIFLE", "WEAPON_DBSHOTGUN", "WEAPON_FLAREGUN",  
    "WEAPON_AUTOSHOTGUN", "WEAPON_BATTLEAXE", "WEAPON_COMPACTLAUNCHER", "WEAPON_MINISMG", "WEAPON_PIPEBOMB",  
    "WEAPON_POOLCUE", "WEAPON_SWEEPER", "WEAPON_WRENCH"  
}

RegisterCommand("repair", function(source, args, rawCommand)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    SetVehicleFixed(pVeh)
    SetVehicleDirtLevel(pVeh, 0.0)
end, false)


RegisterCommand("car", function(source, args, rawCommand)
    RequestModel(GetHashKey(args[1]))
    while not HasModelLoaded(GetHashKey(args[1])) do Wait(1) end

    local veh = CreateVehicle(GetHashKey(args[1]), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), 1, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
end, false)

RegisterCommand("pos", function(source, args, rawCommand)
    print("{pos = "..GetEntityCoords(GetPlayerPed(-1))..", heading = "..GetEntityHeading(GetPlayerPed(-1)).."},")
end, false)

RegisterCommand("revive", function(source, args, rawCommand)
    ReviveInjuredPed(GetPlayerPed(-1))
    NetworkResurrectLocalPlayer(GetEntityCoords(GetPlayerPed(-1)), 100.0, 0, 0)
end, false)

RegisterCommand("giveweapon", function(source, args, rawCommand)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(args[1]), 255, 0, 1)
end, false)

RegisterCommand("settime", function(source, args, rawCommand)
    NetworkOverrideClockTime(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
end, false)

RegisterCommand("random", function(source, args, rawCommand)
    local pVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetVehicleModKit(pVeh, 0)
    for i = 0,49 do
        local p = GetNumVehicleMods(pVeh, i)
        print(i, p)
        if p == 0 then p = 2 end
        SetVehicleMod(pVeh, i, math.random(1, p), true)
    end
end, false)

local slow = false
RegisterCommand("slow", function(source, args, rawCommand)
    if not slow then
        SetTimeScale(0.25)
    else
        SetTimeScale(1.0)
    end
    slow = not slow
end, false)

-- Tp to coords
RegisterCommand('tp', function(source, args, rawCommand)
    print(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
    if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
        
        local pPed = GetPlayerPed(-1)
        SetEntityCoordsNoOffset(pPed, tonumber(args[1]), tonumber(args[2]), tonumber(args[3]), 0.0, 0.0, 0.0, 0)
    end
end)



RegisterCommand("giveweaponsall", function()
    local player = GetPlayerPed(-1)
    for k,v in pairs(weapons) do
        GiveWeaponToPed(player, GetHashKey(v), 255, 0, 0) 
    end
end)

RegisterCommand("giveweapon", function(source, args, rawCommand)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(args[1]), 255, 0, 1)
end, false)


RegisterCommand("skin", function() 
    local Model = GetHashKey('mp_m_freemode_01')
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(10)
	end
	SetPlayerModel(PlayerId(), Model)
	SetPedDefaultComponentVariation(PlayerPedId())
    SetPedRandomComponentVariation(PlayerPedId(), true)
    SetModelAsNoLongerNeeded(Model)
end)

RegisterCommand("suicide", function()
    local pPed = GetPlayerPed(-1)
    SetEntityHealth(pPed, 0)
end)

RegisterCommand("heal", function()
    local pPed = GetPlayerPed(-1)
    SetEntityHealth(pPed, 100)
end)

