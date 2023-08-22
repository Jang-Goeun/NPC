-----------------------------------------------------------------------------------------
--
-- ending.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	sceneGroup:insert(background)

 	local endingText = display.newText("실패", display.contentWidth*0.5, display.contentHeight*0.52, font_Content)
 	endingText.size = 200

	endingText:setFillColor(1, 0.185, 0.5)
	sceneGroup:insert(endingText)

	local retryText = display.newText("다시하기", display.contentWidth*0.5, display.contentHeight*0.72, font_Content)
 	retryText.size = 80
	retryText:setFillColor(1, 0.185, 0.5)
	sceneGroup:insert(retryText)

	local Text = display.newText("나가기", display.contentWidth*0.5, display.contentHeight*0.82, font_Content)
 	Text.size = 80
	Text:setFillColor(1, 0.185, 0.5)
	sceneGroup:insert(Text)


	local function re ( event )
		composer.gotoScene( "emptyScreen" )
	end
	retryText:addEventListener("tap", re)

	local function go ( event )
		composer.gotoScene( "computerScreen" )
	end
	Text:addEventListener("tap", go)

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
		composer.removeScene( "failEnding" )
	elseif phase == "did" then
		-- Called when the scene is now off screen

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene