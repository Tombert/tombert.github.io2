---
layout: page
title: My Setup 
permalink: /my_setup/
private: false
---

I've been following [The Setup](https://usesthis.com/) for about a year now, and I really enjoy seeing people's explanation about why they chose "software X" or "computer Y", so I figured I'd share mine too. 


### Who are you, and what do you do?
My name is Thomas Gebert.  I do a lot of things, but most of them involve breathing and programming on the computer.  Currently I'm a software engineer for [WebMD](https://webmd.com), but I've had a bunch of jobs and gigs. 

### What hardware do you use?
I have a whole litany of computers I use for different things, but I'll try to give a basic summary.  

I use an old Dell PowerEdge 2900 with 8GB or RAM and two Dual-Xeon CPUs as a NAS, in addition to a remote dev box and video streaming server.  It has also been known to host a Minecraft server or two. It's old, crusty, and arguably useless now, but I love it, since it enables me to have something "centralized" running on my own hardware, with eight hard drives to make sure that I don't lose something. 

My daily driver computer right now is an Asus R700V, with an i7 CPU and 16GB of memory.  It's a decent laptop that I don't have a lot of problems with it (except for the annoying NVidia Optimus card inside there).  It's where I do most of my programming at home, since it's beefy enough to handle most of my experiments with video and GPU programming, but is still a laptop, so I can work on my couch, which has sort of become my impromptu office.   

When I'm out and about I use an ASUS Zenbook UX305FA, since it's light and has a decent-enough screen, albeit *objectively terrible* speakers. 

For my phone, I use a Nexus 6, and for streaming movies I usually use a mostly-retired Macbook Air and a projector. 

### And what software? 

Dear God, where the hell do I begin.  

On my server, I run FreeNAS, and make extremely liberal use of the jail system they have, which enables me to have a bunch of "pretend" servers to mess about with.  I run a chat server using ejabberd, a video server using Emby, and too-many-to-count dev jails "just cuz", which means a large chunk of my development tends to happen in FreeBSD-land. 

In part because I so often work on a remote server, I make use of console based tools as often as I can.  My "IDE" is consequently built out of using a bunch of tmux windows and me constantly swapping back and forth between Vim and Emacs, depending on my mood.  

I really like the freedom tmux brings, in that nearly everything I do can be powered via keystrokes, and the fact that I don't need to set up some elaborate X-Forwarding nonsense when I work off of my server (let's see you do *that* with your fancy IntelliJ or Visual Studio!).  Being able to SSH in, attach to my previous session, and have all my tools configured is pretty rad.    

I use [Afraid.org](http://afraid.org) to forward [brucewillis.sexy](http://brucewillis.sexy) to my home IP address, so I can memorize something simple and always have a way to log into my home.  

For keeping stuff synchronized, I use Git, as evidenced by the fact that this is hosted by Github.  I don't know how to use any of the GUI tools for Git, so I always end up on the command line.  I run a Gitlab instance on my server, which I use for private repos, and I use Github for stuff that I want to be public.

I also use GNU Stow to keep my settings synchronized between computers, as well as so I can easily keep them backed up on Github. 

For chat, I use Profanity for XMPP, and WeeChat for IRC.  I'm currently forced to use Skype to talk to my parents.  

For my operating systems at home, it almost doesn't matter because of the stuff I rambled about above, but I run Arch Linux on my big Asus, and Ubuntu Gnome on my small laptops, though in both cases I live in the terminal for everything but web browsing, and even for that I sometimes use Elinks.  


### What would be your dream setup?
I'm not sure I'd change a lot...I'd like to have a slightly beefier server (though not at a cost of increased power consumption) with sixteen hard drive bays intead of eight, and 8 cores instead of 4, and 32GB of RAM. 

I'd also like my current big laptop, but with an actually-ok-and-not-terrible screen resolution, and a regular NVidia card instead of this Optimus nonsense.  Oh, and something that can run FreeBSD without a cavalcade of driver issues would be cool, specifically so I can use ZFS on my laptop.   

Otherwise, I like what I have now.  
