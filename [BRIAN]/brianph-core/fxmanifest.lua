fx_version 'cerulean'
game 'gta5'

-- * userHandlers
client_script 'client/cl_userHandler.lua'
server_script 'server/sv_userHandler.lua'

-- * OxMySQL connection
server_script '@oxmysql/lib/MySQL.lua'

-- * Dependencies

dependency 'oxmysql'