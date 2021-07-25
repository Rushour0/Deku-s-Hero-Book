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

-- for k,v in pairs(native.getFontNames()) do print(k,v) end
-- load menu screen
composer.gotoScene( "hero_template" )


The_Heroes = {}

function compare( a, b )
	print(a,b)
    return a < b  -- Note "<" as the operator
end

-- File name from where the data is imported
filename = system.pathForFile( "Hero Book.json", system.ResourceDirectory )