local QBCore = exports['qb-core']:GetCoreObject()
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local skillbarDuration = nil
local skillbarPos = nil
local skillbarWidth = nil
local processing = false

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

if not Config.useTarget then
    CreateThread(function()
        while true do
            local inRange = false

            local PlayerPed = PlayerPedId()
            local PlayerPos = GetEntityCoords(PlayerPed)

            
            for k, _ in pairs(Config.Locations) do
                for i, _ in pairs(Config.Locations[k].coords) do
                    local coords = vector3(Config.Locations[k].coords[i].x, Config.Locations[k].coords[i].y, Config.Locations[k].coords[i].z)
                    local distance = #(PlayerPos - coords)
                    if distance < 15 then
                        inRange = true

                        if distance < 2 then
                            DrawText3Ds(coords.x, coords.y, coords.z, Config.Locations[k].text)
                            if IsDisabledControlJustReleased(0, Config.Key) then
                                if not processing then
                                    if Config.debug then
                                        print("^1Pressed processing button")
                                    end
                                    TriggerServerEvent("process:server:process", k)
                                end
                            end
                        end
                    end
                end
            end

            if not inRange then
                Wait(2000)
            end
            Wait(3)
        end
    end)
else
    for k, _ in pairs(Config.Locations) do
        for i, _ in pairs(Config.Locations[k].coords) do

            exports['qb-target']:AddCircleZone('cr-proccess_' .. k .. i, vector3(Config.Locations[k].coords[i].x, Config.Locations[k].coords[i].y, Config.Locations[k].coords[i].z), 0.5,{
                name = 'cr-proccess_' .. k .. i, debugPoly = Config.debug, useZ=true}, {
                options = {{label = Config.Locations[k].text,icon = 'fa-solid fa-hand-rock-o', action = function() TriggerServerEvent("process:server:process", k) end}},
                distance = 2.0
            })
        end
    end
end

RegisterNetEvent("cr-process:client:process", function(k)
-- function Process(k)
    if Config.debug then
        print("^2now processing")
    end
    PrepareProcessAnim(k)
    QBCore.Functions.Progressbar("grind_coke", Config.Locations[k].textProgressBar, Config.Locations[k].progressbar, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("process:server:getitem", k)
        QBCore.Functions.Notify(Config.Locations[k].notifyProgressbar, "success")
        ClearPedTasks(PlayerPedId())
        if Config.debug then
            print("^2done processing")
        end
        processing = false
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        processing = false
        if Config.debug then
            print("^1canceld processing")
        end
    end)
end)

RegisterNetEvent('process:client:ProcessMinigame', function(k)
    if not processing then
        processing = true
        if Config.Locations[k].miniGame then
            ProcessMinigame(k)
        else
            
            TriggerEvent("cr-process:client:process", k)
        end
    end
end)

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

function PrepareProcessAnim(k)
    local ped = PlayerPedId()
    loadAnimDict(Config.Locations[k].animDict)
    TaskPlayAnim(ped, Config.Locations[k].animDict, Config.Locations[k].anim, 6.0, -6.0, -1, 47, 0, 0, 0, 0)
end

function ProcessMinigame(k)
    dufficulty(k)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if Config.debug then
        print("^4skillbarDuration " .. skillbarDuration)
        print("^4skillbarPos " .. skillbarPos)
        print("^4skillbarWidth " .. skillbarWidth)
        print("^4NeededAttempts " .. NeededAttempts)
    end
    Skillbar.Start({
        duration = skillbarDuration,
        pos = skillbarPos,
        width = skillbarWidth,
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            
            TriggerEvent("cr-process:client:process", k)
            -- Process(k)
            QBCore.Functions.Notify(Config.Locations[k].notifyMinigameSuccess, "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0

            if Config.debug then
                print("^2Made the skillchecks")
            end
        else    
            -- dufficulty(k)
            if Config.debug then
                print("^4before SucceededAttempts " .. SucceededAttempts)
            end
            Skillbar.Repeat({
                duration = skillbarDuration,
                pos = skillbarPos,
                width = skillbarWidth,
            })
            SucceededAttempts = SucceededAttempts + 1
            if Config.debug then
                print("^4after SucceededAttempts " .. SucceededAttempts)
            end
        end
                
        
	end, function()

            QBCore.Functions.Notify(Config.Locations[k].notifyMinigameFail, "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            Wait(1000)
            processing = false
            if Config.debug then
                print("^1Failed skillchecks")
            end
    end)
end

function dufficulty(k)
    if Config.debug then
        print("^4Skillbar dufficulty " .. Config.Locations[k].skillBar)
    end
    if Config.Locations[k].skillBar == "hard" then
        skillbarDuration = math.random(600, 1000)
        skillbarPos = math.random(5, 50)
        skillbarWidth = math.random(7, 15)
        NeededAttempts = math.random(5, 10)
    elseif Config.Locations[k].skillBar == "medium" then
        skillbarDuration = math.random(1000, 1500)
        skillbarPos = math.random(10, 40)
        skillbarWidth = math.random(10, 20)
        NeededAttempts = math.random(5, 7)
    elseif Config.Locations[k].skillBar == "easy" then
        skillbarDuration = math.random(1500, 2000)
        skillbarPos = math.random(15, 30)
        skillbarWidth = math.random(15, 30)
        NeededAttempts = math.random(3, 5)
    end
end
