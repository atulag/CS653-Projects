module Transform where

import Element
import GHC.Float



translate::(DimensionT, DimensionT)->Element->Element

translate shift (shape, oldTransList) = (shape, (TranslateC shift):oldTransList)



changeStrokeColor::Color->Element->Element

changeStrokeColor newColor (Line pts oldColor width, trans) = (Line pts newColor width, trans)

changeStrokeColor newColor (Group elems, trans) =
    (Group $ map (changeStrokeColor newColor) elems, trans)



changeStrokeWidth::Width->Element->Element

changeStrokeWidth newWidth (Line pts color oldWidth, trans) = (Line pts color newWidth, trans)

changeStrokeWidth newWidth (Group elems, trans) =
    (Group $ map (changeStrokeWidth newWidth) elems, trans)
