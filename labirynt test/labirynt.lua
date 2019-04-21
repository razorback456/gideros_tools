	Z = {}  --масив зірок
	POS={}   --  масив зєднаних зірок
	table.insert(POS, 1)
----------------------------------------------------------------------------
--
-----------------------------------------------------------------

function logGame(blox,blocy,d)
	--dovg=d
	---------------матриця поля---------------------------------
	P={}
	for i=1,blocy do  -- створити рядки
		P[i]={}
		for ii=1,blox do   -- створити стопці
			P[i][ii]={0,0,0,0,0,0,0}  -- створити параметри  верх/право/низ/ліво/  мітка фігури/ відвідана клітина/ сигнал
			P[i][ii].s=0
		end
	end
	--P[i][ii][1-4]-- стіна
	--P[i][ii][5]=1  -- тупік
	-------------------------------------------------------------
	--P[1-blocy][1-blox][1-7]
	--вибрати випадкову клітину
	Kx=math.random(blox)
	Ky=math.random(blocy)

	--P[Ky][Kx][5]=a  --присвоїти клітині номер
	local a=1
	DX=0
	DY=0

	repeat
		dovg=d--5  -- макс довж  4-100   ///5*10-20-40-80
		a=a-1
			repeat
				vect=math.random(4)  -- випадковий напрям 
				if vect==1 then 
					DY=-1 DX=0
					elseif vect==2 then 
					DX=1 DY=0
					elseif vect==3 then 
					DY=1  DX=0
				else
					DX=-1  DY=0
				end
				nx, ny = Kx+DX, Ky + DY   -- координати потенціальної точки маршруту
				------------КРОК на пусту----------------------
				if nx>0  and ny>0 and  ny<=blocy and  nx<=blox and P[ny][nx][5]==0 and dovg>0 then  --якшо потенційна ячейка пуста та в межі поля
					dovg=dovg-1
					P[ny][nx].x=Kx  --координати попередньої точки маршруту
					P[ny][nx].y=Ky
					Kx,Ky=nx,ny
					a=a+1
					P[Ky][Kx][5]=a 
					
				else  -- відмічаєм в цьому напрямку стіну
					 P[Ky][Kx][vect]=1	-- vect  1-верх/2-право/3-низ/4-ліво/ 
				end
				-----------------------------------
			until  P[Ky][Kx][1]+P[Ky][Kx][2]+P[Ky][Kx][3]+P[Ky][Kx][4]==4 -- якшо є 4 стіни
				 
			-------------КРОК на заняту-----------------------------	 
			
			--поставити всі стіни
			--вибити стіну в напрямку переходу
			 P[Ky][Kx][1],P[Ky][Kx][2],P[Ky][Kx][3],P[Ky][Kx][4]=1,1,1,1
			if P[Ky][Kx][5] ~=1 then
				 if Ky> P[Ky][Kx].y then P[Ky][Kx][1]=0 
				 elseif Ky< P[Ky][Kx].y then P[Ky][Kx][3]=0 
				 elseif Kx< P[Ky][Kx].x then P[Ky][Kx][2]=0 
				 elseif Kx> P[Ky][Kx].x then P[Ky][Kx][4]=0
				 end
			end
			 
			Ky,Kx=	P[Ky][Kx].y,P[Ky][Kx].x 
			
			----------------------------------------
	 until a==1
	 ---------------------------------------------------
		for iv=1,blocy do  --вибивати стіни 
			 for iiv=1,blox do
				if P[iv][iiv][2]==0 then --право
					if  P[iv][iiv][5]- P[iv][iiv+1][5]==1 or P[iv][iiv][5]- P[iv][iiv+1][5]==-1 then
						P[iv][iiv+1][4]=0 
					
					end
				end
				if P[iv][iiv][4]==0 then  --ліво
				
					if  P[iv][iiv][5]- P[iv][iiv-1][5]==1 or P[iv][iiv][5]- P[iv][iiv-1][5]==-1 then
						P[iv][iiv-1][2]=0 
					
					end
				end
				if P[iv][iiv][3]==0 then  --низ
		
					if  P[iv][iiv][5]- P[iv+1][iiv][5]==1 or P[iv][iiv][5]- P[iv+1][iiv][5]==-1 then
						P[iv+1][iiv][1]=0 
					
					end
				end
				
				if P[iv][iiv][1]==0 then  --верх
		
					if  P[iv][iiv][5]- P[iv-1][iiv][5]==1 or P[iv][iiv][5]- P[iv-1][iiv][5]==-1 then
						P[iv-1][iiv][3]=0 
				
					end
				end
			 
			 
			 
			 
			 end 
		end 
	
		
	
