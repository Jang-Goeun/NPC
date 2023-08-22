-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

-- ↓ 시작화면 배치 -----------------------------------------------------------------------------------------------

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/room.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:setFillColor(0.5, 0.5) -- 게임 방
	room:scale(0.59, 0.53)

	local explanation = display.newImage("image/explanation.png")
	explanation.x, explanation.y = display.contentWidth*0.06, display.contentHeight*0.15   -- ?설명
	explanation:scale(0.6, 0.6)

	local inventory = display.newImage("image/inventory.png")
	inventory.x, inventory.y = display.contentWidth*0.13, display.contentHeight*0.15   -- 인벤토리
	inventory:scale(0.6, 0.6)

	local back = display.newImage("image/back.png")
	back.x, back.y = display.contentWidth*0.9, display.contentHeight*0.15   -- 뒤로가기
	back:scale(0.6, 0.6)

	local item_Change = display.newImage("image/Item_Change.png")
	item_Change.x, item_Change.y = display.contentWidth*0.955, display.contentHeight*0.63   -- 얻은 아이템 장착 및 변경 버튼
	item_Change:scale(0.6, 0.6)

	local interact_extent = display.newRect(display.contentCenterX, display.contentCenterY, 50, 80)
	interact_extent.x, interact_extent.y = display.contentWidth*0.75, display.contentHeight*0.75   -- game으로 넘어갈 수 있는 부분
	interact_extent.alpha = 1
	
	-- ↓ 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = display.contentWidth*0.11, display.contentHeight*0.73
	up:scale(0.5 ,0.5)
	up.name  = "up"

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = display.contentWidth*0.15, display.contentHeight*0.8   -- 조이스틱(우)
	right:scale(0.5 ,0.5)
	right.name = "right"

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = display.contentWidth*0.07, display.contentHeight*0.8   -- 조이스틱(좌)
	left:scale(0.5 ,0.5)
	left.name = "left"

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = display.contentWidth*0.11, display.contentHeight*0.87   -- 조이스틱(하)
	down:scale(0.5 ,0.5)
	down.name = "down"

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = display.contentWidth*0.11, display.contentHeight*0.73
	stopUp:scale(0.5 ,0.5)

	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = display.contentWidth*0.15, display.contentHeight*0.8   -- 조이스틱(우)
	stopRight:scale(0.5 ,0.5)

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = display.contentWidth*0.07, display.contentHeight*0.8   -- 조이스틱(좌)
	stopLeft:scale(0.5 ,0.5)

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = display.contentWidth*0.11, display.contentHeight*0.87   -- 조이스틱(하)
	stopDown:scale(0.5 ,0.5)

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(back)
	sceneGroup:insert(item_Change)
	sceneGroup:insert(interact_extent)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------------


-- ↓ 사람 랜덤 배치 ------------------------------------------------------------------------------------------

	local personGroup = display.newGroup();
	local person = {}
	local w = {0.24, 0.37, 0.5, 0.63, 0.76}
	local selectedIndices = {0, 0, 0, 0, 0}  -- 이전에 선택한 인덱스를 저장하는 테이블  1이면 이전에 선택한 인덱스임

	for i = 1, 5 do
		local randomIndex
		repeat
			randomIndex = math.random(#w)  -- 랜덤 인덱스 선택
		until not (selectedIndices[randomIndex] == 1)  -- 선택된 인덱스가 이전에 선택된 값과 겹치지 않도록 반복

		person[i] = display.newImage(personGroup, "image/사람/liar" .. i .. ".png")
		person[i].x, person[i].y = display.contentWidth * w[randomIndex], display.contentHeight * 0.3
		person[i]:scale(0.2, 0.2)
		selectedIndices[randomIndex] = 1
	end
	-- 레이어 정리
	sceneGroup:insert(personGroup)

	composer.setVariable( "personGroup", personGroup )

-- ↑ 사람 랜덤 배치 --------------------------------------------------------------------------------------------


-- ↓ 상호작용 버튼 ---------------------------------------------------------------------------------------------------
	local interact_button = {}

	for i = 1, 2 do
		interact_button[i] = display.newImageRect("image/상호작용버튼/interact_button-"..i..".png", 160, 160)
		interact_button[i].x, interact_button[i].y = display.contentWidth*0.88, display.contentHeight*0.8
		--interact_button[i]:scale(0.6,)
		interact_button[i].alpha = 0

		sceneGroup:insert(interact_button[i])
	end
	
	interact_button[1].alpha = 1 -- 처음 모습
-- ↑ 상호작용 버튼 ---------------------------------------------------------------------------------------------------


-- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 100, 100)
		player[1][i].x, player[1][i].y = display.contentWidth*0.82, display.contentHeight*0.75 
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 100, 100)
		player[2][i].x, player[2][i].y = display.contentWidth*0.82, display.contentHeight*0.75 
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 100, 100)
		player[3][i].x, player[3][i].y = display.contentWidth*0.82, display.contentHeight*0.75 
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 100, 100)
		player[4][i].x, player[4][i].y = display.contentWidth*0.82, display.contentHeight*0.75 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[3][1].alpha = 1 -- 처음 모습

	local locationX = 1200
	local locationY = 700

	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)

