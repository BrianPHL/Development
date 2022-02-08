BRIANPH = BRIANPH or {}
BRIANPH.UserHandler = BRIANPH.userHandler or {}
BRIANPH.UserHandler.Utilities = BRIANPH.UserHandler.Utilities or {}

-- ? server/sv_userHandler.lua functions module;
-- ? might migrate into a more globally available modules file.

function BRIANPH.UserHandler.Utilities.GetSteamIdentifier(src)

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

function BRIANPH.UserHandler.Utilities.GetLicenseIdentifier(src)

    -- ? Grabs the user's FiveM license identifier and returns the result.

    local getIdentifier = GetPlayerIdentifiers(src)
    local license
    
    for _, data in pairs(getIdentifier) do
    
        if string.match(data, 'license:') then

            license = data
            break

        end

    end

    return license

end

function BRIANPH.UserHandler.Utilities.GetNameIdentifier(src)

    -- ? Grabs the user's Steam username identifier and returns the result.

    username = GetPlayerName(src)

    return username

end