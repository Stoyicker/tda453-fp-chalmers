module L03A where
import Data.List
import Data.Char

-- **** 
-- Small examples of IO
-- writeFile

-- * Building instructions vs running instructions
-- _Instructions_ themselves, and the result of _Running_ the instructions are *not* the same
-- You should think of IO as a special, abstract type representing instructions

-- Who gets to run instructions? Nobody. The only way they can be run is if it is the top-level value.
-- Only If the IO type reaches the top-level does the runtime run the instruction.

-- instructions with results:


-- building complex instructions from simple ones

copyFile :: FilePath -> FilePath -> IO ()
copyFile fromFile toFile = 
  -- here you are getting a string from an IO String, but you're doing it INSIDE a `do`.
  -- So the only thing you can return is an IO ().
  -- readFile returns IO String,
  -- writeFile 2nd argument has to be a string.
   do c <- readFile fromFile 
      -- the type of the last line will be the type of the result
      -- here it is IO ()
      writeFile toFile c

-- var <- expr 
-- var :: a  expr :: IO 
-- this returns something of type IO a

-- find longest Word in "/usr/share/dict/words"
longest :: IO String
longest = do 
        wlist <- readFile "/usr/share/dict/words"
        return (long wlist)

  where long :: (Int, String) -> String
        long  =  maximum . map (\w -> (length w, w)) . words
-- dotwice

dotwice :: IO a -> IO (a,a)
dotwice i = do 
        a1 <- i
        a2 <- i
        return (a1,a2)

dont :: IO a -> IO ()
dont i = return ()

test :: IO Int
test = do 
     return 42
     return 0

-- sequence_ 
mySequence_ :: [IO a] -> IO ()
mySequence_ []     = return ()
mySequence_ (i:is) = 
  do i 
     mySequence_ is
 -- i >> mySequence_ is

-- sequence
mySequence :: [IO a] -> IO [a]
mySequence [] = return []
mySequence (i:is) = 
  do a <- i
     as <- mySequence is
     return (a:as)

-- Exercises: Define the following functions: 
copyAll :: [FilePath] -> FilePath -> IO()
copyAll fromFiles toFile = undefined
  -- hint: sequence :: [IO a] -> IO [a]   
  --       map :: (a -> b) -> [a] -> [b]

forLoop :: [a] -> (a -> IO ()) -> IO ()
forLoop = undefined 
-- e.g. forLoop [1..10] print 
-- will print numbers from 1 to 10.


