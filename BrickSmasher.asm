.model small
.stack 100h

.data

;tasks
;------ take input name from user
;		display on screen
;		on restart use same name
;		upon restart reset variables
; 		make instructions screen
;		make leaderbaord screen	
;				file handling

;		make timer
;		show timer
; 		implement sound


;aesthetics 


;game variables

	isActive db 0  ; will be used as a boolean checker to see if game is active or not
	currentScreen db 0  ;what menu 0->main menu  ; 1->game
	currentLevel db 1
	exitGame db 0	;variable to exit game or not
	backgroundColor db 0CH
	


;time variables 

	
	timeCheck db 0  ;variable to check time change


;ball variables 

	initialBallX  dw 150  ;initial co-ordinates of the ball
	initialBallY  dw 130
	
	ballX dw 150   ;starting x and y co-ordinates
	
	ballY dw 130 
	ballSize dw 7   ;size of ball in x and y direction (radius)
	
	ballVelocityX dw  2     ;changes the speed of the ball 
	ballVelocityY dw  5
	
	
	;brick variables
	
	bricksXArray dw 80,100,120,140,160,180,200,220 ;x-coordinates of bricks  (10 bricks)
	dw 80,100,120,140,160,180,200,220
	dw 80,100,120,140,160,180,200,220
	bricksYArray dw 8 dup(50) 						 ;y-coordinates of bricks (3 rows)
	dw 8 dup(70)
	dw 8 dup (90)
	currentBrickX dw 80
	currentBrickY dw 40
	totalBricks dw 48 		; totalbricks= 48/2 = 24
	currentBricks dw 48   
	
	;bricksRows   		dw 12   ;3 rows
	;bricksColumns		dw	40   ;10 columns
	;currentBrickRow		dw  0
	;currentBrickCol		dw  0
	
	bricksLivesLevel1 dw 8 dup(1)					 ;number of hits to break the brick
	dw 8 dup(1)
	dw 8 dup(1)
	
	bricksLivesLevel2 dw 8 dup(2)					 ;number of hits to break the brick
	dw 8 dup(2)
	dw 8 dup(2)
	
	;bricksLivesLevel3
	;dw 8 up(3)
	;dw 8 dup(3)
	;dw 8 dup(3)
	bricksLivesLevel3 dw 2 dup(10)					 ;number of hits to break the brick
	dw 2 dup (3)
	dw 10
	dw 3 dup (3) 					;1st row
	
	dw 5 dup(3)							;2nd row
	dw 10
	dw 2 dup (3) 		
	
	dw 8 dup(3)							;3rd row
	
	specialBrickNumber dw 0    			;the index of the specialBrick
	specialBrickCounter dw 5 
	
	
	bricksWidth dw 15  ;width of one brick to draw
	bricksHeight dw 10  ;height of one brick
	 
	
;boundary variables

	boundaryWidth	dw  140h  	  ; 320 pixels 
	boundaryHeight  dw  0C8h      ; 200pixels
	
;paddle
	
	paddleX dw 150  ;left side of paddle
	paddleY dw 190 
	
	;position variables
	paddleHeight dw 5
	paddleWidth dw  50
	paddleVelocity dw 10
	
;player variables

	
	playerLives db 3
	playerScore db 0
	
	
;UserInterfaceText


;FileHandling Highscore Variables
    Username db 20 dup('$')
    highscorefile db 'Hscore.txt',0
    handle dw ?
    spaces db '     ','$'
	stringscreen db 1

	;main menu text
	
	gameNameText db "Brick Breaker", '$'
	userNameText db "Insert Name",'$'
	startGameText db "Press A to start Game", '$'
	seeInstructionText db "Press I to see instructions", '$'
	seeLeaderboardText db "Press L to see leaderboard", '$'

	playerLivesString 	   db "Lives:",'$'
	playerLivesCounterText db 3 dup(3),'$'
	playerLivesCounterText2 db ' ','$'
	playerLivesCounterText1 db ' ','$'
	
	
	playerScoreString 	   db "Score:",'$'
	playerScoreCounterText db '0','$'
	playerScoreDigit1 db 0
	playerScoreDigit2 db 0
	;rem db 0
	gameOverText db "Game Over!", '$'
	
	yourScoreIsText db "'s Score is : " , '$'
	restartGameString db "Press R to play again" , '$'
	returnToMainMenuString db "Press E to return to Main Menu", '$'
	LevelString db "Level: " ,'$'
	
	pauseScreenString db 'Game Is Paused', '$'
	pauseScreenKeyString db 'Press Enter Key To resume', '$'
	pauseScreenEscape db 'Press E again to return to main Menu', '$'

	youWinString db 'Congratulations!You have won the game!','$'
	exitGameText db "Press E to exit game", '$'
	lvl db ' ','$'
	
	instructionsMenu db 'Welcome to the instructions menu', '$'
	instructionLine1 db 'Use a and d keys to move paddle', '$'
	instructionLine2 db 'Destroy All Bricks To Win The Game', '$'
	instructionLine3 db 'You only have 3 lives and there are 3 levels', '$'
	instructionLine4 db 'Each level increases number of hits to destroy bricks', '$'
	instructionLine5 db 'The final brick has some immovable bricks and some special bricks', '$'
	instructionLine6 db 'Hit the special brick to destroy 5 bricks instantly!', '$'
	


 

