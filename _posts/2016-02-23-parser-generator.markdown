---
layout: post
comments: true
title:  "Why the fuck did no one tell me about parser generators?"
date:   2016-02-22 17:46:32
---


As I've mentioned before, I'm in the process of rewriting my web framework "Frameworkey" in Erlang.  It's been rewarding, but, if I'm being honest, it's been a bit of a straight (and boring) port.  A lot of the semantics are the same as the JavaScript version, and it's impossible to avoid the feeling of "this is clearly *not* the way to do this shit". 

It's not that I went in with the mindset of "I need to take my JavaScript code and make it work with Erlang!", nor do I feel like JavaScript forces the best idioms on people, because it most certainly doesn't. I simply didn't know better, which gets to the title of this article:

### Parser generators are fucking wonderful.

The parsing for Frameworkey has traditionally been something akin to:

{% highlight javascript %}

var actions = "controller.action controller2.action2 controller3.action3";
var actionarray = actions.split(" ");
var properActions = actions.map( (action) => action.split("."));
return properActions;

{% endhighlight %}


And this works ok.   Hell, it's been used in production, and it performs well enough, but then we get to the topic of scaling.

I'm not even talking about "will this handle a trillion users who all decide to log in at once and need consistent data everywhere" territory, but more of the "I want to add a new feature in a relatively short amount of time" problem. 

For example, in the JS version of Frameworkey, I wanted to run two actions in parallel.  I ended up creating a new syntax for that:

{% highlight javascript %}

var actions = "controller.action^controller2.action2 controller3.action3";

{% endhighlight %}

Which looks sexy and everything, but how the hell was I going to add that feature?  The entire code was built on my splitting architecture.

I just assumed that nothing was better, and ended up doing a full rewrite. 

And that's what I'm getting at:

### If you ever need to parse a document, don't be an idiot and do it yourself...Use a fucking Parser Generator.

If I had know anything about parsers and lexers back when I was writing Frameworkey, I might have defined a file like this:

{% highlight erlang %}

Definitions.

Rules.

GET|PUT|POST|DELETE|PATCH : {token, {method, TokenLine, TokenChars}}.
/[A-Za-z_]+ : {token, {endpoint, TokenLine, TokenChars}}.
[A-Za-z0-9_]+\.[A-Za-z0-9_]+ : {token, {function, TokenLine, splitControllerAction(TokenChars)}}.
\|\>  : {token, {pipe, TokenLine}}.
[\s\t\n\r]+ : skip_token.

Erlang code.
splitControllerAction(A) ->
[Controller, Action] = string:tokens(A, "."),
   {list_to_atom(Controller), list_to_atom(Action)}.


{% endhighlight %}


This might seem complex, and it sort of is, but at the same time, *it scales*.  Adding a new feature is as simple as adding another grammar to this file, compiling it, and bam, I have a new grammar.

Once the grammar is defined, I create a new parser: 


{% highlight erlang %}
Nonterminals route actionlist elem.
Terminals function endpoint method pipe.
Rootsymbol route.

route -> method endpoint actionlist : {'$1', '$2', '$3'}.

actionlist -> elem : ['$1'].
actionlist -> elem 'pipe' actionlist : ['$1' | '$3'].

elem -> function : extract_token('$1').



Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
{% endhighlight %}


Which may seem intimidating, but *that's it*.  The parsing *never* gets more complicated than that.

The result has ended up creating a slightly faster parser than the one I wrote manually, and, as previously mentioned, a result that scales linearly, instead of exponentionally.

Learning this has gotten me fascinated.  I feel like creating a who shitload of Domain Specific Languages to handle any which thing...Maybe the first step I should learn is moderation.  Ha!  I'll start on that right after I win the lottery. 
