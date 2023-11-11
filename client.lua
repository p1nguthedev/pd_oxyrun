local pedCoords = Config.StartPedCoords

local pedCoords2 = Config.GrabPackagesPedCoords

local pedCoords3 = Config.Delivery1PedCoords

local pedCoords4 = Config.Delivery2PedCoords

local pedCoords5 = Config.Delivery3PedCoords

local pedCoords6 = Config.Delivery4PedCoords

local startnpcmodel = Config.StartPedModel
local hash = GetHashKey(startnpcmodel)

function target()
    exports.ox_target:addBoxZone({
        coords = Config.StartPedTargetCoords,
        size = vec3(1.5, 1.5, 1.5),
        rotation = 160,
        debug = drawZones,
        options = {
            {
                name = 'pd_oxyrun1',
                event = 'pd_oxyrun:checkPoliceCount',
                icon = 'fa fa-sign-in',
                label = Config.Locales["sign_in"],
                canInteract = function(entity, distance, coords, name)
                    return true
                end
            },
        }
    })
end

CreateThread(function()
    if Config.Use3DText == false then
    target()  
    else 
    end
    while true do
        local wait = 500
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - Config.StartPedTargetCoords)

        if Config.Use3DText and distance < 3.0 then
            wait = 0
            Text3D(Config.StartPedTargetCoords, Config.Locales["3dtext_sign_in"])
            if IsControlJustPressed(0, 38) then 
            TriggerServerEvent("pd_oxyrun:checkPoliceCount")
        end
    end
        Wait(wait)  
    end
end)

RegisterNetEvent('pd_oxyrun:client:startOxyRun')
AddEventHandler('pd_oxyrun:client:startOxyRun', function()
    if isMissionOnGoing == true then
        TriggerEvent("pd_oxyrun:client:notify", Config.Locales["mission_already_going_on"], 3000, 'error', true, -1)
    else
        if Config.UseProgressBar == true then
        jobStartProgbar()
    else
        jobStart()
        end
    end
end)

function jobStart()
    isMissionOnGoing = true
    jobStartMail()
    pdoxyrungetgoodies = AddBlipForCoord(Config.GrabPackagesPedCoords)
    SetBlipSprite(pdoxyrungetgoodies, 1)
    SetBlipColour(pdoxyrungetgoodies, 63)
    SetBlipRoute(pdoxyrungetgoodies, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locales["GPS_GrabPackages"])
    EndTextCommandSetBlipName(pdoxyrungetgoodies)
    pdGetGoodies()
end

local showing3dtextgrabpackages = false

function pdGetGoodies()
    local packagesmodel = Config.GrabPackagesPedModel

    while not HasModelLoaded(packagesmodel) do
        RequestModel(packagesmodel)
        Wait(100)
    end

    if not DoesEntityExist(startnpc2) then
        local ped2 = CreatePed(4, packagesmodel, pedCoords2.x, pedCoords2.y, pedCoords2.z, pedCoords2.w, true, false)
        TaskStartScenarioInPlace(ped2, "WORLD_HUMAN_SMOKING", 0, true)
        FreezeEntityPosition(ped2, true)
        SetEntityCanBeDamaged(ped2, false)
        SetBlockingOfNonTemporaryEvents(ped2, true)
        SetPedDiesWhenInjured(ped2, false)
        SetPedCanPlayAmbientAnims(ped2, true)
        SetPedCanRagdollFromPlayerImpact(ped2, false)
        SetEntityInvincible(ped2, true)
        startnpc2 = ped2

        while true do
            local wait = 500
            if Config.Use3DText then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.GrabPackagesTargetCoords)
                if showing3dtextgrabpackages == false then
                if distance < 3.0 then
                    wait = 0
                    Text3D(Config.GrabPackagesTargetCoords, Config.Locales["3dtext_crab_packages"])
                    if IsControlJustPressed(0, 38) then
                    showing3dtextgrabpackages = true
                    TriggerEvent("pd_oxyrun_giveitem:client")
                    end
                end
            end
            else
                target420 = exports.ox_target:addBoxZone({
                    coords = Config.GrabPackagesTargetCoords,
                    size = vec3(1.5, 1.5, 1.5),
                    rotation = 160,
                    debug = drawZones,
                    options = {
                        {
                            name = 'pd_oxyrun2',
                            event = 'pd_oxyrun_giveitem:client',
                            icon = 'fa fa-hand-rock-o',
                            label = Config.Locales["crab_packages"],
                            canInteract = function(entity, distance, coords, name)
                                return true
                            end
                        },
                    }
                })
            end
            Wait(wait)
        end
    end
end


