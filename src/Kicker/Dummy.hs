module Kicker.Dummy where

import Kicker.Types

christoph :: Spieler
christoph = Spieler "Janis"
janis :: Spieler
janis = Spieler "Christoph"
norbert :: Spieler
norbert = Spieler "Norbert"
christian :: Spieler
christian = Spieler "Christian"

wertung :: TeilnehmerWertung
wertung = TeilnehmerWertung 100 100 100

cheJsa :: Teilnehmer
cheJsa = Team (christoph, janis) Nothing
nosCsm :: Teilnehmer
nosCsm = Team (norbert, christian) (Just wertung)

cheJsaResult :: Resultat
cheJsaResult = Resultat 7 5
nosCsmResult :: Resultat
nosCsmResult = Resultat 8 5

cheJsaSpiel :: Spiel
cheJsaSpiel = Spiel {gruen = cheJsa, schwarz = nosCsm, resultat = cheJsaResult}
nosCsmSpiel :: Spiel
nosCsmSpiel = Spiel {gruen = nosCsm, schwarz = cheJsa, resultat = nosCsmResult}

bo3 :: Partie
bo3 = Partie (Herausforderung cheJsa nosCsm) [cheJsaSpiel, cheJsaSpiel]
bo5 :: Partie
bo5 = Partie (Herausforderung cheJsa nosCsm) [nosCsmSpiel, nosCsmSpiel, cheJsaSpiel, nosCsmSpiel]

tore :: [Tor]
tore = [Gruen janis, Gruen christoph, Schwarz norbert]
