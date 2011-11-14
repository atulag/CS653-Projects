module SVGOps where

import Element



data SVG a = SVGC {unsvg::a}



getSVGStringFromElement::Element->SVG String

getSVGStringFromElement (Line (PointC (x1, y1), PointC (x2, y2)) (ColorC (red, green, blue)) (WidthC width), transList) =
    SVGC $ concat ["<line x1=\"", show x1, "\" y1=\"", show y1, "\" x2=\"", show x2,
                   "\" y2=\"", show y2, "\" style=\"stroke:rgb(", show red, " ,",
                   show green, ", ", show blue, ");stroke-width:", show width, "\"/>", "\n"]

getSVGStringFromElement (Rect (PointC (x,y)) (DimensionC width, DimensionC height) (ColorC (red1,green1,blue1)) (ColorC (red2, green2, blue2)) (WidthC swidth), transList) =
    SVGC $ concat ["<rect x=\"", show x, "\" y =\"", show y,"\" width =\"", show width,"\" height =\"", show height,
                   "\" style =\"fill:rgb(", show red1, ",", show green1, ",", show blue1, ");stroke:rgb(",
                   show red2, ",", show green2, ",", show blue2, ");stroke-width:", show swidth, "\"/>", "\n"]

getSVGStringFromElement (Group elems, transList) = getSVGStringFromElements elems



getSVGStringFromElements::[Element]->SVG String

getSVGStringFromElements elems =
    let svgstrs = map getSVGStringFromElement elems
    in concatSVGStrs svgstrs



concatSVGStrs::[SVG String]->SVG String

concatSVGStrs svgstrs = SVGC . concat $ map unsvg svgstrs



makeFullSVGString::SVG String->SVG String

makeFullSVGString svgstr =
    let initial = SVGC "<svg xlmns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\n"
        final = SVGC "</svg>"
    in concatSVGStrs [initial, svgstr, final]


fillColor::Color->SVG String

fillColor (ColorC (red, green, blue)) = 
    SVGC $ concat ["fill:rgb(", show red, ",", show green, ",", show blue, ");"]



strokeColor:: Color->SVG String

strokeColor (ColorC (red, green, blue)) =
    SVGC $ concat ["stroke:rgb(", show red, ",", show green, ",", show blue, ");"]



strokeWidth::Width->SVG String

strokeWidth (WidthC width) = 
    SVGC $ concat ["stroke-width:",show width]



