module Paths_HSVG (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/atulag/.cabal/bin"
libdir     = "/home/atulag/.cabal/lib/HSVG-0.1/ghc-7.0.3"
datadir    = "/home/atulag/.cabal/share/HSVG-0.1"
libexecdir = "/home/atulag/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "HSVG_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "HSVG_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "HSVG_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "HSVG_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
