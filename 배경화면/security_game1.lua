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
	local background = display.newImageRect("image/배경화면.png", display.contentWidth, display.contentHeight)
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

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	sceneGroup:insert(question)
	sceneGroup:insert(inventory)


	local underbar = display.newImageRect("image/UI/작업표시줄.png", display.contentWidth, 80)
	underbar.x, underbar.y = display.contentWidth/2, display.contentHeight*0.968
	sceneGroup:insert(underbar)

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1800, 100
	sceneGroup:insert(restart)
	
	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 시간 -------------------------------------------------------------------------------------------------

	local hour = os.date( "%I" )
	local minute = os.date( "%M" )

	local hourText = display.newText(hour, display.contentWidth*0.919, display.contentHeight*0.972, font_Speaker)
	hourText.size = 46
	hourText:setFillColor(0)
	local minuteText = display.newText(minute, display.contentWidth*0.975, display.contentHeight*0.972, font_Speaker)
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

	-- ↓ 보안창 ----------------------------------------------------------------------------------------------------------------------------
	local securityGroup = {}
	local security = {}
	local button = {}
	-- 10/10

	for i = 1, 10 do
		securityGroup[i] = display.newGroup()
	end

	for i = 1, 10 do
		security[i] = display.newImage("image/보안/바이러스감지창.png")
		security[i].name = i

		securityGroup[i]:insert(security[i])

		button[i] = display.newImageRect("image/보안/취소버튼.png", 110, 50)
		button[i].name = i

		securityGroup[i]:insert(button[i])
		securityGroup[i].alpha = 0
		
		sceneGroup:insert(securityGroup[i])
	end
	

	-- 좌표 설정
	security[1].x, security[1].y = display.contentWidth * 0.4, display.contentHeight * 0.51
	security[2].x, security[2].y = display.contentWidth * 0.145, display.contentHeight * 0.3
	security[3].x, security[3].y = display.contentWidth * 0.82, display.contentHeight * 0.65
	security[4].x, security[4].y = display.contentWidth * 0.7, display.contentHeight * 0.45
	security[5].x, security[5].y = display.contentWidth * 0.5, display.contentHeight * 0.8
	security[6].x, security[6].y = display.contentWidth * 0.67, display.contentHeight * 0.19 
	security[7].x, security[7].y = display.contentWidth * 0.4, display.contentHeight * 0.2
	security[8].x, security[8].y = display.contentWidth * 0.18, display.contentHeight * 0.72
	security[9].x, security[9].y = display.contentWidth * 0.85, display.contentHeight * 0.3
	security[10].x, security[10].y = display.contentWidth * 0.6, display.contentHeight * 0.7

	for i = 1, 10 do
		button[i].x, button[i].y = security[i].x, security[i].y + 75
	end


	-- ↑ 오브젝트 정리 ---------------------------------------------------------------------------------------------------------------------

	-- ↓ 함수 정리 -------------------------------------------------------------------------------------------

	local cancelNum = 0

	local function cancel( event )
		if event.target.name == 1 then
			security[1].alpha = 0
		elseif event.target.name == 2 then
			security[2].alpha = 0
		elseif event.target.name == 3 then
			security[3].alpha = 0
		elseif event.target.name == 4 then
			security[4].alpha = 0
		elseif event.target.name == 5 then
			security[5].alpha = 0
		elseif event.target.name == 6 then
			security[6].alpha = 0
		elseif event.target.name == 7 then
			security[7].alpha = 0
		elseif event.target.name == 8 then
			security[8].alpha = 0
		elseif event.target.name == 9 then
			security[9].alpha = 0
		else
			security[10].alpha = 0
		end

		event.target.alpha = 0
		cancelNum = cancelNum + 1

		if(cancelNum == 10) then
			print("1라 성공")
			audio.play(gameSuccess)
			composer.showOverlay( "배경화면.security_game2" )
			-- composer.hideOverlay( "security_game1" )
		end

	end
	for i = 1, 10 do
		button[i]:addEventListener("tap", cancel)
	end

 	local go = 25

 	local function counter( event )
 	 	go = go - 1
 		
 		if(go == 23) then
			securityGroup[1].alpha = 1
 		end

		if(go == 20) then
			securityGroup[2].alpha = 1
		end
		if(go == 17) then
			securityGroup[3].alpha = 1
		end
		if(go == 15) then
			securityGroup[4].alpha = 1
		end
		if(go == 13) then
			securityGroup[5].alpha = 1
		end
		if(go == 11) then
			securityGroup[6].alpha = 1
		end
		if(go == 9) then
			securityGroup[7].alpha = 1
		end
		if(go == 8) then
			securityGroup[8].alpha = 1
		end
		if(go == 7) then
			securityGroup[9].alpha = 1
		end
		if(go == 6) then
			securityGroup[10].alpha = 1
		end
		
		if(go == -1) then
			composer.gotoScene("배경화면.security_badEnding")
		end
 	end
 	timer.performWithDelay(520, counter, 26)

	
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
		timer.cancelAll()
		composer.removeScene( "배경화면.security_game1" )
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
