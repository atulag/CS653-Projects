module SVGOps (SVG(SVGC), makeFullSVGString, getSVGStringFromElements)  where

import Element



data SVG a = SVGC {unsvg::a}



getSVGStringFromElement::Element->SVG String

getSVGStringFromElement (Line (PointC (x1, y1), PointC (x2, y2)) (ColorC (red, green, blue)) (WidthC width)) =
    SVGC $ concat ["<line x1=\"", show x1, "\" y1=\"", show y1, "\" x2=\"", show x2,
                   "\" y2=\"", show y2, "\" style=\"stroke:rgb(", show red, " ,",
                   show green, ", ", show blue, ");stroke-width:", show width, "\"/>", "\n"]

getSVGStringFromElement (Group elems) = getSVGStringFromElements elems



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
