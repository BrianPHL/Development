local decode = json.decode
local encode = json.encode

BPX = {
    Players    = {},
    Connecting = {},
    Queue      = {}
}

AddEventHandler('playerConnecting', function(_, _, deferrals)

    deferrals.defer()
    
    local src        = source
    local playerName = BPX.getNameIdentifier(src)
    local defWelcome = '[BPX]: 👋 Welcome ' .. playerName

    Wait(1)
    deferrals.update(defWelcome)
    local playerSteam = BPX.getSteamIdentifier(src)

    Wait(1000)

    if not playerSteam then

        local defNoSteam = '[BPX]: No Steam identifier detected. Please check if your Steam client is running.'
        deferrals.done(defNoSteam)
        CancelEvent()
        return

    end

    deferrals.done()

end)

AddEventHandler('playerDropped', function()

    local src        = source
    local srcMatch   = BPX.Players[src]
    local playerName = BPX.getNameIdentifier(src)

    if srcMatch then

        -- TODO: add a function that saves the player's info
        -- TODO: last loc, bank bal, cash bal, items, & appearance

        BPX.Players[src] = nil
        print('[BPX]: ' .. playerName .. ' quit or disconnected.')

    end

end)

