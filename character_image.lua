
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view

	-- Making a white background in the back
	local back = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
	back:setFillColor(1)

	-- background.png is loaded as the background
	local background = display.newImage( "background.jpg",display.contentCenterX,display.contentCenterY )
	background.alpha = 0.9

	sceneGroup:insert(back)
	sceneGroup:insert(background)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	local image

	local function back_buttonClick( event )

		composer.gotoScene("character_template" , {effect = "crossFade",time = 400})
	end

	if ( phase == "will" ) then

		
		-- Create the widget
		back_button = widget.newButton(
			{
				label = "Back",
				labelColor = {default={1,1,1,1}, over={0.8,0.8,0.8,1}},
				fontSize = 16,
				onEvent = back_buttonClick,
				emboss = false,
				-- Properties for a rounded rectangle button
				shape = "roundedRect",
				width = 60,
				height = 40,
				cornerRadius = 2,
				fillColor = { default={0,0,0,1}, over={0.6,0.6,0.6,0.4} },
				x = 30,
				y = 20
			})

		local image = display.loadRemoteImage( characters[character_type_id][character_id][], "GET", networkListener, character_id .. ".png", system.ApplicationSupportDirectory, display.contentCenterX, display.contentCenterY )
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
	sceneGroup:insert(image)
	sceneGroup:insert(back_button)
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
