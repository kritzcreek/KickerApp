module Kicker where

import Kicker.Types
import Control.Applicative

spieleInPartie :: Partie -> Int
spieleInPartie (Partie _ spiele) = length spiele

toreInSpiel :: Teilnehmer -> Spiel -> Int
toreInSpiel t s | gruen s   == t = toreGruen (resultat s)
                | schwarz s == t = toreSchwarz (resultat s)
                | otherwise = 0

-- Nothing steht hier für Unentschieden
spielGewinner :: Spiel -> Maybe Teilnehmer
spielGewinner s | toreG > toreS = Just (gruen s)
                | toreG < toreS = Just (schwarz s)
                | otherwise = Nothing
  where toreG = toreInSpiel (gruen s) s
        toreS = toreInSpiel (schwarz s) s


partieGewinner :: Partie -> Maybe Teilnehmer
partieGewinner (Partie _ []) = Nothing
partieGewinner (Partie h spiele)
  | erg > 0 = Just (herausforderer h)
  | erg < 0 = Just (gegner h)
  | otherwise = Nothing
  where
    siegerNachInt :: Teilnehmer -> Int
    siegerNachInt = \t -> if t == herausforderer h then 1 else -1
    erg = sum $ (maybe 0 siegerNachInt) <$> (spielGewinner <$> spiele)


toreInPartie :: Partie -> (Int, Int)
toreInPartie (Partie _ []) = (0, 0)
toreInPartie (Partie h spiele) = (tore (herausforderer h), tore (gegner h))
  where
    tore :: Teilnehmer -> Int
    tore = \ teilnehmer -> sum $ (toreInSpiel teilnehmer) <$> spiele
