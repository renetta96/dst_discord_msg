local webhook_url

GLOBAL.SetDiscordWebhook = function(url)
	TheSim:SetPersistentString("Discord_Webhook_URL.txt", url, false, nil)
	webhook_url = url
	if not string.starts(url, "https://discordapp.com/api/webhooks/") then
		print("WARNING: This Discord webhook url doesn't look right!")
		print("  It's supposed to start with \"https://discordapp.com/api/webhooks/\".")
	else
		print("Webhook url set! The mod should work now. :3")
	end
end

GLOBAL.PrintDiscordWebhook = function(url)
	print(webhook_url)
end

function ReportMissingWebhook()
	print("WARNING: Could not load webhook url for Discord Announcements!")
	print("  The mod will not work until you set the webhook url.")
	print("  Set the url with the command SetDiscordWebhook(url)")
	print("  and make sure the url is in quotes.")
	print("  Like this:")
	print("    SetDiscordWebhook(\"https://discordapp.com/api/webhooks/734950925428326401/3ni3djnasd\")")
end

GLOBAL.SendDiscordMessage = function(msg)
	if not webhook_url then
		ReportMissingWebhook()
		return
	end
	TheSim:QueryServer(
	webhook_url,
		function(...)
			print("Announcing death to Discord.. :3")
			print(...)
		end,
		"POST",
		--dst's version of the json library erroneously escapes single quotes. this gsub fixes that. goofy, huh?
		GLOBAL.json.encode({
			content = string.gsub(msg,"'","’"),
			avatar_url = "https://cdn.discordapp.com/attachments/411973405349249025/735308819508232242/unknown.png"
		})
	)
end

GLOBAL.SendDiscordDeathMessage = function(msg, character)
	local character_icons = {
		-- Supports some character mods. Let me know if you want me to add yours.
		-- Thanks Chévre (Goat Slice) for getting these icons for me! ^^
		unknown = "https://cdn.discordapp.com/attachments/242336026251493376/735280247464788028/avatar_unknown.png",
		charlie = "https://media.discordapp.net/attachments/381234050632908801/735364619551637646/avatar_charlie.png",
		wagstaff = "https://cdn.discordapp.com/attachments/735356544174260255/735358342112870430/avatar_wagstaff.png",
		walani = "https://cdn.discordapp.com/attachments/242336026251493376/735280248593186927/avatar_walani.png",
		walter = "https://cdn.discordapp.com/attachments/242336026251493376/735280250539343902/avatar_walter.png",
		warly = "https://cdn.discordapp.com/attachments/242336026251493376/735280252397289552/avatar_warly.png",
		waxwell = "https://cdn.discordapp.com/attachments/242336026251493376/735280253974478858/avatar_waxwell.png",
		wearger = "https://cdn.discordapp.com/attachments/242336026251493376/735280255673172018/avatar_wearger.png",
		webber = "https://cdn.discordapp.com/attachments/242336026251493376/735280257107755078/avatar_webber.png",
		weerclops = "https://cdn.discordapp.com/attachments/242336026251493376/735280258617573386/avatar_weerclops.png",
		wendy = "https://cdn.discordapp.com/attachments/242336026251493376/735280259863281775/avatar_wendy.png",
		wes = "https://cdn.discordapp.com/attachments/242336026251493376/735280260903469166/avatar_wes.png",
		wheeler = "https://cdn.discordapp.com/attachments/735356544174260255/735358338656763965/avatar_wheeler.png",
		wickerbottom = "https://cdn.discordapp.com/attachments/242336026251493376/735280261994119218/avatar_wickerbottom.png",
		wathgrithr = "https://cdn.discordapp.com/attachments/242336026251493376/735280263139033108/avatar_wigfrid.png",
		wilba = "https://cdn.discordapp.com/attachments/735356544174260255/735358331748745266/avatar_wilba.png",
		wilbur = "https://cdn.discordapp.com/attachments/242336026251493376/735280264405843988/avatar_wilbur.png",
		willow = "https://cdn.discordapp.com/attachments/242336026251493376/735280365790429194/avatar_willow.png",
		wilson = "https://cdn.discordapp.com/attachments/242336026251493376/735280368583966810/avatar_wilson.png",
		winona = "https://cdn.discordapp.com/attachments/242336026251493376/735280371343556678/avatar_winona.png",
		wolfgang = "https://cdn.discordapp.com/attachments/242336026251493376/735280374325837974/avatar_wolfgang.png",
		woodie = "https://cdn.discordapp.com/attachments/242336026251493376/735280376796282981/avatar_woodie.png",
		woodlegs = "https://cdn.discordapp.com/attachments/242336026251493376/735280379270922310/avatar_woodlegs.png",
		woose = "https://cdn.discordapp.com/attachments/242336026251493376/735280382332633179/avatar_woose.png",
		wormot = "https://media.discordapp.net/attachments/381234050632908801/735363977118482442/avatar_wormot.png",
		wormwood = "https://cdn.discordapp.com/attachments/242336026251493376/735280384891289721/avatar_wormwood.png",
		wortox = "https://cdn.discordapp.com/attachments/242336026251493376/735280387378380890/avatar_wortox.png",
		wragonfly = "https://cdn.discordapp.com/attachments/242336026251493376/735280392768323654/avatar_wragonfly.png",
		wurt = "https://cdn.discordapp.com/attachments/242336026251493376/735280434950176778/avatar_wurt.png",
		wx78 = "https://cdn.discordapp.com/attachments/242336026251493376/735280438947610754/avatar_wx78.png",
		zeta = "https://cdn.discordapp.com/attachments/746763081346056275/746768784072769647/zeta.png"
	}
	if not webhook_url then
		ReportMissingWebhook()
		return
	end
	TheSim:QueryServer(
		webhook_url,
		function(...)
			print("Announcing death to Discord.. :3")
			print(...)
		end,
		"POST",
		--dst's version of the json library erroneously escapes single quotes. this gsub fixes that. goofy, huh?
		GLOBAL.json.encode({
			username = string.gsub(GLOBAL.TheNet:GetServerName(),"'","’"),
			embeds = {
				{
					author = {
						name = string.gsub(msg,"'","’"), -- abusing author field
						icon_url = character_icons[character] or character_icons.unknown
					}
				}
			},
			avatar_url = "https://cdn.discordapp.com/attachments/411973405349249025/735308819508232242/unknown.png"
		})
	)
