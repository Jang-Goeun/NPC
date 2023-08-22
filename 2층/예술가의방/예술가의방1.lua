-----------------------------------------------------------------------------------------
--
-- memo.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local background = display.newImage("image/배경/배경_저택_예술가의방.png", display.contentCenterX, display.contentCenterY)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	local memo = display.newImageRect("image/UI/세모", 200, 200)

    local picGroup = display.newGroup()
    local pic = {}
    pic[1] = display.newImageRect("image/예술가의방/artist/예술가의방 그림 H.png", 200, 150)
    pic[1].x, pic[1].y = 700, 850
    picGroup:insert(pic[1])
    pic[2] = display.newImageRect("image/예술가의방/artist/예술가의방 그림 U.png", pic[1].width, pic[1].height)
    pic[2].x, pic[2].y = 500, 400
    picGroup:insert(pic[2])
    pic[3] = display.newImageRect("image/예술가의방/artist/예술가의방 그림 N.png", pic[1].width, pic[1].height)
    pic[3].x, pic[3].y = 1000, 600
    picGroup:insert(pic[3])
    pic[4] = display.newImageRect("image/예술가의방/artist/예술가의방 그림 T.png", pic[1].width, pic[1].height)
    pic[4].x, pic[4].y = 1450, 700
    picGroup:insert(pic[4])
    sceneGroup:insert(picGroup)

    local framGroup = display.newGroup()
    local fram = {}
    fram[1] = display.newImageRect("image/예술가의방/artist/오브제 액자.png", 200, 200)
    fram[1].x, fram[1].y = 700, 180
    framGroup:insert(fram[1])
    fram[2] = display.newImageRect("image/예술가의방/artist/오브제 액자.png", fram[1].width, fram[1].height)
    fram[2].x, fram[2].y = 950, 180
    framGroup:insert(fram[2])
    fram[3] = display.newImageRect("image/예술가의방/artist/오브제 액자.png", fram[1].width, fram[1].height)
    fram[3].x, fram[3].y =1200, 180
    framGroup:insert(fram[3])
    fram[4] = display.newImageRect("image/예술가의방/artist/오브제 액자.png", fram[1].width, fram[1].height)
    fram[4].x, fram[4].y = 1450, 180
    framGroup:insert(fram[4])
    sceneGroup:insert(framGroup)
-- ↑ 배경 ----------------------------------------------------------------------------------------------------

-- ↓ 대화 ----------------------------------------------------------------------------------------------------
	local talk = {}
    talk[1] = display.newImage("image/UI/대화창 ui.png")
	talk[1].x, talk[1].y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk[1]:scale(0.7, 0.78) -- 대화창

    talk[2] = display.newImageRect("image/UI/대답박스 분리.png", 350, 200)
    talk[2].x, talk[2].y =520, 610

-- ↓ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------
    local Data = jsonParse( "2층/예술가의방/예술가의방_json/memo.json" )

    local dialog = display.newGroup()

    local name = display.newText(dialog, "메모", 520, 610, font_Speaker)
	name:setFillColor(0)
	name.size = 50

	local content = display.newText(dialog, "[이곳은 사냥을 위해 만들어진 곳이다. 너도 사냥을 하기 위해 여기 왔겠지. 숨은 것을 잘 찾아 사냥해보렴.]", 960, 760, font_Content)
	content:setFillColor(0)
	content.size = 30

    if Data then
        print(Data[1].name)
        print(Data[1].content)
    end
    local index = 0

    local function nextScript( event )
        index = index + 1
        if(index > #Data) then 
            display.remove(dialog)
            display.remove(talk[1])
            display.remove(talk[2])
            composer.gotoScene("2층.예술가의방.예술가의방2") 
            return
        end

        name.text = Data[index].name
        content.text = Data[index].content
    end

    talk[1]:addEventListener("tap", nextScript)
    dialog:toFront()

-- ↑ json1에서 정보 읽고 적용 ----------------------------------------------------------------------------------

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