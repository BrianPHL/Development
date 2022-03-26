fx_version 'cerulean'
game 'gta5'

description 'bp-framework core'
author 'BrianPHL'

-- Oxmysql
server_script '@oxmysql/lib/MySQL.lua'

-- BP prefix
client_script 'src/sh_prefix.lua'
server_script 'src/sh_prefix.lua'

-- Connection handler
server_script 'src/connection/sv_modules.lua'
server_script 'src/connection/sv_main.lua'
client_script 'src/connection/cl_main.lua'

-- Dependencies
dependency 'oxmysql'

-- Provides
provide 'core'