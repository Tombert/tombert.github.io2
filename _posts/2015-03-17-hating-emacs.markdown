---
layout: post
comments: true
title:  "Annoyances with Emacs."
date:   2015-03-17 21:04:20
---

Emacs has been "that editor I've always used" for me, and for the most part, it has been fine. It's fast, it's relatively easy to pick up, and it has a really robust, decent plugin architecture that allows for adding just about any feature you could possibly imagine.  There's no doubt that it has contributed immensly to what success I've had in my life, and I certainly wouldn't be as good of a programmer without it. 

### So why is it starting to drive me crazy?

Seriously, just staring at the editor nowadays has started to drive me nuts, and I don't really know why.  Maybe I'm just too used to it and need more of a challenge.  Maybe I just feel I've exhausted what I need to learn about the editor.  Maybe (probably) I'm just an asshole. 

### What problems do you think you have?

I guess the biggest problem I have with Emacs really isn't even Emacs' fault: the fact that it's not preinstalled on anything. Whenever I need to edit a server config, it's always `nano` or `vim`, because Emacs is never installed. 

And in fairness, the GNU team doesn't really have control on where Emacs is installed, so it's not directly their fault, but then it asks a deeper question: *Why* is Emacs not installed on anything?

#### Emacs is too damn big.

I don't know where this trend of "editors are allowed to be huge and take up all your memory" started. Maybe it started with Emacs, but I suspect that Microsoft Visual Studio had something to do with it more than anything.  

Emacs, while not huge, will take up a couple hundred megs of memory, but it's also a relatively large download.  If you want the GUI version, you have to have the entire GTK toolkit installed, which makes the download a few hundred megs, tough to justify on a server.   Granted, you can run the command-line interface, but the editor is still roughly a hundred megs installed, not to mention it'll easily eat fifty megs of the server's RAM.

### Long Story Short 

I've decided I'm going to try switching to Vim full time.  I don't know if it's a good idea or not, but this article was written using it, so it seems to be ok.

And hey, maybe I'll write the next one on a server, because apparently that's a big deal to me. 
