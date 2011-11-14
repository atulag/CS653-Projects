module FileOps where

import SVGOps (SVG(SVGC), makeFullSVGString, getSVGStringFromElements)
import Element



writeToFile::String->[Element]->IO ()

writeToFile fileName elems = writeSVGStringToFile fileName $ makeFullSVGString $ getSVGStringFromElements elems


	
writeSVGStringToFile::String->SVG String->IO ()

writeSVGStringToFile fileName (SVGC str) = writeFile fileName str
