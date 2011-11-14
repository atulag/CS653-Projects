#!/usr/bin/env runhaskell

import HSVG

main =
	let red = newColor (255,0,0)
	    blue = newColor (0,0,255)
            white = newColor(255,255,255)
	    a = newPoint (20,20)
	    b = newPoint (200,100)
            width = newDimension 200
            height = newDimension 500
	    swidth = newWidth 10
	    swidth2 = newWidth 100
	    fwidth = newDimension 1200
	    fheight = newDimension 500
	    rec1 = newRectangle a (width,height) white red swidth
        in
		writeToFile "fk.svg" [rec1] (fwidth,fheight)
	    