end

GLOBAL.TheSim:GetPersistentString("Discord_Webhook_URL.txt", function(load_success, str)
	if load_success == true then
		webhook_url = str
	else
		ReportMissingWebhook()
	end
end)

AddPlayerPostInit(function(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return
	end

	inst:ListenForEvent("death", function(inst,data)
		--from player_common_extensions.lua
		local deathcause = data ~= nil and data.cause or "unknown"
		local deathpkname
		local deathbypet

		if data == nil or data.afflicter == nil then
			deathpkname = nil
		elseif data.afflicter.overridepkname ~= nil then
			deathpkname = data.afflicter.overridepkname
			deathbypet = data.afflicter.overridepkpet
		else
			local killer = data.afflicter.components.follower ~= nil and data.afflicter.components.follower:GetLeader() or nil
			if killer ~= nil and
				killer.components.petleash ~= nil and
				killer.components.petleash:IsPet(data.afflicter) then
				deathbypet = true
			else
				killer = data.afflicter
			end
			deathpkname = killer:HasTag("player") and killer:GetDisplayName() or nil
		end

		local announcement_string = GLOBAL.GetNewDeathAnnouncementString(
			inst,
			deathcause,
			deathpkname,
			deathbypet
		)
		GLOBAL.SendDiscordDeathMessage(announcement_string, inst.prefab)
	end)

	inst:ListenForEvent('respawnfromghost', function(inst, data)
		local rezsource =
        data ~= nil and (
            (data.source ~= nil and data.source.prefab ~= "reviver" and data.source:GetBasicDisplayName()) or
            (data.user ~= nil and data.user:GetDisplayName())
        ) or
        GLOBAL.STRINGS.NAMES.SHENANIGANS
    local announcement_string = GLOBAL.GetNewRezAnnouncementString(inst, rezsource)
    GLOBAL.SendDiscordDeathMessage(announcement_string, inst.prefab)
	end)
end)

AddPrefabPostInit('world', function(world)
	if not world.ismastersim then
		return
	end

	world:ListenForEvent('ms_playerjoined', function(src, player)
		local joinstring = string.format(GLOBAL.STRINGS.UI.NOTIFICATION.JOINEDGAME, player:GetDisplayName())
		GLOBAL.SendDiscordDeathMessage(joinstring, player.prefab)
	end)

	world:ListenForEvent('ms_playerleft', function(src, player)
		local leftstring = string.format(GLOBAL.STRINGS.UI.NOTIFICATION.LEFTGAME, player:GetDisplayName())
		GLOBAL.SendDiscordDeathMessage(leftstring, player.prefab)
	end)
end)
