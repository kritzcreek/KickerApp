{-# LANGUAGE GADTs #-}
{-# LANGUAGE TemplateHaskell #-}
module Kicker.Types where

import Control.Lens

data Farbe = Gruen | Schwarz deriving (Show, Eq)
data Position = Vorne | Hinten deriving (Show, Eq)
data Tor = Tor Spieler deriving (Show, Eq)

data Resultat =
  Resultat {
    _toreGruen   :: Int,
    _toreSchwarz :: Int,
    _torListe    :: [Tor]
    } deriving (Show, Eq)

data TeilnehmerWertung =
  TeilnehmerWertung {
    _elo       :: Int,
    _vorneElo  :: Int,
    _hintenElo :: Int
    } deriving(Show, Eq)

data Spieler =
  Spieler {
    _name :: String
    } deriving(Show, Eq)

data Teilnehmer where
  Team   :: (Spieler, Spieler) -> Maybe TeilnehmerWertung -> Teilnehmer
  Einzel :: Spieler -> Maybe TeilnehmerWertung -> Teilnehmer
  deriving(Show, Eq)

data Spiel =
  Spiel {
    _gruen           :: Teilnehmer,
    _schwarz         :: Teilnehmer,
    _gruenBelegung   :: Belegung,
    _schwarzBelegung :: Belegung,
    _resultat        :: Resultat
  } deriving (Show, Eq)

data Belegung =
  Belegung {
    _vorne  :: Spieler,
    _hinten :: Spieler
  } deriving(Show, Eq)

data Herausforderung =
  Herausforderung  {
    _herausforderer :: Teilnehmer,
    _gegner         :: Teilnehmer
  }

data Partie = Partie Herausforderung [Spiel]

parseTor :: String -> Tor
parseTor str = Tor (Spieler str)

neuesResultat :: Resultat
neuesResultat = Resultat 0 0 []

-- | API Wunsch:
-- | Neue Herausforderung
-- | Akzeptieren
-- | Neues Spiel (Belegung)
-- | Tor
-- | Spiel Beenden

data SpielEvent =
  TorEvent Spieler
  | Switcharoo Farbe
  | SpielEnde

data HerausforderungEvent =
  NeueHerausforderung Herausforderung
  | Akzeptieren Herausforderung
  | NeuesSpiel Teilnehmer Belegung Teilnehmer Belegung
  | HerausforderungBeenden

makeLenses ''Resultat
makeLenses ''TeilnehmerWertung
makeLenses ''Spieler
makeLenses ''Herausforderung
makeLenses ''Belegung
makeLenses ''Spiel
