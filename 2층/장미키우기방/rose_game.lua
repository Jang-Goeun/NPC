-----------------------------------------------------------------------------------------
--
-- rose_game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local getSound

local function loadWaterSound() --주전자 터치하면 나침반나옴 (변수이름만 이모양)
	getSound = audio.loadSound("sound/물주는_소리.mp3")
	audio.play(getSound)
    print("물줌")
end
local function loadWitherSound() --주전자 터치하면 나침반나옴 (변수이름만 이모양)
	getSound = audio.loadSound("sound/시드는_소리.mp3")
	audio.play(getSound)
    print("시듦")
end
local function loadMoveSound() --주전자 터치하면 나침반나옴 (변수이름만 이모양)
	getSound = audio.loadSound("sound/파이_이동소리.mp3")
	audio.play(getSound)
    print("움직임")
end
local function loadBugSound()
    getSound = audio.loadSound("sound/종이 찢는 소리.mp3")
	audio.play(getSound)
    print("벌레공격")
end

--변수선언 ---------------------------------------------------------------------
local background
--기본 오브제
local pi
local pi2
local roseGroup
local rose = {}
local glass
local box
local pot
local bug --벌레생성함수 따로만들기

local boxText--박스 말풍선
local tapToStart
--setting
local gameTime = 50
local bugSpeed = 2
local gameStarted = false

local timeText --남은시간: ~

local gameTimer
local roseTimer
local checkTimer
--상태확인
local isThirsty = false
local isAttacted = false
local isCareless = false

local isDied = false
--상태타이머
local wiltedTime = 0
local checkTime = 0


--벌레 함수 -------------------------------------------------------------------------

--1. 벌레 생성----------------------------------------------------------
local function createBug()
    local bugs = display.newGroup()
    --왼/오 랜덤결정
    local side = math.random(1,2) == 1 and "left" or "right" 
    --생성 위치에 따라 벌레 생성
    if side == "left" then
        bug = display.newImageRect("image/오브제/bug_left.png", 300,200) 
        bug.x, bug.y = display.contentWidth*0.3, display.contentHeight/2
        bugs:insert(bug)
        transition.to(bug, {
            x = display.contentWidth/2, -- 오른쪽으로 이동할 위치
            time = 2000, -- 이동하는 시간
            onComplete = function()
                bug = display.newImageRect("image/오브제/bug_left.png", 300,200) 
                bug.x, bug.y = roseGroup.x, roseGroup.y
            end
        })

    else
        bug = display.newImageRect("image/오브제/bug_right.png", 300,200) 
        bug.x, bug.y = display.contentWidth*0.7, display.contentHeight/2

        transition.to(bug, {
            x = display.contentWidth/2, -- 오른쪽으로 이동할 위치
            time = 2000, -- 이동하는 시간
            onComplete = function()
                bug = display.newImageRect("image/오브제/bug_right.png", 300,200) 
                bug.x, bug.y = roseGroup.x, roseGroup.y
                local function eating(event)
                    loadBugSound()
                end
                timer.performWithDelay(1000,loadBugSound, 2)
            end
        })
    end
    --2. 벌레 제거----------------------------------------------------------
    local function onBugTouch(event) --버그 터치하면 사라짐.
        if event.phase == "ended" then
            print("벌레 터치")
            display.remove(bugs)
            display.remove(bug)
            isAttacted = false
            rose[1].alpha= 1
            rose[2].alpha = 0
        end
    end
    --터치 이벤트부여
    bug:addEventListener("touch", onBugTouch) --터치하면 제거됨

end


--물뿌리개 --------------------------------------------------------------------------------

--1. 애니메이션 함수 --------------------------------------
local function watering(object)

    transition.to(object, {
        
        rotation = -90,  -- 왼쪽으로 90도 회전
        time = 500, --회전시간
        
        --회전완료하면,
        onComplete = function()
            -- 기울인 상태로 1초간 유지하기

            timer.performWithDelay(500, function()
                transition.to(object, {
                    rotation = 0,  -- 초기 회전 상태로 복귀
                    time = 500
                })
                end
            )
        end
    })
end


--2. 드래그이벤트 함수 ------------------------------------
local function onPotTouch(event) --드래그해서 장미에 놓으면, 물완료,장미정상 이벤트
    
    if( event.phase == "began" ) then
        display.getCurrentStage():setFocus( event.target )
        event.target.isFocus = true
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
            -- 드래그 끝났을때 && 물뿌리개를 장미 위에 갖다놨을때
            if ( event.target.x > display.contentCenterX - 100 and event.target.x < display.contentCenterX + 100
 					and event.target.y > display.contentCenterY - 100 and event.target.y < display.contentCenterY + 100
                    and isThirsty == true) then

                    --물뿌리는 효과음
                    ------------------------------------
                    --물뿌리개 1초간 물주고 원래자리로
                    watering(pot)
                    loadWaterSound()
                    event.target.x = display.contentWidth*0.86
 					event.target.y = display.contentHeight*0.4
                    --장미 건강하게
                    if rose[2].alpha == 1 then --시들어있었으면
                        rose[1].alpha = 1
                        rose[2].alpha = 0
                    end
                    --목마름스위치 false
                    isThirsty = false
            else --장미 위 아니면 원위치
                event.target.x = display.contentWidth*0.86
 				event.target.y = display.contentHeight*0.4
 			end
        else
            display.getCurrentStage():setFocus( nil )
            event.target.isFocus = false
        end
    end
