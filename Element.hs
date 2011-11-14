module Element where



data Point = PointC (Float, Float) deriving Show

newPoint::(Float, Float)->Point

newPoint coords = PointC coords



data Color = ColorC (Int, Int, Int) deriving Show

newColor::(Int, Int, Int)->Color

newColor rgb = ColorC rgb



data Width = WidthC Float deriving Show

newWidth::Float->Width

newWidth width = WidthC width



data Element = Line (Point, Point) Color Width | Group [Element] deriving Show



newLine::(Point, Point)->Color->Width->Element

newLine points color width = Line points color width



newGroup::[Element]->Element

newGroup elems = Group elems
