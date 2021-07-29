{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Handler.Homepage where

import Import

getHomepageR :: Handler Html
getHomepageR = do 
    defaultLayout $ do
        setTitle "Homepage"
 
