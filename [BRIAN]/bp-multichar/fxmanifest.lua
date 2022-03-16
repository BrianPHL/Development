fx_version 'cerulean'
game 'gta5'

description 'bp-framework multi-character system'
author 'BrianPHL'

ui_page 'src/index.html'

files {
    'lib/jquery/js/*',
    'lib/fontawesome/css/*',
    'lib/fontawesome/webfonts/*',
    'lib/fontawesome/anims/*',
    'src/index.html',
    'src/css/*',
    'src/js/*'
}

client_scripts {
    'src/lua/cl_*'
}

server_scripts {
    'src/lua/sv_*'
}
