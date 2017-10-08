#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance , force

;Version	Date			Author		Notes
;	0.1		08-OCT-2017		Staid03		Initial

;Script Purpose:
;Simple GUI to help keep score for Magic The Gathering
;Built in about 2 hours, partly in breaks between playing
;with my son

;set up tray icon
iconfile = icon_1.ico
menu , tray , icon , %iconfile%

;set up file to keep scores
tallyFile = gameTally.txt
;query the file to get details
tallyTextColumn1 := getTallyCol(1,tallyFile)
tallyTextColumn2 := getTallyCol(2,tallyFile)

;get image 
imagefile := getImage()

;GUI variables
editY = 55
scrollY = 200
resetX = 550
resetY := scrolly + 150
saveX := resetX - 100
saveY := resetY
namewidth = 200
tallyText1X := saveX - 320
tallyText2X := tallyText1X + 150
tallyTextY = 380
Player1 = Dad
Player2 = Josh

;--------------gui;--------------
{
	gui , add , picture , x0 y0 h500 w800, %imagefile%	
	gui , font , s50
	gui , font , cGray
	gui , add , Edit , x120 y%editY% w%namewidth% vName1 , %Player1%
	gui , add , Edit , x440 y%editY% w%namewidth% vName2 , %Player2%
	gui , font , s80
	gui , font , cGreen	
	gui , add , Edit , x120 y%scrollY% w200 vEdit1 , 
	gui , add, UpDown, vMyUpDown1 Range1-50, 20
	gui , font , s80
	gui , font , cBlue
	gui , add , Edit , x440 y%scrollY% w200 vEdit2, 
	gui , add, UpDown, vMyUpDown2 Range1-50, 20
	gui , font , s20
	gui , add , button , x%resetX% y%resetY% , Reset
	gui , add , button , x%saveX% y%saveY% , Save
	gui , font , cGray
	gui , add , text , x%tallyText1X% y%tallyTextY% , %tallyTextColumn1%
	gui , add , text , x%tallyText2X% y%tallyTextY% , %tallyTextColumn2%
	gui , show , AutoSize	
}
return ;--------------end gui;--------------

;In preparation for future functionality. For now this just opens the tally file
;so the scores can be manually entered.
buttonSave:
{
	run , %tallyFile%
}
return

;reset the GUI
buttonReset:
{
	gui , destroy
	run , Magic_counter.ahk
}
return

;get the background image
getimage()
{
	;I have a folder with 53 images in it.
	;If you want to copy this functionality you will need
	;to download x number of images and change the value
	;for number of images to match your value.
	;Also, I use a script to rename all the JPG images
	;I had to image_y.jpg where y = a unique image number
	
	;If you do not want to use that functionality, comment it
	;out and replace xyz below with the path to the background
	;image of your choice
	imagefile = xyz
	
	;block of code for random background image (comment this out
	;if unused)
	/*
	{
		number_of_images = 53
		image_location = C:\Users\study\Dropbox2\Dropbox\Magic Counter\images\
		
		random , random_image_picker , 1 , %number_of_images%

		imagefile = C:\Users\study\Dropbox2\Dropbox\Magic Counter\images\image_%random_image_picker%.jpg
	}
	*/
	imagefile = image_1.jpg
	return imagefile
}
return

;get the previous tally/scores from the file and load them into
;the GUI. It is best for only two players but can handle more.
getTallyCol(colNum, tallyFile)
{
	loop , read , %tallyFile%
	{
		StringSplit , a , a_loopreadline , |
		thisItem := a%colNum%
		ifequal , a_index , 1
		{
			column = %thisItem%
		}
		else
		{
			column = %column%`n%a_space%%a_space%%a_space%%a_space%%thisItem%
		}
	}
	return column
}
return 