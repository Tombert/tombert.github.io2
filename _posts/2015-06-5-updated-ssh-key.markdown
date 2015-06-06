---
layout: post
comments: true
title:  "A purer SSH-key getter. "
date:   2015-06-05 12:14:02
---

Awhile ago, I wrote an article about [how to automate the retrieval of SSH keys](/2015/04/17/almost-hacked.html).  THat worked fine, there was nothing wrong with it, but I've been getting more into haskell, and I figured that Haskell-izing some shell-stuff would be a fun little project.  Subsequently, here's the updated script: 

{% highlight haskell%}
module Main where
import Control.Concurrent.Async
import Network.HTTP.Conduit
import System.Environment
import qualified Data.ByteString.Lazy as LB

-- Very simple helper function to do a basic get request 

makeUrl :: String -> String
makeUrl u = "https://github.com/" ++ u ++ ".keys"

main :: IO ()
main = do
  usernames <- getArgs 
  let urls = map makeUrl usernames
  keys <- mapConcurrently simpleHttp urls
  mapM_ LB.putStrLn keys

{% endhighlight %}

Was this necessary?  Not really.  Is it cooler?  Absolutely!  I even improved it slightly by running requests in parallel. 

I might start posting more of these; I'd like to see Haskell used for more shell stuff. 
