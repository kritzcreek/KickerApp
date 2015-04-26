import           Engine.Spiel
import           Kicker.Dummy
import           Kicker.Types
import           Test.Tasty
import           Test.Tasty.HUnit
import           Test.Tasty.QuickCheck as QC

import           Control.Lens hiding (each)
import           Control.Monad.State
import           Data.List
import           Data.Ord
import           Pipes
import qualified Pipes.Prelude         as P

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [qcProps]

qcProps = testGroup "(checked by QuickCheck)"
  [ QC.testProperty "sort == sort . reverse" $
      \list -> sort (list :: [Int]) == sort (reverse list)
  , QC.testProperty "Fermat's little theorem" $
      \x -> ((x :: Integer)^7 - x) `mod` 7 == 0
  ]

neueSpieldaten :: Spieldaten
neueSpieldaten = (set resultat neuesResultat cheJsaSpiel, [])

unitTests = testGroup "Unit tests"
  [ testCase "List comparison (different length)" $
      [1, 2, 3] `compare` [1,2] @?= GT

  -- the following test does not hold
  , testCase "List comparison (same length)" $
      [1, 2, 3] `compare` [1,2,2] @?= GT

  , testCase "Kann ein Tor parsen" $
      evalState (P.head (each ["Christoph"] >-> goalProducer)) neueSpieldaten
        @?= Just (Tor (Spieler "Christoph"))
  , testCase "Ein neues Spiel ist leer" $
      execState (P.head (each [] >-> mkSpiel)) neueSpieldaten
       @?= neueSpieldaten
  , testCase "Ein Tor wird hinzugefügt" $
     execState (P.head (each ["Christoph"] >-> mkSpiel)) neueSpieldaten
       @?= (set resultat (Resultat 1 0 []) cheJsaSpiel
           , [Tordaten (Spieler "Christoph") Gruen Vorne])
  ]
