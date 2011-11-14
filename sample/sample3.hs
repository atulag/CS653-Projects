#!/usr/bin/env runhaskell

import HSVG

main =
    let p1 = newPoint (200, 200)
        p2 = newPoint (400, 400)
        c1 = newColor (13, 43, 48)
        c2 = newColor (123, 12, 255)
        c3 = newColor (223, 34, 0)
        w1 = newWidth 50
        w2 = newWidth 200
        l1 = newLine (p1, p2) c1 w1
        l2 = rotate 90 (scaleMajor 2 l1)
        g1 = scaleMinor 1.4 $ translate (500, 1000) $ newGroup [l1, l2]
    in
        writeToFile "sample3.svg" [l2, l1, g1]