.code

bricksDrawMacros35 macro X,Y

drawBrickHorizontalLines35:
		
		
			mov ah,0ch 						;write pixel
			mov al, 2CH				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines35  ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines35  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm

bricksDrawMacros310 macro X,Y

drawBrickHorizontalLines310:
		
		
			mov ah,0ch 						;write pixel
			mov al, 1CH				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines310   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines310  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm


bricksDrawMacros33 macro X,Y

drawBrickHorizontalLines33:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'E'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines33   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines33  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm


bricksDrawMacros32 macro X,Y

drawBrickHorizontalLines32:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'D'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines32   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines32  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm

bricksDrawMacros31 macro X,Y

drawBrickHorizontalLines31:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'C'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines31   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines31  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm

bricksDrawMacros22 macro X,Y

drawBrickHorizontalLines22:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'F'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines22   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines22   ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm



bricksDrawMacros21 macro X,Y

drawBrickHorizontalLines21:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'C'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines21   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines21   ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm

bricksDrawMacros11 macro X,Y

drawBrickHorizontalLines11:
		
		
			mov ah,0ch 						;write pixel
			mov al, 'C'				;yellow color of ball
			mov bh,00h 
			int 10h 
			
			;draws horizontal line
			inc cx         
			mov ax,cx    
			sub ax,X      			;incrementing x cordinates till it is size of paddle width
			cmp ax,bricksWidth 				;checks if x cordinates is greater than the paddle width
			jne drawBrickHorizontalLines11   ;reach width of paddle. If nt->go to label ; If t->go next line of code
					
			;increments y axis and draws horizontal line one at a time
			mov cx, X				;goes back to initial x cordinates
			inc dx 							;inc y_axis
			mov ax,dx
			sub ax,Y
			cmp ax,bricksHeight
			jne drawBrickHorizontalLines11  ;double loop
			
			;resetting y Position
			
		;	add currentBrickCol,4
			
			;mov ax,bricksColumns
			;cmp currentBrickCol,ax
			;jne nextBrickInRow
		
			
		;	resetRowsIncrementColumns:
				
		;		mov currentBrickRow,0
		;		inc currentBrickCol
			
		;	compareCols:
			
		;		mov ax,bricksColumns
		;		cmp currentBrickCol,ax
		;		jne nextBrickInRow
		
		


endm


main proc 

;---- data moving code
	mov ax,@data
	mov ds, ax

;------clear all registers --------

	mov ax,0
	mov bx,0
	mov cx,0
	mov dx,0
	
	call randomBrickNumber

		mov ah,0h  					;set video mode 
		mov al,13h 					;video mode selection
		int 10h   					;executing
		
		mov ah,0Bh
		mov bh,00h  				;background color
		mov bl,01h  				;choosing black
		int 10h
		
	call graphicsAndClearScreen
	
	
	UsernameMenu:
			call drawUsernameMenu
			jmp TimeCheckLabel

;----- time-----

	TimeCheckLabel:
	
		cmp exitGame,1
		je exitGameLabel
	
		;cmp stringscreen,1
		;je drawUsernameMenu
		
		cmp currentScreen,0
		je mainMenu
	
		cmp isActive,0
		je   gameOverMenu
		
		
		mov ah,2ch 				;get system time
		int 21h    				;CH=hour , Cl=min , DH = Second, DL= 1/100 secs
		
		cmp dl,timeCheck 		;checking time with previous variable
		je TimeCheckLabel       ;keep checking if it is same
		
		;if time is different then perform functionalities
		
	;---drawing ball---
		
		mov timeCheck,dl ;update variable
		
			
		call graphicsAndClearScreen				
		
		call drawBricks
		
		call ballMove 		 ;ball collision detection complete ---> check if it works
							; ball reset position if it falls below screen remaining
		
		call drawBall
		

		call drawPaddle
		call paddleMove     ;arrow key implementation remaining 
		
		call drawUserInterface		;draw all the game user interface
		
		
		jmp TimeCheckLabel
		
		

		gameOverMenu:
			call drawGameOverMenu
			jmp   TimeCheckLabel
			
		
		mainMenu:
			call drawMainMenu
			jmp TimeCheckLabel
			
			
		exitGameLabel:
			call exitGameProcedure
		
	






;--- ending program with escape sequence----

	programExit:
	
		mov ah,4ch
		int 21h

main endp 

randomBrickNumber proc


RANDGEN:         ; generate a rand no using the system time
RANDSTART:

	mov cx,1
	startDelay:
	cmp cx,30000
	je endDelay
	inc cx
	jmp startDelay
	
	endDelay:


   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 24
   div  cx       ; here dx contains the remainder of the division - from 0 to 9
   mov dh,0
   mov specialBrickNumber,dx

  ; add  specialBrickNumber, '0'  ; to ascii from '0' to '9'
   ;mov ah, 2h   ; call interrupt to display a value in DL
   ;int 21h      
   
   mov si, specialBrickNumber
   mov ax,si
   mov bx,2
   mul bx
   mov si,ax
   mov bricksLivesLevel3[si],5
   
   ret
randomBrickNumber endp