RegisterNetEvent('pd_oxyrun_giveitem:client', function ()
    exports.ox_target:removeZone(target420)
    RemoveBlip(pdoxyrungetgoodies)
    SetEntityAsNoLongerNeeded(startnpc2)
    TriggerServerEvent('pd_oxyrun_giveitem:server')
    TriggerServerEvent("pd_oxyrun:server:policeAlert")
    grabbedPackagesMail()
    firststdevelivery()
end)

local showing3dtextdelivery1 = false

function firststdevelivery()
    pdoxy1stdeveliver = AddBlipForCoord(Config.Delivery1PedCoords)
    SetBlipSprite(pdoxy1stdeveliver, 1)
    SetBlipColour(pdoxy1stdeveliver, 63)
    SetBlipRoute(pdoxy1stdeveliver, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locales["deliveryblip1"])
    EndTextCommandSetBlipName(pdoxy1stdeveliver)
    local npcmodel3 = Config.Delivery1PedModel
    local hash3 = GetHashKey(npcmodel3)

    while not HasModelLoaded(hash3) do
        RequestModel(hash3)
        Wait(100)
    end

    if not DoesEntityExist(startnpc3) then
        local ped3 = CreatePed(4, hash3, pedCoords3.x, pedCoords3.y, pedCoords3.z, pedCoords3.w, true, false)
        FreezeEntityPosition(ped3, true)
        SetEntityCanBeDamaged(ped3, false)
        SetBlockingOfNonTemporaryEvents(ped3, true)
        SetPedDiesWhenInjured(ped3, false)
        SetPedCanPlayAmbientAnims(ped3, true)
        SetPedCanRagdollFromPlayerImpact(ped3, false)
        SetEntityInvincible(ped3, true)
        startnpc3 = ped3

        while true do
            local wait = 500
            if Config.Use3DText then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.Delivery1TargetCoords)
                if showing3dtextdelivery1 == false then
                if distance < 3.0 then
                    wait = 0
                    Text3D(Config.Delivery1TargetCoords, Config.Locales["3dtext_handover_packages"])
                    if IsControlJustPressed(0, 38) then
                    showing3dtextdelivery1 = true
                    TriggerEvent("pd_oxyrun_giveitem2:client")
                    end
                end
            end
            else
    target1stdeveliver = exports.ox_target:addBoxZone({
        coords = Config.Delivery1TargetCoords,
        size = vec3(1.5, 1.5, 1.5),
        rotation = 160,
        debug = drawZones,
        options = {
            {
                name = 'pd_oxyrundevlivery1',
                event = 'pd_oxyrun_giveitem2:client',
                icon = 'fa fa-hand-rock-o',
                label = Config.Locales["handover_packages"],
                canInteract = function(entity, distance, coords, name)
                    return true
                end
            },
        }
    }) 
         end  
        Wait(wait)
      end
   end
end

RegisterNetEvent('pd_oxyrun_giveitem2:client', function ()
    exports.ox_target:removeZone(target1stdeveliver)
    TriggerServerEvent("pd_oxyrun:server:policeAlert")
    RemoveBlip(pdoxy1stdeveliver)
    deliveryprogressbar1()
end)

RegisterNetEvent('pd_oxyrun_itemcheck1:client', function ()
    Wait(3000)
    SetEntityAsNoLongerNeeded(startnpc3)
    deliveryMail2()
    secoundstdevelivery()
end)

RegisterNetEvent('pd_oxyrun_itemcheck2:client', function ()
    Wait(3000)
    SetEntityAsNoLongerNeeded(startnpc4)
    deliveryMail3()
    thirdstdevelivery()
end)

RegisterNetEvent('pd_oxyrun_itemcheck3:client', function ()
    Wait(3000)
    SetEntityAsNoLongerNeeded(startnpc5)
    deliveryMail4()
    forthstdevelivery()
end)

RegisterNetEvent('pd_oxyrun_itemcheck4:client', function ()
    Wait(3000)
    SetEntityAsNoLongerNeeded(startnpc6)
    jobDoneRewardMail()
    isMissionOnGoing = false
end)

RegisterNetEvent('pd_oxyrun:ped1asnolongerneeded:client', function ()
    SetEntityAsNoLongerNeeded(startnpc3)
end)

RegisterNetEvent('pd_oxyrun:ped1asnolongerneeded:client2', function ()
    SetEntityAsNoLongerNeeded(startnpc4)
end)

RegisterNetEvent('pd_oxyrun:ped1asnolongerneeded:client3', function ()
    SetEntityAsNoLongerNeeded(startnpc5)
end)

RegisterNetEvent('pd_oxyrun:ped1asnolongerneeded:client4', function ()
    SetEntityAsNoLongerNeeded(startnpc6)
end)

RegisterNetEvent("pd_oxyrun:client:policeAlert", function()
    if Config.EnableHandOffAlerts == true then 
        policeAlert()
    end
end)

