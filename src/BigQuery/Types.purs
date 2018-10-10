module BigQuery.Types(QueryOpts) where

type QueryOpts = 
  { query :: String
  , useLegacySql :: Boolean
  }
