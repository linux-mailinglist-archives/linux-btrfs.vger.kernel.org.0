Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89ADB1769
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 05:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfIMDMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 23:12:44 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47392 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfIMDMo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 23:12:44 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 28237423558; Thu, 12 Sep 2019 23:12:43 -0400 (EDT)
Date:   Thu, 12 Sep 2019 23:12:43 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190913031242.GF22121@hungrycats.org>
References: <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
> 
> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> 
> > On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
> > > 
> > > Quoting Chris Murphy <lists@colorremedies.com>:
> > > 
> > > > On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
> > > > >
> > > > >
> > > > > Quoting Chris Murphy <lists@colorremedies.com>:
> > > > >
> > > > > > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
> > > > > >>
> > > > > >> It is normal and common for defrag operation to use some disk space
> > > > > >> while it is running. I estimate that a reasonable limit would be to
> > > > > >> use up to 1% of total partition size. So, if a partition size is 100
> > > > > >> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
> > > > > >
> > > > > > The simplest case of a file with no shared extents, the minimum free
> > > > > > space should be set to the potential maximum rewrite of the file, i.e.
> > > > > > 100% of the file size. Since Btrfs is COW, the entire operation must
> > > > > > succeed or fail, no possibility of an ambiguous in between state, and
> > > > > > this does apply to defragment.
> > > > > >
> > > > > > So if you're defragging a 10GiB file, you need 10GiB minimum free
> > > > > > space to COW those extents to a new, mostly contiguous, set of exents,
> > > > >
> > > > > False.
> > > > >
> > > > > You can defragment just 1 GB of that file, and then just write out to
> > > > > disk (in new extents) an entire new version of b-trees.
> > > > > Of course, you don't really need to do all that, as usually only a
> > > > > small part of the b-trees need to be updated.
> > > >
> > > > The `-l` option allows the user to choose a maximum amount to
> > > > defragment. Setting up a default defragment behavior that has a
> > > > variable outcome is not idempotent and probably not a good idea.
> > > 
> > > We are talking about a future, imagined defrag. It has no -l option yet, as
> > > we haven't discussed it yet.
> > > 
> > > > As for kernel behavior, it presumably could defragment in portions,
> > > > but it would have to completely update all affected metadata after
> > > > each e.g. 1GiB section, translating into 10 separate rewrites of file
> > > > metadata, all affected nodes, all the way up the tree to the super.
> > > > There is no such thing as metadata overwrites in Btrfs. You're
> > > > familiar with the wandering trees problem?
> > > 
> > > No, but it doesn't matter.
> > > 
> > > At worst, it just has to completely write-out "all metadata", all the way up
> > > to the super. It needs to be done just once, because what's the point of
> > > writing it 10 times over? Then, the super is updated as the final commit.
> > 
> > This is kind of a silly discussion.  The biggest extent possible on
> > btrfs is 128MB, and the incremental gains of forcing 128MB extents to
> > be consecutive are negligible.  If you're defragging a 10GB file, you're
> > just going to end up doing 80 separate defrag operations.
> 
> Ok, then the max extent is 128 MB, that's fine. Someone here previously said
> that it is 2 GB, so he has disinformed me (in order to further his false
> argument).

If the 128MB limit is removed, you then hit the block group size limit,
which is some number of GB from 1 to 10 depending on number of disks
available and raid profile selection (the striping raid profiles cap
block group sizes at 10 disks, and single/raid1 profiles always use 1GB
block groups regardless of disk count).  So 2GB is _also_ a valid extent
size limit, just not the first limit that is relevant for defrag.

A lot of people get confused by 'filefrag -v' output, which coalesces
physically adjacent but distinct extents.  So if you use that tool,
it can _seem_ like there is a 2.5GB extent in a file, but it is really
20 distinct 128MB extents that start and end at adjacent addresses.
You can see the true structure in 'btrfs ins dump-tree' output.

That also brings up another reason why 10GB defrags are absurd on btrfs:
extent addresses are virtual.  There's no guarantee that a pair of extents
that meet at a block group boundary are physically adjacent, and after
operations like RAID array reorganization or free space defragmentation,
they are typically quite far apart physically.

> I didn't ever said that I would force extents larger than 128 MB.
> 
> If you are defragging a 10 GB file, you'll likely have to do it in 10 steps,
> because the defrag is usually allowed to only use a limited amount of disk
> space while in operation. That has nothing to do with the extent size.

