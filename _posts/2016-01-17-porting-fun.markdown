---
comments: true
layout: post
title: The Joys and Perils of Porting Things to Another Language. 
date: 2016-01-16 23:22:50
---

I know, I know, it's been awhile since I've posted anything. What can I say, I've been busy, and managing a blog takes nearly the lowest priority in my life (right below cleaning my bedroom and right above my unfinished Power Rangers fanfiction).

I deal with Erlang on a daily basis, and on that front I couldn't be much happier. Erlang is a wonderful language, and it gets my approval by most objective measures, but talk is cheap; it's easy to use a language when you're just fixing *someone else's* code, but how is it for making your own stuff.

Consequently, I decided an appropriately difficult but also useful project that could inevitably become a mechanism for me ignoring my wife would be porting over my ["Frameworkey"](https://github.com/tombert/frameworkeypromiseedition) framework over to Erlang.

To those of you that don't know, "Frameworkey" is sort of my catch-all name for an MVC-ish framework that I write to test out a new language or server platform, but there are a couple tenets that I've tried to keep in all the versions:

- Multiple endpoints of the same name should be separable by request method, e.g. `GET /myroute` should be different than `POST /myroute`
- Controller actions should be specified in a config file somehow.
- Controller actions should be composable and reuseable, in a similar fashion to Unix pipes, e.g. `Controller1.action1 Controller2.action2` would run `action1`, and feed whatever it returns into `action2`.
- Permissions and policies should be specified in a config file, and allow for multiple policies to be attached to each action.

You can actually build a surprisingly robust and clean framework with just these three tenets, and FrameworkeyPromiseEdition has actually been used in production for "real" projects, and I felt that these would be an interesting challenge for Erlang.  Here's a few thigns I learned:


## Erlang isn't JavaScript... But the maps give it a similar feel.

Erlang 17 gave the language support for the "map" datastructure, which look and feel somewhat like JavaScript objects.  For example, the following two chunks of code are basically equivalent:

{% highlight erlang %}
MyVar = #{
  data => "Hello"
}.
{% endhighlight %}

{% highlight javascript %}
var myvar = {
  data: "Hello"
};
{% endhighlight %}

As you can probably see, these aren't radically different outside of syntax, and that's sort of my point.  If you are used to Node.js, you can get a JavaScript-ish feel by making heavy use of the map.

## Immutabiity does wonders for scaling and for code readability, but it's a pain in the ass for development.

An odd thing I've noticed in programming is that very often the thing *feels* elegant to write turns out to be a nightmare to maintain, and the only evidence I need to prove this is to look at any C code, and you'll inevitably find several global variables in the mix.

Global variables are considered bad because they make debugging the code extremely difficult, but there *is* a reason that they are used: they're *easy*. Developers *know* they're bad, and still use them because the temptation to use them gets overwhelming.

Immutability fills a similar place in my brain; I logically know it's the superior way to do things in a ton of respects, and it makes the code a lot easier to debug (not to mention a reduction in bugs), but it forces you to bend your brain and invent heirarchies of "input-chaining" in order to work around it.

Now, this isn't strictly true; Erlang gives you ETS, and you can basically use that to create global, mutable variables, but this isn't generally used for control-flow and kind of breaks a couple Erlang idioms.  Consequently, I try and structure my code in such a way to keep things immutable when I can. 


## I found bugs in the JavaScript version of Frameworkey while doing the Erlang version.

This one surprised me the most; in the process of writing an Erlang project, it made me realize a few logic flaws in my initial version of the app.

This means that even the JavaScript version of Frameworkey benefitted from me doing a rewrite, which I think is kind of cool.  Granted, I don't think that anyone uses the JavaScript version of Frameworkey but me, but as far as I'm concerned, the less bugs we have in open-source software, the better the community is as a whole.

------

Overall, I'm a little glad that I sarted this project. Frameworkey-Erlang is is turning out rather well, and II'm in the process of implementing the policies module now.  [Feel free to contribute](https://github.com/Tombert/Frameworkey-Erlang), assuming that I ever get any people reading this blog, which seems unlikely.


