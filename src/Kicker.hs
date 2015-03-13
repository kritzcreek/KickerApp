module Kicker where

import Kicker.Types

spieleInPartie :: Partie -> Int
spieleInPartie (Partie p) = length p

-- Nothing steht hier für Unentschieden
partieGewinner :: Partie -> Maybe Teilnehmer
partieGewinner (Partie []) = Nothing
partieGewinner (Partie spiele@(s:_)) | t1 > t2 = Just (gruen s)
                                     | t2 > t1 = Just (schwarz s)
                                     | otherwise = Nothing
  where gewonneneSpiele t = filter ((t ==) . gewinner . resultat) spiele
        t1 = length $ gewonneneSpiele (gruen s)
        t2 = length $ gewonneneSpiele (schwarz s)

toreInPartie :: Partie -> (Int, Int)
toreInPartie (Partie []) = (0, 0)
toreInPartie (Partie spiele@(s:_)) = (tore t1, tore t2)
  where
    t1 = gruen s
    t2 = schwarz s
    tore :: Teilnehmer -> Int
    tore t = toreAlsGruen t + toreAlsSchwarz t
    toreAlsGruen t =   sum $ map (toreGruen . resultat) (filter ((t ==) .  gruen) spiele)
    toreAlsSchwarz t = sum $ map (toreSchwarz . resultat) (filter ((t ==) . schwarz) spiele)
