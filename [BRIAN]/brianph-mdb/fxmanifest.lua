fx_version 'cerulean'
game 'gta5'

description 'A twist on FiveM MDT'
author 'BrianPHL'

ui_page 'src/index.html'

files {
    'dist/jquery/js/*',
    'dist/fontawesome/css/*',
    'dist/fontawesome/webfonts/*',
    'dist/fontawesome/anims/*',
    'src/index.html',
    'src/assets/*',
    'src/css/*',
    'src/js/*'
}

client_scripts {
    'src/lua/cl_*'
}

server_scripts {
    'src/lua/sv_*'
}