exitGameProcedure proc

	mov ah,00h
	mov al,02h
	int 10h
	
	mov ah,4ch
	int 21h


exitGameProcedure endp

;---------- increments x and y cordinates of the ball 
;---------- uses ax register to add variables 

ballMove proc

	;----horizontal movement
	
		mov ax,ballVelocityX  
		add ballX,ax
		
	    ;if xcordinate of ball < 0
			;reverse direction of ball by changing velocity
		
		cmp ballX,0
		jle reverseVelocityX
		
		
		;if xcordinate of ball+ballSize> boundaryWidth
			;reverse direction of ball 
			
		mov ax,boundaryWidth
		sub ax,ballSize
		cmp ballX,ax
		jge reverseVelocityX
			
	;----vertical movement 

		mov ax,ballVelocityY  
		add ballY,ax


		;if Ycordinate of ball < 0
			;reverse direction of ball by changing velocity
		
		cmp ballY,0
		jle reverseVelocityY
		
		
		;if Ycordinate of ball+ballSize> boundaryHeight
			;reset position 
			
		mov ax,boundaryHeight	
		sub ax,ballSize
		cmp ballY,ax      			 ;comparing y cordinates of ball with boundary using ax register 
		jge resetPosition

		jmp PaddleCollision
		
		;velocityX= -velocityX
		reverseVelocityX:    
			neg ballVelocityX
			jmp exitBallMove
		
		;velocityY = -velocityY
		reverseVelocityY:
			neg ballVelocityY
			jmp exitBallMove
			
		;if ball falls below the screen reset the ball position	
		; decrement lives 
		resetPosition:
			call ballResetPosition
			jmp exitBallMove
			
			
			
			
			
; 	Checking if it is colliding with paddle 
	;(ballX+ballSize> paddleX) and (ballX< paddleX+paddleWidth) and....   
	; ... (ballY+ballSize>paddleY) and (ballY<paddleY+paddleHeight)
	
;x -coordinate checking
	;1st condition

PaddleCollision:	
		mov ax, ballX
		add ax,ballSize
		cmp ax,paddleX
		jl exitBallMove    ;if condition is not satisfied (no collision) then exit 
		
		;2nd condition
		mov ax,paddleX
		add ax,paddleWidth
		cmp ax,ballX
		jng exitBallMove
		
	;y coordinate checking
		;3rd condition
		mov ax,ballY
		add ax,ballSize
		cmp ax,paddleY
		jl exitBallMove
		
		;4th condition
		mov ax,paddleY
		add ax,paddleHeight
		cmp ax,ballY
		jng exitBallMove
		
		
		;if all conditions are satisfied it is colliding
		neg ballVelocityY 			;changes direction of vertical velocity 
		
		call audioAids
		
		
		
	
	exitBallMove:
		ret
		
ballMove endp

;----- function to call if ball falls below edge of screen
;----- resets ball position and reduces the number of lives
;----- uses ax register and variables

ballResetPosition proc
	
	dec playerLives				;decreases player lives
	
	cmp playerLives,0   		;if player lives reach 0 then game is over---> reset player points 
	je gameOverCall
	jne continueballResetPosition
	
	gameOverCall:     	;calls game over and jumps to the exit
		
		call gameOver   					;resets lives
		
		jmp ballResetPositionExit
	
	
	
	continueballResetPosition:
	
		
	
		call updateLivesText
		
		mov ax,initialBallX
		mov ballX,ax
				
		mov ax,initialBallY
		mov ballY,ax
		
		mov paddleX,150
		mov paddleY, 190
		
		
ballResetPositionExit:		

	ret

ballResetPosition endp	




;----- after ball falls off edge the lives gets updated and the text on the screen gets updated


updateLivesText proc

	mov ax,0    		;cleaning up ax register
	mov al,playerLives 	;displays the lives
	
	
	;before printing convert decimal to ascii
	;add 30h  (num to ascii)
	
	;add al,30h
	.if(al<3)
		.if(al==2)
			mov bl,playerLivesCounterText2
			mov [playerLivesCounterText+2],bl	  ;moves value to string
		.endif
		.if(al==1)
			mov bl,playerLivesCounterText1
			mov [playerLivesCounterText+1],bl
		.endif
	.else
		mov bl,3
		mov [playerLivesCounterText],bl
		mov [playerLivesCounterText+1],bl
		mov [playerLivesCounterText+2],bl
	.endif
	
	

	exitUpdateLivesText:
		ret

updateLivesText endp


;-----  
updateScoresText proc

	mov ax,0    		;cleaning up ax register
	mov al,playerScore 	;displays the lives
	
	
	;before printing convert decimal to ascii
	;add 30h  (num to ascii)
	
	
	add al,30h
	mov [playerScoreCounterText],al  ;moves value to string
	sub al,30h
	;clear AH to use for reminder
    mov ah,00
    ;moving var to al
    ;mov al,var
    ;take bl=10
    mov bl,10
    ;al/bl --> twodigit number/10 = decemel value
    div bl
    ;move reminder to rem
    mov playerScoreDigit2,ah
	mov playerScoreDigit1,al
    


	exitUpdateLivesText:
		ret

updateScoresText endp


;------ resets variables 
;bricks health reset need to implementation
;player score reset 

