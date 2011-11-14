module SVGOps where

import Element



data SVG a = SVGC {unsvg::a}



getSVGStringFromElement::Element->SVG String

getSVGStringFromElement (Line (PointC (x1, y1), PointC (x2, y2)) scolor swidth, transList) =
    SVGC $ concat ["<line x1=\"", show x1, "\" y1=\"", show y1, "\" x2=\"", show x2,
                   "\" y2=\"", show y2, "\" style=\"", (strokeColor scolor), (strokeWidth swidth), "\"",
                    getStringFromTransforms transList, "/>", "\n"]

getSVGStringFromElement (Rect (PointC (x,y)) (DimensionC width, DimensionC height) fcolor scolor swidth, transList) =
    SVGC $ concat ["<rect x=\"", show x, "\" y =\"", show y,"\" width =\"", show width,"\" height =\"", show height,
                   "\" style =\"",(fillColor fcolor), (strokeColor scolor), (strokeWidth swidth), "\"",
                   getStringFromTransforms transList, "/>", "\n"]




getSVGStringFromElement ((Polyline points scolor swidth),transList) = 
    SVGC $ concat ["<polyline fill=\"none\" style =\"",(strokeColor scolor), (strokeWidth swidth),
                   "\" points = \"",(printPointList points),"\"", getStringFromTransforms transList, "/>","\n"]

getSVGStringFromElement ((Polygon points fcolor scolor swidth), transList) = 
    SVGC $ concat ["<polygon style =\"", (fillColor fcolor), (strokeColor scolor), (strokeWidth swidth),
                   "\" points = \"", (printPointList points),"\"",getStringFromTransforms transList,"/>","\n"]


getSVGStringFromElement (Group elems, transList) = 
     let initstr = SVGC $ concat ["<g ", getStringFromTransforms transList, ">","\n"]
         endstr = SVGC "</g>\n"
     in concatSVGStrs [initstr, getSVGStringFromElements elems, endstr]



getSVGStringFromElements::[Element]->SVG String

getSVGStringFromElements elems =
    let svgstrs = map getSVGStringFromElement elems
    in concatSVGStrs svgstrs



concatSVGStrs::[SVG String]->SVG String

concatSVGStrs svgstrs = SVGC . concat $ map unsvg svgstrs



makeFullSVGString::(Dimension, Dimension)->SVG String->SVG String

makeFullSVGString (DimensionC width, DimensionC height) svgstr =
    let initial = SVGC $ concat ["<svg width=\"", show (width/100), "cm\" height=\"", show (height/100), 
                               "cm\" viewBox=\"0 0 ",show width," ", show height,
                               "\" xlmns = \"http://www.w3.org/2000/svg\" version=\"1.1\">\n"]
        final = SVGC "</svg>"
    in concatSVGStrs [initial,  svgstr, final]


fillColor::Color->String

fillColor (ColorC (red, green, blue)) = 
    concat ["fill:rgb(", show red, ",", show green, ",", show blue, ");"]



strokeColor::Color->String

strokeColor (ColorC (red, green, blue)) =
    concat ["stroke:rgb(", show red, ",", show green, ",", show blue, ");"]



strokeWidth::Width->String

strokeWidth (WidthC width) = 
    concat ["stroke-width:",show width]


printPointList::[Point]->String

printPointList points =
    let pts = map printPoint points
    in concat pts


printPoint::Point->String

printPoint (PointC (x,y)) = 
    concat [show x, ",", show y, " "]



getStringFromTransforms::[Transformation]->String

getStringFromTransforms transList = 
    let transtrs = map getStringFromTransform transList
        initstr = " transform = \""
        endstr = "\""
    in concat [initstr, concat transtrs, endstr]


getStringFromTransform::Transformation->String

getStringFromTransform (TranslateC (x,y)) =
    concat ["translate(", show x, ",", show y, ") "]

getStringFromTransform (ScaleC (sx,sy)) = 
    concat ["scale(", show sx, ",", show sy, ") "]

getStringFromTransfrom (RotateC (angle, cx,cy)) = 
    concat ["rotate(", show angle , ",", show cx, ",", show cy, ") "]

getStringFromTransfrom (SkewXC angle) = 
    concat ["skewX(", show angle, ") "]

getStringFromTransfrom (SkewYC angle) = 
    concat ["skewY(", show angle, ") "]

getStringFromTransfrom (MatrixC (a,b,c,d,e,f)) = 
    concat ["matrix(", show a, ",", show b, ",", show c, ",", show d, ",",
             show e, ",", show f, ") "]
