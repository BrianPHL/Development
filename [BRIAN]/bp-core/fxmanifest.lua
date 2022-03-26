fx_version 'cerulean'
game 'gta5'

description 'bp-framework core'
author 'BrianPHL'

-- oxmysql
server_script '@oxmysql/lib/MySQL.lua'

-- connection
client_script 'src/connection/sh_*'
server_script 'src/connection/sh_*'

dependency 'oxmysql'