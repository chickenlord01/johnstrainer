fx_version 'cerulean'
games { 'gta5' }

author 'John | https://github.com/chickenlord01'
description 'Lua replacement for vMenu'
version '0.0.1'
lua54 'yes'

dependencies {
    'ox_lib'
}

shared_script '@ox_lib/init.lua'

shared_scripts {
    'utils/**/shared.lua',
    'modules/**/shared.lua'
}

client_scripts {
    'utils/**/client.lua',
    'init/client.lua',
    'modules/**/client.lua'
}

server_scripts {
    'utils/**/server.lua',
    'init/server.lua',
    'modules/**/server.lua'
}

files {
    'locales/*.json'
}