local decode = json.decode
local encode = json.encode

BPX = {
    Players    = {},
    Connecting = {},
    Queue      = {}
}

AddEventHandler('playerDropped', function()

    local src        = source
    local srcMatch   = BPX.Players[src]
    local playerName = BPX.getNameIdentifier(src)

    if srcMatch then

        -- TODO: add a function that saves the player's info
        -- TODO: last loc, bank bal, cash bal, items, & appearance

        BPX.Players[src] = nil
        print('[BPX] ' .. playerName .. ' quit or disconnected.')

    end

end)

