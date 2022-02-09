BRIANPH = BRIANPH or {}
BRIANPH.deferralsHandler = BRIANPH.deferralsHandler or {}
BRIANPH.deferralsHandler.Utilities = BRIANPH.deferralsHandler.Utilities or {}

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

    deferrals.defer()

    local src   = source
    local steam = BRIANPH.deferralsHandler.Utilities.GetSteamIdentifier(src)

    deferrals.update(string.format(" 👋 Hello, " ..playerName .. "! We are now checking your information..."))

    Wait(1000)

    if not steam then

        local steamMessage = '🚫 Your Steam client wasn\'t detected! Please check if your Steam client is open or if you have weak internet connection.'
        deferrals.done(steamMessage)

    else

        local checkMessage  = '🐢 Now validating your information through our database...'
        deferrals.update(checkMessage)

        Wait(1000)

        local a = [[SELECT * FROM core_users WHERE steam = @steam]]
        local b = {

            ['@steam']  = steam

        }

        MySQL.query(a, b, function(queryResult)

            for _, data in pairs(queryResult) do

                local status = data.status

                if status == 'banned' then

                    local bannedMessage = '🚫 You are banned from connecting to our server! File a ticket in the Discord to appeal your ban.'
                    deferrals.done(bannedMessage)

                else

                    local successMessage = '✔️ Validation successful! Connecting to server...'
                    deferrals.update(successMessage)

                    Wait(1000)

                    deferrals.done()

                end

            end

        end)

    end

end)
