fx_version 'adamant'

game 'gta5'

description 'Pixel Development OXY RUN'
lua54 'yes'
version '1.0'

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
} 

server_scripts {
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}

escrow_ignore {
	'config.lua'
}