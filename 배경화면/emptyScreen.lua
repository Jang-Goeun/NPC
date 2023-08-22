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
	local background = display.newImageRect("image/배경/배경화면.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------
	local programGroup = display.newGroup()

	local program1 = display.newImage("image/UI/게임.png") --게임
	program1.x, program1.y = 370, 200
	programGroup:insert(program1)

	local program2 = display.newImage("image/UI/과제.png") --과제
	program2.x, program2.y = 680, 200
	programGroup:insert(program2)

	local program3 = display.newImage("image/UI/열기.png") --열기
	program3.x, program3.y = 860, 200
	programGroup:insert(program3)

	local program4 = display.newImage("image/UI/사진.png") --사진
	program4.x, program4.y = 1040, 200
	programGroup:insert(program4)

	local program5 = display.newImage("image/UI/SMS.png") --sms
	program5.x, program5.y = 1380, 200	
	programGroup:insert(program5)

	local program6 = display.newImage("image/UI/보안.png") --보안
	program6.x, program6.y = 1570, 200
	programGroup:insert(program6)

	local program7 = display.newImage("image/UI/내PC.png") --내pc
	program7.x, program7.y = 170, 450
	programGroup:insert(program7)

	local program8 = display.newImage("image/UI/인터넷.png") --인터넷
	program8.x, program8.y = 1770, 450
	programGroup:insert(program8)

	local program9 = display.newImage("image/UI/휴지통.png") --휴지통
	program9.x, program9.y = 1040, 740
	programGroup:insert(program9)
	sceneGroup:insert(programGroup)

	local underbar = display.newImageRect("image/UI/작업표시줄.png", display.contentWidth, 80)
	underbar.x, underbar.y = display.contentWidth/2, display.contentHeight*0.968
	sceneGroup:insert(underbar)

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1800, 100
	sceneGroup:insert(restart)

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80
	sceneGroup:insert(inventory)

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80
	sceneGroup:insert(question)
	
	-- ↑ ui정리 -------------------------------------------------------------------------------------------------


	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	local programNumber = composer.getVariable("programNumber")
	print(programNumber)

	if programNumber ==  2 then -- 과제
		composer.showOverlay( "배경화면.screen_project" ) 
	elseif programNumber ==  3 then -- 일기
		composer.showOverlay( "배경화면.screen_diary" )
	elseif programNumber ==  4 then -- 사진
		composer.showOverlay( "배경화면.screen_picture" ) 
	elseif programNumber ==  5 then -- sms
		composer.showOverlay( "배경화면.screen_kakao" )
	elseif programNumber ==  6 then -- 보안
		composer.showOverlay( "배경화면.security_loading" )
	elseif programNumber ==  7 then -- 내pc
		composer.showOverlay( "배경화면.screen_myPC" )
	elseif programNumber ==  8 then -- 인터넷
		composer.showOverlay( "배경화면.screen_internet" )
	elseif programNumber ==  9 then -- 휴지통
		composer.showOverlay( "" )
	end


	-- ↓ 시간 -------------------------------------------------------------------------------------------------

	local hour = os.date( "%I" )
	local minute = os.date( "%M" )

	local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
	hourText.size = 46
	hourText:setFillColor(0)
	local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
	minuteText.size = 46
	minuteText:setFillColor(0)

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
		composer.removeScene( "배경화면.emptyScreen" )
		composer.removeScene( "배경화면.screen_diary" )
		composer.removeScene( "배경화면.security_loading" )
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