gameOver proc

	
	mov playerLives,03h

	;inc playerLives	
	call updateLivesText	;not sure why this fixes the bug
	mov isActive,0				;will stop the game  
	
	mov currentLevel,1
	mov playerScore,0
	mov ballVelocityX,2
	mov ballVelocityY,5
	mov paddleWidth,50
	mov backgroundColor,0CH
	
	mov ax,initialBallX
		mov ballX,ax
				
		mov ax,initialBallY
		mov ballY,ax
		
		mov paddleX,150
		mov paddleY, 190
	
	mov cx,48
	
	
	.while(cx>0)
		
		mov si,cx
		
		mov bricksLivesLevel1[si],1
		mov bricksLivesLevel2[si],2
		mov bricksLivesLevel3[si],3
		
	
		sub cx,2
	
	.endw
	
	mov bricksLivesLevel3[0],10
	mov bricksLivesLevel3[2],10
	mov bricksLivesLevel3[8],10
	mov bricksLivesLevel3[18],10
	call randomBrickNumber
	
	


	ret

gameOver endp



paddleMove proc

	;check if pressed a key 
	
	mov ah,01h
	int 16h   						;zf=0 if key is pressed
	jz exitPaddleProc
	
	
	;else exit procedure
	
	;check which key pressed
	checkKey:
	
		mov ah,00h
		int 16h   ;al has ascii character
		jz exitPaddleProc
		
		; -> arrow key or D key or d key to move right
		
		cmp al, 44h
		je paddleMoveRight
		cmp al, 64h
		je paddleMoveRight
		
		; <- arrow key or A key or a key to move left
		
		cmp al,41h
		je paddleMoveLeft
		cmp al,61h
		je paddleMoveLeft
		
		cmp al,1Bh
		je PauseMenu
		
		jmp exitPaddleProc
		
		PauseMenu:
			call drawPauseMenu


	;------ move the paddle to the left by incrementing velocity variable
		paddleMoveLeft:
			
			mov ax,paddleVelocity
			sub paddleX,ax
			
			;checking if it goes below 0 x cordinates
			
			cmp paddleX,0
			jle paddleBoundaryFixLeft  ;if paddle moves too much to the left move it back
			
			jmp exitPaddleProc
			
			paddleBoundaryFixLeft:
			
				mov paddleX,0
				jmp exitPaddleProc
						
		
		
	;------ move the paddle to the right by incrementing velocity variable
		paddleMoveRight:
			
			mov ax,paddleVelocity
			add paddleX,ax
			
			mov ax,boundaryWidth        ;the paddle shouldn't exceed boundary width
			sub ax, paddleWidth     	;subtracting length of the paddle from the width 
			cmp paddleX,ax  			;if X cordinate of paddle moves out of bounds then move it back
			jge paddleBoundaryFixRight  ;if it is greater move paddle back
			
			jmp exitPaddleProc
			
			paddleBoundaryFixRight:   	;move paddle back
				
				mov paddleX,ax        	;changing the x-cordinate
			
			jmp exitPaddleProc



	exitPaddleProc:
		ret
		
		
paddleMove endp


;------- function to draw ball on the screen ----------
	;--- uses a double loop to draw ball and variables defined in data ----
	;--- uses cx,dx,ah,al,bh registers
drawBall proc

	;initializing ball 
	mov cx, ballX ;x cordinates
	mov dx, ballY ;y cordinates
	
	drawBallHorizontalLines:
	
		mov ah,0ch ;write pixel
		mov al, 1110b ;yellow color of ball
		mov bh,00h 
		int 10h 
		
		;draws horizontal line
		inc cx         
		mov ax,cx    
		sub ax,ballX       			 ;incrementing x cordinates till it is size of ball
		cmp ax,ballSize    			 ;checks if x cordinates is greater than the size 
		jne drawBallHorizontalLines  ;reach width of ball. If nt->go to label ; If t->go next line of code
				
		;increments y axis and draws horizontal line one at a time
		mov cx, ballx 				 ;goes back to initial x cordinates
		inc dx 						 ;inc y_axis
		mov ax,dx
		sub ax,ballY 
		cmp ax,ballSize
		jne drawBallHorizontalLines  ;double loop
	

	ret
	
drawBall endp



