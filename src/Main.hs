-- | Main entry point to the application.
module Main where

import           Control.Applicative ((<$>))
import           Control.Monad       (unless)
import           Engine.Spiel
import           Kicker
import           Kicker.Dummy
import           Kicker.Types (name, Belegung())
import           Pipes
import           System.IO           (isEOF)


goalProducer :: Producer Tor IO ()
goalProducer = do
  eof <- lift isEOF
  unless eof $ do
    s <- lift (parseTor <$> getLine)
    yield s
    goalProducer

-- | The main entry point.
main :: IO ()
main = do
    putStrLn $ "BO3 Gewinner: " ++ show (partieGewinner bo3)
    putStrLn $ "BO3 Torstand: " ++ show (toreInPartie bo3)
    putStrLn $ "BO5 Gewinner: " ++ show (partieGewinner bo5)
    putStrLn $ "BO5 Torstand: " ++ show (toreInPartie bo5)
    (spiel, torschuetzen) <- spielAuswerten herausforderung (Belegung christoph janis) (Belegung norbert christian) tore
    putStrLn $ "Die Torschutzen: " ++ show (map name torschuetzen)
