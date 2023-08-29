-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local backgroundY = composer.getVariable("backgroundY")

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)


	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1820, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(restart)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	local image = display.newImage("image/저택그림/액자1.png")
	image.x, image.y = display.contentCenterX, display.contentCenterY

	sceneGroup:insert(image)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local function back(event)
		composer.hideOverlay("1층.key_lockingImage_1")
		composer.gotoScene("1층.game_lobby")
	end
	background:addEventListener("tap", back)
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
		composer.removeScene( "1층.key_lockingImage_1" )
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
