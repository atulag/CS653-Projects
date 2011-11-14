#!/usr/bin/env runhaskell

import HSVG

main =
    let black = newColor (0, 0, 0)
        blue = newColor (0, 0, 255)
        p1 = newPoint (200, 200)
        p2 = newPoint (200, 2000)
        p3 = newPoint (2000, 200)
        width1 = newWidth 1
        width10 = newWidth 10
        width100 = newWidth 100
        l1 = newLine (p1, p2) blue width1
        l2 = newLine (p2, p3) blue width10
        l3 = newLine (p1, p3) black width100
        g1 = newGroup [l1, l2]
    in
        writeToFile "sample2.svg" [g1, l3]
