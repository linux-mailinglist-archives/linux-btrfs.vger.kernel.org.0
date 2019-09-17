Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614EBB58B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfIQXkt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 17 Sep 2019 19:40:49 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39384 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfIQXkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:49 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3861A42EAE1; Tue, 17 Sep 2019 19:40:44 -0400 (EDT)
Date:   Tue, 17 Sep 2019 19:40:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190917234044.GH24379@hungrycats.org>
References: <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
 <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
 <20190917053055.GG24379@hungrycats.org>
 <20190917060724.Horde.2JvifSdoEgszEJI8_4CFSH8@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190917060724.Horde.2JvifSdoEgszEJI8_4CFSH8@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 17, 2019 at 06:07:24AM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > I doubt that on a 50TB filesystem you need to read the whole tree...are
> > you going to globally optimize 50TB at once?  That will take a while.
> 
> I need to read the whole free-space tree to find a few regions with most
> free space. Those will be used as destinations for defragmented data.

Hmmm...I have some filesystems with 2-4 million FST entries, but
they can be read in 30 seconds or less, even on the busy machines.

> If a mostly free region of sufficient size (a few GB) can be found faster,
> then there is no need to read the entire free-space tree. But, on a disk
> with less than 15% free space, it would be advisable to read the entire free
> space tree to find the less-crowded regions of the filesystem.

A filesystem with 15% free space still has 6 TB of contiguous.
Not hard to find some room!  You can just look in the chunk tree, all
the unallocated space there is multi-GB contiguous chunks.  Every btrfs
is guaranteed to have a chunk tree, but some don't have free space trees
(though the ones that don't should probably be strongly encouraged to
enable that feature).  So you probably don't even need to look for free
space if there is unallocated space.

On the other hand, you do need to measure fragmentation of the existing
free space, in order to identify the highest-priority areas for defrag.
So maybe you read the whole FST anyway, sort, and spit out a short list.
It's not nearly as expensive as I thought.

I did notice one thing while looking at filesystem metadata vs commit
latency the other day:  btrfs's allocation performance seems to be
correlated to the amount of free space _in the block groups_, not _on the
filesystem_.  So after deleting 2% of the files on a 50% full filesystem,
it runs as slowly a 98% full one.  Then when you add 3% more data to fill
the free space and allocate some new block groups, it goes fast again.
Then you delete things and it gets slow again.  Rinse and repeat.

> > My dedupe runs continuously (well, polling with incremental scan).
> > It doesn't shut down.
> 
> Ah... so I suggest that the defrag should temporarily shut down dedupe, at
> least in the initial versions of defrag. Once both defrag and dedupe are
> working standalone, the merging effort can begin.

Pausing dedupe just postpones the inevitable.  The first thing dedupe
will do when it resumes is a new-data scan that will find all the new
defrag extents, because dedupe has to discover what's in them and update
the now out-of-date physical location data in the hash table.  When defrag
and dedupe are integrated, the hash table gets updated by defrag in
place--same table entries in a different location.

I have that problem _right now_ when using balance to defragment free
space in block groups.  Dedupe performance drops while the old relocated
data is rescanned--since it's old, we already found all the duplicates,
so the iops of the rescan are just repairing the damage to the hash
table that balance did.

That said...I also have a plan to make dedupe's new-data scans about
two orders of magnitude faster under common conditions.  So maybe in the
future dedupe won't care as much about rereading stuff, as rereading will
add at most 1% redundant read iops.  That still requires running dedupe
first (or in the kernel so it's in the write path), or have some way for
defrag to avoid touching recently added data before dedupe gets to it,
due to the extent-splitting duplicate work problem.

> I think that this kind of close dedupe-defrag integration should mostly be
> left to dedupe developers. 

That's reasonable--dedupe creates a specific form of fragmentation
problems.  Not fixing those is bad for dedupe performance (and performance
in general) so it's a logical extension of the dedupe function to take
care of them as we go.  I was working on it already.

> First, both defrag and dedupe should work
> perfectly on their own. 

You use the word "perfectly" in a strange way...

There are lots of btrfs dedupers that are optimized for different cases:
some are very fast for ad-hoc full-file dedupe, others are traditional
block-oriented filesystem-tree scanners that run on multiple filesystems.
There's an in-kernel one under development that...runs in the kernel
(honestly, running in the kernel is not as much of an advantage as you
might think).  I wrote a deduper that was designed to merely not die when
presented with a large filesystem and a 50%+ dupe hit rate (it ended
up being faster and more efficient than the others purely by accident,
but maybe that says more about the state of the btrfs dedupe art than
about the quality of my implementation).  I wouldn't call any of these
"perfect"--there are always some subset of users for which any of them
are unusable or there is a more suitable tool that performs better for
some special case.

There is similar specialization and variation among defrag algorithms
as well.  At best, any of them is "a good result given some choice
of constraints."

> Then, an interface to defrag should be made
> available to dedupe developers. In particular, I think that the batch-update
> functionality (it takes lots of extents and an empty free space region, then
> writes defragmented extents to the given region) is of particular interest
> to dedupe.

Yeah, I have a wishlist item for a kernel call that takes a list of
(virtual address, length) pairs and produces a single contiguous physical
extent containing the content of those pairs, updating all the reflinks
in the process.  Same for dedupe, but that one replaces all the extents
with reflinks to the first entry in the list instead of making a copy.

I guess the extent-merge call could be augmented with an address hint
for allocation, but experiments so far have indicated that the possible
gains are marginal at best given the current btrfs allocator behavior,
so I haven't bothered pursuing that.
