module Engine.Spiel where

import Kicker.Types
import Control.Applicative
import Control.Monad.State

type LaufendesSpiel = State Resultat
type Torschuetze = Spieler

spielAuswerten ::Herausforderung -> [Tor] -> (Spiel, [Torschuetze])
spielAuswerten (Herausforderung h g) ts =
  (Spiel h g res, torschuetzen)
  where (torschuetzen, res) = runState spielverlauf neuesSpiel
        spielverlauf :: LaufendesSpiel [Torschuetze]
        spielverlauf = sequence (torVerarbeiten <$> ts)
        neuesSpiel = Resultat 0 0

torVerarbeiten ::Tor -> LaufendesSpiel Torschuetze
torVerarbeiten (Gruen ts) = do
  bisher <- get
  put bisher {toreGruen = toreGruen bisher + 1}
  return ts
torVerarbeiten (Schwarz ts) = do
  bisher <- get
  put bisher {toreSchwarz = toreSchwarz bisher + 1}
  return ts