-- ↑ 플레이어 ---------------------------------------------------------------------------------------------------


-- ↓ 플레이어 이동 함수 정리 -------------------------------------------------------------------------------------------------

	local movingDirection = nil
	local moveSpeed = 4
	local d = 0
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
			if(d == 0.8) then
				motionUp = motionUp + 1
				d = 0
			end
			if motionUp == 5 then
				motionUp = 1
			end

			--[[if playerGroup.y > room.contentHeight - playerGroup.contentHeight then
				playerGroup.y = playerGroup.y - moveSpeed
			end--]]

			up.alpha = 0.5
			if (playerGroup.x > interact_extent.contentHeight - playerGroup.contentHeight * 3.7) and (playerGroup.x < interact_extent.contentHeight - playerGroup.contentHeight * 1.42) and (playerGroup.y < interact_extent.contentHeight - playerGroup.contentHeight * 2.9) then
				interact_button[1].alpha = 0
				interact_button[2].alpha = 1
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
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
			if(d == 0.8) then
				motionDown = motionDown + 1
				d = 0
			end
			if motionDown == 5 then
				motionDown = 1
			end

			--[[if playerGroup.y < room.contentHeight - playerGroup.contentHeight * 4.5 then
				playerGroup.y = playerGroup.y + moveSpeed
			end--]]
			down.alpha = 0.5

			if (playerGroup.x > interact_extent.contentHeight - playerGroup.contentHeight * 3.7) and (playerGroup.x < interact_extent.contentHeight - playerGroup.contentHeight * 1.42) and (playerGroup.y < interact_extent.contentHeight - playerGroup.contentHeight * 2.9) then
				interact_button[1].alpha = 0
				interact_button[2].alpha = 1
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
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
			if(d == 1) then
				motionLeft = motionLeft + 1
				d = 0
			end
			if motionLeft == 5 then
				motionLeft = 1
			end

			if playerGroup.x > interact_extent.contentWidth - playerGroup.contentWidth * 1.5 then
				playerGroup.x = playerGroup.x - moveSpeed
			end
			left.alpha = 0.5

			if (playerGroup.x > interact_extent.contentHeight - playerGroup.contentHeight * 1.5) and (playerGroup.x < interact_extent.contentHeight - playerGroup.contentHeight * 1.2) then
				interact_button[1].alpha = 0
				interact_button[2].alpha = 1
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
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
			if(d == 1) then
				motionRight = motionRight + 1
				d = 0
			end
			if motionRight == 5 then
				motionRight = 1
			end

			--[[if playerGroup.x < room.contentWidth - playerGroup.contentWidth * 8 then
				playerGroup.x = playerGroup.x + moveSpeed
			end--]]
			right.alpha = 0.5

			if (playerGroup.x < interact_extent.contentHeight - playerGroup.contentHeight * 1.25) and (playerGroup.x < interact_extent.contentHeight - playerGroup.contentHeight * 1.42) and (playerGroup.x > interact_extent.contentHeight - playerGroup.contentHeight * 3.7) and (playerGroup.y < interact_extent.contentHeight - playerGroup.contentHeight * 2.9) then
				interact_button[1].alpha = 0
				interact_button[2].alpha = 1
			else
				interact_button[1].alpha = 1
				interact_button[2].alpha = 0
			end
		end

	end

	local function touchEventListener(event)
		if event.phase == "began" or event.phase == "moved" then
			-- print("터치를 시작함")
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


-- ↓ 상호작용 버튼 클릭 함수 ---------------------------------------------------------------------------------
	
	local function tapinteract_buttonEventListener( event )
		if interact_button[2].alpha == 1 then
			display.remove(playerGroup) -- 기존 이미지 삭제
			composer.gotoScene("game1") -- game1으로 넘어가기
		else
			print("상호작용 버튼을 탭함")
		end
	end

	interact_button[2]:addEventListener("tap", tapinteract_buttonEventListener)
-- ↑ 상호작용 버튼 클릭 함수-----------------------------------------------------------------------------------
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