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
  
  chs <- mapM readChapter chapters

  let out = concat chs

  writeFile "out.tex" out

  let defaultPageSize = PageFormat.a4
      docInfo = standardDocInfo {
        author = toPDFString "Book of Sciences authors",
        compressed = False
      }


  runPdf "out.pdf" docInfo defaultPageSize $ do
    generateDocument chs
    

generateDocument :: [String] -> PDF ()
generateDocument chs = do
  chapPages <- forM chs $ \ch -> do
    p <- addPage Nothing
    createPageContent p ch
    return p

  forM chapPages $ \chp ->
    newSection (toPDFString "Section") Nothing Nothing $ do
      newSectionWithPage (toPDFString "Subsection") Nothing Nothing chp $ do
        return ()
  return ()

createPageContent :: PDFReference PDFPage -> String -> PDF ()
createPageContent page s = drawWithPage page $ do
  strokeColor red
  setWidth 0.5
  stroke $ Rectangle (10 :+ 0) (200 :+ 300)
  textText (PDFFont Times_Roman 12) (toPDFString s)

textText :: PDFFont -> PDFString -> Draw ()
textText f t = do
  drawText $ do
    setFont f
    textStart 10 200.0
    leading $ getHeight f
    renderMode FillText
    displayText t
    startNewLine
    displayText $ toPDFString "Another little test"
