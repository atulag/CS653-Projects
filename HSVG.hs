module HSVG (newWidth, newColor, newPoint, newLine, newGroup, scaleMajor, scaleMinor, rotate, translate, changeStrokeColor, changeStrokeWidth, writeToFile) where

import FileOps (writeToFile)
import Transform (scaleMajor, scaleMinor, rotate, translate, changeStrokeColor, changeStrokeWidth)
import Element (newWidth, newColor, newPoint, newLine, newGroup)
