Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6474AB44F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 02:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfIQAtS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Sep 2019 20:49:18 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45996 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732054AbfIQAtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 20:49:18 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D789F42C2B1; Mon, 16 Sep 2019 20:49:16 -0400 (EDT)
Date:   Mon, 16 Sep 2019 20:49:16 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190917004916.GD24379@hungrycats.org>
References: <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 07:42:51AM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > Your defrag ideas are interesting, but you should spend a lot more
> > time learning the btrfs fundamentals before continuing.  Right now
> > you do not understand what btrfs is capable of doing easily, and what
> > requires such significant rework in btrfs to implement that the result
> > cannot be considered the same filesystem.  This is impairing the quality
> > of your design proposals and reducing the value of your contribution
> > significantly.
> 
> Ok, that was a shot at me; and I admit, guilty as charged. I barely have a
> clue about btrfs.
> Now it's my turn to shoot. Apparently, the people which are implementing the
> btrfs defrag, or at least the ones that responded to my post, seem to have
> no clue about how on-demand defrag solutions typically work. I had to
> explain the usual tricks involved in the defragmentation, and it was like
> talking to complete rookies. None of you even considered a full-featured
> defrag solution, all that you are doing are some partial solutions.

Take a look at btrfs RAID5/6 some time, if you want to see rookie mistakes...

> And, you all got lost in implementation details. How many times have I been
> told here that some operation cannot be performed, and then it turned out
> the opposite. You have all sunk into some strange state of mind where every
> possible excuse is being made in order not to start working on a better,
> hollistic defrag solution.
> 
> And you even misunderstood me when I said "hollistic defrag", you thought I
> was talking about a full defrag. No. A full defrag is a defrag performed on
> all the data. A holistic defrag can be performed on only some data, but it
> is hollistic in the sense that it uses whole information about a filesystem,
> not just a partial view of it. A holistic defrag is better than a partial
> defrag: it is faster and produces better results, and it can defrag a wider
> spectrum of cases. Why? Because a holistic defrag takes everything into
> account.

What I'm looking for is a quantitative approach.  Sort the filesystem
regions by how bad they are (in terms of measurable negative outcomes
like poor read performance, pathological metadata updates, and future
allocation performance), then apply mitigation in increasing order of
cost-benefit ratio (or at least filter by cost-benefit ratio if you can't
sort without reading the whole filesystem) until a minimum threshold
is reached, then stop.  This lets the mitigation scale according to
the available maintenance window, i.e. if you have 5% of a day for
maintenance, you attack the worst 5% of the filesystem, then stop.

In that respect I think we might be coming toward the same point, but
from different directions:  you seem to think the problem is easy to
solve at scale, and I think that's impossible so I start from designs
that make forward progress with a fixed allocation of resources.

> So I think you should all inform yourself a little better about various
> defrag algorithms and solutions that exist. Apparently, you all lost the
> sight of the big picture. You can't see the wood from the trees.

I can see the woods, but any solution that starts with "enumerate all
the trees" will be met with extreme skepticism, unless it can do that
enumeration incrementally.

> Well, no. Perhaps the word "defrag" can have a wider and narrower sense. So
> in a narrower sense, "defrag" means what you just wrote. In that sense, the
> word "defrag" means practically the same as "merge", so why not just use the
> word "merge" to remove any ambiguities. The "merge" is the only operation
> that decreases the number of fragments (besides "delete"). Perhaps you meant
> move&merge. But, commonly, the word "defrag" is used in a wider sense, which
> is not the one you described.

This is fairly common on btrfs:  the btrfs words don't mean the same as
other words, causing confusion.  How many copies are there in a btrfs
4-disk raid1 array?

> > > > Dedupe on btrfs also requires the ability to split and merge extents;
> > > > otherwise, we can't dedupe an extent that contains a combination of
> > > > unique and duplicate data.  If we try to just move references around
> > > > without splitting extents into all-duplicate and all-unique extents,
> > > > the duplicate blocks become unreachable, but are not deallocated.  If we
> > > > only split extents, fragmentation overhead gets bad.  Before creating
> > > > thousands of references to an extent, it is worthwhile to merge it with
> > > > as many of its neighbors as possible, ideally by picking the biggest
> > > > existing garbage-free extents available so we don't have to do defrag.
> > > > As we examine each extent in the filesystem, it may be best to send
> > > > to defrag, dedupe, or garbage collection--sometimes more than one of
> > > > those.
> > > 
> > > This is sovled simply by always running defrag before dedupe.
> > 
> > Defrag and dedupe in separate passes is nonsense on btrfs.
> 
> Defrag can be run without dedupe.

