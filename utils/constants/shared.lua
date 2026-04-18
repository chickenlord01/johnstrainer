--Loads ox_lib string into default LUA string | see https://coxdocs.dev/ox_lib/Modules/String/Shared#libstring
string = lib.string

--Initializes ox_lib locales
lib.locale()

--Initializes constants global table
constants = {}

--Ped appearance based constants
constants.pedComponents = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
constants.pedProps = {0, 1, 2, 6, 7}