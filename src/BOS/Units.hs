module BOS.Units where

-- Unit conversions
inchToPt :: Double -> Double
inchToPt = (*) 72.0

mmToPt :: Double -> Double
mmToPt = flip (/) 127.0 . (*) 360.0

cmToPt :: Double -> Double
cmToPt = flip (/) 127.0 . (*) 3600.0

