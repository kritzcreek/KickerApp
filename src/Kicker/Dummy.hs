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
cheJsaResult = Resultat 7 5 []
nosCsmResult :: Resultat
nosCsmResult = Resultat 8 5 []

cheJsaSpiel :: Spiel
cheJsaSpiel =
  Spiel {
    _gruen = cheJsa,
    _schwarz = nosCsm,
    _gruenBelegung = Belegung {_vorne=christoph, _hinten=janis},
    _schwarzBelegung = Belegung {_vorne=norbert, _hinten=christian},
    _resultat = cheJsaResult
    }
nosCsmSpiel :: Spiel
nosCsmSpiel =
  Spiel {
    _gruen = nosCsm,
    _schwarz = cheJsa,
    _gruenBelegung = Belegung {_vorne=christoph, _hinten=janis},
    _schwarzBelegung = Belegung {_vorne=norbert, _hinten=christian},
    _resultat = nosCsmResult}

bo3 :: Partie
bo3 = Partie herausforderung [cheJsaSpiel, cheJsaSpiel]
bo5 :: Partie
bo5 = Partie herausforderung [nosCsmSpiel, nosCsmSpiel, cheJsaSpiel, nosCsmSpiel]

tore :: [Tor]
tore = [Tor janis, Tor christoph, Tor norbert]

herausforderung :: Herausforderung
herausforderung = Herausforderung cheJsa nosCsm