drawBricks proc

	;draws one brick by going to first X-cordinate of first brick till length of width of brick
	;increments y axis goes to the y axis of the first row
	;rests y axis and moves to next x cordinate of brick
	;repeats this process till whole row has been traversed 
	;goes into the second coordinates of the y axis and jumps back the first x cordinates of the bricksX
	;repeats till end of Yaxis of bricks is reached 
	
		mov si ,0
	nextBrickInRow:
	
	
	;need to see why it doesn't move into registers
		
		mov ax, bricksXArray[si]
		mov currentBrickX,ax
		
		mov ax,bricksYArray[si]
		mov currentBrickY,ax

		mov cx, bricksXArray[si]				;x cordinates
		mov dx, bricksYArray[si]					;y cordinates
		
		
		.if(currentLevel==1)
			mov ax,bricksLivesLevel1[si]

			
		.elseif(currentLevel==2)
			mov ax,bricksLivesLevel2[si]	
			
		.elseif(currentLevel==3)
			mov ax,bricksLivesLevel3[si]

		.elseif(currentLevel==4)
			call drawYouWin
		
			
		.endif
		
		
		;checks collisions with the bricks
	.if(ax>0)	
		BricksCollision:	
			mov ax, ballX
			add ax,ballSize
			cmp ax,currentBrickX
			jl drawBricksLevel    ;if condition is not satisfied (no collision) then exit 
			
			;2nd condition
			mov ax,currentBrickX
			add ax,bricksWidth
			cmp ax,ballX
			jng drawBricksLevel
			
		;y coordinate checking
			;3rd condition
			mov ax,ballY
			add ax,ballSize
			cmp ax,currentBrickY
			jl drawBricksLevel
			
			;4th condition
			mov ax,currentBrickY
			add ax,bricksHeight
			cmp ax,ballY
			jng drawBricksLevel
			
			
			;if all conditions are satisfied it is colliding
			neg ballVelocityY 			;changes direction of vertical velocity 
			call audioAids
			
			.if(currentLevel==1)
				mov bricksLivesLevel1[si],0
				mov ax,bricksLivesLevel1[si]
			

				
			.elseif(currentLevel==2)
				dec bricksLivesLevel2[si]
				mov ax,bricksLivesLevel2[si]
				
			.elseif(currentLevel==3)
				mov ax,bricksLivesLevel3[si]
				
				;implement random brick functionality
				
				.if(ax==5)
					
					mov bricksLivesLevel3[si],0
					sub currentBricks,2
					call specialBrick
				
				.elseif(ax!=10)							;-->reduce totalnumber of bricks for level 3
					dec bricksLivesLevel3[si]
				.endif
				
				mov ax,bricksLivesLevel3[si]
			.endif
			
			
			
			
			cmp ax,0
			jne skipPlayerScore
			
			increasePlayerScore:
			
				inc playerScore
				call updateScoresText
				sub currentBricks,2
				
			.if(currentLevel==3)
				call checkUntouchableBricks
			.endif
				
			
	.endif

skipPlayerScore:	
	
	;level finishes  
	.if(currentBricks==0)
	
		mov si,0
		
		mov ax,totalBricks
		mov currentBricks,ax
		
		inc currentLevel			;-->need to compare level number to exit
		

		
		
		
		;resetting ball position
		
			;mov ax,initialBallX
			;mov ballX,ax
					
			;mov ax,initialBallY
			;mov ballY,ax
			
			
			
		; resetting paddle position 
		
		
		;increasing speed of ball and decreasing paddle width
		
		.if(currentLevel==2) 
			;level 2 adjustments            ;readjust them at the end of game
            call audioAids
			sub paddleWidth,10
			mov backgroundColor,04H
			mov ax,initialBallX
			mov ballX,ax
					
			mov ax,initialBallY
			mov ballY,ax
			
			mov paddleX,150
			mov paddleY, 190
		

            .if(ballVelocityX>0)
                add ballVelocityX,1

            .elseif(ballVelocityX<0)
                sub ballVelocityX,1

            .endif

            .if(ballVelocityY>0)
                add ballVelocityY,2

            .elseif(ballVelocityY<0)
                sub ballVelocityY,2

            .endif

        .elseif(currentLevel==3) 
	
				;level 3 adjustments 
			mov backgroundColor,05H
			call audioAids
			mov ax,initialBallX
			mov ballX,ax
							
			mov ax,initialBallY
			mov ballY,ax
					
			mov paddleX,150
			mov paddleY, 190
			
            .if(ballVelocityX>0)
                add ballVelocityX,1

            .elseif(ballVelocityX<0)
                sub ballVelocityX,1 

            .endif

            .if(ballVelocityY>0)
                add ballVelocityY,2

            .elseif(ballVelocityY<0)
                sub ballVelocityY,2

            .endif

        .endif
		
		
	
	
	.endif
	
	drawBricksLevel:
	
	.if(currentLevel==1)
			
			
			mov ax,bricksLivesLevel1[si]
			
			.if(ax>0)
				bricksDrawMacros11 currentBrickX, currentBrickY
			.endif
			

			add si,2
			cmp si,totalBricks
			jne nextBrickInRow
			
		
			
	.elseif(currentLevel==2)
	
	
			mov ax,bricksLivesLevel2[si]
			
				
			.if(ax==2)			;if health=2
				bricksDrawMacros22 currentBrickX, currentBrickY
			.elseif(ax==1)
				bricksDrawMacros21 currentBrickX, currentBrickY
				
			.endif
			

			add si,2
			cmp si,totalBricks
			jne nextBrickInRow
			
			
	.elseif(currentLevel==3)
	
	
			mov ax,bricksLivesLevel3[si]
			
			.if (ax==10)
				bricksDrawMacros310 currentBrickX, currentBrickY
				
			.elseif (ax==5)
				bricksDrawMacros35 currentBrickX, currentBrickY
			
				
			.elseif(ax==3)			;if health=3
				bricksDrawMacros33 currentBrickX, currentBrickY
			.elseif(ax==2)
				bricksDrawMacros32 currentBrickX, currentBrickY
			.elseif(ax==1)
				bricksDrawMacros31 currentBrickX, currentBrickY
			
				
			.endif
			

			add si,2
			cmp si,totalBricks
			jne nextBrickInRow
	
	
	
	
	.endif
		
		
	

	exitDrawBricks:
		ret