end


--장미 함수 ---------------------------------------------------------------------------------
--장미 시듦상태로 변하는 함수
local function changeRoseImage() --5초마다 소환
    if (rose[1].alpha == 1) then
        loadWitherSound()
        rose[1].alpha = 0
        rose[2].alpha = 1 --시들기
        isThirsty = true
    end
end
--장미가 시든 상태로 2초 유지되는지 확인함수 (1초마다확인함)
local function checkRose() --게임루프안에넣기
    if (rose[2]. alpha == 1) then --시든상태면,
        wiltedTime = wiltedTime + 1
        if (wiltedTime >= 4) then --시든상태로 3초이상이면,
            print("게임오버")
            isDied = true
            rose[2].alpha = 0
            rose[3].alpha = 1
            timer.cancel(roseTimer)
            timer.cancel(bugTimer)
            timer.cancel(checkTimer)
            timer.cancel(gameTimer)
            
            local function goToNextScene()
                local options = {
                    effect = "fade", 
                    time = 1500 
                }
                    
                display.remove(bugs)
                composer.setVariable("gameOverNumber", 4)
                composer.removeScene("2층.장미키우기방.rose_game", options)
                composer.gotoScene("gameOver", options)
            end
            goToNextScene()
        end
    elseif(rose[2].alpha == 0) then
        wiltedTime = 0    
    end

    if (boxText.alpha == 1) then
        checkTime = checkTime + 1
        if (checkTime >= 4) then --체크요구상태로 4초 이상이면
            gameTime = gameTime+5
            boxText.alpha = 0
        end
    elseif (boxText.alpha == 0) then
        checkTime = 0
    end
end
--상자 함수-------------------------------------------------------------------------------------

--상자_파이 이벤트함수 ------------------------------------------
local function box_pi()
    local initX = pi.x
    local initY = pi.y
    --pi.x, pi.y = display.contentWidth*0.14, display.contentHeight*0.4

    local function removePi()
        pi.x, pi.y = initX, initY
    end

    
    transition.to(pi, {
        x = display.contentWidth*0.14, 
        y = display.contentHeight*0.4,
        time = 500, -- 이동하는 시간
        onComplete = function()
            timer.performWithDelay(2000, removePi)
        end
    })
    

end


--상자 함수 -----------------------------------------------------
local function onBoxTouch(event) --터치시, 상자완료 이벤트
    if event.phase == "ended" or event.phase == "canceled" then
        --if boxTimer then
            --timer.cancel(boxTimer)
            --boxTimer = nil
        boxText.alpha = 0
        isCareless = false
        box_pi()
        --end
    end
    --timer.performWithDelay(1000,removePi)
end

--박스체크요구 말풍선 생성 함수
local function checkSheep()
    boxText.alpha= 1
end

local function removeCheckSheep()--생성된후3초마다호출
    boxText.alpha = 0
    gameTime = gameTime+1
end


--유리덮개사라질때 애니메이션 -------------------------------------------
local function removeObjAnimation(obj)
    transition.to ( obj, {
        alpha = 0,
        time = 500,
        onComplete = function()
            display.remove(obj)
        end
    })
end



