local QBCore = exports['qb-core']:GetCoreObject()

local inArmory = false

Citizen.CreateThread(function()
    for _, armory in pairs(Config.Armories) do
        local pedModel = GetHashKey(armory.ped)

        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Citizen.Wait(1)
        end

        local armoryPed = CreatePed(4, pedModel, armory.pedlocation.x, armory.pedlocation.y, armory.pedlocation.z - 1.0, armory.pedheading, false, true)
        
        if armory.pedSettings.SetEntityInvincible then
            SetEntityInvincible(armoryPed, true)
        end
        
        if armory.pedSettings.SetBlockingOfNonTemporaryEvents then
            SetBlockingOfNonTemporaryEvents(armoryPed, true)
        end
        
        if armory.pedSettings.FreezeEntityPosition then
            FreezeEntityPosition(armoryPed, true)
        end

        RequestAnimDict(armory.pedanim.dict)
        while not HasAnimDictLoaded(armory.pedanim.dict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(armoryPed, armory.pedanim.dict, armory.pedanim.anim, 8.0, -8.0, -1, 1, 0, false, false, false)

        exports['qb-target']:AddTargetEntity(armoryPed, {
            options = {
                {
                    label = "Open Armory",
                    icon = "fas fa-box-open",
                    action = function()
                        OpenArmory(armory)
                    end,
                },
            },
            distance = 2.5
        })
    end
end)

function OpenArmory(armory)
    local playerData = QBCore.Functions.GetPlayerData()
    local job = playerData.job.name
    local grade = playerData.job.grade.level

    print("Player job: " .. job)
    print("Player grade: " .. grade)

    if armory.ArmoryItems[job] then
        local items = {}

        for i = 0, grade do
            if armory.ArmoryItems[job][i] then
                for _, item in pairs(armory.ArmoryItems[job][i]) do
                    table.insert(items, item)
                end
            end
        end

        if next(items) then
            SendNUIMessage({
                action = 'open',
                items = items
            })
            SetNuiFocus(true, true)
            inArmory = true
        else
            QBCore.Functions.Notify("You do not have access to the armory.", "error")
        end
    else
        QBCore.Functions.Notify("You do not have access to the armory.", "error")
    end
end

RegisterNUICallback('buyItem', function(data, cb)
    local item = data.item
    local price = data.price

    TriggerServerEvent('qb-policearmory:server:buyItem', item, price)
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    inArmory = false
    SendNUIMessage({action = 'close'}) -- Ensure to hide the armory
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inArmory and IsControlJustPressed(0, 177) then -- ESC key
            SetNuiFocus(false, false)
            inArmory = false
            SendNUIMessage({action = 'close'}) -- Ensure to hide the armory
        end
    end
end)