drawBricks endp


checkUntouchableBricks proc


	mov cx,0
	mov ax,si

	untouchableBrickloop:

		mov si,cx
		mov bx, bricksLivesLevel3[si]

		.if(bx<5 && bx>0)
			jmp untouchableBrickexit
		
		.endif

		add cx,2
		cmp cx,totalBricks
		jne untouchableBrickloop
		
		call drawYouWin
		

untouchableBrickexit:	
	mov si,ax
	ret
checkUntouchableBricks endp


;------- function to draw paddle on the screen ----------
	;--- uses a double loop to draw ball and variables defined in data ----
	;--- uses cx,dx,ah,al,bh registers
	
specialBrick proc
	
	;if more than 5 bricks
	
	.if(currentBricks>10)
		.while(specialBrickCounter>0)
			mov cx,1
			startDelay:
			cmp cx,10000
			je endDelay
			inc cx
			jmp startDelay
			
			endDelay:


		   MOV AH, 00h  ; interrupts to get system time        
		   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

		   mov  ax, dx
		   xor  dx, dx
		   mov  cx, 24
		   div  cx       ; here dx contains the remainder of the division - from 0 to 9
		   mov dh,0
		   mov specialBrickNumber,dx

		  ; add  specialBrickNumber, '0'  ; to ascii from '0' to '9'
		   ;mov ah, 2h   ; call interrupt to display a value in DL
		   ;int 21h      
		   
		   mov si, specialBrickNumber
		   mov ax,si
		   mov bx,2
		   mul bx
		   mov si,ax
		   
		   .if(bricksLivesLevel3[si]!=0)
			   mov bricksLivesLevel3[si],0
			   
			   dec specialBrickCounter
			   inc playerScore
			   sub currentBricks,2
			 .endif
		   
		.endw
		
	.elseif(currentBricks<10)
	
		.while(currentBricks!=0)
		
			mov si,0
			
			.if(bricksLivesLevel3[si]!=0)
				mov bricksLivesLevel3[si],0
				sub currentBricks,2
				call drawYouWin
				
			.endif
			
			add si,2	
			
			
		
		.endw
		
		;call you win screen
		
	.endif 
	ret
specialBrick endp

drawPaddle proc


;initializing ball 
	mov cx, paddleX 					;x cordinates
	mov dx, paddleY 					;y cordinates
	
	drawPaddleHorizontalLines:
	
		mov ah,0ch 						;write pixel
		mov al, 0FH 					;yellow color of ball
		mov bh,00h 
		int 10h 
		
		;draws horizontal line
		inc cx         
		mov ax,cx    
		sub ax,paddleX       			;incrementing x cordinates till it is size of paddle width
		cmp ax,paddleWidth 				;checks if x cordinates is greater than the paddle width
		jne drawPaddleHorizontalLines   ;reach width of paddle. If nt->go to label ; If t->go next line of code
				
		;increments y axis and draws horizontal line one at a time
		mov cx, paddleX 				;goes back to initial x cordinates
		inc dx 							;inc y_axis
		mov ax,dx
		sub ax,paddleY 
		cmp ax,paddleHeight
		jne drawPaddleHorizontalLines   ;double loop


	ret
drawPaddle endp

;--- function to draw lives and points on the screen


drawUserInterface proc

;setting the cursor position and drawing lives remaining of the player

	;printing "Lives:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,01h  			;column number 
	int 10h 				;execute
	
	;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, playerLivesString	;gives dx pointer to string with player lives
	int 21h					;execute
	
	
	;printing the number of lives
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,07h  			;column number 
	int 10h 				;execute
	
	;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, playerLivesCounterText	;gives dx pointer to string with player lives
	int 21h					;execute




	;printing "lives:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
	;printing the text
	
	mov ah,09h					;write string in standard output
	lea dx,playerScoreString	;gives dx pointer to string with player lives
	int 21h						;execute

	
	
	;printing "score:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,17h  			;column number 
	int 10h 				;execute
	
	
	
	
	
	
	;printing the text
	
	;mov ah,09h				;write string in standard output
	;lea dx, playerScoreCounterText	;gives dx pointer to string with player lives
	;int 21h					;execute
	
	;to print (al) we move al to dl
    mov dl,playerScoreDigit1
    add dl,48
    mov ah,02h	; print as an integer
    int 21h

    ;to print the reminder
    mov dl,playerScoreDigit2
    add dl,48
    mov ah,02h
    int 21h
	
	
	;printing "Lives:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,1Fh  			;column number 
	int 10h 				;execute
	
	
	;idk why this is not displaying anything
	
	; ;printing the text
	
	
	
	;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, LevelString	;gives dx pointer to string with player lives
	int 21h					;execute


	;printing "Lives:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,01h  			;row number 
	mov dl,26h  			;column number 
	int 10h 


	mov dl,currentLevel
    add dl,48
    mov ah,02h
    int 21h

	;printing "Name:"
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,03h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
	mov ah,09h				;write string in standard output
	lea dx, Username	;gives dx pointer to string with player lives
	int 21h					;execute
	
	
	
	drawUserInterfaceExit:
		ret

drawUserInterface endp


