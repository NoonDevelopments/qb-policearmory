fx_version 'cerulean'
game 'gta5'

description 'Police Armory with NUI'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/*.js',
}

lua54 'yes'