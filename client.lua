local pidoras = false
local kurwa = false

RegisterNetEvent("BreakpointJail:JailPlayer")
AddEventHandler("BreakpointJail:JailPlayer", function(jailtime)
	if pidoras == true then
		return
	end
	local pP = PlayerPedId()
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, 1677.233, 2658.618, 45.216)
			pidoras = true
			kurwa = false
			while jailtime > 0 and not kurwa do
				pP = PlayerPedId()
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				Notify("You are currently in Jail")
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				if jailtime % 30 == 0 then
					TriggerEvent('chatMessage', 'BreakPoint Administration : ', { 245, 54, 54 }, jailtime .." minutes left until release.")
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local D = Vdist(1677.233, 2658.618, 45.216, pL['x'], pL['y'], pL['z'])
				if D > 90 then
					SetEntityCoords(pP, 1677.233, 2658.618, 45.216)
					if D > 100 then
						jailtime = jailtime + 60
						if jailtime > 1500 then
							jailtime = 1500
						end
						TriggerEvent('chatMessage', 'BreakPoint Administration', { 245, 54, 545 }, "Enjoy more jail time for being silly.")
					end
				end
				jailtime = jailtime - 0.5
			end
			SetEntityCoords(pP, 1855.807, 2601.949, 45.323)
			pidoras = false
			SetEntityInvincible(pP, false)
		end)
	end
end)

RegisterNetEvent("BreakpointJail:UnjailPlayer")
AddEventHandler("BreakpointJail:UnjailPlayer", function()
	kurwa = true
end)

RegisterNetEvent('BreakpointJail:noperms')
AddEventHandler('BreakpointJail:noperms', function()
    Notify("~r~NO ACCESS")
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end


Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/ajail', 'Adminjail a player', {
		{ name="Player ID", help="Player ID" },
		{ name="Seconds", help="Seconds" }
	})
	TriggerEvent('chat:addSuggestion', '/aunjail', 'Adminjail another player', {
		{ name="Player ID", help="Player ID" }
	})
end)