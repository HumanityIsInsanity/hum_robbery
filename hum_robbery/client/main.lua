local QRCore = exports['qr-core']:GetCoreObject()
local robtime = 120 -- Time to rob (in seconds) now its 3.3mins
local timerCount = robtime
local isRobbing = false
local timers = false
local storetimer = nil
local storenumber = nil
local hasShot = nil
local inRange = false
local anticheat = nil

RegisterNetEvent("Witness:ToggleNotification2")
AddEventHandler("Witness:ToggleNotification2", function(coords, alert)
----------------------------------Telegram Alerts Will Go Here---------------------------------- 
print(alert)
end)
---------------------------------- Draw Text 2d & 3d---------------------------------- 
function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)

	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 215)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	SetTextCentre(1)
	DisplayText(str,_x,_y)
end

	function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

---------------------------------- Robbery Start Loop ---------------------------------- 
Citizen.CreateThread(function() 
    while true do
	Citizen.Wait(0)	
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for i = 1, #Config.Shops do
			currentshop = i
			if GetDistanceBetweenCoords(coords, Config.Shops[currentshop].coords.x, Config.Shops[currentshop].coords.y, Config.Shops[currentshop].coords.z, true)  < 5.2 then
				local distance = GetDistanceBetweenCoords(coords, Config.Shops[currentshop].coords.x, Config.Shops[currentshop].coords.y, Config.Shops[currentshop].coords.z, true)
				
				if hasShot == true then
				    DrawText3D(Config.Shops[currentshop].coords.x, Config.Shops[currentshop].coords.y, Config.Shops[currentshop].coords.z + 1.5, Config.Register)
				end
				if Citizen.InvokeNative(0xCB690F680A3EA971, playerPed,4) then -- Checks if ped is holding a weapon
					if isRobbing == false then
						DrawText3D(Config.Shops[currentshop].coords.x, Config.Shops[currentshop].coords.y, Config.Shops[currentshop].coords.z +1.5, Config.StartRob) 
						
					end					
				if	IsPedShooting(playerPed) then
						isRobbing = true
						hasShot = true
						anticheat = GetEntityCoords(playerPed)
					end
				if hasShot == true then
					if IsControlJustReleased(0, 0x760A9C6F) then
						print("Pressed [G] ")
						TriggerServerEvent("hum_robbery:startToRob", function()
						end)
				        Wait(1000)
						TaskPlayAnim(PlayerPedId(), "amb_work@world_human_crouch_inspect@male_c@idle_a", "idle_c", 8.0, -8.0, -1, 1, 0, false, false, false)
					end			
				end
				if hasCompleted == true then
					Wait(Config.RobberyTime - 3000)			
					TriggerServerEvent("hum_robbery:payout", function(playerPed, coords)
					end)
					Wait(Config.Cooldown)
				end
				
				else
					
				end
			else
			end
		end
	end
end)


function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end


RegisterNetEvent('hum_robbery:startAnimation')
AddEventHandler('hum_robbery:startAnimation', function()	
	local _source = source
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local testplayer = exports["syn_minigame"]:taskBar(4000,7)
    local testplayer2
    local testplayer3
    local testplayer4
    Wait(1000)
    if testplayer == 100 then
    testplayer2 = exports["syn_minigame"]:taskBar(3500,7)
    end
    Wait(1000)
    if testplayer2 == 100 then
    testplayer3 = exports["syn_minigame"]:taskBar(3200,7)
    end
    Wait(1000)
    if testplayer3 == 100 then
    testplayer4 = exports["syn_minigame"]:taskBar(2900,7)
    end
    if testplayer4 == 100 then   
	TaskStartScenarioInPlace(playerPed, GetHashKey('world_human_shop_browse_counter'), 120000, true, false, false, false)
    Citizen.Wait(1000)
	QRCore.Functions.Progressbar("ROBBERRRYYYY", ("ROBBERY BABY"), Config.RobberyTime, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function() 
	end)
	print(coords)
	print(anticheat)
	Citizen.Wait(1000)
	ClearPedTasks(PlayerPedId())
	ClearPedSecondaryTask(PlayerPedId())
    Citizen.Wait(4000)
	isRobbing = false
	hasShot = false
	hasCompleted = true

    end        
end)
