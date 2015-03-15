-- | Main entry point to the application.
module Main where

import Kicker
import Kicker.Types (name)
import Kicker.Dummy
import Engine.Spiel

-- | The main entry point.
main :: IO ()
main = do
    putStrLn $ "BO3 Gewinner: " ++ show (partieGewinner bo3)
    putStrLn $ "BO3 Torstand: " ++ show (toreInPartie bo3)
    putStrLn $ "BO5 Gewinner: " ++ show (partieGewinner bo5)
    putStrLn $ "BO5 Torstand: " ++ show (toreInPartie bo5)
    (spiel, torschuetzen) <- spielAuswerten herausforderung tore
    putStrLn $ "Die Torschutzen: " ++ show (map name torschuetzen)
