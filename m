Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C1B2936
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2019 02:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfINA7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 13 Sep 2019 20:59:43 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45926 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728789AbfINA7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 20:59:43 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1D4A442572B; Fri, 13 Sep 2019 20:59:41 -0400 (EDT)
Date:   Fri, 13 Sep 2019 20:59:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190914005931.GI22121@hungrycats.org>
References: <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913025832.Horde.Bwn_M-5buBYcgGbqhc_wDkU@server53.web-hosting.com>
 <20190913052520.Horde.TXpSDI4drVhkIzGxF7ZVMA8@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190913052520.Horde.TXpSDI4drVhkIzGxF7ZVMA8@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 05:25:20AM -0400, General Zed wrote:
> 
> Quoting General Zed <general-zed@zedlx.com>:
> 
> > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > 
> > > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
> > > > 
> > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> > > > 
> > > > > On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
> > > > > >
> > > > > > At worst, it just has to completely write-out "all
> > > > > metadata", all the way up
> > > > > > to the super. It needs to be done just once, because what's the point of
> > > > > > writing it 10 times over? Then, the super is updated as
> > > > > the final commit.
> > > > > 
> > > > > This is kind of a silly discussion.  The biggest extent possible on
> > > > > btrfs is 128MB, and the incremental gains of forcing 128MB extents to
> > > > > be consecutive are negligible.  If you're defragging a 10GB file, you're
> > > > > just going to end up doing 80 separate defrag operations.
> > > > 
> > > > Ok, then the max extent is 128 MB, that's fine. Someone here
> > > > previously said
> > > > that it is 2 GB, so he has disinformed me (in order to further his false
> > > > argument).
> > > 
> > > If the 128MB limit is removed, you then hit the block group size limit,
> > > which is some number of GB from 1 to 10 depending on number of disks
> > > available and raid profile selection (the striping raid profiles cap
> > > block group sizes at 10 disks, and single/raid1 profiles always use 1GB
> > > block groups regardless of disk count).  So 2GB is _also_ a valid extent
> > > size limit, just not the first limit that is relevant for defrag.
> > > 
> > > A lot of people get confused by 'filefrag -v' output, which coalesces
> > > physically adjacent but distinct extents.  So if you use that tool,
> > > it can _seem_ like there is a 2.5GB extent in a file, but it is really
> > > 20 distinct 128MB extents that start and end at adjacent addresses.
> > > You can see the true structure in 'btrfs ins dump-tree' output.
> > > 
> > > That also brings up another reason why 10GB defrags are absurd on btrfs:
> > > extent addresses are virtual.  There's no guarantee that a pair of extents
> > > that meet at a block group boundary are physically adjacent, and after
> > > operations like RAID array reorganization or free space defragmentation,
> > > they are typically quite far apart physically.
> > > 
> > > > I didn't ever said that I would force extents larger than 128 MB.
> > > > 
> > > > If you are defragging a 10 GB file, you'll likely have to do it
> > > > in 10 steps,
> > > > because the defrag is usually allowed to only use a limited amount of disk
> > > > space while in operation. That has nothing to do with the extent size.
> > > 
> > > Defrag is literally manipulating the extent size.  Fragments and extents
> > > are the same thing in btrfs.
> > > 
> > > Currently a 10GB defragment will work in 80 steps, but doesn't necessarily
> > > commit metadata updates after each step, so more than 128MB of temporary
> > > space may be used (especially if your disks are fast and empty,
> > > and you start just after the end of the previous commit interval).
> > > There are some opportunities to coalsce metadata updates, occupying up
> > > to a (arbitrary) limit of 512MB of RAM (or when memory pressure forces
> > > a flush, whichever comes first), but exploiting those opportunities
> > > requires more space for uncommitted data.
> > > 
> > > If the filesystem starts to get low on space during a defrag, it can
> > > inject commits to force metadata updates to happen more often, which
> > > reduces the amount of temporary space needed (we can't delete the original
> > > fragmented extents until their replacement extent is committed); however,
> > > if the filesystem is so low on space that you're worried about running
> > > out during a defrag, then you probably don't have big enough contiguous
> > > free areas to relocate data into anyway, i.e. the defrag is just going to
> > > push data from one fragmented location to a different fragmented location,
> > > or bail out with "sorry, can't defrag that."
> > 
> > Nope.
> > 
> > Each defrag "cycle" consists of two parts:
> >      1) move-out part
> >      2) move-in part
> > 
> > The move-out part select one contiguous area of the disk. Almost any
> > area will do, but some smart choices are better. It then moves-out all
> > data from that contiguous area into whatever holes there are left empty
> > on the disk. The biggest problem is actually updating the metadata,
> > since the updates are not localized.
> > Anyway, this part can even be skipped.
> > 
> > The move-in part now populates the completely free contiguous area with
> > defragmented data.
> > 
> > In the case that the move-out part needs to be skipped because the
> > defrag estimates that the update to metatada will be too big (like in
> > the pathological case of a disk with 156 GB of metadata), it can
> > sucessfully defrag by performing only the move-in part. In that case,
> > the move-in area is not free of data and "defragmented" data won't be
> > fully defragmented. Also, there should be at least 20% free disk space
> > in this case in order to avoid defrag turning pathological.
> > 
> > But, these are all some pathological cases. They should be considered in
> > some other discussion.
> 
> I know how to do this pathological case. Figured it out!
> 
> Yeah, always ask General Zed, he knows the best!!!
> 
> The move-in phase is not a problem, because this phase generally affects a
> low number of files.
> 
> So, let's consider the move-out phase. The main concern here is that the
> move-out area may contain so many different files and fragments that the
> move-out forces a practically undoable metadata update.
> 
> So, the way to do it is to select files for move-out, one by one (or even
> more granular, by fragments of files), while keeping track of the size of
> the necessary metadata update. When the metadata update exceeds a certain
> amount (let's say 128 MB, an amount that can easily fit into RAM), the
> move-out is performed with only currently selected files (file fragments).
> (The move-out often doesn't affect a whole file since only a part of each
> file lies within the move-out area).

This move-out phase sounds like a reinvention of btrfs balance.  Balance
already does something similar, and python-btrfs gives you a script to
target block groups with high free space fragmentation for balancing.
It moves extents (and their references) away from their block group.
You get GB-sized (or multi-GB-sized) contiguous free space areas into
which you can then allocate big extents.

> Now the defrag has to decide: whether to continue with another round of the
> move-out to get a cleaner move-in area (by repeating the same procedure
> above), or should it continue with a move-in into a partialy dirty area. I
> can't tell you what's better right now, as this can be determined only by
> experiments.
> 
> Lastly, the move-in phase is performed (can be done whether the move-in area
> is dirty or completely clean). Again, the same trick can be used: files can
> be selected one by one until the calculated metadata update exceeds 128 MB.
> However, it is more likely that the size of move-in area will be exhausted
> before this happens.
> 
> This algorithm will work even if you have only 3% free disk space left.

I was thinking more like "you have less than 1GB free on a 1TB filesystem
and you want to defrag 128MB things", i.e. <0.1% free space.  If you don't
have all the metadata block group free space you need allocated already
by that point, you can run out of metadata space and the filesystem goes
read-only.  Happens quite often to people.  They don't like it very much.

> This algorithm will also work if you have metadata of huge size, but in that
> case it is better to have much more free disk space (20%) to avoid
> significantly slowing down the defrag operation.
> 
> 
