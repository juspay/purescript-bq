module BigQuery.Core
  ( Client
  , createClient
  , query
  ) where

import Prelude

import BigQuery.Types (QueryOpts)
import Control.Monad.Aff.Class (liftAff, class MonadAff)
import Control.Monad.Aff.Compat (EffFnAff, fromEffFnAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff, class MonadEff)
import Data.Foreign (Foreign)
import Data.Function.Uncurried (Fn2, runFn2)

foreign import data Client :: Type

foreign import _createClient :: forall eff. Fn2 String String (Eff eff Client)
foreign import _query :: forall eff. Fn2 Client QueryOpts (EffFnAff eff Foreign)

createClient :: forall m eff. MonadEff eff m => String -> String -> m Client
createClient projId keyFileName = liftEff $ runFn2 _createClient projId keyFileName

query :: forall m aff. MonadAff aff m => Client -> QueryOpts -> m Foreign
query client opts = liftAff $ fromEffFnAff $ runFn2 _query client opts