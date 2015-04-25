{-# LANGUAGE GADTs #-}
module Kicker.Types where

data Resultat =
  Resultat {
    toreGruen   :: Int,
    toreSchwarz :: Int
    } deriving (Show, Eq)

data TeilnehmerWertung =
  TeilnehmerWertung {
    elo       :: Int,
    vorneElo  :: Int,
    hintenElo :: Int
    } deriving(Show, Eq)

data Spieler =
  Spieler {
    name :: String
    } deriving(Show, Eq)

data Teilnehmer where
  Team   :: (Spieler, Spieler) -> Maybe TeilnehmerWertung -> Teilnehmer
  Einzel :: Spieler -> Maybe TeilnehmerWertung -> Teilnehmer
  deriving(Show, Eq)

data Spiel =
  Spiel {
    gruen    :: Teilnehmer,
    schwarz  :: Teilnehmer,
    gruenBelegung :: Belegung,
    schwarzBelegung :: Belegung,
    resultat :: Resultat
  } deriving (Show, Eq)

data Belegung =
  Belegung {
    vorne :: Spieler,
    hinten :: Spieler
  } deriving(Show, Eq)

data Herausforderung =
  Herausforderung  {
    herausforderer :: Teilnehmer,
    gegner :: Teilnehmer
  }

data Partie = Partie Herausforderung [Spiel]

data Tor = Gruen Spieler | Schwarz Spieler
