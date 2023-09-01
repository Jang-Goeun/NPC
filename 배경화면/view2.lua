----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view


	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	
	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	loading = display.newImageRect("image/로딩창/loading.png", 160, 160)
	loading.x, loading.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert( loading )

	rotateLoading()


	-- ↓ 시간 -------------------------------------------------------------------------------------------------

	local hour = os.date( "%I" )
	local minute = os.date( "%M" )

	local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	hourText.size = 46
	hourText:setFillColor(0)
	local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, "font/PF스타더스트 Bold.ttf")
	minuteText.size = 46
	minuteText:setFillColor(0)

	local text = display.newText(":", display.contentWidth*0.946, display.contentHeight*0.96, font_Speaker)
    text.size = 100
    text:setFillColor(0)
	sceneGroup:insert(text)

	local function counter( event )
		hour = os.date( "%I" )
		hourText.text = hour
		minute = os.date( "%M" )
		minuteText.text = minute
	end

	timer.performWithDelay(1000, counter, -1)

	sceneGroup:insert(hourText)
	sceneGroup:insert(minuteText)

	-- ↑ 시간 -------------------------------------------------------------------------------------------------

	-- local function rotateLoading() -- 로딩창 회전시키는 함수
	-- 	transition.to(loading, {
	-- 		rotation = loading.rotation + 720, --2바퀴 회전
	-- 		x = display.contentCenterX,
	-- 		y = display.contentCenterY,
	-- 		time = 3000, --3초간
	-- 		onComplete = nextScene --회전끝나면, nextScene함수로 이동
	-- 	}
	-- )
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
		composer.removeScene( "배경화면.security_death" )
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