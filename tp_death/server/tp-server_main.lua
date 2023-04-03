

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent("tp_death:deletePlayerContents")
AddEventHandler("tp_death:deletePlayerContents", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter

    local money, gold, cents = Character.money, Character.gold, Character.cents

    if Config.RemoveWeapons then 

        TriggerEvent("vorpCore:getUserWeapons", tonumber(_source), function(getUserWeapons)
           for k, v in pairs (getUserWeapons) do
            local id = v.id

            VorpInv.subWeapon(_source, v.id)

            exports.ghmattimysql:execute("DELETE FROM loadout WHERE id=@id", { ['id'] = id})
           end
        end)

    end

    if Config.RemoveItems then 

        TriggerEvent("vorpCore:getUserInventory", tonumber(_source), function(getInventory)
            for k, v in pairs (getInventory) do
                VorpInv.subItem(_source, v.name, v.count)  
            end
        end) 

    end

    if Config.Accounts.RemoveCash then 
        Character.removeCurrency(0, money)
    end

    if Config.Accounts.RemoveGold then 
        Character.removeCurrency(1, gold)
    end

end) 
