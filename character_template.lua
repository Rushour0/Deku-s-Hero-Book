-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local scene = composer.newScene()

local character_view

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
	
	local function back_buttonClick( event )

		composer.gotoScene("character_type_template" , {effect = "crossFade",time = 400})
	end

	local function image_buttonClick( event )

		composer.gotoScene("character_image" , {effect = "crossFade",time = 400})
	end
	
	if phase == "will" then
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
--[[
		-- Create the widget
		image_button = widget.newButton(
			{
				label = "View image",
				labelColor = {default={1,1,1,1}, over={0.8,0.8,0.8,1}},
				fontSize = 16,
				onEvent = image_buttonClick,
				emboss = false,
				-- Properties for a rounded rectangle button
				shape = "roundedRect",
				width = 80,
				height = 40,
				cornerRadius = 2,
				fillColor = { default={0,0,0,1}, over={0.6,0.6,0.6,0.4} },
				x = display.contentWidth - 40,
				y = 20
			})
]]

	
		-- dislay rows with set color and height, width
		local function onRowRender( event )
	 		
			-- Get reference to the row group
			local row = event.row
			row.alpha = 0

			local params = event.row.params
			-- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth

			if row.id ~= "Image" then
				params.rowTitle = display.newText( row, row.id .. " : " .. characters[character_type_id][character_id][row.id], 0, 0, "fonts/Helvetica-Bold.ttf" ,16 )
				params.rowTitle:setFillColor( 1 )
				-- Align the label left and vertically centered

				params.rowTitle.x = display.contentCenterX
				params.rowTitle.y = rowHeight * 0.5

			else

				local function networkListener( event )
					if ( event.isError ) then
						print( "Network error - download failed: ", event.response )
					elseif ( event.phase == "began" ) then
						print( "Progress Phase: began" )
					elseif ( event.phase == "ended" ) then
						print( "Displaying response image file" )
						myImage = display.newImage( row,event.response.filename, event.response.baseDirectory, display.contentCenterX,rowHeight*0.5)
						myImage.alpha = 0
						transition.to( myImage, { alpha=1.0 } )
					end
				end

				--print(characters[character_type_id][character_id]["Image"])
				image_name = character_id .. ".png"
				print(characters[character_type_id][character_id]["Image"])

				local path = system.pathForFile( image_name, system.ApplicationSupportDirectory )

				-- Open the file from the path
				local fh, reason = io.open( path, "r" )
				print(path)

				if fh then
					print("here")
					myImage = display.newImage(row,image_name,system.ApplicationSupportDirectory,display.contentCenterX,rowHeight*0.5)
					myImage.alpha = 0
					transition.to( myImage, { alpha=1.0 } )					
					
				else
					local params = {}
					params.progress = true

					network.download( characters[character_type_id][character_id]["Image"], "GET", networkListener,params, image_name, system.ApplicationSupportDirectory)
					print("nope")
				end

			end



			transition.to(row,{alpha = 1})

		end

		local function onRowTouch( event )
			-- Get reference to the row group
			local row = event.row
		end

		-- Create the widget table - for viewing properties of the character
		character_view = widget.newTableView(
		    {
				hideBackground = true,
				left = 0,
				top = display.contentHeight/16,
				height = display.contentHeight*15/16,
				width = display.contentWidth,
				onRowRender = onRowRender,
				onRowTouch = onRowTouch,
				rowTouchDelay = 0,
				noLines = true

		    }
		)
	 	
	 	local color1 = { 0.2, 0.2, 0.2, 1}
		local color2 = { 0.2, 0.2, 0.2, 1}
			
		local rowColor = { default=color1, over=color2 }
		
		character_view:insertRow({rowHeight = 500,id = "Image", rowColor = rowColor, params = {rowTitle = nil}})

	 	for attr,value in pairs(characters[character_type_id][character_id]) do
	 		if attr ~= "Image" then
	 		character_view:insertRow({id = attr, rowColor = rowColor, params = {rowTitle = nil, image = nil}}) end
	 	end

		sceneGroup:insert(character_view)
		sceneGroup:insert(back_button)
			
			
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end


end

-- hide()
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("character_template")
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen


	end	
end

-- destroy()
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