drawPauseMenu proc

	
	
	
	;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,8h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, pauseScreenString	;gives dx pointer to string with player lives
	int 21h	
	
	
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Fh  			;row number 
		mov dl,9h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, pauseScreenKeyString	;gives dx pointer to string with player lives
		int 21h		
		
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,13h  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, pauseScreenEscape	;gives dx pointer to string with player lives
		int 21h		

PauseScreenKeyWait:
	mov ah,00h
	int 16h
	
	cmp al,13d
	je exitPauseScreen
	
	cmp al,'E'
	je mainMenu
	cmp al,'e'
	je mainMenu
	
	jmp PauseScreenKeyWait
	
		
	mainMenu:
		call gameOver
		call updateScoresText
		mov isActive,00h
		call drawMainMenu

	exitPauseScreen:

	ret
	
drawPauseMenu endp



;------ draws game over screen

drawGameOverMenu proc

;clear screen first
		
	call HighScoreWrite
	
	call graphicsAndClearScreen
	
;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page 
	mov dh,8h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, gameOverText	;gives dx pointer to string with player lives
	int 21h					;execute


;prints score here <---------------


	;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Ah  			;row number 
		mov dl,2h  			;column number 
		int 10h 				;execute
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, username	 
		int 21h					;execute	
		
	
	
	;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Ah  			;row number 
		mov dl,7h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, yourScoreIsText	 
		int 21h					;execute
	;to print (al) we move al to dl
		mov dl,playerScoreDigit1
		add dl,48
		mov ah,02h	; print as an integer
		int 21h

	;to print the reminder
		mov dl,playerScoreDigit2
		add dl,48
		mov ah,02h
		int 21h
	


;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Fh  			;row number 
		mov dl,9h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, restartGameString	;gives dx pointer to string with player lives
		int 21h		
		
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,13h  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, returnToMainMenuString	;gives dx pointer to string with player lives
		int 21h		


	
;wait for key pressed

gameOverKeyWait:
	mov ah,00h
	int 16h
	
	cmp al,'r' 
	je restart
	cmp al,'R'
	je restart
	
	cmp al,'E'
	je mainMenu
	cmp al,'e'
	je mainMenu
	
	jmp gameOverKeyWait
	
	restart:
		call updateScoresText
		mov isActive,01h
		jmp exitDrawGameOverMenu
		
	mainMenu:
		call updateScoresText
		mov isActive,00h
		call drawMainMenu

	exitDrawGameOverMenu:
		ret

drawGameOverMenu endp
drawMainMenu proc

	;call clear screen
	
	call graphicsAndClearScreen
	
	;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,8h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, gameNameText	;gives dx pointer to string with player lives
	int 21h	
	
	
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Fh  			;row number 
		mov dl,9h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, startGameText	;gives dx pointer to string with player lives
		int 21h		
		
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,15h  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
		mov ah,09h				;write string in standard output
		lea dx,seeInstructionText 	;gives dx pointer to string with player lives
		int 21h		
		
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,13h  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, exitGameText	;gives dx pointer to string with player lives
		int 21h		



	mainMenuWaitForKey:
		;wait for user input
		mov ah,00h
		int 16h
		
		;check which key is pressed
		
		cmp al,'a'
		je startGame
		cmp al,'A'
		je startGame
		
		cmp al,'E'
		je exitGameLabel
		cmp al,'e'
		je exitGameLabel
		
		cmp al,'I'
		je instructionsMenuLabel
		cmp al,'i'
		je instructionsMenuLabel
		
		jmp mainMenuWaitForKey

	
		startGame:
			mov currentScreen,1
			mov isActive,2
			jmp exitDrawMainMenu

			
		instructionsMenuLabel:
			call drawInstructions
			jmp exitDrawMainMenu

			
			
		exitGameLabel:
			mov exitGame,1





	exitDrawMainMenu:
		ret
drawMainMenu endp

drawInstructions proc




    ;moving cursor position
    mov ah,02h              ;set cursor position
    mov bh,00h              ;set page number
    mov dh,8h              ;row number 
    mov dl,10h              ;column number 
    int 10h                 ;execute

;printing the text

    mov ah,09h                ;write string in standard output
    lea dx, instructionLine1    ;gives dx pointer to string with player lives
    int 21h



        ;moving cursor position
        mov ah,02h              ;set cursor position
        mov bh,00h              ;set page number
        mov dh,0Fh              ;row number 
        mov dl,9h              ;column number 
        int 10h                 ;execute

    ;printing the text

        mov ah,09h                ;write string in standard output
        lea dx, instructionLine2    ;gives dx pointer to string with player lives
        int 21h


        ;moving cursor position
        mov ah,02h              ;set cursor position
        mov bh,00h              ;set page number
        mov dh,13h              ;row number 
        mov dl,6h              ;column number 
        int 10h                 ;execute

    ;printing the text

        mov ah,09h                ;write string in standard output
        lea dx, instructionLine3    ;gives dx pointer to string with player lives
        int 21h

PauseScreenKeyWait:
    mov ah,00h
    int 16h


    cmp al,'E'
    je mainMenu
    cmp al,'e'
    je mainMenu

    jmp PauseScreenKeyWait


    mainMenu:
        call gameOver
        call updateScoresText
        mov isActive,00h
        call drawMainMenu


    ret
