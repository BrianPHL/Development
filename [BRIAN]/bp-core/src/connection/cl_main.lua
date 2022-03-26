CreateThread(function()

    while true do

        Wait(0)

        if NetworkIsSessionStarted() then
            TriggerServerEvent('bp-core:playerConnected')
            return
        end

    end

end)