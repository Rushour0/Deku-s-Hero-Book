-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


-- include the Corona "composer" module
composer = require "composer"

-- include "json" library
json = require "json"

-- include Corona's "widget" library
widget = require "widget"

function compare( a, b )
	print(a,b)
    return a < b  -- Note "<" as the operator
end

characters = {}

character_type_id = ""
character_id = ""

-- File name from where the data is imported
filename = system.pathForFile( "Hero Book.json", system.ResourceDirectory )

-- for k,v in pairs(native.getFontNames()) do print(k,v) end
-- load menu screen
composer.gotoScene( "character_types" )
