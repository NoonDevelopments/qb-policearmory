local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-policearmory:server:buyItem')
AddEventHandler('qb-policearmory:server:buyItem', function(item, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.RemoveMoney('cash', price) then
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You have purchased a ' .. item, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
    end
end)
