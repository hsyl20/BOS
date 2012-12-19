import Data.Complex
import System.IO
import Graphics.PDF
import Graphics.PDF.Document
import Data.Traversable (forM)

import qualified BOS.PageFormat as PageFormat

readChapter :: Int -> IO String
readChapter n = readFile $ "contents/" ++ (show n) ++ ".dat"

main = do
  let chapters = [1,3]
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
      title = head ls
  page <- addPage Nothing
  newSection (toPDFString title) Nothing Nothing $ do
    drawWithPage page $ do
      drawText $ do 
        let font = PDFFont Times_Roman 28
        setFont font
        textStart 0 600
        leading $ getHeight font
        renderMode FillText
        displayText $ toPDFString title
      strokeColor black
      setWidth 0.5
      stroke $ Rectangle (10 :+ 10) ((PageFormat.cmToPt 21 - 10) :+ (PageFormat.cmToPt 29.7 - 10))
