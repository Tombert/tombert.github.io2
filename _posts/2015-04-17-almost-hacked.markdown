---
layout: post
comments: true
title:  "How to Automate SSH Authorization"
date:   2015-04-17 21:14:32
---

My brain has been enduring an active fight against the use of Skype as a general communication platform since its purchase by Microsoft.  My reasoning was simple: I was afraid that Microsoft would start to gimp the other platforms' clients, and that fear has largely come to pass, at least in the Linux world, and the wake of the takeover has led to a crash-prone and buggy platform that only exists for legacy reasons. 

Due to this frustration, in addition to the 2013 leaks by Edward Snowden, has led me to start up an XMPP server.  Registration will be open soon, send me an email if you want access now.  

Anyway, for reasons I won't fully understand, there was an attempted brute-force attack on my server from China, because everyone knows that a cheap five-dollar-a-month VPS is absolutely worth compromising, especially one as universally revered as "brucewillis.sexy". 

The solution to this problem was pretty obvious.  First, change to a harder password, then enable SSH public-key authentication, which is relatively easy to set up, but once you do, you risk being locked out of your server if you forget to back up your keys. 

And that little factoid gave me an idea: is there a good way to automate your keys being updated so that SSH authentication isn't so much of a pain? 

--------

The first step is to make sure that you have `curl` installed on your server (or whatever you want to allow `ssh` access to).  If you're on a Linux or Mac server, `curl` is usually pre-installed.  If it's not, generally a `sudo apt-get install curl` or `sudo pacman -S curl`.  This will vary between distributions, so look into the appropriate path for your distro. 

After that, make sure that you have `cron` installed on the server.  This may seem obvious, but Arch Linux doesn't appear to have that pre-installed.  `sudo pacman -S cronie` fixed this for me, but again, look into your distro.  

Alright, enough with this introductory bullshit, let's get to the actual fucking scripting. 

Github has a little-known feature which allows us instant access to all our public SSH keys. 

{% highlight bash %}
curl "https://github.com/<username>.keys"
{% endhighlight %}

This may seem horrifying, but keep in mind, all anyone can do with an SSH *public* key is grant access to stuff, so this actually isn't a security risk. Hell, [look at mine](https://github.com/tombert.keys).

With this tool in hand, the hard part has been done.  Now we can use some good ol' Unix-glue to get everything going. 


{% highlight bash %}
#!/bin/bash

curl "https://github.com/<username>.keys" > tempKeyFile
mv tempKeyFile ~/.ssh/authorized_keys

{% endhighlight %}

Also, don't forget to make it executable. 

{% highlight bash %}
chmod +x whateverINamedTheScript.sh
{% endhighlight %}

This is pretty straightforward.  We grab a list of all the authorized public keys for that account, then redirect that to a text file.  After that, we move that text file to overwrite the standard list of authorized keys.

After that, we need to set up a cron tab to have this update regularly.  I decided to have mine update at 2:30 in the morning, but feel free to have this run whenever you want. 

{% highlight bash %}
30 2 * * * whateverYouNamedTheScript.sh
{% endhighlight %}

Cron is a pretty well-documented standard, obviously feel free to adjust the frequency in which this update happens.  

----------

And that's it!  With this, you can have Github manage your SSH keys, whilst simultaneously keeping your servers substantially more secure than standard password protection. 

If you guys know of a better way to do this, I emplore you to leave a comment, or even better, a pull request to this article.  I am under no delusions that this is the "best" way, but I feel that this is a good place to start.
