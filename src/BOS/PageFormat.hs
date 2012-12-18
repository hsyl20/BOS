module BOS.PageFormat where

import Graphics.PDF (PDFRect(..))

-- Unit conversions

inchToPt :: Double -> Int
inchToPt = round . (*) 72.0

mmToPt :: Double -> Int
mmToPt = round . flip (/) 127.0 . (*) 36.0

cmToPt :: Double -> Int
cmToPt = round . flip (/) 127.0 . (*) 360.0

-- Rectangles
ptRect :: Int -> Int -> PDFRect
ptRect w h = PDFRect 0 0 w h 

convRect :: (Double -> Int) -> Double -> Double -> PDFRect
convRect f w h = ptRect (f w) (f h)

inchRect :: Double -> Double -> PDFRect
inchRect = convRect inchToPt

cmRect :: Double -> Double -> PDFRect
cmRect = convRect cmToPt

mmRect :: Double -> Double -> PDFRect
mmRect = convRect mmToPt


-- Paper sizes
a0 = inchRect 33.11 46.81
a1 = inchRect 23.39 33.11
a2 = inchRect 16.54 23.39
a3 = inchRect 11.69 16.54
a4 = inchRect 8.27 11.69
a5 = inchRect 5.83 8.27
a6 = inchRect 4.13 5.83
a7 = inchRect 2.91 4.13
a8 = inchRect 2.05 2.91
a9 = inchRect 1.46 2.05
a10 = inchRect 1.02 1.46

b0 = inchRect 39.37 55.67
b1 = inchRect 27.83 39.37
b2 = inchRect 19.69 27.83
b3 = inchRect 13.90 19.69
b4 = inchRect 9.84 13.90
b5 = inchRect 6.93 9.84
b6 = inchRect 4.92 6.93
b7 = inchRect 3.46 4.92
b8 = inchRect 2.44 3.46
b9 = inchRect 1.73 2.44
b10 = inchRect 1.22 1.73

c0 = inchRect 36.10 51.06
c1 = inchRect 25.51 36.10
c2 = inchRect 18.03 25.51
c3 = inchRect 12.76 18.03
c4 = inchRect 9.02 12.76
c5 = inchRect 6.38 9.02
c6 = inchRect 4.49 6.38
c7 = inchRect 3.19 4.49
c8 = inchRect 2.24 3.19
c9 = inchRect 1.57 2.24
c10 = inchRect 1.10 1.57

letter = inchRect 8.5 11
legal = inchRect 8.5 14.0
juniorLefal = inchRect 8.0 5.0
ledger = inchRect 17.0 11.0
tabloid = inchRect 11.0 17.0
