Config = {}

-- Important --------------------------------------------------------------------
Config.Framework = "esx" -- put "esx" if you want to use ESX framework or if you want to use qbcore framework then put "qb"
Config.Notify = "okok" -- "esx" for ESX.ShowNotification, "qb" for  QBCore.Functions.Notify, "okok" for exports['okokNotify'], "qs" exports['qs-notify'], "custom" for your own notify, check client event for that
Config.Use3DText = true -- use 3D text instead of ox_target
Config.UseProgressBar = true -- true if you want to false if dont want to use progressbar
Config.EnableHandOffAlerts = true -- true if you have your own dispatch script or false if not
Config.PoliceCount = 3 -- number of police required to start oxy run

function Text3D(coords, text) -- settings of the 3D text
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z + 0.5)
    local factor = (string.len(text)) / 400

    SetTextScale(0.20, 0.20)
    SetTextOutline()
    SetTextCentre(true)
    SetTextDropShadow(2, 0, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextColour(255, 255, 255, 255)
    AddTextComponentString(text)
    DrawText(x, y)
end

function policeAlert()
     -- add your police alert here / or leave it like this if no need
end
-- Start OXY RUN ----------------------------------------------------------------
Config.StartPedCoords = vector4(131.7706, -1509.8939, 28.1416, 228.7240)
Config.StartPedModel = "g_m_m_armboss_01"
Config.StartPedTargetCoords = vec3(131.7706, -1509.8939, 29.1416)

function jobStartProgbar()
    if Config.UseProgressBar == true then 
        lib.progressCircle({
            duration = 1000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        })
    end

    jobStart()
end



function jobStartMail() -- add your own phone email message here (also to other mails)
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Oxy',
        message = 'So you want to work for me. Locate a vehicle with a trunk. I sended you a GPS of pick up location. Take the product and send them to drop off point. You will be rewarded well!',
    }) -- this is for qs phone
end
---------------------------------------------------------------------------------

-- Grab Packages OXY RUN --------------------------------------------------------
Config.GrabPackagesPedCoords = vector4(-46.6621, 1947.1743, 189.5558, 203.6738)
Config.GrabPackagesPedModel = "g_m_y_pologoon_02"
Config.GrabPackagesTargetCoords = vec3(-46.6621, 1947.1743, 190.5558)
Config.SuspiciousPackageItem = "suspicious_package"

function grabbedPackagesMail()
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Oxy',
        message = 'I sent you coordinates of buyer. Sell the product and i will send another location.',
    })
end

---------------------------------------------------------------------------------

-- Delivery 1 -------------------------------------------------------------------
Config.Delivery1PedCoords = vector4(-174.4807, -1528.5482, 33.3538, 138.2193)
Config.Delivery1PedModel = "g_m_y_famdnf_01"
Config.Delivery1TargetCoords = vec3(-174.4807, -1528.5482, 34.3538)
Config.OxyItemAddCount = 3
Config.OxyItem = "prescription_oxy"

function deliveryprogressbar1()
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then
        TriggerServerEvent('pd_oxyrun_giveitem2:server')
    end
end
---------------------------------------------------------------------------------

-- Delivery 2 -------------------------------------------------------------------
Config.Delivery2PedCoords = vector4(700.5472, -2185.5510, 28.7956, 354.9060)
Config.Delivery2PedModel = "g_m_y_famdnf_01"
Config.Delivery2TargetCoords = vec3(700.5472, -2185.5510, 29.7956)

function deliveryMail3()
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Oxy',
        message = 'I sent you coordinates of next buyer. Sell the product and i will send another location. You got two left.',
    })
end

function deliveryprogressbar2()
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then
        TriggerServerEvent('pd_oxyrun_giveitem2:server')
    end
end

function deliveryMail2()
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Oxy',
        message = 'I sent you coordinates of next buyer. Sell the product and i will send another location. You got three left.',
    })
end
---------------------------------------------------------------------------------

-- Delivery 3 -------------------------------------------------------------------
Config.Delivery3PedCoords = vector4(915.1603, -1153.1772, 24.9427, 185.9823)
Config.Delivery3PedModel = "g_m_y_famdnf_01"
Config.Delivery3TargetCoords = vec3(915.1603, -1153.1772, 25.9427)

function deliveryprogressbar3()
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then
        TriggerServerEvent('pd_oxyrun_giveitem2:server')
    end
end

function deliveryMail4()
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Oxy',
        message = 'I sent you coordinates of next buyer. Sell the product and i will send another location. You got one more left.',
    })
end
---------------------------------------------------------------------------------

-- Delivery 4 -------------------------------------------------------------------
Config.Delivery4PedCoords = vector4(718.8228, 248.5290, 92.1374, 58.0784)
Config.Delivery4PedModel = "g_m_y_famdnf_01"
Config.Delivery4TargetCoords = vec3(718.8228, 248.5290, 93.1374)

function deliveryprogressbar4()
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then
        TriggerServerEvent('pd_oxyrun_giveitem2:server')
    end
end

function jobDoneRewardMail()
    TriggerServerEvent('qs-smartphone:server:sendNewMail', {
        sender = 'Boss (OXY)',
        subject = 'Job Done',
        message = 'Good job. Your work is done!',
    })
end
---------------------------------------------------------------------------------

Config.Locales = {
    ["sign_in"] = 'sign in',
    ["crab_packages"] = 'Grab packages',
    ["deliveryblip1"] = 'Delivery 1',
    ["deliveryblip2"] = 'Delivery 2',
    ["deliveryblip3"] = 'Delivery 3',
    ["deliveryblip4"] = 'Delivery 4',
    ["handover_packages"] = 'Handover the package',
    ["GPS_GrabPackages"] = 'Grab Packages',
    ["not_enough_items"] = 'You dont have packages!',
    ["alert_blip"] = 'Suspicious hand of in progress',
    ["mission_already_going_on"] = 'Mission already going on!',
    -- if Config.Use3DText is true here are the locales for that
    ["3dtext_sign_in"] = "Press ~b~[E]~w~ to sign in",
    ["3dtext_crab_packages"] = "Press ~b~[E]~w~ to grab packages",
    ["3dtext_handover_packages"] = "Press ~b~[E]~w~ to hand over packages",
    ["not_enough_police"] = "Not enough cops in city"
}