Yes, but if you're planning to run both on the same filesystem, they
had better be aware of each other.

> Now, how to organize dedupe? I didn't think about it yet. I'll leave it to
> you, but it seems to me that defrag should be involved there. And, my defrag
> solution would help there very, very much.

I can't see defrag in isolation as anything but counterproductive to
dedupe (and vice versa).

A critical feature of the dedupe is to do extent splits along duplicate
content boundaries, so that you're not limited to deduping only
whole-extent matches.  This is especially necessary on btrfs because
you can't split an extent in place--if you find a partial match,
you have to find a new home for the unique data, which means you
get a lot of little fragments that are inevitably distant from their
logically adjacent neighbors which themselves were recently replaced
with a physically distant identical extent.

Sometimes both copies of the data suck (both have many fragments
or uncollected garbage), and at that point you want to do some
preprocessing--copy the data to make the extent you want, then use
dedupe to replace both bad extents with your new good one.  That's an
opportunistic extent merge and it needs some defrag logic to do proper
cost estimation.

If you have to copy 64MB of unique data to dedupe a 512K match, the extent
split cost is far higher than if you have a 2MB extent with 512K match.
So there should be sysadmin-tunable parameters that specify how much
to spend on diminishing returns:  maybe you don't deduplicate anything
that saves less than 1% of the required copy bytes, because you have
lots of duplicates in the filesystem and you are willing to spend 1% of
your disk space to not be running dedupe all day.  Similarly you don't
defragment (or move for any reason) extents unless that move gives you
significantly better read performance or consolidate diffuse allocations
across metadata pages, because there are millions of extents to choose
from and it's not necessary to optimize them all.

On the other hand, if you find you _must_ move the 64MB of data for
other reasons (e.g. to consolidate free space) then you do want to do
the dedupe because it will make the extent move slightly faster (63.5MB
of data + reflink instead of 64MB copy).  So you definitely want one
program looking at both things.

Maybe there's a way to plug opportunistic dedupe into a defrag algorithm
the same way there's a way to plug opportunistic defrag into a dedupe
algorithm.  I don't know, I'm coming at this from the dedupe side.
If the solution looks anything like "run both separately" then I'm
not interested.

> > Extent splitting in-place is not possible on btrfs, so extent boundary
> > changes necessarily involve data copies.  Reference counting is done
> > by extent in btrfs, so it is only possible to free complete extents.
> 
> Great, there is reference counting in btrfs. That helps. Good design.

Well, I say "reference counting" because I'm simplifying for an audience
that does not yet all know the low-level details.  The counter, such as
it is, gives values "zero" or "more than zero."  You never know exactly
how many references there are without doing the work to enumerate them.
The "is extent unique" function in btrfs runs the enumeration loop until
the second reference is found or the supply of references is exhausted,
whichever comes first.  It's a tradeoff to make snapshots fast.

When a reference is created to a new extent, it refers to the entire
extent.  References can refer to parts of extents (the reference has an
offset and length field), so when an extent is partially overwritten, the
extent is not modified.  Only the reference is modified, to make it refer
to a subset of the extent (references in other snapshots are not changed,
and the extent data itself is immutable).  This makes POSIX fast, but it
creates some headaches related to garbage collection, dedupe, defrag, etc.

> > You have to replace the whole extent with references to data from
> > somewhere else, creating data copies as required to do so where no
> > duplicate copy of the data is available for reflink.
> > 
> > Note the phrase "on btrfs" appears often here...other filesystems manage
> > to solve these problems without special effort.  Again, if you're looking
> > for important btrfs things to work on, maybe start with in-place extent
> > splitting.
> 
> I think that I'll start with "software design document for on-demand defrag
> which preserves sharing structure". I have figure out that you don't have it
> yet. And, how can you even start working on a defrag without a software
> design document?
> 
> So I volunteer to write it. Apparently, I'm already half way done.
> 
> > On XFS you can split extents in place and reference counting is by
> > block, so you can do alternating defrag and dedupe passes.  It's still
> > suboptimal (you still waste iops to defrag data blocks that are
> > immediately eliminated by the following dedupe), but it's orders of
> > magnitude better than btrfs.
> 
> I'll reply to the rest of this marathonic post in another reply (when I find
> the time to read it). Because I'm writing the software design document.
> 
> 
> 
