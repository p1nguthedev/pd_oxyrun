if Config.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
else
    print("Framework script not supported!!! Check config.lua for any issues. Open a ticket if needed!")
end

RegisterNetEvent('pd_oxyrun:checkPoliceCount')
AddEventHandler('pd_oxyrun:checkPoliceCount', function()
    local xPlayers = ESX.GetPlayers()

    local policeCount = 0
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config.PoliceCount then
        TriggerClientEvent('pd_oxyrun:client:startOxyRun', -1)
    else
        TriggerClientEvent("pd_oxyrun:client:notify", -1, Config.Locales["not_enough_police"], 3000, 'error', true)
    end
end)

RegisterNetEvent('pd_oxyrun_giveitem:server', function()
    local _source = source
    local xPlayer
    
    if Config.Framework == "esx" then
        xPlayer = ESX.GetPlayerFromId(_source)
    elseif Config.Framework == "qb" then
        xPlayer = QBCore.Functions.GetPlayer(_source)
    else
        print("Framework script not supported!!! Check config.lua for any issues. Open a ticket if needed!")
        return
    end

    local coords = xPlayer.getCoords(true)
    print(xPlayer)

    if xPlayer then
        if #(coords - vector3(-46.6621, 1947.1743, 190.5558)) < 10.0 then
            local amount = 4
            xPlayer.addInventoryItem(Config.SuspiciousPackageItem, amount)
        end
    end
end)

RegisterNetEvent("pd_oxyrun:server:policeAlert", function()
    TriggerClientEvent("pd_oxyrun:server:policeAlert", -1)
end)

RegisterNetEvent('pd_oxyrun_giveitem2:server', function()
    local _source = source
    local xPlayer

    if Config.Framework == "esx" then
        xPlayer = ESX.GetPlayerFromId(_source)
    elseif Config.Framework == "qb" then
        xPlayer = QBCore.Functions.GetPlayer(_source)
    else
        print("Framework script not supported!!! Check config.lua for any issues. Open a ticket if needed!")
        return
    end

    local coords = xPlayer.getCoords(true)

    if xPlayer then
        local distanceToLocation1 = #(coords - vector3(Config.Delivery1PedCoords))
        local distanceToLocation2 = #(coords - vector3(Config.Delivery2PedCoords))
        local distanceToLocation3 = #(coords - vector3(Config.Delivery3PedCoords))
        local distanceToLocation4 = #(coords - vector3(Config.Delivery4PedCoords))

        if distanceToLocation1 < 10.0 or distanceToLocation2 < 10.0 or distanceToLocation3 < 10.0 or distanceToLocation4 < 10.0 then
            local amountToRemove = 1
            local amountToAdd = Config.OxyItemAddCount

            if xPlayer.getInventoryItem('suspicious_package').count >= amountToRemove then
                xPlayer.removeInventoryItem('suspicious_package', amountToRemove)
                xPlayer.addInventoryItem(Config.OxyItem, amountToAdd)
                TriggerClientEvent("pd_oxyrun:client:policeAlert", -1)

                if distanceToLocation1 < 10.0 then
                    TriggerClientEvent("pd_oxyrun_itemcheck1:client", _source)
                elseif distanceToLocation2 < 10.0 then
                    TriggerClientEvent("pd_oxyrun_itemcheck2:client", _source)
                elseif distanceToLocation3 < 10.0 then
                    TriggerClientEvent("pd_oxyrun_itemcheck3:client", _source)
                elseif distanceToLocation4 < 10.0 then
                    TriggerClientEvent("pd_oxyrun_itemcheck4:client", _source)
                end
            else
                TriggerClientEvent("pd_oxyrun:client:notify", Config.Locales["not_enough_items"], 3000, 'error', -1)

                if distanceToLocation1 < 10.0 then
                    TriggerClientEvent("pd_oxyrun:ped1asnolongerneeded:client", _source)
                elseif distanceToLocation2 < 10.0 then
                    TriggerClientEvent("pd_oxyrun:ped1asnolongerneeded:client2", _source)
                elseif distanceToLocation3 < 10.0 then
                    TriggerClientEvent("pd_oxyrun:ped1asnolongerneeded:client3", _source)
                elseif distanceToLocation4 < 10.0 then
                    TriggerClientEvent("pd_oxyrun:ped1asnolongerneeded:client4", _source)
                end
            end
        end
    end
end)