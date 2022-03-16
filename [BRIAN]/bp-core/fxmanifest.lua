fx_version 'cerulean'
game 'gta5'

description 'bp-framework core resource'
author 'BrianPHL'

-- ? Modules !IMPORTANT
server_script 'src/lua/sv_modules.lua'

-- ? Connection
client_script 'src/lua/connection/cl_main.lua'
server_script 'src/lua/connection/sv_main.lua'

-- ? Gameplay
client_script 'src/lua/gameplay/cl_main.lua'
server_script 'src/lua/gameplay/sv_main.lua'

--? User
client_script 'src/lua/user/cl_main.lua'
server_script 'src/lua/user/sv_main.lua'