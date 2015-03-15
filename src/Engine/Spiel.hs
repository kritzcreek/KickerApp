module Engine.Spiel where

import Kicker.Types
import Control.Applicative
import Control.Monad.State

--type LaufendesSpiel = StateT Resultat
type Torschuetze = Spieler

spielAuswerten ::Herausforderung -> [Tor] -> IO (Spiel, [Torschuetze])
spielAuswerten (Herausforderung h g) ts = do
  (torschuetzen, res) <- runStateT spielverlauf neuesSpiel
  return $ (,) (Spiel h g res) torschuetzen
  where
        spielverlauf :: StateT Resultat IO [Torschuetze]
        spielverlauf = sequence (torVerarbeiten <$> ts)
        neuesSpiel = Resultat 0 0

kommentator :: String -> String
kommentator ts = ts ++ " könnte schießen, " ++ ts ++ " schießt... TOOOOOOOOOOR!"

torVerarbeiten ::Tor -> StateT Resultat IO Torschuetze
torVerarbeiten (Gruen ts) = do
  bisher <- get
  lift $ putStrLn (kommentator (name ts))
  put bisher {toreGruen = toreGruen bisher + 1}
  return ts
torVerarbeiten (Schwarz ts) = do
  bisher <- get
  lift $ putStrLn (kommentator (name ts))
  put bisher {toreSchwarz = toreSchwarz bisher + 1}
  return ts
