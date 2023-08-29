-----------------------------------------------------------------------------------------
--
-- picgame_sucess_2.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local gameSuccess = gameSuccess

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
    local framGroup = display.newGroup()
    local fram = {}


    fram[1] = display.newImageRect("image/artist/1.png", 165, 165)
    fram[2] = display.newImageRect("image/artist/2.png", fram[1].width, fram[1].height)
    fram[3] = display.newImageRect("image/artist/3.png", fram[1].width, fram[1].height)
    fram[4] = display.newImageRect("image/artist/4.png", fram[1].width, fram[1].height)


    for i = 1, 4 do
        fram[i].x, fram[i].y = 645 + (i - 1) * 250, 180
        framGroup:insert(fram[i])
    end

    local gun = display.newImageRect("image/자물쇠/총.png", 100, 100)
    gun.isVisible = false

    local function showGunImage()
        gun.isVisible = true
        gun.x = 1510
        gun.y = display.contentCenterY - 200
    end

    local function showGunImage()
        audio.play(gameSuccess)

        gun.isVisible = true
    
        gun.x = 1510
        gun.y = -10
    
        -- 이미지 떨어지는 애니메이션
        local targetY = display.contentCenterY - 200  -- 이미지가 떨어질 목표 Y 좌표
        local fallTime = 1000  -- 애니메이션 시간 (밀리초)
    
        transition.to(gun, {y = targetY, time = fallTime, transition = easing.outQuad})
    end
    
    local isGunShown = false
    
    local function showGun(event)
        if not isGunShown then
            showGunImage()
            isGunShown = true
        end
    end
    
    Runtime:addEventListener("tap", showGun)


    sceneGroup:insert(memo)
    sceneGroup:insert(framGroup)
    sceneGroup:insert(gun)


    -- 조작키 --------------------------------------

	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1820, 80
	sceneGroup:insert(restart)

	local not_interaction = display.newImageRect("image/UI/빈원형.png", 130, 130)
	not_interaction.x, not_interaction.y = 1740, 680
	not_interaction.alpha = 0

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


	-- 레이어 정리
	sceneGroup:insert(not_interaction)
	sceneGroup:insert(interaction)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)


    -- ↑ ui정리 -------------------------------------------------------------------------------------------------

    -- ↓ 플레이어 ---------------------------------------------------------------------------------------------------
	local player = {} 


		player[1] = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
		player[1].x, player[1].y = 1540, 240
		player[1].alpha = 1


	sceneGroup:insert(player[1])
    

-- ↓ 대화 ----------------------------------------------------------------------------------------------------
local talkGroup = display.newGroup()
local talk = {}
talk[1] = display.newImageRect("image/UI/대화창 ui.png", 1500, 1000)
talk[1].x, talk[1].y = display.contentWidth/2, 800

talk[2] = display.newImageRect("image/UI/대답박스 분리.png", 300, 150)
talk[2].x, talk[2].y = 450, 650

for i = 1, 2 do
    talkGroup:insert(talk[i])
end

sceneGroup:insert(talkGroup)

-- ↓ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
local Data = jsonParse( "2층/예술가의방/예술가의방_json/sucess.json" )

local dialog = display.newGroup()

local speaker = display.newText(dialog, "파이", 455, 642, font_Speaker)
speaker:setFillColor(0)
speaker.size = 50

local content = display.newText(dialog, "\"뭐지...?!!\"", 950, 760, font_Content)
content:setFillColor(0)
content.size = 30


local index = 0

local function nextScript( event )
    index = index + 1
    if(index > #Data) then 
        display.remove(dialog)
        display.remove(playerGroup)
        audio.pause(5)
        game3 = 1
        composer.gotoScene("2층.예술가의방.black") 
        return
    end

    speaker.text = Data[index].speaker
    content.text = Data[index].content
end

talk[1]:addEventListener("tap", nextScript)
dialog:toFront()

gun:toFront()

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
        composer.removeScene("2층.예술가의방.picgame_sucess_2")
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
