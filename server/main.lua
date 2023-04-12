local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('process:server:process', function(k)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasItems = false
    if Player.PlayerData.items ~= nil then 
        local item = nil
        for _, v in pairs(Config.Locations[k].items) do
            item = Player.Functions.GetItemByName(Config.Locations[k].items[_].name)
            if item ~= nil and item.amount >= Config.Locations[k].items[_].amount then
                hasItems = true
            else
                TriggerClientEvent('QBCore:Notify', src, Config.Locations[k].notifyDontHaveItems, 'error')
                hasItems = false
                break
            end
        end
        if hasItems then
            TriggerClientEvent("process:client:ProcessMinigame", src, k)
        end
    end
end)

RegisterServerEvent('process:server:getitem', function(k)
    local Player = QBCore.Functions.GetPlayer(source)
    for item, v in pairs(Config.Locations[k].itemToGet) do
        Player.Functions.AddItem(Config.Locations[k].itemToGet[item].name, Config.Locations[k].itemToGet[item].amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Locations[k].itemToGet[item].name], "add")
    end
    for item, v in pairs(Config.Locations[k].items) do
        Player.Functions.RemoveItem(Config.Locations[k].items[item].name, Config.Locations[k].items[item].amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Locations[k].items[item].name], "remove")
    end
end)
