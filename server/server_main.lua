--                _
--               | |
--   _____      _| | _____  ___ _ __
--  / __\ \ /\ / / |/ / _ \/ _ \ '_ \
--  \__ \\ V  V /|   <  __/  __/ |_) |
--  |___/ \_/\_/ |_|\_\___|\___| .__/
--                             | |
--                             |_|
-- https://github.com/swkeep
local QBCore = exports['qb-core']:GetCoreObject()

-- functions

local function remove_item(src, Player, name, amount)
     local res = Player.Functions.RemoveItem(name, amount)
     TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove")
     return res
end

local function isAlreadyInstalled(plate)
     local stash = Config.gunrack.stash_prefix .. plate
     local result = MySQL.Sync.fetchScalar("SELECT EXISTS(SELECT id FROM gunrack WHERE stash= ?)", { stash })
     if result == 1 then return true else return false end
end



-- callbacks

local function HasItem(source, Player, item_name)
     local item = Player.Functions.GetItemByName(item_name)
     if item then
          TriggerClientEvent('QBCore:Notify', source, "You don't have a Gun Rack?!", 'error')
          return true
     end
     return false
end

QBCore.Functions.CreateUseableItem('policegunrack', function(source, item)
     local Player = QBCore.Functions.GetPlayer(source)
     if not Player then return end
     if not IsJobAllowed(Player.PlayerData.job.name) then
          TriggerClientEvent('QBCore:Notify', source, Lang:t('error.not_authorized'), "error")
          return
     end

     TriggerClientEvent('keep-gunrack:client:start_installing_gunrack', source)
end)




-- events     local result = MySQL.Sync.fetchScalar("SELECT EXISTS(SELECT name FROM ox_inventory WHERE name= ?)", { stash })

local function AddInitialItems(plate)
     local query = 'INSERT INTO gunrack (stash) VALUES (:stash)'
     MySQL.Sync.insert(query, {
          ['stash'] = Config.gunrack.stash_prefix .. plate,
     })
end

RegisterNetEvent('keep-gunrack:server:create_gunrack', function(plate)
     local src = source
     local Player = QBCore.Functions.GetPlayer(src)

     if not IsJobAllowed(Player.PlayerData.job.name) then
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_authorized'), "error")
          return
     end

     if isAlreadyInstalled(plate) then
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.already_installed'), "error")
          return
     end

     local _HasItem = HasItem(src, Player, 'policegunrack')
     if not _HasItem then return end

     if not remove_item(src, Player, 'policegunrack', 1) then
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.failed_to_use_gunrack'), "error")
          return
     end

          AddInitialItems(plate)

     
     exports.ox_inventory:RegisterStash(Config.gunrack.stash_prefix .. plate, Config.gunrack.stash_prefix .. plate, Config.gunrack.slots, Config.gunrack.size)
    
     TriggerClientEvent('QBCore:Notify', src, Lang:t('success.successful_installation'), "success")
     TriggerClientEvent('keep-gunrack:client:open_gunrack', src, plate)
end)

RegisterNetEvent('keep-gunrack:server:open_gunrack', function(plate)
     local src = source
     local Player = QBCore.Functions.GetPlayer(src)
     if not Player then return end
     if not IsJobAllowed(Player.PlayerData.job.name) then
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_authorized'), "error")
          return
     end

     if isAlreadyInstalled(plate) then
          if Config.gunrack.use_keys_to_unlock_gunrack then
               if does_player_have_keys(Player, plate) then
                    TriggerClientEvent('keep-gunrack:client:open_gunrack', src, plate)
               else
                    TriggerClientEvent('QBCore:Notify', src, Lang:t('error.dont_have_gunrack_keys'), "error")
               end
          else
               TriggerClientEvent('keep-gunrack:client:open_gunrack', src, plate)
          end
          return
     else
          TriggerClientEvent('QBCore:Notify', src, Lang:t('error.dont_have_a_gunrack'), "error")
          return
     end
end)
