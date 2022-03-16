fx_version 'cerulean'
game 'gta5'

-- ! IMPORTANT: globalModules

    server_script 'sv_globalModules.lua'
    client_script 'cl_globalModules.lua'

-- ? queueHandler

    client_script 'queueHandler/cl_main.lua'
    server_script 'queueHandler/sv_main.lua'

-- ? deferralsHandler

    server_script 'deferralsHandler/sv_main.lua'

-- ? userHandler

    client_script 'userHandler/cl_main.lua'
    server_script 'userHandler/sv_main.lua'

-- ? OxMySQL connection

    server_script '@oxmysql/lib/MySQL.lua'

-- ? Dependencies

    dependency 'oxmysql'