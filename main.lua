-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity(0,10)



local w,h =display.contentWidth, display.contentHeight
local cx, cy=display.contentCenterX, display.contentCenterY


local skyImg=display.newImage( "sky.png")
skyImg.x=cx
skyImg.y=cy

local myLine=display.newLine( 10, 10, cx, cy)
myLine.strokeWidth=3


local myCirc=display.newCircle( cx,cy, 150)
myCirc:setFillColor(0.5,0,0)
local  myRect=display.newRect(cx, cy, 200,200 )
myRect:setFillColor(1,0,0)



local kolobok=display.newImage( "kolobok@2x.png")
kolobok.x=cx
kolobok.y=cy


--transition.to(myRect,{time=10000, alpha=0, x=(w-50), y=(h-50)})
--transition.to(myImage,{time=10000, alpha=0, x=(w-50), y=(h-50)})




--Двигающиеся облака

local cloudImg=display.newImage("cloud.png")
local cloudspeed=0.0005
cloudImg.y=100

local cloudImg1=display.newImageRect("cloud.png",200,100)
cloudImg1.y=250
local cloudspeed1=0.0002

local cloudImg2=display.newImageRect("cloud.png", 180,80)
local cloudspeed2=0.0001
cloudImg2.y=400



count=0
local function repeatFade (event)
	local params=event.source.params
	params.obj.x=w
	transition.to(params.obj, {x=(0-params.obj.width/2), time=params.t } )
end

-- нестройка таймеров    
local tm=timer.performWithDelay(1/cloudspeed, repeatFade, 100)
tm.params={t=1/cloudspeed, obj=cloudImg}

local tm1=timer.performWithDelay(1/cloudspeed1, repeatFade, 100)
tm1.params={t=1/cloudspeed1, obj=cloudImg1}

local tm2=timer.performWithDelay(1/cloudspeed2, repeatFade, 100)
tm2.params={t=1/cloudspeed2, obj=cloudImg2}



-- Земля
local landImg=display.newImage("land.png")
local landImg1=display.newImage("land.png")
landImg.y=1850
landImg1.y=landImg.y

landImg1.x=landImg.x+landImg.width
local speed=20

function enterFrame(event)
	landImg.x=landImg.x-speed
	landImg1.x=landImg1.x-speed
	if (landImg.x+landImg.width)<=0 then
		landImg.x=landImg1.x+landImg.width
	end

	if (landImg1.x+landImg1.width)<=0 then
		landImg1.x=landImg.x+landImg.width
	end

end
 physics.addBody(kolobok, "dynamic")
  physics.addBody(landImg, "static")
   physics.addBody(landImg1, "static")
Runtime:addEventListener("enterFrame", enterFrame)

