--Loads ox_lib string into default LUA string | see https://coxdocs.dev/ox_lib/Modules/String/Shared#libstring
string = lib.string

--Initializes ox_lib locales
lib.locale()

--Initializes constants global table
constants = {}

--Ped appearance based constants
constants.pedComponents = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
constants.pedComponentNames = {
    "Head",
    "Masks",
    "Hair",
    "Upper body",
    "Lower body",
    "Bags & Parachutes",
    "Shoes",
    "Scarfs & Chains",
    "Shirts & Accessories",
    "Body Armor",
    "Badges & Logos",
    "Shirt overlay & Jackets"
}
constants.pedProps = {0, 1, 2, 6, 7}
constants.pedPropNames = {
    "Headwear",
    "Eyewear",
    "Ears",
    "Left wrist",
    "Right wrist"
}
constants.pedTattooZones = {
    ZONE_TORSO = 0,
	ZONE_HEAD = 1,
	ZONE_LEFT_ARM = 2,
	ZONE_RIGHT_ARM = 3,
	ZONE_LEFT_LEG = 4,
	ZONE_RIGHT_LEG = 5,
	ZONE_UNKNOWN = 6,
	ZONE_NONE = 7
}