--메인 함수 -----------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
    --배경
	background = display.newImageRect("image/background2.png",1850, 1100)
    background.x, background.y = display.contentCenterX, display.contentCenterY
    --파이
    pi = display.newImageRect("image/캐릭터/pixil(뒤)-0.png", 450,450)
    pi.x, pi.y = 960,1100
    pi.alpha = 1
    --유리덮개장미
    glass = display.newImageRect("image/오브제/rose0_glass.png", 700,900)
    glass.x, glass.y = display.contentCenterX, display.contentCenterY-20
    --터치해서 시작
    tapToStart = display.newText({
        text = "유리덮개를 벗기고 게임시작", -- 표시할 텍스트
        x = display.contentCenterX, -- x 좌표
        y = display.contentCenterY, -- y 좌표
        width = 2000, -- 텍스트 영역의 가로 크기
        height = 1000, -- 텍스트 영역의 세로 크기
        font = "font/PF스타더스트.ttf", -- 사용할 폰트
        fontSize = 50, -- 폰트 크기
        align = "center" -- 정렬 방식 ("left", "center", "right")
    })
     --장미
    roseGroup = display.newGroup()
    for i = 1, 3 do
        rose[i] = display.newImageRect("image/오브제/rose"..(i-1)..".png", 700, 900)
        rose[i].x, rose[i].y = display.contentCenterX, display.contentCenterY
        rose[i].alpha = 0
        roseGroup:insert(rose[i])
	end
    --상자
    box = display.newImageRect("image/오브제/box2.png", 680,680)
    box.x, box.y = display.contentWidth*0.13, display.contentHeight*0.36
    --주전자
    pot = display.newImageRect("image/오브제/pot.png", 400,320)
    pot.x, pot.y = display.contentWidth*0.86, display.contentHeight*0.4
    --박스_말풍선
    boxText = display.newImageRect("image/오브제/checkSheep.png", 300, 270)
    boxText.x , boxText.y = display.contentWidth*0.61, display.contentHeight*0.2
    boxText.alpha = 0
    --게임남은시간
    timeText=  display.newText("", display.contentWidth*0.1, display.contentHeight*0.05)
    timeText.size = 70
    timeText:setFillColor(0)
    timeText.alpha = 0.8
    timeText = display.newText({
        text = "",
        x = display.contentWidth*0.85,
        y = display.contentHeight*0.1,
        font = "font/PF스타더스트.ttf", 
        fontSize = 80
    })

    sceneGroup:insert(background)
    sceneGroup:insert(roseGroup)
    sceneGroup:insert(glass)
    sceneGroup:insert(box)
    sceneGroup:insert(pot)
    sceneGroup:insert(pi)
    sceneGroup:insert(boxText)
    sceneGroup:insert(timeText)
    sceneGroup:insert(tapToStart)

    --start game- (유리덮개 누르면 게임시작)---------------------------------------------------------
    local function onTouchStart(event)
        if not gameStarted then
            removeObjAnimation(glass)
            glass.alpha = 0
            display.remove(tapToStart)
            rose[1].alpha = 1
            gameStarted = true --메인미션
        end
    end
    --장미 죽었는지 체크함수
    local function checkGameOver() --1초마다호출해서 확인하기
        if (rose[3].alpha == 1) then
            gameStarted = false
            isDied = true
            composer.removeScene("2층.장미키우기방.rose_game")
            local function goToNextScene()
                local options = {
                    effect = "fade", 
                    time = 2000 
                }
                timer.cancel(roseTimer)
                timer.cancel(bugTimer)
                timer.cancel(checkTimer)
                timer.cancel(gameTimer)
                audio.pause(4)
                composer.setVariable("gameOverNumber", 4)
                composer.removeScene("2층.장미키우기방.rose_game",options)
                composer.gotoScene("gameOver", options)
            end
            goToNextScene()
        end
    end
    --시간업데이트 함수
    local function updateTime()
        if (gameTime > -1) then
            gameTime = gameTime - 1
            print(gameTime)
        end

        timeText.text = "time: " .. gameTime
        if (gameTime <= 0) then
            gameStarted = false
            local function goToNextScene()
                local options = {
                    effect = "fade", 
                    time = 1500 
                }
                timer.cancel(roseTimer)
                timer.cancel(bugTimer)
                timer.cancel(checkTimer)
                timer.cancel(gameTimer)
                display.remove(bugs)
                Runtime:removeEventListener("enterFrame", isGameStarted)

                composer.removeScene("2층.장미키우기방.rose_game",options)
                composer.gotoScene("2층.장미키우기방.rose_outro_dialog", options)
            end 
            goToNextScene()    
        end
    end
    --게임루프함수 (장미죽음체크, 시간업데이트 -- 1초마다 호출하기)
    local function gameLoop()
        checkGameOver()
        updateTime()
        checkRose()
    end
    --게임시작됐는지 runtime확인함수
    local function isGameStarted(event)
        if gameStarted and not isDied then
            Runtime:removeEventListener("enterFrame", isGameStarted)

            gameTimer = timer.performWithDelay(1000, gameLoop, 0) --1초마다 게임오버/시간업뎃

            roseTimer = timer.performWithDelay(7000, changeRoseImage, 0) --5초마다 시들기
            bugTimer = timer.performWithDelay(13000, createBug, 0) --7초마다 벌레생성
            checkTimer = timer.performWithDelay(11000, checkSheep, 0) --9초마다 양 확인
            --Runtime:addEventListener("enterFrame", updateTime)
        end
    end

    pot:addEventListener("touch", onPotTouch) --pot 물주는 터치이벤트
    box:addEventListener("touch", onBoxTouch) --box 파이이동, 체크완료 터치이벤트
	
    glass:addEventListener("tap", onTouchStart) --유리덮개 누르면 게임시작

    Runtime:addEventListener("enterFrame", isGameStarted)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
        
        
	elseif phase == "did" then
		-- Called when the scene is now on screen
        --timer.performWithDelay(1000, updateTimer, gameTime) --남은시간타이머
	end	
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
        
        --Runtime:addEventListener("enterFrame", updateTime)
        timer.cancel(roseTimer)
        timer.cancel(bugTimer)
        timer.cancel(checkTimer)
        timer.cancel(gameTimer)

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