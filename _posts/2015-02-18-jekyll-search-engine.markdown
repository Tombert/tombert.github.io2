---
layout: post
comments: true
title:  "Writing a very basic search engine for Jekyll...no plugins required"
date:   2015-02-19 21:37:40
---
I've had pretty good success using the Jekyll blogging engine.  I was a little skeptical about everything being static at first, but it's turned out to be a pretty sexy little blogging engine, and the fact that it's static makes things pretty nice. 

However, there are some features with dynamic sites that are taken for granted, such as doing simple searches on the posts. 

I decided I wasn't going to stand for this, and wrote my own, and I'm happy to show you all how to do the same.

--------- 

The first things you're going to need are jQuery and Lodash. While you can probably get away without the latter, jQuery is absolutely necessary for how I built this thing.  I also tend to prefer to keep things in promises, so as to properly keep everything composable and segmented, as well as make sure our AJAX-ey stuff is handled right. I added the dependencies to the `_inclues/head.html` file: 

{% highlight html %}
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/bluebird/2.9.9/bluebird.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/3.2.0/lodash.min.js"></script>
{% endhighlight%}

--------

We also need to add some HTML to handle all the input, and I found it easier to simply make a new search page. 

Consequently, I made a search.html file in the root of the Jekyll directory, and defined the file like this: 

{% highlight html %}
---
layout: page
title: Search
permalink: /search/
---
<div>
  <input type="text" id="searchParam" /><button id="submit">Search</button>

  <div id="results"></div>
</div>

{% endhighlight %}

As you can all see, I'm not really much of a designer, but the idea behind this is pretty straightforward already.  We're going to submit the input's search params, and feed the output to the `#results` `div`. 

----

Here comes the fun part: the actual code. (Full source on the bottom for people that don't want to read).

First things first, let's make sure the DOM is done loading before we start any kind of processing, and since Jekyll has native CoffeeScript support built-in (at least on Github Pages), let's use it

{% highlight coffeescript %}
$ ->
{% endhighlight %}

Crazy stuff, I know.  That was totally worth a code block. 

-----------------

Anyway, after that, let's define a quick function to grab the parameter from the search box. 

{% highlight coffeescript %}
getSearchParam = -> $("#searchParam").val()
{% endhighlight %}

Ok, now that the easiest stuff is taken care of, let's get to the meat of the program. 

Let's create a new function that takes in the input from our `getSearchParam` function. Immediately we'll need to ping the RSS feed of the site to get all the information. 

{% highlight coffeescript %}
        lookup = (lookupText) ->
                Promise.resolve($.get '/feed.xml')

{% endhighlight %}

I use the `Promise.resolve` feature so as to guarantee that we're using proper `Promise/A+` stuff, not the bizarre pseudo-promises jQuery provides. 

-------------

Anyway, once we've gotten the data, let's do our initial parsing.

{% highlight coffeescript %}
.then (data) ->
      items = _.toArray($(data).find('item'))
      _.map items, (i) ->
      	    description: $(i).find('description').text()
            link:  $(i).find('link').text()
            title: $(i).find('title').text()
{% endhighlight %}

This first chunk is to shape out the data into something relatively easy to play with, then return it back as an array. Afterwards, let's filter this down to only the posts that have the term we care about. 

{% highlight coffeescript %}
.then (items) ->
      _.filter items, (i) -> (i.description.toLowerCase().indexOf(do lookupText.toLowerCase) > -1 or i.title.toLowerCase().indexOf(lookupText.toLowerCase()) > -1 )
{% endhighlight %}

This chain is rather long, but it's straightforward; we want to ignore case, so we'll utilize the `.toLowerCase()` functions and then utilize `.indexOf` to see if our string is actually in the title of the description of the post. 

Afterwards, let's shape our description so that we can show a small sample of where our phrase may be, and let's also highlight it, Google-style. 

{% highlight coffeescript %}
.then (items) ->
      _.map items, (i) ->
      	    index = i.description.toLowerCase().indexOf lookupText.toLowerCase()
            phrase = i.description.substr(index, lookupText.length)
            boldPhrase = "<strong>#{phrase}</strong>"
            i.description = i.description.substr(0, index) + boldPhrase + i.description.substr(index + phrase.length)
            i.description = "..." + i.description.substring((index - 40), (index + 40)) + "..."
            return i
{% endhighlight %}

After that big chunk, let's format all this stuff into some kind of HTML: 

{% highlight coffeescript %}
.then (items) ->
      htmlItems = _.map items, (item) ->
      		"<div class=\"search_item\"><a href=\"#{item.link}\"><h4>#{item.title}</h4></a><div>#{item.description}</div></div>"
{% endhighlight %}

And now let's actually insert it: 

{% highlight coffeescript %}
.then (htmlItems) ->
      $('#results').empty()
      _.each htmlItems, (i) ->
      	     $('#results').append($(i))
{% endhighlight %}

---------

Alright, we have all this stuff to handle everything, let's glue everything together utilizing Lodash's composer method, and the obvious jQuery `click` function. 


{% highlight coffeescript %}
$("#submit").click(_.compose(lookup, getSearchParam))
{% endhighlight %}

And that's it.  Here's the complete source code: 

{% highlight coffeescript %}
---
---
$ ->
        lookup = (lookupText) ->
                Promise.resolve($.get '/feed.xml')
                .then (data) ->
                        items = _.toArray($(data).find('item'))
                        _.map items, (i) ->
                                description: $(i).find('description').text()
                                link:  $(i).find('link').text()
                                title: $(i).find('title').text()
                .then (items) ->
                        _.filter items, (i) -> (i.description.toLowerCase().indexOf(do lookupText.toLowerCase) > -1 or i.title.toLowerCase().indexOf(lookupText.toLowerCase()) > -1 )
                .then (items) ->
                        _.map items, (i) ->
                                index = i.description.toLowerCase().indexOf lookupText.toLowerCase()
                                phrase = i.description.substr(index, lookupText.length)
                                boldPhrase = "<strong>#{phrase}</strong>"
                                i.description = i.description.substr(0, index) + boldPhrase + i.description.substr(index + phrase.length)
                                i.description = "..." + i.description.substring((index - 40), (index + 40)) + "..."
                                return i
                .then (items) ->
                        htmlItems = _.map items, (item) ->
                                "<div class=\"search_item\"><a href=\"#{item.link}\"><h4>#{item.title}</h4></a><div>#{item.description}</div></div>"
                .then (htmlItems) ->
                        $('#results').empty()
                        _.each htmlItems, (i) ->
                                $('#results').append($(i))
                                
        getSearchParam = -> $("#searchParam").val()
                
        $("#submit").click(_.compose(lookup, getSearchParam))

{% endhighlight %}


I realize that this approach involves a lot of copying. I would love to see anyone else's approach to how to solve this problem with any kind of elegance (leave a comment!). 

Anyway, I hope this post was helpful to anyone interested in Jekyll (it really is a fantastic platform). 