{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeOperators #-}

module Api where

import           Data.Aeson
import           Data.Proxy
import           GHC.Generics
import           Servant.API
import           Servant.Elm

type Api =
  "api" :>
    ("item" :> Get '[JSON] [ItemId] :<|>
     "item" :> Capture "itemId" ItemId :> Get '[JSON] Item :<|>
     "item" :> ReqBody '[JSON] String :> Post '[JSON] ItemId :<|>
     "item" :> Capture "itemId" ItemId :> Delete '[JSON] NoContent)

api :: Proxy Api
api = Proxy

-- types

type ItemId = Integer

data Item
  = Item {
    id :: ItemId,
    text :: String
  }
  deriving (Show, Eq, Generic)

instance ElmType Item
instance ToJSON Item
instance FromJSON Item
