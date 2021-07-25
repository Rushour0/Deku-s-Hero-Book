
local scene = composer.newScene()

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


	-- Making a white background in the back
	local background = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,display.contentHeight)
	background:setFillColor(0)

	local load_heroes_button -- button to load the heroes' information

	local heroView -- rows of heroes

	local textField -- for name searching/viewing


	-- Button click template button right now
	local function buttonClick( event )
		phase = event.phase
		if (phase == "ended") then

			-- Loading the json file
			decoded, pos, msg = json.decodeFile( filename )

			if not decoded then
			    print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
			else

				print( "File successfully decoded!" )
				
				for name,Hero in pairs(decoded["Heroes"]) do
					The_Heroes[name] = Hero
				end

				table.sort(The_Heroes,compare)


				--for heroname,herotable in pairs(The_Heroes) do print(heroname) end -- Loop to print all heroes' names

				transition.to( load_heroes_button, { alpha = 0 } ) -- Making the clicked button fade away

				local color1 = { 0, 0, 1,0.3}
				local color2 = { 0, 0.4, 1, 0.5}
					
				local rowColor = { default=color1, over=color2 }
				-- Insert hero rows
				for hero_name,given_table in pairs(The_Heroes) do

					-- Insert a row into the heroView
					heroView:insertRow({id = hero_name, rowColor = rowColor })

				end
				transition.to(textField, {time = 100, y =-textField.y})
				

			end

		end
	end

	-- Create the widget
	load_heroes_button = widget.newButton(
		{
			label = "Load Heroes",
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
	
	load_heroes_button.alpha = next(The_Heroes) == nil and 1 or 0

	-- dislay rows with set color and height, width
	local function onRowRender( event )
 
		-- Get reference to the row group
		local row = event.row
		row.alpha = 0

		-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth

		local rowTitle = display.newText( row, row.id, 0, 0,"fonts/SuperMario256.ttf",16 )
		rowTitle:setFillColor( 1 )

		-- Align the label left and vertically centered

		rowTitle.x = display.contentCenterX
		rowTitle.y = rowHeight * 0.5

		transition.to(row,{alpha = 1})
	end

	local function onRowTouch( event )
		
		-- Get reference to the row group
		local row = event.row

	end

	-- Create the widget table - for scrolling through hero names
	heroView = widget.newTableView(
	    {
			hideBackground = true,
			left = 0,
			top = display.contentHeight/16,
			height = display.contentHeight-100,
			width = display.contentWidth,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
			rowTouchDelay = 0,
			noLines = true

	    }
	)
 
	local function textListener( event )

		if ( event.phase == "began" ) then
			-- User begins editing "textField"

		elseif ( event.phase == "ended" ) then
			-- Output resulting text from "textField"
			print( event.target.text )


		elseif (event.phase == "submitted") then
			print("submitted")
			event.target.text = ""

		elseif ( event.phase == "editing" ) then

		end
	end

	-- Create text field
	textField = native.newTextField( display.contentCenterX,-display.contentHeight/16+display.contentHeight/32,display.contentWidth*7/8,32 )
	textField.font = native.newFont( "Helvetica" ,24)
	textField:addEventListener( "userInput", textListener )
	textField:setReturnKey( "search" )
--[[
	-- Create text box
	textField = native.newTextBox( display.contentCenterX,display.contentCenterY, 180,200 )
	textField.isEditable = true
	textField.font = native.newFont( "Helvetica" ,16)
	textField:addEventListener( "userInput", textListener )
	textField:setReturnKey( "done" )
--]]

	sceneGroup:insert(background)
	sceneGroup:insert(heroView)
	sceneGroup:insert(load_heroes_button)
	sceneGroup:insert(textField)
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

