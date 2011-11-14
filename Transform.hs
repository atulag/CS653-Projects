module Transform (scaleMajor, scaleMinor, rotate, translate, changeStrokeColor, changeStrokeWidth) where

import Element
import GHC.Float


getPolar::(Float, Float)->(Float, Float)->(Float, Float, Float, Float)

getPolar (x1, y1) (x2, y2) =
    let xmid = (x1 + x2)/2
        ymid = (y1 + y2)/2
        xdiff = xmid - x1
        ydiff = ymid - y1
    in (xmid, ymid, xdiff, ydiff)



scaleMajor::Float->Element->Element

scaleMajor factor (Line (PointC coord1, PointC coord2) color width) =
    let (xmid, ymid, xdiff, ydiff) = getPolar coord1 coord2
        nx1 = xmid - factor * xdiff
        ny1 = ymid - factor * ydiff
        nx2 = xmid + factor * xdiff
        ny2 = ymid + factor * ydiff
    in
        Line (PointC (nx1, ny1), PointC (nx2, ny2)) color width

scaleMajor factor (Group elems) = 
    Group $ map (scaleMajor factor) elems



scaleMinor::Float->Element->Element

scaleMinor factor (Line pts color (WidthC width)) =
    Line pts color $ WidthC $ factor * width

scaleMinor factor (Group elems) =
    Group $ map (scaleMinor factor) elems



degToRad::Float->Float

degToRad = (*) (pi / 180)



sine::Float->Float

sine = sin . degToRad



cosine::Float->Float

cosine = cos . degToRad



rotate::Float->Element->Element

rotate angle (Line (PointC coord1, PointC coord2) color width) =
    let (xmid, ymid, xdiff, ydiff) = getPolar coord1 coord2
        c = cosine angle
        s = sine angle
        nx1 = xmid - ( xdiff * c + ydiff * s)
        ny1 = ymid - ( ydiff * c - xdiff * s)
        nx2 = xmid + ( xdiff * c + ydiff * s)
        ny2 = ymid + ( ydiff * c - xdiff * s)
    in
        Line (PointC (nx1, ny1), PointC (nx2, ny2)) color width

rotate angle (Group elems) =
    Group $ map (rotate angle) elems



translate::(Float, Float)->Element->Element

translate (x, y) (Line (PointC (x1, y1), PointC (x2, y2)) color width) = 
    (Line (PointC (x1 + x, y1 + y), PointC (x2 + x, y2 + y)) color width)

translate coords (Group elems) =
    Group $ map (translate coords) elems



changeStrokeColor::Color->Element->Element

changeStrokeColor newColor (Line pts oldColor width) = Line pts newColor width

changeStrokeColor newColor (Group elems) =
    Group $ map (changeStrokeColor newColor) elems



changeStrokeWidth::Width->Element->Element

changeStrokeWidth newWidth (Line pts color oldWidth) = Line pts color newWidth

changeStrokeWidth newWidth (Group elems) =
    Group $ map (changeStrokeWidth newWidth) elems
