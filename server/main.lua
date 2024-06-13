local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-policearmory:server:buyItem')
AddEventHandler('qb-policearmory:server:buyItem', function(item, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    print("Attempting to purchase item: " .. tostring(item))  -- Debug print
    print("Price: " .. tostring(price))  -- Debug print

    if Player.Functions.RemoveMoney('cash', price) then
        local canCarry = exports.ox_inventory:CanCarryItem(src, item, 1)
        print("Can carry item: " .. tostring(item) .. " - " .. tostring(canCarry))  -- Debug print
        if canCarry then
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerClientEvent('QBCore:Notify', src, 'You have purchased a ' .. tostring(item), 'success')
        else
            print("Cannot carry item: " .. tostring(item))  -- Debug print
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough space in your inventory.', 'error')
        end
    else
        print("Not enough money for item: " .. tostring(item))  -- Debug print
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
    end
end)

QBCore.Functions.CreateCallback('qb-policearmory:server:canCarryItem', function(source, cb, item)
    local src = source
    print("Checking if player can carry item: " .. tostring(item))  -- Debug print
    local canCarry = exports.ox_inventory:CanCarryItem(src, item, 1)
    print("Can carry: " .. tostring(canCarry))  -- Debug print
    cb(canCarry)
end)
