
discordwebhooklink = "discordwebhookinhere"


local jailtime = Config.defaultTime
local maxtime = Config.maxTime

RegisterCommand("aunjail", function(source, args, raw)
	if IsPlayerAceAllowed(source, "jail.commands") then
	if #args <= 0 then
		TriggerClientEvent('chatMessage', source, "Please use this format:", {255, 0, 0}, "/unjail [Player ID]")
	else
	local jpid = tonumber(args[1])
	if GetPlayerName(jpid) ~= nil then
		TriggerClientEvent('chatMessage', source, 'BreakPoint Administration', { 245, 54, 54 }, "Successfully unjailed ^2" .. GetPlayerName(jpid) .."")
        TriggerClientEvent("BreakpointJail:UnjailPlayer", jpid)
		local steam = GetPlayerName(source)
		local jplayer = GetPlayerName(jpid)
		sendLog("User Unjailed (/unjail)", "**User:** ".. steam .."\n**Unjailed by:** ".. steam .."")
	end
end
else
	TriggerClientEvent('BreakpointJail:noperms', source)
end
end, false)


RegisterCommand("ajail", function(source, args, raw)
	if IsPlayerAceAllowed(source, "jail.commands") then
	if #args <= 0 then
		TriggerClientEvent('chatMessage', source, "Please use this format:", {255, 0, 0}, "/jail [Player ID] [Seconds]")
	else
	local jpid = tonumber(args[1])
	if args[2] ~= nil then
		jailtime = tonumber(args[2])				
	end
	if jailtime > maxtime then
		jailtime = maxtime
	end
	if GetPlayerName(jpid) ~= nil then
		TriggerClientEvent("BreakpointJail:JailPlayer", jpid, jailtime)
		TriggerClientEvent('chatMessage', -1, 'BreakPoint Administration', { 245, 54, 54 }, GetPlayerName(jpid) ..' jailed for '.. jailtime ..' secs')
		local steam = GetPlayerName(source)
		local jplayer = GetPlayerName(jpid)
		sendLog("User Jailed (/jail)", "**User:** ".. jplayer .."\n**Time:** ".. jailtime .." seconds\n**Jailed by:** ".. steam .."")
	end
end
else
	TriggerClientEvent('BreakpointJail:noperms', source)
end
end, false)

function sendLog(name, message)
	local content = {
        {
        	["color"] = '14561591',
            ["author"] = {
		        ["name"] = "".. name .."",
		        ["icon_url"] = 'https://avatars.fastly.steamstatic.com/4b8d5d5d0dfc53049f3deb558d5f8a58561154fc_full.jpg',
		    },
            ["description"] = message,
            ["footer"] = {
            ["text"] = "",
            }
        }
    }
  	PerformHttpRequest(discordwebhooklink, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end