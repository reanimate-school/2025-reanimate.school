    set kernel_options pfcolors

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Aliases
    
    ; Player 0
    dim _P0Col = a
    dim _P0SpriteFrame = b
    dim _P0x = c
    dim _P0y = d
    dim _P0Dir = e

    ; Missile 0
    dim _Missile0StartX = f
    dim _Missile0StartY = g
    dim _Missile0Dir = h
    dim _Missile0Active = i
    dim _Missile0Life = j

    ; Player 1
    dim _P1Col = k
    dim _P1SpriteFrame = l
    dim _P1x = m
    dim _P1y = n
    dim _P1Dir = o

    ; Missile 1
    dim _Missile1StartX = p
    dim _Missile1StartY = q
    dim _Missile1Dir = r
    dim _Missile1Active = s
    dim _Missile1Life = t

    ; Music
    dim _Duration0 = u
	dim _Duration1 = v
    ; Plus "sdata musicData1 = w"

    ; Game
    dim _BitField = x



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Title screen
TITLE
TITLE_reset_fire
    if joy0fire || joy1fire then goto TITLE_reset_fire

    playfield:
    ................................
    ................................
    ..XXXXXX........................
    ...X...XX..X..X.XXXXX...........
    ...X....X.XX..X.X.....X.........
    ...X....X.X..XX.XX....X.........
    ...XXXXXX.XXXX..X...X.X.........
    .................XXXX.XX........
    .......................XXXXXX...
    ................................
    ................................
end

    pfcolors:
    $01
    $02
    $03
    $04
    $05
    $16
    $07
    $08
    $09
    $0A
    $0B
    $1C
end

    drawscreen
    if joy0fire then goto INIT
    if joy1fire then goto INIT
    goto TITLE



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; End screen
END
END_reset_fire
    if joy0fire || joy1fire then goto END_reset_fire

    missile0x = 0
    missile0y = 0
    missile1x = 0
    missile1y = 0
    player0x = 0
    player0y = 0
    player1x = 0
    player1y = 0
    AUDV0 = 0
    AUDV1 = 0

    playfield:
    ................................
    ..X.............................
    ..X...........XX.............X..
    ...X..........X...X...XX.....X..
    ...XX...X.....X...X...XXX...X...
    ....X..XXX...X....X...X.X...X...
    ....XX.X.XX.XX....X...X.XX..X...
    .....XXX..XXX.....X..XX..XXX....
    ......XX...X.........X....XX....
    ..........................X.....
    ................................
end

    pfcolors:
    $CC
    $BB
    $AA
    $99
    $88
    $77
    $66
    $55
    $44
    $33
    $22
    $11
end

    drawscreen
    if joy0fire then goto TITLE
    if joy1fire then goto TITLE
    goto END



INIT
INIT_reset_fire
    if joy0fire || joy1fire then goto INIT_reset_fire

    ; Player 0
    _P0Col = $38
    _P0SpriteFrame = 0
    _P0x = 50
    _P0y = 50
    _P0Dir = 1

    ; Missile 0
    _Missile0StartX = 0
    _Missile0StartY = 0
    _Missile0Dir = 0
    _Missile0Active = 0 
    _Missile0Life = 0

    ; Player 1
    _P1Col = $38
    _P1SpriteFrame = 0
    _P1x = 100
    _P1y = 80
    _P1Dir = 2

    ; Missile 1
    _Missile1StartX = 0
    _Missile1StartY = 0
    _Missile1Dir = 0
    _Missile1Active = 0
    _Missile1Life = 0

    ; Music
    AUDV0 = 0 
    AUDV1 = 0
    _Duration0 = 1
	_Duration1 = 1

    ; Game
    COLUBK = $0
    COLUPF = $84
    scorecolor = $ff
    score = 0

    ; Background
    playfield:
    ..........XXXXXXX..XXX..........
    ..........X..........X..........
    ..........X..........X..........
    ..........X..........X..........
    ..........X..........X..........
    ..........XXX........X..........
    ..........X..XX......X..........
    ..........X....XX....X..........
    ..........X......XX..X..........
    ...........X......X.X...........
    ............XXXXXXXX............