end



-------------------------------
--
--------------------------------

function  drawLabirynt(z)


P[1][1][1]=0  --вхід прибратри стіну
P[#P][#P[1]][2]=0 -- вихід
-- вхід стіни
MYline(1*z,1*z,1*z,1*z-z)
MYline(1*z+z,1*z,1*z+z,1*z-z)
--вихід стіни
MYline(#P[1]*z+z,#P*z,#P[1]*z+z+z,#P*z)
MYline(#P[1]*z+z,#P*z+z,#P[1]*z+z+z,#P*z+z)
-------------------------------------
--
-----------------------------------------------
	for i=1,#P do  --Y 
			for ii=1,#P[i] do  --  X
				q1,q2,q3,q4=P[i][ii][1],P[i][ii][2],P[i][ii][3],P[i][ii][4]
				
				if q1==1 then MYline(ii*z,i*z,ii*z+z,i*z) end
				if q3==1 and i==#P then MYline(ii*z,i*z+z,ii*z+z,i*z+z) end
				if q4==1 then MYline(ii*z,i*z,ii*z,i*z+z) end
				if q2==1 and ii==#P[i]  then MYline(ii*z+z,i*z,ii*z+z,i*z+z) end
			end
	end
end

function MYline(x,y,xx,yy)
	local myShapeX = Shape.new()  --создали фигуру
	myShapeX:setLineStyle(4, 0x77E8FE , 1)   -- обводка  2пикс толщиной цветом 0x0000FF  и прозрачность 50%
	myShapeX:beginPath()   --рисуем путь из линий
	myShapeX:moveTo(x,y)  --стартовая точка
	myShapeX:lineTo(xx,yy)
	myShapeX:endPath()  --замыкаем путь в фигуру
	room1:addChild(myShapeX)  -- добавляем фигуру в уровень  у нас вышел квадрат
	
end
--star.new(tx,ty,new_z) -- рисуем звезды
------------------------------------
--	 вузлові зірки
------------------------
function  drawStar(z)


	table.insert(Z, star.new(1*z+z/2,1*z+z/2-z,1))   --  Z[1]  перша
	Z[1].x=1 
	Z[1].y=0
	table.insert(Z,star.new(#P[1]*z+z/2+z,#P*z+z/2,1))   --  Z[2]  остання
	Z[2].x=#P[1]+1
	Z[2].y=#P
	
-------------------------------------------------------------------

-------------------------------------------------------------------

	for i=1,#P do  --Y 
			for ii=1,#P[i] do  --  X
				q1,q2,q3,q4=P[i][ii][1],P[i][ii][2],P[i][ii][3],P[i][ii][4]
				
				if q1+q2+q3+q4==2 then
					if q1+q3==0 or q2+q4==0 then
					else
					
						table.insert(Z, star.new(ii*z+z/2,i*z+z/2,1) )
						
						Z[#Z].x=ii
						Z[#Z].y=i
						
					end
				else
					table.insert(Z, star.new(ii*z+z/2,i*z+z/2,1) )
						Z[#Z].x=ii
						Z[#Z].y=i
				end
			
			
			end
	end
	-------------------------------------------
	
	for i=1, #Z do
	Z[i].col=0
		room1:addChild(Z[i])

	end
	Z[1].col=1
end



	
aa=30
logGame(10,10,400)
 drawLabirynt(aa)
 drawStar(aa)