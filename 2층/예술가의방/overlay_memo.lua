-- overlay_memo.lua

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
	local sound_artist_memo2 = audio.loadSound("sound/종이 넘기는 소리 2.mp3")
    local sceneGroup = self.view

    -- Images
    local memo = display.newImageRect(sceneGroup, "image/UI/메모지.png", 401, 450)
    memo.x, memo.y = display.contentWidth/2, 500

    sceneGroup:insert(memo)

    local function onTouch(event)
        composer.hideOverlay("2층.예술가의방.overlay_memo")
		audio.play(sound_artist_memo2)
    end

    memo:addEventListener("tap", onTouch)

	memo:toFront()
  
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
		composer.removeScene( "2층.예술가의방.overlay_memo" )
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
