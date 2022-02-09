AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)

    local src = source
    TriggerEvent('brianph-core:deferralsHandler:executeDeferrals', src, playerName, setKickReason, deferrals)

end)
