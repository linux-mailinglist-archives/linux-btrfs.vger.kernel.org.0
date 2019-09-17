Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425E9B4551
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbfIQBor (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 21:44:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54477 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfIQBoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 21:44:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so1254413wmp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 18:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du516svBTm1z04yIBym5ytnXrUA5DoBOG81mRETrTzM=;
        b=ZwRmvQscCIcK1x9dbnl9J2GcFRgvwTc9DJMg58ixyxfjtu2r7C1fPev5XJV0Ls/K0D
         hgvShJAE3I6NRyjUouBGHQBOBdgI0a6GUETuauZWbYQashz5PARAf7TI8tvQLSarswHi
         AS5iQolBoLTa/mgKcjOrDMcKN9JQYWISW1wt8LbQTcC4wB8UyFOifM5s2Kr6iwJVtFvS
         WCVtU21CsRYZcj4ZgyjwO1QsPtxsQpEpbHumAxexSoQFL21WJmFMLzMhY+6Veqo94G8x
         9WZxNcIwm3ujFJwEw4TV1eJddO5I1K1jvD2kDRu0j5eIEkSE2GP1mTWKBOwlL1KfdbU7
         ORwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du516svBTm1z04yIBym5ytnXrUA5DoBOG81mRETrTzM=;
        b=GaZsqRF+sJT368f8Z0VcbCyuCly4sL1LhLRtg4rMLeb6NMhMs3FBP98VU0QMo4ToJv
         5r+M4t0eRPwFDyxRRWIjb7jwljxSG/EsCEW7CdKaAQIkEyse+iRuOj/zIYEBIXgYkIC4
         zafPmG0qUV55LAXz2wjNo6inIYPYV4im5u4LMSKf2sc3QFfzXlazymRHziZEJAAf5g5j
         AZmVu/VYOGotSP0yZL+4MTpbfaIrqmTxKXVZqIugA1z5c+0B52wmtkhiLwai3ZA0rQLs
         gA/vufeDFN5p9/CS3Xbbs4NZSwjKCFz0yxOapTFZGKR3v8bbJHEY6pahHNPJh4IAV/68
         3PpQ==
X-Gm-Message-State: APjAAAUqRieXRENSDXIapb3QrkerCQt/Q+yl9FaZJri8KswFjBRA4vIc
        RM+45PtiKiV7KCEVAxrZzzHbARDwsdY0rdei6zBary+am8Z0Zw==
X-Google-Smtp-Source: APXvYqw/fE7+xnAXnV1ai5xlpdDNqKBNrkkV6AIfwP/CmMvlDbxuiscqC4S9GAs4oCU6apZdzTXrnIHKaxzD7N3hJsU=
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr1248225wmc.106.1568684683948;
 Mon, 16 Sep 2019 18:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org> <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org> <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org> <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org> <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
 <20190916225126.GB24379@hungrycats.org> <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
In-Reply-To: <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 16 Sep 2019 19:44:31 -0600
Message-ID: <CAJCQCtRW8ObeQ5nL_Q9t-7rXDtOk5TQLcZnhH6bGRMA-puUVNw@mail.gmail.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     General Zed <general-zed@zedlx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 7:03 PM General Zed <general-zed@zedlx.com> wrote:
>
> Ok, so a reflink contains a virtual address. Did I get that right?
>
> All extent ref items are reflinks which contain a 4 KB aligned address
> because the extents have that same alignment. Did I get that right?
>
> Virtual addresses are 8-bytes in size?
>
> I hope that virtual addresses are not wasteful of address space (that
> is, many top bits in an 8 bit virtual address are all zero).

All addresses in Btrfs are in linear address space. This is actually a
lot easier for everyone if you've familiarized yourself with some
things:

https://btrfs.wiki.kernel.org/index.php/On-disk_Format

You probably don't need to know the literal on disk format at a sector
level. There is a human readable form available with 'btrfs
inspect-internal dump-tree'. Create a Btrfs file system, and dump the
tree so you can see what it looks like totally empty. Mount it. Copy
over a file. Unmount it. Dump tree. You don't actually have to unmount
it, but it will keep Btrfs from regular commit intervals making things
move around. Make a directory. Dump tree. Add file to directory. Dump
tree. Move the file. Dump tree.

You'll see the relationship between the superblock, and all the trees.
You'll see nodes and leaves, and figure out the difference between
them.

Make a reflink. Dump tree. Make a snapshot. Dump tree.


> > Extent data items are stored in a single tree (with other trees using
> > the same keys) that just lists which parts of the filesystem are occupied,
> > how long they are, and what data/metadata they contain.  Each extent
> > item contains a list of references to one of four kinds of object that
> > refers to the extent item (aka backrefs).  The free space tree is the
> > inverse of the extent data tree.
>
> Ok, so there is an "extent tree" keyed by virtual addresses. Items
> there contain extent data.
>
> But, how are nodes in this extent tree addressed (how do you travel
> from the parent to the child)? I guess by full virtual address, i.e.
> by a reflink, but this reflink can point within-extent, meaning its
> address is not 4 KB aligned.
>
> Or, an alternative explanation:
> each whole metadata extent is a single node. Each node is often
> half-full to allow for various tree operations to be performed. Due to
> there being many items per each node, there is additional CPU
> processing effort required when updating a node.

Reflinks are like a file based snapshot, they're a file with its own
inode and other metadata you expect for a file, but points to the same
extents as another file. Off hand I'm not sure other than age if
there's any difference between the structure of the original file and
a reflink of that file. Find out. Make a reflink, dump tree. Delete
the original file. Dump tree.




>
> > Each extent ref item is a reference to an extent data item, but it
> > also contains all the information required to access the data.  For
> > normal read operations the extent data tree can be ignored (though
> > you still need to do a lookup in the csum tree to verify csums.
>
> So, for normal reads, the information in subvol tree is sufficient.

A subvolume is a file tree. A snapshot is a prepopulated subvolume.
It's interesting to snapshot a subvolume. Dump tree. Modify just one
thing in the snapshot. Dump tree.



>
> >> So, you are saying that backrefs are already in the extent tree (or
> >> reachable from it). I didn't know that, that information makes my defrag
> >> much simpler to implement and describe. Someone in this thread has
> >> previously mislead me to believe that backref information is not easily
> >> available.
> >
> > The backref isn't a precise location--it just tells you which metadata
> > blocks are holding at least one reference to the extent.  Some CPU
> > and linear searching has to be done to resolve that fully to an (inode,
> > offset) pair in the subvol tree(s).  It's a tradeoff to make normal POSIX
> > go faster, because you don't need to update the extent tree again when
> > you do some operations on the forward ref side, even though they add or
> > remove references.  e.g. creating a snapshot does not change the backrefs
> > list on individual extents--it creates two roots sharing a subset of the
> > subvol trees' branches.
>
> This reads like a mayor fu**** to me.
>
> I don't get it. If a backref doesn't point to an exact item, than CPU
> has to scan the entire 16 KB metadata extent to find the matching
> reflink. However, this would imply that all the items in a metadata
> extent are always valid (not stale from older versions of metadata).
> This then implies that, when an item of a metadata extent is updated,
> all the parents of all the items in the same extent have to be
> updated. Now, that would be such a waste, wouldn't it? Especially if
> the metadata extent is allowed to contain stale items.
>
> An alternative explanation: all the b-trees have 16 KB nodes, where
> each node matches a metadata extent. Therefore, the entire node has a
> single parent in a particular tree.
>
> This means all virtual addresses are always 4 K aligned, furthermore,
> all virtual addresses that point to metadata extents are 16 K aligned.
>
> 16 KB is a pretty big for a tree node. I wonder why was this size
> selected vs. 4 KB nodes? But, it doesn't matter.

4KiB used to be the default. It was benchmarked and found to be
faster. They can optionally be 32K or 64k on x86.

Btrfs filesystem sector size must match arch pagesize. And nodesize
can't be smaller than filesystem sector size. And leaf size must be
the same as nodesize.

> So, I guess that the virtual-to-physical address translation tables
> are always loaded in memory and that this translation is very fast?
> And the translation in the opposite direction, too.

That's the job of the chunk tree and device tree. And that's how
multiple device support magic happens where files and extent
information don't have to deal with where the data is, that's the job
of other trees.

Add device. Dump tree. Do a balance convert to change to raid1 for
data and metadata. Dump tree.

It's sometimes also useful to dump the super which is in a sense the
top most part of the tree.

-- 
Chris Murphy
