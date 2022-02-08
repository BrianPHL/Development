fx_version 'cerulean'
game 'gta5'

-- ? deferralsHandler

    server_script 'deferralsHandler/sv_main.lua'
    server_script 'deferralsHandler/sv_modules.lua'

-- ? userHandler

    client_script 'userHandler/cl_main.lua'
    server_script 'userHandler/sv_main.lua'
    server_script 'userHandler/sv_modules.lua'

-- ? OxMySQL connection

    server_script '@oxmysql/lib/MySQL.lua'

-- ? Dependencies

    dependency 'oxmysql'