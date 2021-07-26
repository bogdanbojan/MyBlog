{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Handler.PostNew where

import Yesod.Form.Bootstrap3
import Yesod.Text.Markdown
import Import


-- data BlogPost = BlogPost
--         { title :: Text
--         , article :: Markdown
--         }
-- Same record datatype has been generated from models.
-- Therefore, we don't really need this one.

blogPostForm :: AForm Handler BlogPost
blogPostForm = BlogPost 
            <$> areq textField (bfs ("Title" :: Text)) Nothing
            <*> areq markdownField (bfs ("Article" :: Text)) Nothing

getPostNewR :: Handler Html
getPostNewR = do
    (widget, enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm blogPostForm
    defaultLayout $ do
        $(widgetFile "posts/new")

postPostNewR :: Handler Html
postPostNewR = do
        ((res, widget), enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm blogPostForm
        case res of 
          FormSuccess blogPost -> do 
                blogPostId <- runDB $ insert blogPost 
                redirect $ PostDetailsR blogPostId
          _ -> defaultLayout $(widgetFile "posts/new")