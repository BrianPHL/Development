local decode = json.decode
local encode = json.encode

Connection = {
    Players    = {},
    Connecting = {},
    Queue      = {}
}

CreateThread(function()
    while true do
        Wait(2500)
        print(encode(Connection.Players))
    end
end)

AddEventHandler('playerConnecting', function(_, _, deferrals)

    deferrals.defer()
    
    local src           = source
    local playerName    = BP.getNameIdentifier(src)
    local playerSteam   = BP.getSteamIdentifier(src)
    local playerLicense = BP.getLicenseIdentifier(src)

    local defWelcome    = '👋 Welcome ' .. playerName .. ' [' .. playerSteam .. ']'
    local defNoSteam    = '🔴 No Steam identifier detected. Please check if your Steam client is running'
    local defUpdate     = '🟡 Verifying your identifier status in our database'
    local defBanned     = '🔴 You have been banned from connecting to the server'
    local defAccepted   = '🟢 Identifier status successfully validated! Enjoy ' .. playerName 

    Wait(1)

    deferrals.update(defWelcome)
    Wait(2000)

    if not playerSteam then

        deferrals.done(defNoSteam)
        CancelEvent()
        return

    end
    
    deferrals.update(defUpdate)
    Wait(3000)

    local function insertPlayer()

        local query  = [[INSERT INTO core_users (steamUsername, steamIdentifier, fivemLicense) VALUES (@steamUsername, @steamIdentifier, @fivemLicense)]]
        local params = {
            ['@steamUsername']   = playerName,
            ['@steamIdentifier'] = playerSteam,
            ['@fivemLicense']    = playerLicense
        }

        MySQL.insert(query, params)

        deferrals.update(defAccepted)
        Wait(3000)

        deferrals.done()

    end

    local function checkPlayer()

        local query  = [[SELECT * FROM core_users WHERE steamIdentifier = @steamIdentifier]]
        local params = {['@steamIdentifier'] = playerSteam }

        MySQL.query(query, params, function(queryResult)

            if next(queryResult) ~= nil then

                for _, data in pairs(queryResult) do

                    local userStatus = data.userStatus
                    
                    if userStatus ~= 'banned' then

                        deferrals.update(defAccepted)
                        Wait(3000)

                        deferrals.done()

                    end

                    deferrals.done(defBanned)
                    return

                end

            end

            insertPlayer()

        end)

    end

    checkPlayer()

end)

RegisterServerEvent('bp-core:playerConnected')
AddEventHandler('bp-core:playerConnected', function()

    local src        = source
    local srcMatch   = Connection.Players[src]
    local playerName = BP.getNameIdentifier(src)

    if not srcMatch then

        Connection.Players[src] = true
        print('(bp-core): ' .. playerName .. ' successfully connected')

    end

end)

AddEventHandler('playerDropped', function()

    local src        = source
    local srcMatch   = Connection.Players[src]
    local playerName = BP.getNameIdentifier(src)

    if srcMatch then

        -- TODO: add a function that saves the player's info
        -- TODO: last loc, bank bal, cash bal, items, & appearance

        Connection.Players[src] = nil
        print('(bp-core): ' .. playerName .. ' quit or disconnected')

    end

end)

