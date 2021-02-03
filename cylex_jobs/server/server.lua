ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cylex_jobs:server:getConfig', function(source, cb, itemName) 
    while Jobs == nil do 
        Citizen.Wait(100)
    end
    cb(Jobs)
end)

RegisterServerEvent("cylex_jobs:server:process")
AddEventHandler("cylex_jobs:server:process", function(coords, k, v, id)
    local player = ESX.GetPlayerFromId(source)
    if not player or k == nil or coords == nil or id == nil or v == nil then return TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['nilError']}) end
    local jobData = Jobs[k].location[id]
    if #(jobData.coords - coords) <= 10 then
        --print('server check 1')
        local item = player.getInventoryItem(jobData.item["itemName"])
        local requiredItem = player.getInventoryItem(jobData.item["requiredItem"])
        if item or jobData.item["process"] == "sell" then
            if jobData.item["process"] == "pickup" then
                --print('collect server')
                if (player.getInventoryItem(jobData.item["itemName"]).count + jobData.item["addCount"]) <= player.getInventoryItem(jobData.item["itemName"]).limit then
                    --print('give server')
                    player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = messages[setLocale]['haveCollected']..jobData.item["addCount"].."x ".. ESX.GetItemLabel(jobData.item["itemName"])})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['itemLimit']})
                end
            elseif jobData.item["process"] == "exchange" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    --print('tienes item necesario')
                    if (player.getInventoryItem(jobData.item["itemName"]).count + jobData.item["addCount"]) <= player.getInventoryItem(jobData.item["itemName"]).limit then
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = messages[setLocale]['haveProcessed']..jobData.item["addCount"].."x "..ESX.GetItemLabel(jobData.item["itemName"])})
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['itemLimit']})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['itemLimit']})
                end
            elseif jobData.item["process"] == "package" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    if (player.getInventoryItem(jobData.item["itemName"]).count + jobData.item["addCount"]) <= player.getInventoryItem(jobData.item["itemName"]).limit then
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = messages[setLocale]['havePackaged']..jobData.item["addCount"].."x "..ESX.GetItemLabel(jobData.item["itemName"])})
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['itemLimit']})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['itemLimit']})
                end
            elseif jobData.item["process"] == "sell" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                    player.addMoney(jobData.item["price"])
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Ha vendido "..jobData.item["removeCount"].."x "..ESX.GetItemLabel(jobData.item["requiredItem"]).. " for $"..jobData.item["price"]})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['notEnoughItem']})
                end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = messages[setLocale]['possExec']})
            print("[cylex_jobs] - ERROR - cylex_jobs:server:process Tried to query an item that isn't included in the 'items' table.") 
            print("[cylex_jobs] Item must be "..jobData.item["itemName"])
        end
    else
        print("[cylex_jobs] - WARNING - cylex_jobs:server:process event called without close to the process coords. User Identifier:"..player.identifier)
        DropPlayer(player.source, "Kicked for using exploit!")
    end
end)

ESX.RegisterServerCallback('cylex_jobs:checkCount', function(source, cb, itemName) 
    local player = ESX.GetPlayerFromId(source)
    local item = player.getInventoryItem(itemName)
    if item then
        --print(messages[setLocale]['test'])
        --print('count check sv f')
        --print(item.name)
        --print(item.count)
        cb(item.count)
    else
        --print('count check sv ff')
        --print(item)
        cb(0)
    end
end)
