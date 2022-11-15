local QRCore = exports['qr-core']:GetCoreObject()


Locations = {
    vector3(-324.26, 804.1, 117.93),
    vector3(2825.2976074219, -1320.1049804688, 45.755676269531),
    vector3(-785.47, -1323.85, 43.9),
    vector3(-1789.34, -387.5, 160.37),
    vector3(-3687.2, -2622.31, -13.3), 
    vector3(-5486.33, -2937.6, -0.35),
    vector3(1328.03, -1293.70,  77.07),

}
RegisterNetEvent("hum_robbery:startToRob")
AddEventHandler("hum_robbery:startToRob", function(robtime)
    local _source = source
    local Player = QRCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("lockpick") then       
        -- playerjobloop()      
        TriggerClientEvent('hum_robbery:startAnimation', source)
        print("robbery started")
        --TriggerClientEvent("vorp:TipBottom", _source, "Sheriffs Have Been Alerted",6000)
    else
        --TriggerClientEvent("vorp:TipBottom", _source, "You dont have a lockpick", 6000)
        print("No Lockpick")
    end     
end)

RegisterNetEvent("hum_robbery:payout")
AddEventHandler("hum_robbery:payout", function()
    local Player = QRCore.Functions.GetPlayer(source)
    local name = Player.PlayerData.name
    local randomitempull = math.random(1, #Config.Items)
    
    print(Player,name,"has successfully robbed a general store") 
    Player.Functions.AddMoney('cash', Config.Payout)
    hasCompleted = false

end)



RegisterNetEvent("policenotify")
AddEventHandler("policenotify", function(players, coords, alert)
    print("law notified")
end)


            
      

