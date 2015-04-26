module Engine.Spiel where

import           Control.Applicative
import           Control.Lens
import           Control.Monad.State
import           Data.Maybe          (fromMaybe)
import           Kicker.Types
import           Pipes

type Torschuetze = Spieler
data Tordaten = Tordaten Spieler Farbe Position deriving (Show, Eq)
type Spieldaten = (Spiel, [Tordaten])

inTeilnehmer :: Spieler -> Teilnehmer -> Bool
inTeilnehmer s (Team (s1, s2) _) = s == s1 || s == s2
inTeilnehmer s (Einzel s1 _) = s == s1

findeTeam :: Spieler -> Spiel -> Maybe Farbe
findeTeam s sp | inTeilnehmer s (sp ^. gruen) = Just Gruen
               | inTeilnehmer s (sp ^. schwarz) = Just Schwarz
               | otherwise = Nothing

tordaten :: Tor -> Spiel -> Maybe Tordaten
tordaten (Tor schuetze) spiel = Tordaten schuetze <$> farbe <*> position
  where farbe = findeTeam schuetze spiel
        position = Just Vorne

torHinzufuegen :: Spiel -> Farbe -> Spiel
torHinzufuegen sp Gruen = sp & resultat . toreGruen %~ succ
torHinzufuegen sp Schwarz = sp & resultat . toreSchwarz %~ succ

torVerarbeiten :: Tor -> State Spieldaten Spieldaten
torVerarbeiten tor@(Tor ts) = do
  bisherState@(bisherSpiel, bisherTordaten) <- get
  let newState =
        do neuesSpiel <- torHinzufuegen bisherSpiel <$> findeTeam ts bisherSpiel
           neueTordaten <- tordaten tor bisherSpiel
           return (neuesSpiel, neueTordaten : bisherTordaten)
  put (fromMaybe bisherState newState)
  get

mkSpiel :: Consumer String (State Spieldaten) ()
mkSpiel = goalProducer >-> goalConsumer

goalProducer :: Pipe String Tor (State Spieldaten) ()
goalProducer = do
    parseTor <$> await >>= yield
    goalProducer

goalConsumer :: Consumer Tor (State Spieldaten) ()
goalConsumer = await >>= lift . torVerarbeiten >> goalConsumer

