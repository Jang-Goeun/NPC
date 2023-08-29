-----------------------------------------------------------------------------------------
--
-- picgame_re_1.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local sound_artist_memo1 = audio.loadSound("sound/종이 넘기는 소리 1.mp3")
    local sound_artist_memo2 = audio.loadSound("sound/종이 넘기는 소리 2.mp3")
    local buttonSound = buttonSound
    local buttonSound2 = buttonSound2

    -- Background
    local background = display.newImage("image/artist/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)

    local memo = display.newImageRect("image/UI/메모지.png", 120, 150)
    memo.x, memo.y = 450, 180
    memo.alpha = 0.7
    memo.name = "memo"  

    local button = display.newImageRect("image/UI/버튼.png", 50, 50)
    button.x, button.y = 1535, 220
    sceneGroup:insert(button)

    -- Images
    local picGroup = display.newGroup()
    local pic = {}
    local framGroup = display.newGroup()
    local fram = {}

    pic[1] = display.newImageRect("image/artist/예술가의방 그림 H.png", 200, 150)
    pic[1].x, pic[1].y = 1450, 700
    pic[2] = display.newImageRect("image/artist/예술가의방 그림 U.png", pic[1].width, pic[1].height)
    pic[2].x, pic[2].y = 500, 650
    pic[3] = display.newImageRect("image/artist/예술가의방 그림 N.png", pic[1].width, pic[1].height)
    pic[3].x, pic[3].y = 850, 500
    pic[4] = display.newImageRect("image/artist/예술가의방 그림 T.png", pic[1].width, pic[1].height)
    pic[4].x, pic[4].y = 1100, 880

    fram[1] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[2] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[3] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)
    fram[4] = display.newImageRect("image/artist/오브제 액자.png", 200, 200)


    for i = 1, 4 do
        picGroup:insert(pic[i])
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end

    sceneGroup:insert(memo)
    sceneGroup:insert(framGroup)
    sceneGroup:insert(picGroup)


    -- 조작키 --------------------------------------

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1820, 80
	sceneGroup:insert(restart)

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	not_interaction.alpha = 0

    local finger = display.newImage("image/UI/포인터.png")
	finger.x, finger.y = 1560, 810
    finger.alpha = 0

	local interaction = display.newImageRect("image/UI/변형.png", 130, 130)
	interaction.x, interaction.y = 1740, 680
	interaction.alpha = 0

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

    local circle = display.newCircle(240, 80, 50)
    circle:setFillColor(1)
    circle.alpha=0.7
    sceneGroup:insert(circle)

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	-- ↓ 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"
	up.alpha = 0.5

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"
	right.alpha = 0.5

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"
	left.alpha = 0.5

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"
	down.alpha = 0.5

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = 330, 697

	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = 442, 810

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = 218, 810

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = 330, 923

	-- 레이어 정리
	sceneGroup:insert(not_interaction)
	sceneGroup:insert(interaction)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)
    sceneGroup:insert(finger)

	sceneGroup:insert(up)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(down)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopDown)


    -- ↑ ui정리 -------------------------------------------------------------------------------------------------

    -- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local playerGroup = display.newGroup()
	local player = {} 

	for i = 1, 4 do
		player[i] = {}
	end

	-- 앞
	for i = 1, 4 do
		player[1][i] = display.newImageRect("image/캐릭터/pixil(앞)-"..(i - 1)..".png", 120, 120)
		player[1][i].x, player[1][i].y = 1530, 240
		player[1][i].alpha = 0

		playerGroup:insert(player[1][i])
	end
	-- 뒤
	for i = 1, 4 do
		player[2][i] = display.newImageRect("image/캐릭터/pixil(뒤)-"..(i - 1)..".png", 120, 120)
		player[2][i].x, player[2][i].y = 1530, 240
		player[2][i].alpha = 0

		playerGroup:insert(player[2][i])
	end
	-- 왼쪽
	for i = 1, 4 do
		player[3][i] = display.newImageRect("image/캐릭터/pixil(왼)-"..(i - 1)..".png", 120, 120)
		player[3][i].x, player[3][i].y = 1530, 240
		player[3][i].alpha = 0

		playerGroup:insert(player[3][i])
	end
	-- 오른쪽
	for i = 1, 4 do
		player[4][i] = display.newImageRect("image/캐릭터/pixil(오른)-"..(i - 1)..".png", 120, 120)
		player[4][i].x, player[4][i].y = 1530, 240 
		player[4][i].alpha = 0

		playerGroup:insert(player[4][i])
	end

	sceneGroup:insert(playerGroup)

	player[1][1].alpha = 1 -- 처음 모습

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
        if(d == 1.2) then
            motionUp = motionUp + 1
            d = 0
        end
        if motionUp == 5 then
            motionUp = 1
        end

        if (playerGroup.y > -4) then -- 여기 숫자 각 맵에 맞게 조절하시면 됩니다. ex) -608
            playerGroup.y = playerGroup.y - moveSpeed
        end
        up.alpha = 0.7

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
        if(d == 1.2) then
            motionDown = motionDown + 1
            d = 0
        end
        if motionDown == 5 then
            motionDown = 1
        end

        if (playerGroup.y < 668) then -- 숫자 조절
            playerGroup.y = playerGroup.y + moveSpeed
        end
        down.alpha = 0.7

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
        if(d == 1.4) then
            motionLeft = motionLeft + 1
            d = 0
        end
        if motionLeft == 5 then
            motionLeft = 1
        end

        if (playerGroup.x > -1156) then -- 숫자 조절
            playerGroup.x = playerGroup.x - moveSpeed
        end
        left.alpha = 0.7

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
        if(d == 1.4) then
            motionRight = motionRight + 1
            d = 0
        end
        if motionRight == 5 then
            motionRight = 1
        end

        if (playerGroup.x < 20) then -- 숫자 조절
            playerGroup.x = playerGroup.x + moveSpeed
        end
        right.alpha = 0.7
    end

    if (-5 < playerGroup.y and playerGroup.y < 100 and -65 < playerGroup.x and playerGroup.x < 25) then
        finger.alpha = 1
    else
        finger.alpha = 0
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

        --print(playerGroup.x, playerGroup.y)
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

