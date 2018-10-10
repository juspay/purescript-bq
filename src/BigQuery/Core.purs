module BigQuery.Core
  ( Client
  , _createClient
  , query
  ) where

import Prelude

import Data.Either (Either(..))
import Data.Function.Uncurried (Fn4) as Fn
import Data.Function.Uncurried (runFn4)
import Effect (Effect)
import Effect.Aff (Aff, Canceler, makeAff)
import Effect.Exception (Error)
import Foreign (Foreign)
import BigQuery.Types (QueryOpts)

foreign import data Client :: Type

foreign import _createClient :: String -> String -> Effect Client
foreign import _query :: Fn.Fn4 (Error -> Effect Unit) (Foreign -> Effect Unit) Client QueryOpts (Effect Canceler)

query :: Client -> QueryOpts -> Aff Foreign
query client opts = makeAff (\cb -> runFn4 _query (cb <<< Left) (cb <<< Right) client opts)
