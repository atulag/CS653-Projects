#!/usr/bin/env runhaskell

import HSVG

main =
	let red = newColor (255,0,0)
	    blue = newColor (0,0,255)
	    a = newPoint (0,0)
	    b = newPoint (200,100)
	    width = newWidth 10
	    width2 = newWidth 100
	    line = newLine (a,b) blue width
	    line1 = translate (500,500) $ changeStrokeWidth width2 line
	    line2 = translate (1000, 1000) $ changeStrokeColor red line
	in
		writeToFile "fk.hs" [line, line1, line2]
	    