-- ↓ 메모 -------------------------------------------------------------------------------------------------

local function memoTap(event)
    audio.play(sound_artist_memo1)
    composer.showOverlay("2층.예술가의방.overlay_memo", {isModal = true})
end

memo:addEventListener("tap", memoTap)

    -- ↓ 그림 선택/이동 -------------------------------------------------------------------------------------------------

    local function successScene(event)
        composer.gotoScene("2층.예술가의방.picgame_sucess_2")
    end

    local function failScene(event)
        for i = 1, #fram do
            display.remove(fram[i].currentPic) -- 제거된 currentPic
        end
                
        composer.gotoScene("2층.예술가의방.picgame_re")
    end
    
    local imagePaths = {
        "image/artist/1.png",
        "image/artist/2.png",
        "image/artist/3.png",
        "image/artist/4.png"
    }


    local imageStates = {}  -- 각 이미지의 상태를 저장하는 테이블

    for i = 1, 4 do
        imageStates[i] = false  -- 초기에 모든 이미지의 상태를 false로 설정
    end


    local function drag( event )
        if( event.phase == "began" ) then
            display.getCurrentStage():setFocus( event.target )
            event.target.isFocus = true
            event.target:toFront()
            -- 드래그 시작할 때

        elseif( event.phase == "moved" ) then

            if ( event.target.isFocus ) then
                -- 드래그 중일 때
                event.target.x = event.xStart + event.xDelta
                event.target.y = event.yStart + event.yDelta
            end

        elseif ( event.phase == "ended" or event.phase == "cancelled") then
            if ( event.target.isFocus ) then
                display.getCurrentStage():setFocus( nil )
                event.target.isFocus = false

                local x = event.target.x
                local y = event.target.y

                -- 드래그 끝났을 때
                for i = 1, #fram do

                    if fram[i] then
                        local frameX = fram[i].x
                        local frameY = fram[i].y

                        local x = event.xStart + event.xDelta
                        local y = event.yStart + event.yDelta

                        if frameX and frameY then
                            if (x > frameX - 50 and x < frameX + 50 and
                                y > frameY - 50 and y < frameY + 50) then
                                    
                                    local newPicGroup = display.newGroup()
                                    local newPic = {}
                                    newPic = fram[i].currentPic
                                        
                                    local index = event.target.myIndex
                                    local imagePath = imagePaths[index]
                                    fram[i].currentPic = display.newImageRect(newPicGroup, imagePath, 165, 165)
                                    fram[i].currentPic.x, fram[i].currentPic.y = frameX, frameY
                                    sceneGroup:insert(newPicGroup)
                                    sceneGroup:insert(playerGroup)

                                display.remove(event.target)
                                display.remove(fram[i])

                                audio.play(buttonSound2)

                                if i == index then
                                    imageStates[index] = true

                                    if imageStates[1] and imageStates[2] and imageStates[3] and imageStates[4] then
                                        finger:addEventListener("tap", successScene)
                                        --print("성공")
                                    end
                                else
                                        finger:addEventListener("tap", failScene)
                                        --print("실패")
                                end

                                break -- 이미 한 번 위치를 찾았으면 더 이상 확인할 필요 없음
                            end
                        end
                    end

                end 
                
    
            else
                display.getCurrentStage():setFocus(nil)
                event.target.isFocus = false
            end
        end
    end


    
    local selGroup = display.newGroup()
    local sel = {}
    local function updateSelection()

        --U
        if playerGroup.x > -1130 and playerGroup.x < -930 and
            playerGroup.y > 280 and playerGroup.y < 460 then
                if pic[2] then
                    if not sel[1] then
                        sel[1] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                        sel[1].x, sel[1].y = 440, 720
                        sel[1].label = display.newText("확대/축소", sel[1].x, sel[1].y-3, native.systemFont, 22)
                        sel[1].label:setFillColor(0)
                        sel[1].font = native.newFont(font_Speaker)
                        selGroup:insert(sel[1])

                        local function sel1Tap(event)
                            audio.play(buttonSound)

                            display.remove(sel[1].label)
                            display.remove(sel[1])
                            display.remove(sel[2].label)
                            display.remove(sel[2]) 

                            composer.showOverlay("overlayScene2", {isModal = true})
                        end
        
                        sel[1]:addEventListener("tap", sel1Tap)

                    end
            
                    if not sel[2] then
                        sel[2] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                        sel[2].x, sel[2].y = 550, 720
                        sel[2].label = display.newText("옮기기", sel[2].x, sel[2].y-3, native.systemFont, 22)
                        sel[2].label:setFillColor(0)
                        sel[2].font = native.newFont(font_Speaker)
                        selGroup:insert(sel[2])

                        local function sel2Tap(event)
                            audio.play(buttonSound)

                            display.remove(sel[1].label)
                            display.remove(sel[1])
                            display.remove(sel[2].label)
                            display.remove(sel[2]) 

                            display.remove(pic[2])
                            

                            local imagePath = "image/artist/2.png"
                            pic[2].currentPic = display.newImageRect(imagePath, 165, 165)
                            pic[2].currentPic.x, pic[2].currentPic.y = pic[2].x, pic[2].y

                            pic[2].currentPic.myIndex = 2
                            pic[2].currentPic:addEventListener("touch", drag)
                            

                        end
                        sel[2]:addEventListener("tap", sel2Tap)

                    end
                end
    
                else
                    if sel[1] then
                        display.remove(sel[1].label)
                        display.remove(sel[1])
                        sel[1] = nil
                        
                    end
            
                    if sel[2] then
                        display.remove(sel[2].label)
                        display.remove(sel[2])
                        sel[2] = nil
                    end
                end
        
        
        --N
        if playerGroup.x > -776 and playerGroup.x < -575  and
            playerGroup.y > 135 and playerGroup.y < 300 then
            if pic[3] then 
                if not sel[3] then
                    sel[3] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[3].x, sel[3].y = 800, 570
                    sel[3].label = display.newText("확대/축소", sel[3].x, sel[3].y-3, native.systemFont, 22)
                    sel[3].label:setFillColor(0)
                    sel[3].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[3])

                    local function sel3Tap(event)
                        audio.play(buttonSound)

                        display.remove(sel[3].label)
                        display.remove(sel[3])
                        display.remove(sel[4].label)
                        display.remove(sel[4])

                        composer.showOverlay("2층.예술가의방.overlayScene3", {isModal = true})
                    end

                    sel[3]:addEventListener("tap", sel3Tap)
                end
        
                if not sel[4] then
                    sel[4] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[4].x, sel[4].y = 910, 570
                    sel[4].label = display.newText("옮기기", sel[4].x, sel[4].y-3, native.systemFont, 22)
                    sel[4].label:setFillColor(0)
                    sel[4].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[4])

                    local function sel4Tap(event)
                        audio.play(buttonSound)
                        
                        display.remove(sel[3].label)
                        display.remove(sel[3])
                        display.remove(sel[4].label)
                        display.remove(sel[4])

                        display.remove(pic[3])

                        local imagePath = "image/artist/3.png"
                        pic[3].currentPic = display.newImageRect(imagePath, 165, 165)
                        pic[3].currentPic.x, pic[3].currentPic.y = pic[3].x, pic[3].y

                        pic[3].currentPic.myIndex = 3
                        pic[3].currentPic:addEventListener("touch", drag)

                    end
        
                    sel[4]:addEventListener("tap", sel4Tap)
                end
            end
        

            else
                if sel[3] then
                    display.remove(sel[3].label)
                    display.remove(sel[3])
                    sel[3] = nil
                end
        
                if sel[4] then
                    display.remove(sel[4].label)
                    display.remove(sel[4])
                    sel[4] = nil
                end
            end


        --T
        if playerGroup.x > -535 and playerGroup.x < -340 and
            playerGroup.y > 510 and playerGroup.y < 670 then
            if pic[4] then 
                if not sel[5] then
                    sel[5] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[5].x, sel[5].y = 1040, 945
                    sel[5].label = display.newText("확대/축소", sel[5].x, sel[5].y-3, native.systemFont, 22)
                    sel[5].label:setFillColor(0)
                    sel[5].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[5])

                    local function sel5Tap(event)
                        audio.play(buttonSound)

                        display.remove(sel[5].label)
                        display.remove(sel[5])
                        display.remove(sel[6].label)
                        display.remove(sel[6])

                        composer.showOverlay("2층.예술가의방.overlayScene4", {isModal = true})
                    end

                    sel[5]:addEventListener("tap", sel5Tap)
                end
        
                if not sel[6] then
                    sel[6] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[6].x, sel[6].y = 1150, 945
                    sel[6].label = display.newText("옮기기", sel[6].x, sel[6].y-3, native.systemFont, 22)
                    sel[6].label:setFillColor(0)
                    sel[6].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[6])

                    local function sel6Tap(event)
                        audio.play(buttonSound)
                        
                        display.remove(sel[5].label)
                        display.remove(sel[5])
                        display.remove(sel[6].label)
                        display.remove(sel[6])

                        display.remove(pic[4])

                        local imagePath = "image/artist/4.png"
                        pic[4].currentPic = display.newImageRect(imagePath, 165, 165)
                        pic[4].currentPic.x, pic[4].currentPic.y = pic[4].x, pic[4].y

                        pic[4].currentPic.myIndex = 4
                        pic[4].currentPic:addEventListener("touch", drag)


                    end
        
                    sel[6]:addEventListener("tap", sel6Tap)
                end
        
            end

            else
                if sel[5] then
                    display.remove(sel[5].label)
                    display.remove(sel[5])
                    sel[5] = nil

                end
        
                if sel[6] then
                    display.remove(sel[6].label)
                    display.remove(sel[6])
                    sel[6] = nil
                end
            end 


        --H
        if playerGroup.x > -175 and playerGroup.x < 21 and
            playerGroup.y > 350 and playerGroup.y < 510 then
            if pic[1] then 
                if not sel[7] then
                    sel[7] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[7].x, sel[7].y = 1390, 780
                    sel[7].label = display.newText("확대/축소", sel[7].x, sel[7].y-3, native.systemFont, 22)
                    sel[7].label:setFillColor(0)
                    sel[7].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[7])

                    local function sel7Tap(event)
                        audio.play(buttonSound)

                        display.remove(sel[7].label)
                        display.remove(sel[7])
                        display.remove(sel[8].label)
                        display.remove(sel[8])
                        
                        composer.showOverlay("2층.예술가의방.overlayScene1", {isModal = true})
                    end

                    sel[7]:addEventListener("tap", sel7Tap)
                end
        
                if not sel[8] then
                    sel[8] = display.newImageRect("image/UI/대답박스 분리.png", 150, 80)
                    sel[8].x, sel[8].y = 1500, 780
                    sel[8].label = display.newText("옮기기", sel[8].x, sel[8].y-3, native.systemFont, 22)
                    sel[8].label:setFillColor(0)
                    sel[8].font = native.newFont(font_Speaker)
                    selGroup:insert(sel[8])

                    local function sel8Tap(event)
                        audio.play(buttonSound)
                        
                        display.remove(sel[7].label)
                        display.remove(sel[7])
                        display.remove(sel[8].label)
                        display.remove(sel[8])

                        display.remove(pic[1])

                        local imagePath = "image/artist/1.png"
                        pic[1].currentPic = display.newImageRect(imagePath, 165, 165)
                        pic[1].currentPic.x, pic[1].currentPic.y = pic[1].x, pic[1].y

                        pic[1].currentPic.myIndex = 1
                        pic[1].currentPic:addEventListener("touch", drag)


                    end
        
                    sel[8]:addEventListener("tap", sel8Tap)
                end
            end

            else
                if sel[7] then
                    display.remove(sel[7].label)
                    display.remove(sel[7])
                    sel[7] = nil
                end
        
                if sel[8] then
                    display.remove(sel[8].label)
                    display.remove(sel[8])
                    sel[8] = nil
                end

        end
    end

    local function autoUpdateSelection()
        for i = 1, 4 do
            if pic[i] then
                updateSelection()

            end
        end
        timer.performWithDelay(100, autoUpdateSelection) -- 0.1초마다 업데이트
    end

    
    -- 자동 업데이트 시작
    autoUpdateSelection()
    
    sceneGroup:insert(selGroup)
    playerGroup:toFront()

end

	----------------------------------------------------------------------------------------------------------


function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.
        composer.removeScene("2층.예술가의방.picgame_re_1")
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