RegisterNetEvent("pd_oxyrun:client:notify", function(msg, time, type, sound)
    if Config.Notify == "esx" then
        ESX.ShowNotification(msg)
    elseif Config.Notify == "qbcore" then  
        QBCore.Functions.Notify(msg, type, time)  
    elseif Config.Notify == "custom" then
        -- add your code here   
    elseif Config.Notify == "qs" then 
        exports['qs-notify']:Alert(msg, TIME(time), type)
    elseif Config.Notify == "okok" then
        exports['okokNotify']:Alert('', msg, time, type, sound)
    else
        print("Notify script not supported!!! Check config.lua for any issues. Open a ticket if needed!")
    end
end)

local secoundstdeveliverytext3d = false

function secoundstdevelivery()
    pdoxy2stdeveliver = AddBlipForCoord(Config.Delivery2PedCoords)
    SetBlipSprite(pdoxy2stdeveliver, 1)
    SetBlipColour(pdoxy2stdeveliver, 63)
    SetBlipRoute(pdoxy2stdeveliver, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locales["deliveryblip2"])
    EndTextCommandSetBlipName(pdoxy2stdeveliver)
    local npcmodel4 = Config.Delivery2PedModel
    local hash4 = GetHashKey(npcmodel4)

    while not HasModelLoaded(hash4) do
        RequestModel(hash4)
        Wait(100)
    end

    if not DoesEntityExist(startnpc4) then
        local ped4 = CreatePed(4, hash4, pedCoords4.x, pedCoords4.y, pedCoords4.z, pedCoords4.w, true, false)
        FreezeEntityPosition(ped4, true)
        SetEntityCanBeDamaged(ped4, false)
        SetBlockingOfNonTemporaryEvents(ped4, true)
        SetPedDiesWhenInjured(ped4, false)
        SetPedCanPlayAmbientAnims(ped4, true)
        SetPedCanRagdollFromPlayerImpact(ped4, false)
        SetEntityInvincible(ped4, true)
        startnpc4 = ped4
        while true do
            local wait = 500
            if Config.Use3DText then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.Delivery2TargetCoords)
                if secoundstdeveliverytext3d == false then
                if distance < 3.0 then
                    wait = 0
                    Text3D(Config.Delivery2TargetCoords, Config.Locales["3dtext_handover_packages"])
                    if IsControlJustPressed(0, 38) then
                    secoundstdeveliverytext3d = true
                    TriggerEvent("pd_oxyrun_giveitem3:client")
                    end
                end
            end
            else
    target2stdeveliver = exports.ox_target:addBoxZone({
        coords = Config.Delivery2TargetCoords,
        size = vec3(1.5, 1.5, 1.5),
        rotation = 160,
        debug = drawZones,
        options = {
            {
                name = 'pd_oxyrundevlivery2',
                event = 'pd_oxyrun_giveitem3:client',
                icon = 'fa fa-hand-rock-o',
                label = Config.Locales["handover_packages"],
                canInteract = function(entity, distance, coords, name)
                    return true
                end
            },
        }
    })
end
    Wait(wait)
      end
   end
end

RegisterNetEvent('pd_oxyrun_giveitem3:client', function ()
    exports.ox_target:removeZone(target2stdeveliver)
    TriggerServerEvent("pd_oxyrun:server:policeAlert")
    RemoveBlip(pdoxy2stdeveliver)
    deliveryprogressbar2()
end)

local thirdstdevelivery3dtext = false

function thirdstdevelivery()
    pdoxy3stdeveliver = AddBlipForCoord(Config.Delivery3PedCoords)
    SetBlipSprite(pdoxy3stdeveliver, 1)
    SetBlipColour(pdoxy3stdeveliver, 63)
    SetBlipRoute(pdoxy3stdeveliver, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locales["deliveryblip3"])
    EndTextCommandSetBlipName(pdoxy3stdeveliver)
    local npcmodel5 = Config.Delivery3PedModel
    local hash5 = GetHashKey(npcmodel5)

    while not HasModelLoaded(hash5) do
        RequestModel(hash5)
        Wait(100)
    end

    if not DoesEntityExist(startnpc5) then
        local ped5 = CreatePed(4, hash5, pedCoords5.x, pedCoords5.y, pedCoords5.z, pedCoords5.w, true, false)
        FreezeEntityPosition(ped5, true)
        SetEntityCanBeDamaged(ped5, false)
        SetBlockingOfNonTemporaryEvents(ped5, true)
        SetPedDiesWhenInjured(ped5, false)
        SetPedCanPlayAmbientAnims(ped5, true)
        SetPedCanRagdollFromPlayerImpact(ped5, false)
        SetEntityInvincible(ped5, true)
        startnpc5 = ped5
        while true do
            local wait = 500
            if Config.Use3DText then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.Delivery3TargetCoords)
                if thirdstdevelivery3dtext == false then
                if distance < 3.0 then
                    wait = 0
                    Text3D(Config.Delivery3TargetCoords, Config.Locales["3dtext_handover_packages"])
                    if IsControlJustPressed(0, 38) then
                    thirdstdevelivery3dtext = true
                    TriggerEvent("pd_oxyrun_giveitem4:client")
                    end
                end
            end
            else
    target3stdeveliver = exports.ox_target:addBoxZone({
        coords = Config.Delivery3TargetCoords,
        size = vec3(1.5, 1.5, 1.5),
        rotation = 160,
        debug = drawZones,
        options = {
            {
                name = 'pd_oxyrundevlivery3',
                event = 'pd_oxyrun_giveitem4:client',
                icon = 'fa fa-hand-rock-o',
                label = Config.Locales["handover_packages"], 
                canInteract = function(entity, distance, coords, name)
                    return true
                end
            },
        }
    })end
    Wait(wait)
     end
   end
