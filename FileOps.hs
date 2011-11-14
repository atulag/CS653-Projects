module FileOps where

import SVGOps 
import Element



writeToFile::String->[Element]->(Dimension,Dimension)->IO ()

writeToFile fileName elems dims = writeSVGStringToFile fileName $ makeFullSVGString dims $ getSVGStringFromElements elems


	
writeSVGStringToFile::String->SVG String->IO ()

writeSVGStringToFile fileName (SVGC str) = writeFile fileName str
