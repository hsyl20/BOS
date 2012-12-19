import Data.Complex
import System.IO
import Graphics.PDF
import Graphics.PDF.Document
import Data.Traversable (forM)
import Data.Foldable (forM_)
import Data.List (stripPrefix)
import Data.Maybe (fromMaybe)

import qualified BOS.PageFormat as PageFormat
import BOS.Units (cmToPt)

readChapter :: Int -> IO String
readChapter n = readFile $ "contents/" ++ (show n) ++ ".dat"

main = do
  let chapters = [1,3,2]
      defaultPageSize = PageFormat.a4
      docInfo = standardDocInfo {
        author = toPDFString "Book of Sciences authors",
        compressed = False
      }
  
  chs <- mapM readChapter chapters

  runPdf "out.pdf" docInfo defaultPageSize $ do
    generateDocument chs
    

generateDocument :: [String] -> PDF ()
generateDocument chs = do
  forM chs generateChapter
  return ()


generateChapter :: String -> PDF ()
generateChapter ch = do
  let ls = lines ch
      titleMaybe = stripPrefix "=" $ head ls

  page <- addPage Nothing

  newSection (toPDFString $ fromMaybe "Undefined chapter title" titleMaybe) Nothing Nothing $ do
    drawWithPage page $ do
      forM_ titleMaybe $ \title -> do
        drawText $ do 
          let font = PDFFont Times_Roman 28
          setFont font
          textStart 0 600
          leading $ getHeight font
          renderMode FillText
          displayText $ toPDFString title
      strokeColor black
      setWidth 0.5
      stroke $ Rectangle (10 :+ 10) ((cmToPt 21 - 10) :+ (cmToPt 29.7 - 10))