end

RegisterNetEvent('pd_oxyrun_giveitem4:client', function ()
    exports.ox_target:removeZone(target3stdeveliver)
    TriggerServerEvent("pd_oxyrun:server:policeAlert")
    RemoveBlip(pdoxy3stdeveliver)
    deliveryprogressbar3()
end)

local fourthstdelivery3dtext = false 

function forthstdevelivery()
    pdoxy4stdeveliver = AddBlipForCoord(Config.Delivery4PedCoords)
    SetBlipSprite(pdoxy4stdeveliver, 1)
    SetBlipColour(pdoxy4stdeveliver, 63)
    SetBlipRoute(pdoxy4stdeveliver, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Locales["deliveryblip4"])
    EndTextCommandSetBlipName(pdoxy4stdeveliver)
    local npcmodel6 = Config.Delivery4PedModel
    local hash6 = GetHashKey(npcmodel6)

    while not HasModelLoaded(hash6) do
        RequestModel(hash6)
        Wait(100)
    end

    if not DoesEntityExist(startnpc6) then
        local ped6 = CreatePed(4, hash6, pedCoords6.x, pedCoords6.y, pedCoords6.z, pedCoords6.w, true, false)
        FreezeEntityPosition(ped6, true)
        SetEntityCanBeDamaged(ped6, false)
        SetBlockingOfNonTemporaryEvents(ped6, true)
        SetPedDiesWhenInjured(ped6, false)
        SetPedCanPlayAmbientAnims(ped6, true)
        SetPedCanRagdollFromPlayerImpact(ped6, false)
        SetEntityInvincible(ped6, true)
        startnpc6 = ped6

        while true do
            local wait = 500
            if Config.Use3DText then
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.Delivery4TargetCoords)
                if fourthstdelivery3dtext == false then
                if distance < 3.0 then
                    wait = 0
                    Text3D(Config.Delivery4TargetCoords, Config.Locales["3dtext_handover_packages"])
                    if IsControlJustPressed(0, 38) then
                    fourthstdelivery3dtext = true
                    TriggerEvent("pd_oxyrun_giveitem5:client")
                    end
                end
            end
            else
    target4stdeveliver = exports.ox_target:addBoxZone({
        coords = Config.Delivery4TargetCoords,
        size = vec3(1.5, 1.5, 1.5),
        rotation = 160,
        debug = drawZones,
        options = {
            {
                name = 'pd_oxyrundevlivery4',
                event = 'pd_oxyrun_giveitem5:client',
                icon = 'fa fa-hand-rock-o',
                label = Config.Locales["handover_packages"], 
                canInteract = function(entity, distance, coords, name)
                    return true
                end
            },
        }
    })
end
    Wait(wait)
end
   end
end

RegisterNetEvent('pd_oxyrun_giveitem5:client', function ()
    exports.ox_target:removeZone(target4stdeveliver)
    TriggerServerEvent("pd_oxyrun:server:policeAlert")
    RemoveBlip(pdoxy4stdeveliver)
    deliveryprogressbar4()
end)

CreateThread(function()
    while true do
        local wait = 500

        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(100)
        end
    
        if not DoesEntityExist(pd_oxyrunstartingNpc) then
            local ped = CreatePed(4, hash, pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, true, false)
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
            FreezeEntityPosition(ped, true)
            SetEntityCanBeDamaged(ped, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
	        SetPedDiesWhenInjured(ped, false)
	        SetPedCanPlayAmbientAnims(ped, true)
  	        SetPedCanRagdollFromPlayerImpact(ped, false)
 	        SetEntityInvincible(ped, true)
            pd_oxyrunstartingNpc = ped
        end
        
        Wait(wait)
    end
end)