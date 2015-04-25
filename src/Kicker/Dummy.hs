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
marvin :: Spieler
marvin = Spieler "Marvin"
tom :: Spieler
tom = Spieler "Tom"

wertung :: TeilnehmerWertung
wertung = TeilnehmerWertung 100 100 100

cheJsa :: Teilnehmer
cheJsa = Team (christoph, janis) Nothing
nosCsm :: Teilnehmer
nosCsm = Team (norbert, christian) (Just wertung)
mmuTpe :: Teilnehmer
mmuTpe = Team (marvin, tom) Nothing


cheJsaResult :: Resultat
cheJsaResult = Resultat 7 5
nosCsmResult :: Resultat
nosCsmResult = Resultat 8 5

cheJsaSpiel :: Spiel
cheJsaSpiel =
  Spiel {
    gruen = cheJsa,
    schwarz = nosCsm,
    gruenBelegung = Belegung {vorne=christoph, hinten=janis},
    schwarzBelegung = Belegung {vorne=norbert, hinten=christian},
    resultat = cheJsaResult
    }
nosCsmSpiel :: Spiel
nosCsmSpiel =
  Spiel {
    gruen = nosCsm,
    schwarz = cheJsa,
    gruenBelegung = Belegung {vorne=christoph, hinten=janis},
    schwarzBelegung = Belegung {vorne=norbert, hinten=christian},
    resultat = nosCsmResult}

bo3 :: Partie
bo3 = Partie herausforderung [cheJsaSpiel, cheJsaSpiel]
bo5 :: Partie
bo5 = Partie herausforderung [nosCsmSpiel, nosCsmSpiel, cheJsaSpiel, nosCsmSpiel]

tore :: [Tor]
tore = [Gruen janis, Gruen christoph, Schwarz norbert]

herausforderung :: Herausforderung
herausforderung = Herausforderung cheJsa nosCsm
