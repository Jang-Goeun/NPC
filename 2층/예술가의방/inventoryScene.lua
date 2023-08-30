-----------------------------------------------------------------------------------------
--
-- inventoryScene.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.play(buttonSound)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local circle = display.newCircle(240, 80, 50)
    circle:setFillColor(1)
    circle.alpha=0.7
    sceneGroup:insert(circle)

	sceneGroup:insert(inventory)

	local back = display.newImageRect("image/UI/인벤토리(칸).png", 777.5, 415)
	back.x, back.y = display.contentWidth * 0.275 , display.contentHeight * 0.332
	sceneGroup:insert(back)

	local gun = display.newImageRect("image/UI/총.png", 100, 100)
    gun.x, gun.y = 230, 310
	sceneGroup:insert(gun)



	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 ------------------------------------------------------------------------------------------------------------


	-- 인벤토리 끄기
	local function hide( event )
		audio.play(buttonSound)
		composer.hideOverlay("inventoryScene")
	end
	inventory:addEventListener("tap", hide)


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
		composer.removeScene( "1층.inventoryScene" )
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
