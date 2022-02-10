BRIANPH = BRIANPH or {}
BRIANPH.deferralsHandler = BRIANPH.deferralsHandler or {}
BRIANPH.deferralsHandler.Utilities = BRIANPH.deferralsHandler.Utilities or {}

RegisterServerEvent('brianph-core:deferralsHandler:executeDeferrals')
AddEventHandler('brianph-core:deferralsHandler:executeDeferrals', function(src, playerName, setKickReason, deferrals)

    local pSrc = src
    deferrals.defer()

    local src   = source
    local steam = BRIANPH.deferralsHandler.Utilities.GetSteamIdentifier(pSrc)

    local connectingMessage = '[deferralsHandler] Welcome, ' .. playerName .. '. Your identifiers are being validated...'
    deferrals.update(connectingMessage)

    Wait(3000)

    if not steam then

        local steamMessage = '[deferralsHandler] Your Steam client wasn\'t detected! Please check if your Steam client is open or you might be having trouble with your internet connection'
        deferrals.done(steamMessage)

    else

        local checkMessage  = '[deferralsHandler] Now checking your information and status in the server database...'
        deferrals.update(checkMessage)

        Wait(3000)

        local a = [[SELECT * FROM core_users WHERE steam = @steam]]
        local b = {

            ['@steam']  = steam

        }

        MySQL.query(a, b, function(queryResult)

            for _, data in pairs(queryResult) do

                local status = data.status

                if status == 'banned' then

                    local bannedMessage = '[deferralsHandler] You are banned from connecting to the server! File a ticket in the Discord to appeal your ban.'
                    deferrals.done(bannedMessage)

                else

                    local successMessage = '[deferralsHandler] Validation successful! Connecting to server...'
                    deferrals.update(successMessage)

                    Wait(3000)

                    deferrals.done()

                end

            end

        end)

    end

end)

