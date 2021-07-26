
local composer = require( "composer" )

local scene = composer.newScene()

local decoded
-- create()
function scene:create( event )

	local sceneGroup = self.view

	-- Making a white background in the back
	local back = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
	back:setFillColor(0)

	-- background.png is loaded as the background
	local background = display.newImage( "background.jpg",display.contentCenterX,display.contentCenterY )
	background.alpha = 0.9

	-- Loading the json file
	decoded, pos, msg = json.decodeFile( filename )

	if not decoded then
	    print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
	else

		print( "File successfully decoded!" )
	end

	sceneGroup:insert(back)
	sceneGroup:insert(background)

end

-- show()
function scene:show( event )

	sceneGroup = self.view
	local phase = event.phase

	local character_select -- character selecting table

	if ( phase == "will" ) then

		-- Go back to previous scene
		local function back_buttonClick( event )

			composer.gotoScene("character_types" , {effect = "crossFade",time = 400})
		end

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

		-- dislay rows with set color and height, width
		local function onRowRender( event )
	 		
			-- Get reference to the row group
			local row = event.row
			row.alpha = 0


			-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth

			local params = event.row.params

			if character_type_id == "U.A._Students" then
				
				params.rowTitle = display.newText( row, row.id , 0, 0,"fonts/Helvetica-Bold.ttf",16 )
				params.rowTitle:setFillColor( 0 )

			else
				params.rowTitle = display.newText( row, characters[character_type_id][row.id]["Alias"], 0, 0,"fonts/Helvetica-Bold.ttf",16 )
				params.rowTitle:setFillColor( 0 )
			end
			-- Align the label left and vertically centered

			params.rowTitle.x = display.contentCenterX
			params.rowTitle.y = rowHeight * 0.5

			transition.to(row,{alpha = 1})
		end

		local function onRowTouch( event )
			
			-- Get reference to the row group
			local row = event.row
			local params = event.row.params

			params.rowTitle:setFillColor(0.6)
			character_id = row.id

			--textField.alpha = 0
			print(event.phase)
			if event.phase == "release" then
				params.rowTitle:setFillColor(0)
				composer.gotoScene( "character_template", {effect = "crossFade",time = 400} )
			elseif event.phase == "cancelled" then
				params.rowTitle:setFillColor(0)
			end

		end

		-- Create the widget table - for scrolling through character names
		character_select = widget.newTableView(
		    {
				hideBackground = true,
				left = 0,
				top = display.contentHeight/16,
				height = display.contentHeight*15/16,
				width = display.contentWidth,
				onRowRender = onRowRender,
				onRowTouch = onRowTouch,
				rowTouchDelay = 0,
				noLines = false

		    }
		)

		if characters[character_type_id] == nil then
			characters[character_type_id] = {}
		end

		-- Loading the characters and their respective info
		for character_name,character_table in pairs(decoded["Complete Information"][character_type_id]) do
			characters[character_type_id][character_name] = character_table
		end
		
		local color1 = { 0.96, 0.96, 1,1}
		local color2 = { 0.96, 0.96, 1, 0.6}
			
		local rowColor = { default=color1, over=color2 }
		-- Insert character rows
		for character_name,given_table in pairs(characters[character_type_id]) do
			-- Insert a row into the character_select
			character_select:insertRow({id = character_name, rowColor = rowColor, params = { rowTitle = nil} })
		end

		sceneGroup:insert(character_select)
		sceneGroup:insert(back_button)

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
		composer.removeScene("character_type_template")


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
