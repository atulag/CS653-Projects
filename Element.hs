module Element where


type ColorT = Int

type FactorT = Float

type AngleT = Float

type DimensionT = Float

type UnitlessT = Float



data Transformation =
    TranslateC (DimensionT, DimensionT) |
    ScaleC (FactorT, FactorT) |
    RotateC (AngleT, DimensionT, DimensionT) |
    SkewXC AngleT |
    SkewYC AngleT |
    MatrixC (UnitlessT, UnitlessT, UnitlessT, UnitlessT, UnitlessT, UnitlessT) 
    deriving Show



data Point = PointC (DimensionT, DimensionT) deriving Show

newPoint::(DimensionT, DimensionT)->Point

newPoint coords = PointC coords



data Color = ColorC (ColorT, ColorT, ColorT) deriving Show

newColor::(ColorT, ColorT, ColorT)->Color

newColor rgb = ColorC rgb



data Width = WidthC DimensionT deriving Show

newWidth::DimensionT->Width

newWidth width = WidthC width



data Dimension = DimensionC DimensionT deriving Show

newDimension::DimensionT->Dimension

newDimension length = DimensionC length




data Shape = Line (Point, Point) Color Width |
               Rect Point (Dimension, Dimension) Color Color Width |
               Circle Point Dimension Color Color Width |
               Ellipse Point Dimension Dimension Color Color Width |
               Polyline [Point] Color Width |
               Polygon [Point] Color Color Width |
               Group [Element]
               deriving Show



type Element = (Shape, [Transformation])



newLine::(Point, Point)->Color->Width->Element

newLine points color width = (Line points color width, [])



newRectangle::Point->(Dimension,Dimension)->Color->Color->Width->Element

newRectangle point dimensions fillcolor strokecolor width = 
              (Rect point dimensions fillcolor strokecolor width, [])



newSquare::Point->Dimension->Color->Color->Width->Element

newSquare point side fillcolor strokecolor width =
              newRectangle point (side,side) fillcolor strokecolor width



newCircle::Point->Dimension->Color->Color->Width->Element

newCircle point radius fillColor strokeColor strokeWidth = (Circle point radius fillColor strokeColor strokeWidth, [])



newEllipse::Point->Dimension->Dimension->Color->Color->Width->Element

newEllipse point radiusX radiusY fillColor strokeColor strokeWidth = (Ellipse point radiusX radiusY fillColor strokeColor strokeWidth, [])



newPolyline::[Point]->Color->Width->Element

newPolyline points scolor swidth = (Polyline points scolor swidth, [])



newPolygon::[Point]->Color->Color->Width->Element

newPolygon points fcolor scolor swidth = 
             ((Polygon points fcolor scolor swidth), [])


newGroup::[Element]->Element

newGroup elems = (Group elems, [])
