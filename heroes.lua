-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local json = require "json"
local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

The_Heroes = {}

--------------------------------------------
local infoGroup = display.newGroup()

function scene:create( event )
	local sceneGroup = self.view

	background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	local filename = system.pathForFile( "Hero Book.json", system.ResourceDirectory )

	local function buttonClick( event )
		phase = event.phase
		if (phase == "ended") then

			decoded, pos, msg = json.decodeFile( filename )

			if not decoded then
			    print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
			else

				print( "File successfully decoded!" )

				for _,Hero in pairs(decoded["Heroes"]) do
					The_Heroes[#The_Heroes+1] = Hero
				end

			end
			
			print("clicked")
		end
	end

	-- Create the widget
	button1 = widget.newButton(
		{
			label = "tap me",
			fontSize = 28,
			onEvent = buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
			strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
			strokeWidth = 4,
			x = display.contentCenterX,
			y = display.contentCenterY
		})


	sceneGroup:insert(background)
	sceneGroup:insert(button1)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
