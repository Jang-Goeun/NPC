-----------------------------------------------------------------------------------------
--
-- 배경화면
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImage("image/배경/배경화면.png",display.contentCenterX, display.contentCenterY)
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
	program9.x, program9.y = 1040, 700
	programGroup:insert(program9)
	sceneGroup:insert(programGroup)

	local underbar = display.newImageRect("image/UI/작업표시줄.png", display.contentWidth, 80)
	underbar.x, underbar.y = display.contentWidth/2, display.contentHeight*0.968
	sceneGroup:insert(underbar)

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1820, 80
	sceneGroup:insert(restart)

	local cursor = display.newImage("image/UI/커서.png")
	cursor.x, cursor.y = 1560, 810 

	local finger = display.newImageRect("image/UI/손가락포인터.png", 200, 200)
	finger.x, finger.y = 1560, 840
	finger.alpha = 0

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	-- not_interaction.alpha = 0

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80


	-- 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = 330, 697

	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = 442, 810

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = 218, 810

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = 330, 923

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------

	-- 이전 움직였던 좌표 있으면 받아오기
	local pX = composer.getVariable("playerX")
	local pY = composer.getVariable("playerY")
	local x
	local y

	local playerGroup = display.newGroup()
	local player = {} -- 앞

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 170, 170)
		player[1][i].alpha = 0
		
		if pX == nil and pY == nil then
			player[1][i].x, player[1][i].y = 1200, 670
		else
			player[1][i].x, player[1][i].y = 1200 + pX, 670 + pY
		end

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 170, 170)
		player[2][i].alpha = 0

		if pX == nil and pY == nil then
			player[2][i].x, player[2][i].y = 1200, 670
		else
			player[2][i].x, player[2][i].y = 1200 + pX, 670 + pY
		end

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 170, 170)
		player[3][i].alpha = 0

		if pX == nil and pY == nil then
			player[3][i].x, player[3][i].y = 1200, 670
		else
			player[3][i].x, player[3][i].y = 1200 + pX, 670 + pY
		end

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 170, 170)
		player[4][i].alpha = 0
		
		if pX == nil and pY == nil then
			player[4][i].x, player[4][i].y = 1200, 670
		else
			player[4][i].x, player[4][i].y = 1200 + pX, 670 + pY
		end

		playerGroup:insert(player[4][i])
	end

	if pX ~= nil and pY ~= nil then
		x = pX
		y = pY
	else
		x = 0
		y = 0 
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

	sceneGroup:insert(cursor)
	sceneGroup:insert(finger)
	sceneGroup:insert(not_interaction)
	sceneGroup:insert(interaction)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)

	-- ↑ 플레이어 ---------------------------------------------------------------------------------------------------
	
	-- ↓ 프로그램 이동  -------------------------------------------------------------------------------------------------

	local programNumber

	local function transfer( event )
		if pX == nil then
			composer.setVariable("playerX", playerGroup.x)
			composer.setVariable("playerY", playerGroup.y)
		else
			composer.setVariable("playerX", playerGroup.x + pX)
			composer.setVariable("playerY", playerGroup.y + pY)
		end

		if programNumber == 1 then
			composer.gotoScene("1층.game_loding") --임시

		elseif 1 < programNumber and programNumber < 10 then
			composer.setVariable("programNumber", programNumber)

			if programNumber == 6 then
				composer.gotoScene( "배경화면.security_script" )
			else
				composer.gotoScene( "배경화면.emptyScreen" )
			end
		end
	end
	finger:addEventListener("tap", transfer)


	-- ↑ 프로그램 이동 ---------------------------------------------------------------------------------------------------

	-- ↓ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

    local movingDirection = nil
    local moveSpeed = 3.5
	local d = 0
	local d_n
	local motionUp = 1
	local motionDown = 1
	local motionRight = 1
	local motionLeft = 1

    local function moveCharacter(event)
        if movingDirection == "up" then
			-- 이전 모습 삭제
			if motionUp == 1 then -- 1~4
				player[2][4].alpha = 0
			else
				player[2][motionUp - 1].alpha = 0
			end
			-- 현재 모습 
			player[2][motionUp].alpha = 1
		
			d = d + 0.2 -- 움직임 속도 조절
			d_n = d
			if(d == 1.2) then
				motionUp = motionUp + 1
				d = 0
			end
			if motionUp == 5 then
				motionUp = 1
		 	end

			if (playerGroup.y > -582 - y) then -- 여기 숫자 각 맵에 맞게 조절하시면 됩니다. ex) -608
				playerGroup.y = playerGroup.y - moveSpeed
			end
			up.alpha = 0.7

			-- 프로그램 이동(위)
			if( -470 - y < playerGroup.y and playerGroup.y < -365 - y) then -- program 1~6
				cursor.alpha = 0
				finger.alpha = 1

				if(-890 - x < playerGroup.x and playerGroup.x < -800 - x) then
					programNumber = 1
				elseif(-530 - x < playerGroup.x and playerGroup.x < -460 - x) then
					programNumber = 2
				elseif(-368 - x < playerGroup.x and playerGroup.x < -310 - x) then
					programNumber = 3
				elseif(-180 - x < playerGroup.x and playerGroup.x < -125 - x) then
					programNumber = 4
				elseif(150 - x < playerGroup.x and playerGroup.x < 210 - x) then
					programNumber = 5
				elseif(350 - x < playerGroup.x and playerGroup.x < 410 - x) then
					programNumber = 6
	
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -220 - y < playerGroup.y and playerGroup.y < -98 - y) then -- program 7~8
				cursor.alpha = 0
				finger.alpha = 1

				if(-1048  - x < playerGroup.x and playerGroup.x < -992 -  x) then
					programNumber = 7
				elseif(548 - x < playerGroup.x and playerGroup.x < 604 - x ) then
					programNumber = 8
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( 15 - y < playerGroup.y and playerGroup.y < 169 - y) then -- program 9
				cursor.alpha = 0
				finger.alpha = 1

				if(-180 - x < playerGroup.x and playerGroup.x < -105 - x) then
					programNumber = 9

				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			else
				cursor.alpha = 1
				finger.alpha = 0
				programNumber = 0
			end


        elseif movingDirection == "down" then
			-- 이전 모습 삭제
			if motionDown == 1 then -- 1~4
				player[1][4].alpha = 0
			else
				player[1][motionDown - 1].alpha = 0
			end
			-- 현재 모습 
		 	player[1][motionDown].alpha = 1

		 	d = d + 0.2 -- 움직임 속도 조절
			d_n = d
			if(d == 1.2) then
				motionDown = motionDown + 1
				d = 0
			end
			if motionDown == 5 then
				motionDown = 1
		 	end

			if (playerGroup.y < 240 - y) then -- 숫자 조절
		 		playerGroup.y = playerGroup.y + moveSpeed
			end
			down.alpha = 0.7

			-- 프로그램 이동(아래)
			if( -560  - y < playerGroup.y and playerGroup.y < -515 - y) then -- program 1~6
				cursor.alpha = 0
				finger.alpha = 1

				if(-890  - x < playerGroup.x and playerGroup.x < -800 - x) then
					programNumber = 1
				elseif(-530 - x < playerGroup.x and playerGroup.x < -460 - x) then
					programNumber = 2
				elseif(-368 - x < playerGroup.x and playerGroup.x < -310 - x) then
					programNumber = 3
				elseif(-180 - x < playerGroup.x and playerGroup.x < -125 - x) then
					programNumber = 4
				elseif(150 - x < playerGroup.x and playerGroup.x < 210 - x) then
					programNumber = 5
				elseif(350 - x < playerGroup.x and playerGroup.x < 410 - x) then
					programNumber = 6
	
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -380 - y < playerGroup.y and playerGroup.y < -280 - y) then
				cursor.alpha = 0
				finger.alpha = 1

				if(-1048 - x < playerGroup.x and playerGroup.x < -992 - x) then
					programNumber = 7
				elseif(548 - x < playerGroup.x and playerGroup.x < 604 - x) then
					programNumber = 8
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -164 - y < playerGroup.y and playerGroup.y < 20 - y) then
				cursor.alpha = 0
				finger.alpha = 1

				if(-180 - x < playerGroup.x and playerGroup.x < -105 - x) then
					programNumber = 9

				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			else
				cursor.alpha = 1
				finger.alpha = 0
				programNumber = 0
			end

        elseif movingDirection == "left" then
			-- 이전 모습 삭제
			if motionLeft == 1 then -- 1~4
				player[3][4].alpha = 0
			else
				player[3][motionLeft - 1].alpha = 0
			end
			-- 현재 모습 
		 	player[3][motionLeft].alpha = 1

		 	d = d + 0.2 -- 움직임 속도 조절
			d_n = d
			if(d == 1.4) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
		 	end

			if (playerGroup.x > -1140) then -- 숫자 조절
		 		playerGroup.x = playerGroup.x - moveSpeed
			end
			left.alpha = 0.7

			-- 프로그램 이동(좌)
			if( -530  - y < playerGroup.y and playerGroup.y < -350 - y) then -- program 1~6
				cursor.alpha = 0
				finger.alpha = 1

				if(-850  - x < playerGroup.x and playerGroup.x < -705 - x) then --1
					programNumber = 1
				elseif(-530 - x < playerGroup.x and playerGroup.x < -400 - x) then --2
					programNumber = 2
				elseif(-330 - x < playerGroup.x and playerGroup.x < -226 - x) then --3
					programNumber = 3
				elseif(-157 - x < playerGroup.x and playerGroup.x < -40 - x) then --4
					programNumber = 4
				elseif(168 - x < playerGroup.x and playerGroup.x < 310 - x) then --5
					programNumber = 5
				elseif(380 - x < playerGroup.x and playerGroup.x < 470 - x) then --6
					programNumber = 6
	
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -275 - y < playerGroup.y and playerGroup.y < -200 - y) then
				cursor.alpha = 0
				finger.alpha = 1

				if(-1100 - x < playerGroup.x and playerGroup.x < -965 - x) then
					programNumber = 7
				elseif(548 - x < playerGroup.x and playerGroup.x < 670 - x) then
					programNumber = 8
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -55 - y < playerGroup.y and playerGroup.y < 55 - y) then
				cursor.alpha = 0
				finger.alpha = 1

				if(-165 - x < playerGroup.x and playerGroup.x < -50 - x) then
					programNumber = 9

				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			else
				cursor.alpha = 1
				finger.alpha = 0
				programNumber = 0
			end

        elseif movingDirection == "right" then
			-- 이전 모습 삭제
			if motionRight == 1 then -- 1~4
				player[4][4].alpha = 0
			else
				player[4][motionRight - 1].alpha = 0
			end

			-- 현재 모습 
		 	player[4][motionRight].alpha = 1

		 	d = d + 0.2 -- 움직임 속도 조절
			d_n = d
			if(d == 1.4) then
				motionRight = motionRight + 1
				d = 0
			end
			if motionRight == 5 then
				motionRight = 1
		 	end

			if (playerGroup.x < 656) then -- 숫자 조절
		 		playerGroup.x = playerGroup.x + moveSpeed
			end
			right.alpha = 0.7


			-- 프로그램 이동(우)
			if(-530  - y < playerGroup.y and playerGroup.y < -350 - y) then -- program 1~6
				cursor.alpha = 0
				finger.alpha = 1

				if(-945 - x < playerGroup.x and playerGroup.x < -815 - x) then
					programNumber = 1
				elseif(-638 - x < playerGroup.x and playerGroup.x < -490 - x) then
					programNumber = 2
				elseif(-460 - x < playerGroup.x and playerGroup.x < -320 - x) then
					programNumber = 3
				elseif(-260 - x < playerGroup.x and playerGroup.x < -146 - x) then
					programNumber = 4
				elseif(65 - x < playerGroup.x and playerGroup.x < 190 - x) then
					programNumber = 5
				elseif(267 - x < playerGroup.x and playerGroup.x < 360 - x) then
					programNumber = 6
	
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -275 - y < playerGroup.y and playerGroup.y < -200 - y) then -- program 7~8
				cursor.alpha = 0
				finger.alpha = 1

				if(-1141  - x < playerGroup.x and playerGroup.x < -1024 -  x) then
					programNumber = 7
				elseif(440 - x < playerGroup.x and playerGroup.x < 578 - x ) then
					programNumber = 8
				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			elseif( -55 - y < playerGroup.y and playerGroup.y < 55 - y) then -- program 9
				cursor.alpha = 0
				finger.alpha = 1

				if(-273 - x < playerGroup.x and playerGroup.x < -164 - x) then
					programNumber = 9

				else
					cursor.alpha = 1
					finger.alpha = 0
					programNumber = 0
				end

			else
				cursor.alpha = 1
				finger.alpha = 0
				programNumber = 0
			end


        end

    end

    local function touchEventListener(event)
        if event.phase == "began" or event.phase == "moved" then
            -- print("터치를 시작함")
			if d == nil or d == 0 then
				d = 0
			else
				d = d_n
			end

            if event.target == up then
                movingDirection = "up"

				for i = 1, 4 do
					if i ~= 2 then
						for j = 1, 4 do
							player[i][j].alpha = 0
						end
					end
				end
            elseif event.target == down then
                movingDirection = "down"

				for i = 2, 4 do
					for j = 1, 4 do
						player[i][j].alpha = 0
					end
				end
            elseif event.target == left then
                movingDirection = "left"

				for i = 1, 4 do
					if i ~= 3 then
						for j = 1, 4 do
							player[i][j].alpha = 0
						end
					end
				end
            elseif event.target == right then
                movingDirection = "right"

				for i = 1, 3 do
					for j = 1, 4 do
						player[i][j].alpha = 0
					end
				end
            end

        elseif event.phase == "ended" or event.phase == "cancelled" then
            movingDirection = nil

			up.alpha = 1
			right.alpha = 1
			left.alpha = 1
			down.alpha = 1

			print(playerGroup.x, playerGroup.y)
        end
    end

    up:addEventListener("touch", touchEventListener)
    down:addEventListener("touch", touchEventListener)
    left:addEventListener("touch", touchEventListener)
    right:addEventListener("touch", touchEventListener)

    Runtime:addEventListener("enterFrame", moveCharacter)

	local function stopMove ( event )
		if event.phase == "began" or event.phase == "moved" then
			movingDirection = nil
			if d == nil or d == 0 then
				d = 0
			else
				d = d_n
			end

			up.alpha = 1
			right.alpha = 1
			left.alpha = 1
			down.alpha = 1
		end
	end

	stopUp:addEventListener("touch", stopMove)
    stopDown:addEventListener("touch", stopMove)
	stopLeft:addEventListener("touch", stopMove)
    stopRight:addEventListener("touch", stopMove)

    -- ↑ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

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
		composer.removeScene( "배경화면.computerScreen" )
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