drawInstructions endp

drawYouWin proc

	call gameOver
	
	
	call HighScoreWrite
	
	call graphicsAndClearScreen
	
;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page 
	mov dh,8h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
;printing the text
	
	mov ah,09h				;write string in standard output
	lea dx, youWinString	;gives dx pointer to string with player lives
	int 21h					;execute


;prints score here <---------------

	;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Ah  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, yourScoreIsText	 
		int 21h					;execute
	;to print (al) we move al to dl
		mov dl,playerScoreDigit1
		add dl,48
		mov ah,02h	; print as an integer
		int 21h

	;to print the reminder
		mov dl,playerScoreDigit2
		add dl,48
		mov ah,02h
		int 21h
	


;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,0Fh  			;row number 
		mov dl,9h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, restartGameString	;gives dx pointer to string with player lives
		int 21h		
		
		
		;moving cursor position
		mov ah,02h  			;set cursor position
		mov bh,00h  			;set page number
		mov dh,13h  			;row number 
		mov dl,6h  			;column number 
		int 10h 				;execute
		
	;printing the text
		
		mov ah,09h				;write string in standard output
		lea dx, returnToMainMenuString	;gives dx pointer to string with player lives
		int 21h		


	
;wait for key pressed

gameOverKeyWait:
	mov ah,00h
	int 16h
	
	cmp al,'r' 
	je restart
	cmp al,'R'
	je restart
	
	cmp al,'E'
	je mainMenu
	cmp al,'e'
	je mainMenu
	
	jmp gameOverKeyWait
	
	restart:
		call updateScoresText
		mov isActive,01h
		jmp exitDrawGameOverMenu
		
	mainMenu:
		call updateScoresText
		mov isActive,00h
		call drawMainMenu

	exitDrawGameOverMenu:
		ret


drawYouWin endp


;------ turns on the graphics mode and clears the screen by setting background to black colour

graphicsAndClearScreen proc

	;-- change background color and refresh screen
		

		
		mov ah,06h  					;set video mode 
		mov al,00h					;video mode selection
		mov bh,backgroundColor
		mov ch,00
		mov cl,00
		mov dh,24
		mov dl,40
		int 10h 
		
	
	


	ret 
graphicsAndClearScreen endp

drawUsernameMenu proc

	;call clear screen
	
	call graphicsAndClearScreen
	
	;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,8h  			;row number 
	mov dl,10h  			;column number 
	int 10h 				;execute
	
;printing the text
	
	lea dx, userNameText	;gives dx pointer to string with player lives
	mov ah,09h				;write string in standard output
	int 21h	
	
	
		
	;moving cursor position
	mov ah,02h  			;set cursor position
	mov bh,00h  			;set page number
	mov dh,0Fh  			;row number 
	mov dl,9h  			;column number 
	int 10h 				;execute
		
	;input the username
		
	mov si,offset Username
	loop1:
	mov al,0
	mov ah,01h
	int 21h
	.if(al==13)	
		jmp exitDrawUsername
	.endif
	;add v1,1
	mov [si],al
	add si,1
	jmp loop1
			
	
	exitDrawUsername:
	mov al,0						;zf=0 if key is pressed
	;jz exitPaddleProc
	;call gameOver
	mov	stringscreen,0
	mov currentScreen,0
	mov isActive,00h
	;call graphicsAndClearScreen
	;call drawMainMenu
		ret
drawUsernameMenu endp

HighScoreWrite proc

    ; mov ah,3ch    ; create a file
    ; lea dx,highscorefile
    ; mov cl,0
    ; int 21h     ; call interrupt
    ; mov handle,ax

    mov ah,3dh
    mov al,1
    lea dx,highscorefile
    int 21h

    mov bx,ax
    mov cx,0
    mov ah,42h
    mov al,02h
    int 21h



    lea dx,Username
    mov cx,lengthof Username
    mov ah,40h
    int 21h


    lea dx,spaces
    mov cx,5
    mov ah,40h
    int 21h



    lea dx,playerScoreCounterText
    mov cx,1
    mov ah,40h
    int 21h




    lea dx,spaces
    mov cx,5
    mov ah,40h
    int 21h

    mov al,currentLevel
    add al,48
    mov [lvl],al

    lea dx,lvl
    mov cx,1
    mov ah,40h
    int 21h

    ;close a file
    mov ah,3eh
    int 21h


    ret
HighScoreWrite endp


audioAids proc

 
        mov     al, 182         ; Prepare the speaker for the
        out     43h, al         ;  note.
        mov     ax, 800        ; Frequency number (in decimal)
                                ;  for middle C.
        out     42h, al         ; Output low byte.
        mov     al, ah          ; Output high byte.
        out     42h, al 
        in      al, 61h         ; Turn on note (get value from
                                ;  port 61h).
        or      al, 00000011b   ; Set bits 1 and 0.
        out     61h, al         ; Send new value.
        mov     bx, 1          ; Pause for duration of note.
pause1:
       mov     cx, 65535
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h         ; Turn off note (get value from
                                ;  port 61h).
        and     al, 11111100b   ; Reset bits 1 and 0.
        out     61h, al         ; Send new value.

        


exitAudioAids:

ret
audioAids endp

end
