
local scene = composer.newScene()

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Making a white background in the back
	local back = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
	back:setFillColor(0)

	-- background.png is loaded as the background
	local background = display.newImage( "background.jpg",display.contentCenterX,display.contentCenterY )
	background.alpha = 0.9

	local load_heroes_button,load_students_button,load_staff_button,load_villains_button -- buttons to load information

	-- Button click to determine character type and take to character selector
	local function load_characters_buttonClick( event )
		local phase = event.phase
		if (phase == "ended") then
			character_type_id = event.target.name

			composer.gotoScene( "character_type_template", {time = 400, effect = "crossFade"})
		end
	end
	
	-- Create the widget - Load Pro Heroes
	load_heroes_button = widget.newButton(
		{
			label = "Pro Heroes",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 28,
			onEvent = load_characters_buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,1,0.7}, over={0.6,0.6,0.6,0.4} },
			
			font = "fonts/Helvetica-Bold.ttf",x = display.contentCenterX,
			y = display.contentHeight/2
		})
	load_heroes_button.name = "Pro_Heroes"
	
	-- Create the widget - Load UA Staff
	load_staff_button = widget.newButton(
		{
			label = "U.A. Staff",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 28,
			onEvent = load_characters_buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,1,0.7}, over={0.6,0.6,0.6,0.4} },
			

			font = "fonts/Helvetica-Bold.ttf",x = display.contentCenterX,
			y = load_heroes_button.y + 50
		})
	load_staff_button.name = "U.A._Staff"

	-- Create the widget - Load UA Students
	load_students_button = widget.newButton(
		{
			label = "U.A. Students",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 28,
			onEvent = load_characters_buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,1,0.7}, over={0.6,0.6,0.6,0.4} },
			

			font = "fonts/Helvetica-Bold.ttf",x = display.contentCenterX,
			y = load_staff_button.y + 50
		})
	load_students_button.name = "U.A._Students"

	-- Create the widget - Load Villains
	load_villains_button = widget.newButton(
		{
			label = "Villains",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 28,
			onEvent = load_characters_buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,1,0.7}, over={0.6,0.6,0.6,0.4} },
			

			font = "fonts/Helvetica-Bold.ttf",x = display.contentCenterX,
			y = load_students_button.y+50
		})
	load_villains_button.name = "Villains"

	-- Create the widget - Load Vigilantes
	load_vigilantes_button = widget.newButton(
		{
			label = "Vigilantes",
			labelColor = {default={0,0,0,1}, over={0.5,0.5,0.5,1}},
			fontSize = 28,
			onEvent = load_characters_buttonClick,
			emboss = false,
			-- Properties for a rounded rectangle button
			shape = "roundedRect",
			width = 200,
			height = 40,
			cornerRadius = 2,
			fillColor = { default={1,1,1,0.7}, over={0.6,0.6,0.6,0.4} },
			

			font = "fonts/Helvetica-Bold.ttf",x = display.contentCenterX,
			y = load_villains_button.y+50
		})
	load_vigilantes_button.name = "Vigilantes"

	
	sceneGroup:insert(back)
	sceneGroup:insert(background)
	sceneGroup:insert(load_heroes_button)
	sceneGroup:insert(load_staff_button)
	sceneGroup:insert(load_students_button)
	sceneGroup:insert(load_villains_button)
	sceneGroup:insert(load_vigilantes_button)
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
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

