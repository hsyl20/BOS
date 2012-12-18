import System.IO

readChapter :: Int -> IO String
readChapter n = readFile $ "contents/" ++ (show n) ++ ".dat"

main = do
  let chapters = [1,3]
  
  chs <- mapM readChapter chapters

  let out = concat chs

  writeFile "out.tex" out