end

    ; Music
    goto __SetupMusicChannel1
__continueAfterSettingMusicChannel1



_MAINLOOP
    COLUP0 = _P0Col
    COLUP1 = _P1Col
    AUDV0 = 0

    player0x = _P0x
    player0y = _P0y
    player1x = _P1x
    player1y = _P1y

    NUSIZ0 = $30 
    NUSIZ1 = $30
    missile0height = 1
    missile1height = 1

    ; Inputs    
    goto __HandleInput
__continueAfterHandlingInput

    ; Collisions
    if collision(player1, missile0) then _P1Col = _P1Col - 1 : score = score + 1     : _Missile0Active=0 : missile0x=0 : missile0y=0 :   AUDC0 = 8: AUDV0 = 15 : AUDF0 = 15
    if collision(player0, missile1) then _P0Col = _P0Col - 1 : score = score + 10000 : _Missile1Active=0 : missile1x=0 : missile1y=0 :   AUDC0 = 8: AUDV0 = 15 : AUDF0 = 15
 
    ; Missiles
    goto __HandleMissiles
__continueAfterHandlingMissiles

    ; Score
    if score[2] > 10 then goto END
    if score[0] > 10 then goto END

    ; Sprites
    _P0SpriteFrame = _P0SpriteFrame+1
    if _P0SpriteFrame = 60 then _P0SpriteFrame = 0

    _P1SpriteFrame = _P1SpriteFrame+1
    if _P1SpriteFrame =20 then _P1SpriteFrame = 0
  
    if _P1SpriteFrame < 10 then player1:
        %00000000
        %00000000
        %00000000
        %00000000
        %00011100
        %00111110
        %01110010
        %11100000
        %11100000
        %11110000
        %01111100
        %01100100
        %00111000
        %00000000
        %00000000
        %00000000
end
    if _P1SpriteFrame >= 10 then player1: 
        %00000000
        %00000000
        %00000000
        %00000000
        %00011100
        %00111110
        %01111110
        %11100111
        %11100011
        %11111100
        %01111100
        %01100100
        %00111000
        %00000000
        %00000000
        %00000000
end
    if _P0SpriteFrame < 30 then player0:
        %00000000
        %00000000
        %00000000
        %00000000
        %00011100
        %00111110
        %01110010
        %11100000
        %11100000
        %11110000
        %01111100
        %01100100
        %00111000
        %00000000
        %00000000
        %00000000
end
    if _P0SpriteFrame >= 30 then player0:
        %00000000
        %00000000
        %00000000
        %00000000
        %00011100
        %00111110
        %01111110
        %11100111
        %11100011
        %11111100
        %01111100
        %01100100
        %00111000
        %00000000
        %00000000
        %00000000
end

    ; Music
    goto __PlayChannel1
__continueAfterPlayingChannel1

    drawscreen

    goto _MAINLOOP


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Handling missiles
__HandleMissiles
    if _Missile0Active = 1 then goto __shootMissile0
__continueShootMissile0

    if _Missile1Active = 1 then goto __shootMissile1
__continueShootMissile1

    if _Missile0Active = 2 then goto __moveMissile0
__continueMoveMissile0

    if _Missile1Active = 2 then goto __moveMissile1
__continueMoveMissile1

    if _Missile0Life > 99 || missile0x > 150 then goto __resetMissile0
__continueMissile0

    if _Missile1Life > 99 || missile1x > 150 then goto __resetMissile1
__continueMissile1

    goto __continueAfterHandlingMissiles
 
__shootMissile0
    missile0x = _Missile0StartX
    missile0y = _Missile0StartY
    _Missile0Life = 0
    _Missile0Active = 2
    _Missile0Dir = _P0Dir
    _Missile0StartX = player0x 
    _Missile0StartY = player0y - 8
    goto __continueShootMissile0

__shootMissile1
    missile1x = _Missile1StartX
    missile1y = _Missile1StartY
    _Missile1Life = 0
    _Missile1Active = 2
    _Missile1Dir = _P1Dir
    _Missile1StartX = player1x 
    _Missile1StartY = player1y - 8
    goto __continueShootMissile1

