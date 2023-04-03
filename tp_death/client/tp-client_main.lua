RegisterNetEvent('vorp:PlayerForceRespawn')
AddEventHandler('vorp:PlayerForceRespawn', function()
  TriggerServerEvent('tp_death:deletePlayerContents')
end)