Defrag is literally manipulating the extent size.  Fragments and extents
are the same thing in btrfs.

Currently a 10GB defragment will work in 80 steps, but doesn't necessarily
commit metadata updates after each step, so more than 128MB of temporary
space may be used (especially if your disks are fast and empty,
and you start just after the end of the previous commit interval).
There are some opportunities to coalsce metadata updates, occupying up
to a (arbitrary) limit of 512MB of RAM (or when memory pressure forces
a flush, whichever comes first), but exploiting those opportunities
requires more space for uncommitted data.

If the filesystem starts to get low on space during a defrag, it can
inject commits to force metadata updates to happen more often, which
reduces the amount of temporary space needed (we can't delete the original
fragmented extents until their replacement extent is committed); however,
if the filesystem is so low on space that you're worried about running
out during a defrag, then you probably don't have big enough contiguous
free areas to relocate data into anyway, i.e. the defrag is just going to
push data from one fragmented location to a different fragmented location,
or bail out with "sorry, can't defrag that."

> > 128MB is big enough you're going to be seeking in the middle of reading
> > an extent anyway.  Once you have the file arranged in 128MB contiguous
> > fragments (or even a tenth of that on medium-fast spinning drives),
> > the job is done.
> 
> Ok. When did I say anything different?

There are multiple parties in this thread.  I'm not addressing just you.

> > > On my comouter the ENTIRE METADATA is 1 GB. That would be very tolerable and
> > > doable.
> > 
> > You must have a small filesystem...mine range from 16 to 156GB, a bit too
> > big to fit in RAM comfortably.
> 
> You mean: all metadata size is 156 GB on one of your systems. However, you
> don't typically have to put ALL metadata in RAM.
> You need just some parts needed for defrag operation. So, for defrag, what
> you really need is just some large metadata cache present in RAM. I would
> say that if such a metadata cache is using 128 MB (for 2 TB disk) to 2 GB
> (for 156 GB disk), than the defrag will run sufficiently fast.

You're missing something (metadata requirement for delete?) in those
estimates.

Total metadata size does not affect how much metadata cache you need
to defragment one extent quickly.  That number is a product of factors
including input and output and extent size ratio, the ratio of various
metadata item sizes to the metadata page size, and the number of trees you
have to update (number of reflinks + 3 for extent, csum, and free space
trees).

It follows from the above that if you're joining just 2 unshared extents
together, the total metadata required is well under a MB.

If you're defragging a 128MB journal file with 32768 4K extents, it can
create several GB of new metadata and spill out of RAM cache (which is
currently capped at 512MB for assorted reasons).  Add reflinks and you
might need more cache, or take a performance hit.  Yes, a GB might be
the total size of all your metadata, but if you run defrag on a 128MB
log file you could rewrite all of your filesystem's metadata in a single
transaction (almost...you probably won't need to update the device or
uuid trees).

If you want to pipeline multiple extents per commit to avoid seeking,
you need to multiply the above numbers by the size of the pipeline.

You can also reduce the metadata cache requirement by reducing the output
extent size.  A 16MB target extent size requires only 64MB of cache for
the logfile case.

> > Don't forget you have to write new checksum and free space tree pages.
> > In the worst case, you'll need about 1GB of new metadata pages for each
> > 128MB you defrag (though you get to delete 99.5% of them immediately
> > after).
> 
> Yes, here we are debating some worst-case scenaraio which is actually
> imposible in practice due to various reasons.

No, it's quite possible.  A log file written slowly on an active
filesystem above a few TB will do that accidentally.  Every now and then
I hit that case.  It can take several hours to do a logrotate on spinning
arrays because of all the metadata fetches and updates associated with
worst-case file delete.  Long enough to watch the delete happen, and
even follow along in the source code.

I guess if I did a proactive defrag every few hours, it might take less
time to do the logrotate, but that would mean spreading out all the
seeky IO load during the day instead of getting it all done at night.
Logrotate does the same job as defrag in this case (replacing a file in
thousands of fragments spread across the disk with a few large fragments
close together), except logrotate gets better compression.

To be more accurate, the example I gave above is the worst case you
can expect from normal user workloads.  If I throw in some reflinks
and snapshots, I can make it arbitrarily worse, until the entire disk
is consumed by the metadata update of a single extent defrag.

> So, doesn't matter.
> 

