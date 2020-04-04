Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE619E706
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgDDSRw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 4 Apr 2020 14:17:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37574 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgDDSRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 14:17:52 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3F112650889; Sat,  4 Apr 2020 14:17:49 -0400 (EDT)
Date:   Sat, 4 Apr 2020 14:17:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
Message-ID: <20200404181749.GL13306@hungrycats.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <20200402210254.GG13306@hungrycats.org>
 <CAL3q7H4hQbvi4u-_70bhXoW2UZ5JMekc3XKousVY5HO4A80=Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL3q7H4hQbvi4u-_70bhXoW2UZ5JMekc3XKousVY5HO4A80=Rw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 09:58:04AM +0000, Filipe Manana wrote:
> On Thu, Apr 2, 2020 at 10:02 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Thu, Apr 02, 2020 at 11:08:55AM +0000, Filipe Manana wrote:
> > > Hi,
> > >
> > > Recently I was looking at why the test case btrfs/125 from fstests often fails.
> > > Typically when it fails we have something like the following in dmesg/syslog:
> > >
> > >  (...)
> > >  BTRFS error (device sdc): space cache generation (7) does not match inode (9)
> > >  BTRFS warning (device sdc): failed to load free space cache for block
> > > group 38797312, rebuilding it now
> > >  BTRFS info (device sdc): balance: start -d -m -s
> > >  BTRFS info (device sdc): relocating block group 754581504 flags data|raid5
> > >  BTRFS error (device sdc): bad tree block start, want 39059456 have 0
> > >  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
> > > (dev /dev/sde sector 18688)
> > >  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
> > > (dev /dev/sde sector 18696)
> > >  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
> > > (dev /dev/sde sector 18704)
> > >  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
> > > (dev /dev/sde sector 18712)
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
> > > csum 0x8941f998 expected csum 0x93413794 mirror 1
> > >  BTRFS info (device sdc): read error corrected: ino 257 off 1380352
> > > (dev /dev/sde sector 718728)
> > >  BTRFS info (device sdc): read error corrected: ino 257 off 1376256
> > > (dev /dev/sde sector 718720)
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> > >  BTRFS info (device sdc): balance: ended with status: -5
> > >  (...)
> > >
> > > So I finally looked into it to figure out why that happens.
> > >
> > > Consider the following scenario and steps that explain how we end up
> > > with a metadata extent
> > > permanently corrupt and unrecoverable (when it shouldn't be possible).
> > >
> > > * We have a RAID5 filesystem consisting of three devices, with device
> > > IDs of 1, 2 and 3;
> > >
> > > * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
> > >
> > > * We have a single metadata block group that starts at logical offset
> > > 38797312 and has a
> > >   length of 715784192 bytes.
> > >
> > > The following steps lead to a permanent corruption of a metadata extent:
> > >
> > > 1) We make device 3 unavailable and mount the filesystem in degraded
> > > mode, so only
> > >    devices 1 and 2 are online;
> > >
> > > 2) We allocate a new extent buffer with logical address of 39043072, this falls
> > >    within the full stripe that starts at logical address 38928384, which is
> > >    composed of 3 stripes, each with a size of 64Kb:
> > >
> > >    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
> > > stripe 3, offset 39059456 ]
> > >    (the offsets are logical addresses)
> > >
> > >    stripe 1 is in device 2
> > >    stripe 2 is in device 3
> > >    stripe 3 is in device 1  (this is the parity stripe)
> > >
> > >    Our extent buffer 39043072 falls into stripe 2, starting at page
> > > with index 12
> > >    of that stripe and ending at page with index 15;
> > >
> > > 3) When writing the new extent buffer at address 39043072 we obviously
> > > don't write
> > >    the second stripe since device 3 is missing and we are in degraded
> > > mode. We write
> > >    only the stripes for devices 1 and 2, which are enough to recover
> > > stripe 2 content
> > >    when it's needed to read it (by XORing stripes 1 and 3, we produce
> > > the correct
> > >    content of stripe 2);
> > >
> > > 4) We unmount the filesystem;
> > >
> > > 5) We make device 3 available and then mount the filesystem in
> > > non-degraded mode;
> > >
> > > 6) Due to some write operation (such as relocation like btrfs/125
> > > does), we allocate
> > >    a new extent buffer at logical address 38993920. This belongs to
> > > the same full
> > >    stripe as the extent buffer we allocated before in degraded mode (39043072),
> > >    and it's mapped to stripe 2 of that full stripe as well,
> > > corresponding to page
> > >    indexes from 0 to 3 of that stripe;
> > >
> > > 7) When we do the actual write of this stripe, because it's a partial
> > > stripe write
> > >    (we aren't writing to all the pages of all the stripes of the full
> > > stripe), we
> > >    need to read the remaining pages of stripe 2 (page indexes from 4 to 15) and
> > >    all the pages of stripe 1 from disk in order to compute the content for the
> > >    parity stripe. So we submit bios to read those pages from the corresponding
> > >    devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is that we
> > >    assume whatever we read from the devices is valid - in this case what we read
> > >    from device 3, to which stripe 2 is mapped, is invalid since in the degraded
> > >    mount we haven't written extent buffer 39043072 to it - so we get
> > > garbage from
> > >    that device (either a stale extent, a bunch of zeroes due to trim/discard or
> > >    anything completely random). Then we compute the content for the
> > > parity stripe
> > >    based on that invalid content we read from device 3 and write the
> > > parity stripe
> > >    (and the other two stripes) to disk;
> > >
> > > 8) We later try to read extent buffer 39043072 (the one we allocated while in
> > >    degraded mode), but what we get from device 3 is invalid (this extent buffer
> > >    belongs to a stripe of device 3, remember step 2), so
> > > btree_read_extent_buffer_pages()
> > >    triggers a recovery attempt - this happens through:
> > >
> > >    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
> > >      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() ->
> > >        -> raid56_parity_recover()
> > >
> > >    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (the parity
> > >    stripe) by XORing the content of these last two. However the parity
> > > stripe was
> > >    recomputed at step 7 using invalid content from device 3 for stripe 2, so the
> > >    rebuilt stripe 2 still has invalid content for the extent buffer 39043072.
> > >
> > > This results in the impossibility to recover an extent buffer and
> > > getting permanent
> > > metadata corruption. If the read of the extent buffer 39043072
> > > happened before the
> > > write of extent buffer 38993920, we would have been able to recover it since the
> > > parity stripe reflected correct content, it matched what was written in degraded
> > > mode at steps 2 and 3.
> > >
> > > The same type of issue happens for data extents as well.
> > >
> > > Since the stripe size is currently fixed at 64Kb, the issue doesn't happen only
> > > if the node size and sector size are 64Kb (systems with a 64Kb page size).
> > >
> > > And we don't need to do writes in degraded mode and then mount in non-degraded
> > > mode with the previously missing device for this to happen (I gave the example
> > > of degraded mode because that's what btrfs/125 exercises).
> > >
> > > Any scenario where the on disk content for an extent changed (some bit flips for
> > > example) can result in a permanently unrecoverable metadata or data extent if we
> > > have the bad luck of having a partial stripe write happen before an attempt to
> > > read and recover a corrupt extent in the same stripe.
> > >
> > > Zygo had a report some months ago where he experienced this as well:
> > >
> > > https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.org/
> > >
> > > Haven't tried his script to reproduce, but it's very likely it's due to this
> > > issue caused by partial stripe writes before reads and recovery attempts.
> >
> > Well, I don't mean to pick a nit, but I don't see how the same effect is
> > at work here.  My repro script tries very hard to avoid concurrent writing
> > and reading to keep the bugs that it may find as simple as possible.
> > It does the data writes first, then sync, then corruption, then sync,
> > then reads.
> >
> > Certainly, if btrfs is occasionally reading data blocks without checking
> > sums even in the ordinary read path, then everything that follows that
> > point will lead to similar corruption.  But maybe there are two separate
> > bugs here.
> >
> > > This is a problem that has been around since raid5/6 support was added, and it
> > > seems to me it's something that was not thought about in the initial design.
> > >
> > > The validation/check of an extent (both metadata and data) happens at a higher
> > > layer than the raid5/6 layer, and it's the higher layer that orders the lower
> > > layer (raid56.{c,h}) to attempt recover/repair after it reads an extent that
> > > fails validation.
> >
> > Can raid5/6 call back into just the csum validation?  It doesn't need
> > to look at the current transaction--committed data is fine (if it wasn't
> > committed, it wouldn't be on disk to have a csum in the first place).
> 
> Calling just the csum validation is possible, but not enough for
> metadata (we have to very its tree level and first key, to verify it
> matches with the parent node, generation/transid, fsid and other
> fields to make sure we're not dealing with a stale metadata extent,
> either from a previously missing device or from a previously created
> fs in the device).
> 
> As for looking at only committed data, it's not that simple
> unfortunately. For example, you have to make sure that while you are
> searching though the commit root for csums (or whatever else) the
> commit root (and all its descendants) doesn't go away - so one has to
> either hold a transaction open or hold the semaphore
> fs_info->commit_root_sem, to prevent a transaction commit from
> switching commit roots and dropping the one we are currently using -
> that's the same we do for fiemap and the logical ino ioctls for
> example - and you, above all users (since you are a heavy user of the
> logical ino ioctl), have the experience of how bad this can be, as
> blocking transaction commits can cause huge latencies for other
> processes.
> 
> >
> > In practice you have to have those parts of the csum tree in RAM
> > already--if you don't, the modifications you're making will force you
> > read the csum tree pages so you can insert new csum items anyway.  A
> 
> I wouldn't count on that much optimism. There will always be cases
> where the leaf containing the csum is not in memory anymore or was
> never loaded since the fs was mounted.

Sure, that's even the common case for data extents when you delete them:
if you have a lot of scattered deletes, most of the IO time in commit
will be spent reading csum pages in random order, removing a single item,
and then sending the modified csum page back to disk.  This can be many
gigabytes of IO, and we need to throttle it in deletes and truncates
or commits take hours.

When you're adding new extents in between existing ones, you have to read
the csum or parent pages containing adjacent extent items to be able to
insert the new items into the tree.  We either need to read the page as
part of figuring out what we're doing (e.g. to look up inode permissions),
or we need to read the page to update it later in the commit (e.g. to
insert the new items).  We gain nothing by pretending we don't have to
do that read at some point in the transaction, as long as the result of
that read ends up cached so we don't have to do it twice.

Adjacent items might not be in the same pages if they're the first
or last item on a leaf, but that happens <1% of the time.

> > csum lookup on every adjacent block won't affect performance very much
> > (i.e. it's terrible already, we're not going to make it much worse).
> >
> > For metadata blocks it's similar except you need to follow some backrefs
> > to verify parent transid and level.  It's not enough to check the metadata
> > block csum.
> 
> Yep, just mentioned above before reading this paragraph.
> 
> >
> > I admit I don't know all the details here.  If it's possible for one
> > transaction in flight to free space that can be consumed by another
> > transaction also in flight, then my suggestions above are probably doomed.
> 
> It's possible for one transaction to start while the previous one is
> committing, but the new transaction can't use anything the previous
> one freed until the previous one writes the superblocks on all the
> devices.
> 
> >
> > > I'm not seeing a reasonable way to fix this at the moment, initial thoughts all
> > > imply:
> > >
> > > 1) Attempts to validate all extents of a stripe before doing a partial write,
> > > which not only would be a performance killer and terribly complex, ut would
> > > also be very messy to organize this in respect to proper layering of
> > > responsabilities;
> > >
> > > 2) Maybe changing the allocator to work in a special way for raid5/6 such that
> > > it never allocates an extent from a stripe that already has extents that were
> > > allocated by past transactions. However data extent allocation is currently
> > > done without holding a transaction open (and forgood reasons) during
> > > writeback. Would need more thought to see how viable it is, but not trivial
> > > either.
> >
> > IMHO the allocator should never be allocating anything in a partially
> > filled RAID5/6 stripe, except if the stripe went from empty to partially
> > filled in the current transaction.  This makes RAID5/6 stripes effectively
> > read-only while they have committed data in them, becoming read-write
> > again only when they are completely empty.
> >
> > If you allow allocations within partially filled stripes, then you get
> > write hole and other problems like this one where CoW expectations and
> > RMW reality collide.  If you disallow RMW, all the other problems go
> > away and btrfs gets faster (than other software raid5 implementations
> > with stripe update journalling) because it's not doing RMW any more.
> > The cost is having to balance or defrag more often for some workloads.
> 
> Yep.
> 
> >
> > The allocator doesn't need to know the full details of the current
> > transaction.  It could look for raid-stripe-aligned free space clusters
> > (similar to what the ssd "clustering" does now, but looking at the
> > block group to figure out how to get exact raid5/6 stripe alignment
> > instead of blindly using SZ_2M).  The allocator can cache the last
> > (few) partially-filled cluster(s) for small allocations, and put big
> > allocations on stripe-aligned boundaries.  If the allocator was told
> > that a new transaction started, it would discard its cached partially
> > filled clusters and start over looking for empty stripe-width ones.
> 
> Yep, the clustering as it's done for ssd mode, is precisely what I had in mind.
> 
> >
> > The result is a lot more free space fragmentation, but balance can
> > solve that.  Maybe create a new balance filter optimized to relocate
> > data only from partial stripes (packing them into new full-width ones)
> > and leave other data alone.
> 
> One big problem I through about is:
> 
> During write paths such as buffered writes, we reserve space by
> updating some counters (mostly to speed up things).
> Since they are counters they have no idea if there's enough free
> contiguous space for a stripe, so that means a buffered write doesn't
> fail (with ENOSPC) at the time a write/pwrite call.
> But then later at writeback time, when we actually call the allocator
> to reserve an extent, we could fail since we can't find contiguous
> space. So the write would silently fail, surprising users/applications
> - they can check for errors by calling fsync, which would return the
> error, but that still would be very surprising and we had such cases
> in the past with nodatacow and snapshotting or extent cloning for
> example, which surprised people. As such it's very desirable to avoid
> that.
> 
> >
> > I'm ignoring nodatacow above because it's an entirely separate worm
> > can: nodatacow probably needs a full stripe update journal to work,
> > which eliminates most of the benefit of nodatacow.  If you place
> > nodatasum extents in the same raid stripes as datasum extents, you end
> > up potentially corrupting the datasum extents.  I don't know of a way to
> > fix this, except to say "nodatacow on raid5 will eat your data, sorry,
> > that's the price for nodatasum", and make sure nodatasum files are
> > never allocated in the same raid5 stripe as datasum files.
> 
> Yes. The journal would do it, and there was some years ago a rfc
> patchset that added one with the goal of solving the write-hole
> problem (similar to the md solution).
> I think that would solve too the problem I reported about partial
> stripe writes before read/recovery. I'm trying to see if there's a
> simpler solution to solve this problem.
> 
> Thanks.
> 
> >
> > > Any thoughts? Perhaps someone else was already aware of this problem and
> > > had thought about this before. Josef?
> > >
> > > Thanks.
> > >
> > >
> > > --
> > > Filipe David Manana,
> > >
> > > “Whether you think you can, or you think you can't — you're right.”
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
