module Transform where

import Element



translate::(DimensionT, DimensionT)->Element->Element

translate shift (shape, oldTransList) = (shape, (TranslateC shift):oldTransList)



scale::(FactorT, FactorT)->Element->Element

scale factor (shape, oldTransList) = (shape, (ScaleC factor):oldTransList)



rotate::(AngleT, DimensionT, DimensionT)->Element->Element

rotate shift (shape, oldTransList) = (shape, (RotateC shift):oldTransList)



skewX::AngleT->Element->Element

skewX angle (shape, oldTransList) = (shape, (SkewXC angle):oldTransList)



skewY::AngleT->Element->Element

skewY angle (shape, oldTransList) = (shape, (SkewYC angle):oldTransList)



matrixTrans::(UnitlessT, UnitlessT, UnitlessT, UnitlessT, UnitlessT, UnitlessT)->Element->Element

matrixTrans matrix (shape, oldTransList) = (shape, (MatrixC matrix):oldTransList)



changeStrokeColor::Color->Element->Element

changeStrokeColor newColor (Line pts oldColor width, trans) = (Line pts newColor width, trans)

changeStrokeColor newColor (Group elems, trans) =
    (Group $ map (changeStrokeColor newColor) elems, trans)



changeStrokeWidth::Width->Element->Element

changeStrokeWidth newWidth (Line pts color oldWidth, trans) = (Line pts color newWidth, trans)

changeStrokeWidth newWidth (Group elems, trans) =
    (Group $ map (changeStrokeWidth newWidth) elems, trans)