__moveMissile0
    if _Missile0Dir = 1 then missile0x = _Missile0StartX + _Missile0Life * 2
    if _Missile0Dir = 2 then missile0x = _Missile0StartX - _Missile0Life * 2
    missile0y = _Missile0StartY

    _Missile0Life = _Missile0Life + 1

    goto __continueMoveMissile0

__moveMissile1
    if _Missile1Dir = 1 then missile1x = _Missile1StartX + _Missile1Life * 2
    if _Missile1Dir = 2 then missile1x = _Missile1StartX - _Missile1Life * 2
    missile1y = _Missile1StartY

    _Missile1Life = _Missile1Life + 1

    goto __continueMoveMissile1

__resetMissile0
    _Missile0Life = 0
    _Missile0Active = 0
    missile0y = 0
    missile0x = 0
    _Missile0Dir = 1
    goto __continueMissile0

__resetMissile1
    _Missile1Life = 0
    _Missile1Active = 0
    missile1y = 0
    missile1x = 0
    _Missile1Dir = 1
    goto __continueMissile1



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Handling input
__HandleInput
    if joy0right then _P0x = _P0x+1 : _P0Dir = 1
    if joy0left  then _P0x = _P0x-1 : _P0Dir = 2
    if joy0up    then _P0y = _P0y - 1
    if joy0down  then _P0y = _P0y + 1
    if joy0fire && _Missile0Active = 0 then _Missile0Active = 1
   
    if _P0Dir = 2 then REFP0 = 8 else REFP0 = 0

    if joy1right then _P1x = _P1x + 1 : _P1Dir = 1
    if joy1left  then _P1x = _P1x - 1 : _P1Dir = 2
    if joy1up    then _P1y = _P1y - 1
    if joy1down  then _P1y = _P1y + 1
    if joy1fire && _Missile1Active = 0 then _Missile1Active = 1

    if _P1Dir = 2 then REFP1 = 8 else REFP1 = 0

    ; Looping offscreen
    if _P0x < 1 then _P0x = 159
    if _P0x > 159 then _P0x = 1
    if _P0y > 96 then _P0y = 1
    if _P0y < 1 then _P0y = 96

    if _P1x < 1 then _P1x = 159
    if _P1x > 159 then _P1x = 1
    if _P1y > 96 then _P1y = 1
    if _P1y < 1 then _P1y = 96

    goto __continueAfterHandlingInput   



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Playing music
__PlayChannel1
    _Duration1 = _Duration1 - 1
    if _Duration1 then goto __continueAfterPlayingChannel1

    ; read data: V,C,F
    temp1 = sread(musicData1) ; V
    temp2 = sread(musicData1) ; C
    temp3 = sread(musicData1) ; F

    AUDV1 = temp1 ; V
    AUDC1 = temp2 ; C
    AUDF1 = temp3 ; F

    _Duration1 = sread(musicData1)
    if _Duration1 = 255 then _Duration1 = 1: goto __SetupMusicChannel1
    goto __continueAfterPlayingChannel1



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Setting up music
__SetupMusicChannel1
    sdata musicData1 = w
    13, 12, 20
    6
    0, 0, 0
    6
    13, 12, 18
    6
    0, 0, 0
    6
    13, 12, 16
    7
    0, 0, 0
    6
    13, 12, 15
    1
    13, 4, 18
    6
    13, 4, 19
    6
    13, 4, 18
    6
    13, 4, 15
    13
    13, 4, 13
    6
    13, 4, 15
    6
    0, 0, 0
    6
    13, 4, 23
    6
    13, 4, 24
    6
    13, 4, 23
    7
    13, 4, 18
    13
    13, 4, 19
    6
    13, 4, 18
    6
    0, 0, 0
    6
    13, 4, 15
    6
    13, 4, 17
    6
    13, 4, 20
    7
    13, 4, 24
    13
    13, 4, 26
    6
    13, 4, 24
    6
    0, 0, 0
    6
    13, 4, 23
    25
    13, 12, 31
    19
    0,0,0
    255
end
    goto __continueAfterSettingMusicChannel1