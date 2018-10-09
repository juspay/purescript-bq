module Types(QueryOpts) where

import Prelude

type QueryOpts = 
  { query :: String
  , useLegacySql :: Boolean
  }
