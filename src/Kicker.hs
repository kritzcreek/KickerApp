module Kicker where

import           Control.Applicative
import           Control.Lens
import           Kicker.Types

spieleInPartie :: Partie -> Int
spieleInPartie (Partie _ spiele) = length spiele

toreInSpiel :: Teilnehmer -> Spiel -> Int
toreInSpiel t s | s ^. gruen   == t = s ^. resultat . toreGruen
                | s ^. schwarz == t = s ^. resultat . toreSchwarz
                | otherwise = 0

-- Nothing steht hier für Unentschieden
spielGewinner :: Spiel -> Maybe Teilnehmer
spielGewinner s | toreG > toreS = Just (s ^. gruen )
                | toreG < toreS = Just (s ^. schwarz)
                | otherwise = Nothing
  where toreG = toreInSpiel (s ^. gruen) s
        toreS = toreInSpiel (s ^. schwarz) s


partieGewinner :: Partie -> Maybe Teilnehmer
partieGewinner (Partie _ []) = Nothing
partieGewinner (Partie h spiele)
  | erg > 0 = Just (h ^. herausforderer)
  | erg < 0 = Just (h ^. gegner)
  | otherwise = Nothing
  where
    siegerNachInt :: Teilnehmer -> Int
    siegerNachInt t = if t == (h ^. herausforderer) then 1 else -1
    erg = sum $ maybe 0 siegerNachInt <$> (spielGewinner <$> spiele)


toreInPartie :: Partie -> (Int, Int)
toreInPartie (Partie _ []) = (0, 0)
toreInPartie (Partie h spiele) = (tore (h ^. herausforderer), tore (h ^. gegner))
  where
    tore :: Teilnehmer -> Int
    tore teilnehmer = sum $ map (toreInSpiel teilnehmer) spiele
