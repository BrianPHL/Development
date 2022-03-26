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
    
    local src         = source
    local playerName  = BP.getNameIdentifier(src)
    local playerSteam = BP.getSteamIdentifier(src)
    local defWelcome  = '(bp-core): 👋 Welcome ' .. playerName .. '[ ' .. playerSteam .. ' ]'

    Wait(1)
    deferrals.update(defWelcome)

    Wait(1000)

    if not playerSteam then

        local defNoSteam = '(bp-core): No Steam identifier detected. Please check if your Steam client is running'
        deferrals.done(defNoSteam)
        CancelEvent()
        return

    end

    deferrals.done()

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

