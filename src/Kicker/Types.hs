{-# LANGUAGE GADTs #-}
module Kicker.Types where

data Resultat =
  Resultat { gewinner    :: Teilnehmer,
             toreGruen   :: Int,
             toreSchwarz :: Int
           } deriving (Show, Eq)

data TeilnehmerWertung =
  TeilnehmerWertung { elo       :: Int,
                      vorneElo  :: Int,
                      hintenElo :: Int
                    } deriving(Show, Eq)

data Spieler =
  Spieler { name :: String } deriving(Show, Eq)

data Teilnehmer where
  Team   :: (Spieler, Spieler) -> Maybe TeilnehmerWertung -> Teilnehmer
  Einzel :: Spieler -> Maybe TeilnehmerWertung -> Teilnehmer
  deriving(Show, Eq)

data Spiel = Spiel { gruen    :: Teilnehmer,
                     schwarz  :: Teilnehmer,
                     resultat :: Resultat
                   } deriving (Show, Eq)

newtype Partie = Partie [Spiel]
