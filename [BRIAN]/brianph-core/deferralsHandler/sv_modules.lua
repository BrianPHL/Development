BRIANPH = BRIANPH or {}
BRIANPH.deferralsHandler = BRIANPH.deferralsHandler or {}
BRIANPH.deferralsHandler.Utilities = BRIANPH.deferralsHandler.Utilities or {}

function BRIANPH.deferralsHandler.Utilities.GetSteamIdentifier(src)

    -- ? Grabs the user's steam hex identifier and returns the result.

    local getIdentifier = GetPlayerIdentifiers(src)
    local steam

    for _, data in pairs(getIdentifier) do

        if string.match(data, 'steam:') then

            steam = data
            break

        end

    end

    return steam

end