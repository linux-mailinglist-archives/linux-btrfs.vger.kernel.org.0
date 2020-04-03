Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD65B19CF01
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 06:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgDCECW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 Apr 2020 00:02:22 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37066 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgDCECW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 00:02:22 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DFBBE64C2E8; Fri,  3 Apr 2020 00:02:20 -0400 (EDT)
Date:   Fri, 3 Apr 2020 00:02:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
Message-ID: <20200403040220.GJ2693@hungrycats.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
 <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
 <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 08:00:40AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/4/2 下午9:26, Filipe Manana wrote:
> > On Thu, Apr 2, 2020 at 1:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2020/4/2 下午8:33, Filipe Manana wrote:
> >>> On Thu, Apr 2, 2020 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2020/4/2 下午7:08, Filipe Manana wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Recently I was looking at why the test case btrfs/125 from fstests often fails.
> >>>>> Typically when it fails we have something like the following in dmesg/syslog:
> >>>>>
> >>>>>  (...)
> >>>>>  BTRFS error (device sdc): space cache generation (7) does not match inode (9)
> >>>>>  BTRFS warning (device sdc): failed to load free space cache for block
> >>>>> group 38797312, rebuilding it now
> >>>>>  BTRFS info (device sdc): balance: start -d -m -s
> >>>>>  BTRFS info (device sdc): relocating block group 754581504 flags data|raid5
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39059456 have 0
> >>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
> >>>>> (dev /dev/sde sector 18688)
> >>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
> >>>>> (dev /dev/sde sector 18696)
> >>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
> >>>>> (dev /dev/sde sector 18704)
> >>>>>  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
> >>>>> (dev /dev/sde sector 18712)
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
> >>>>> csum 0x8941f998 expected csum 0x93413794 mirror 1
> >>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1380352
> >>>>> (dev /dev/sde sector 718728)
> >>>>>  BTRFS info (device sdc): read error corrected: ino 257 off 1376256
> >>>>> (dev /dev/sde sector 718720)
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >>>>>  BTRFS info (device sdc): balance: ended with status: -5
> >>>>>  (...)
> >>>>>
> >>>>> So I finally looked into it to figure out why that happens.
> >>>>>
> >>>>> Consider the following scenario and steps that explain how we end up
> >>>>> with a metadata extent
> >>>>> permanently corrupt and unrecoverable (when it shouldn't be possible).
> >>>>>
> >>>>> * We have a RAID5 filesystem consisting of three devices, with device
> >>>>> IDs of 1, 2 and 3;
> >>>>>
> >>>>> * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
> >>>>>
> >>>>> * We have a single metadata block group that starts at logical offset
> >>>>> 38797312 and has a
> >>>>>   length of 715784192 bytes.
> >>>>>
> >>>>> The following steps lead to a permanent corruption of a metadata extent:
> >>>>>
> >>>>> 1) We make device 3 unavailable and mount the filesystem in degraded
> >>>>> mode, so only
> >>>>>    devices 1 and 2 are online;
> >>>>>
> >>>>> 2) We allocate a new extent buffer with logical address of 39043072, this falls
> >>>>>    within the full stripe that starts at logical address 38928384, which is
> >>>>>    composed of 3 stripes, each with a size of 64Kb:
> >>>>>
> >>>>>    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
> >>>>> stripe 3, offset 39059456 ]
> >>>>>    (the offsets are logical addresses)
> >>>>>
> >>>>>    stripe 1 is in device 2
> >>>>>    stripe 2 is in device 3
> >>>>>    stripe 3 is in device 1  (this is the parity stripe)
> >>>>>
> >>>>>    Our extent buffer 39043072 falls into stripe 2, starting at page
> >>>>> with index 12
> >>>>>    of that stripe and ending at page with index 15;
> >>>>>
> >>>>> 3) When writing the new extent buffer at address 39043072 we obviously
> >>>>> don't write
> >>>>>    the second stripe since device 3 is missing and we are in degraded
> >>>>> mode. We write
> >>>>>    only the stripes for devices 1 and 2, which are enough to recover
> >>>>> stripe 2 content
> >>>>>    when it's needed to read it (by XORing stripes 1 and 3, we produce
> >>>>> the correct
> >>>>>    content of stripe 2);
> >>>>>
> >>>>> 4) We unmount the filesystem;
> >>>>>
> >>>>> 5) We make device 3 available and then mount the filesystem in
> >>>>> non-degraded mode;
> >>>>>
> >>>>> 6) Due to some write operation (such as relocation like btrfs/125
> >>>>> does), we allocate
> >>>>>    a new extent buffer at logical address 38993920. This belongs to
> >>>>> the same full
> >>>>>    stripe as the extent buffer we allocated before in degraded mode (39043072),
> >>>>>    and it's mapped to stripe 2 of that full stripe as well,
> >>>>> corresponding to page
> >>>>>    indexes from 0 to 3 of that stripe;
> >>>>>
> >>>>> 7) When we do the actual write of this stripe, because it's a partial
> >>>>> stripe write
> >>>>>    (we aren't writing to all the pages of all the stripes of the full
> >>>>> stripe), we
> >>>>>    need to read the remaining pages of stripe 2 (page indexes from 4 to 15) and
> >>>>>    all the pages of stripe 1 from disk in order to compute the content for the
> >>>>>    parity stripe. So we submit bios to read those pages from the corresponding
> >>>>>    devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is that we
> >>>>>    assume whatever we read from the devices is valid - in this case what we read
> >>>>>    from device 3, to which stripe 2 is mapped, is invalid since in the degraded
> >>>>>    mount we haven't written extent buffer 39043072 to it - so we get
> >>>>> garbage from
> >>>>>    that device (either a stale extent, a bunch of zeroes due to trim/discard or
> >>>>>    anything completely random). Then we compute the content for the
> >>>>> parity stripe
> >>>>>    based on that invalid content we read from device 3 and write the
> >>>>> parity stripe
> >>>>>    (and the other two stripes) to disk;
> >>>>>
> >>>>> 8) We later try to read extent buffer 39043072 (the one we allocated while in
> >>>>>    degraded mode), but what we get from device 3 is invalid (this extent buffer
> >>>>>    belongs to a stripe of device 3, remember step 2), so
> >>>>> btree_read_extent_buffer_pages()
> >>>>>    triggers a recovery attempt - this happens through:
> >>>>>
> >>>>>    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
> >>>>>      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() ->
> >>>>>        -> raid56_parity_recover()
> >>>>>
> >>>>>    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (the parity
> >>>>>    stripe) by XORing the content of these last two. However the parity
> >>>>> stripe was
> >>>>>    recomputed at step 7 using invalid content from device 3 for stripe 2, so the
> >>>>>    rebuilt stripe 2 still has invalid content for the extent buffer 39043072.
> >>>>>
> >>>>> This results in the impossibility to recover an extent buffer and
> >>>>> getting permanent
> >>>>> metadata corruption. If the read of the extent buffer 39043072
> >>>>> happened before the
> >>>>> write of extent buffer 38993920, we would have been able to recover it since the
> >>>>> parity stripe reflected correct content, it matched what was written in degraded
> >>>>> mode at steps 2 and 3.
> >>>>>
> >>>>> The same type of issue happens for data extents as well.
> >>>>>
> >>>>> Since the stripe size is currently fixed at 64Kb, the issue doesn't happen only
> >>>>> if the node size and sector size are 64Kb (systems with a 64Kb page size).
> >>>>>
> >>>>> And we don't need to do writes in degraded mode and then mount in non-degraded
> >>>>> mode with the previously missing device for this to happen (I gave the example
> >>>>> of degraded mode because that's what btrfs/125 exercises).
> >>>>
> >>>> This also means, other raid5/6 implementations are also affected by the
> >>>> same problem, right?
> >>>
> >>> If so, that makes them less useful as well.
> >>> For all the other raid modes we support, which use mirrors, we don't
> >>> have this problem. If one copy is corrupt, we are able to recover it,
> >>> period.
> >>>
> >>>>
> >>>>>
> >>>>> Any scenario where the on disk content for an extent changed (some bit flips for
> >>>>> example) can result in a permanently unrecoverable metadata or data extent if we
> >>>>> have the bad luck of having a partial stripe write happen before an attempt to
> >>>>> read and recover a corrupt extent in the same stripe.
> >>>>>
> >>>>> Zygo had a report some months ago where he experienced this as well:
> >>>>>
> >>>>> https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.org/
> >>>>>
> >>>>> Haven't tried his script to reproduce, but it's very likely it's due to this
> >>>>> issue caused by partial stripe writes before reads and recovery attempts.
> >>>>>
> >>>>> This is a problem that has been around since raid5/6 support was added, and it
> >>>>> seems to me it's something that was not thought about in the initial design.
> >>>>>
> >>>>> The validation/check of an extent (both metadata and data) happens at a higher
> >>>>> layer than the raid5/6 layer, and it's the higher layer that orders the lower
> >>>>> layer (raid56.{c,h}) to attempt recover/repair after it reads an extent that
> >>>>> fails validation.
> >>>>>
> >>>>> I'm not seeing a reasonable way to fix this at the moment, initial thoughts all
> >>>>> imply:
> >>>>>
> >>>>> 1) Attempts to validate all extents of a stripe before doing a partial write,
> >>>>> which not only would be a performance killer and terribly complex, ut would
> >>>>> also be very messy to organize this in respect to proper layering of
> >>>>> responsabilities;
> >>>>
> >>>> Yes, this means raid56 layer will rely on extent tree to do
> >>>> verification, and too complex.
> >>>>
> >>>> Not really worthy to me too.
> >>>>
> >>>>>
> >>>>> 2) Maybe changing the allocator to work in a special way for raid5/6 such that
> >>>>> it never allocates an extent from a stripe that already has extents that were
> >>>>> allocated by past transactions. However data extent allocation is currently
> >>>>> done without holding a transaction open (and forgood reasons) during
> >>>>> writeback. Would need more thought to see how viable it is, but not trivial
> >>>>> either.
> >>>>>
> >>>>> Any thoughts? Perhaps someone else was already aware of this problem and
> >>>>> had thought about this before. Josef?
> >>>>
> >>>> What about using sector size as device stripe size?
> >>>
> >>> Unfortunately that wouldn't work as well.
> >>>
> >>> Say you have stripe 1 with a corrupt metadata extent. Then you do a
> >>> write to a metadata extent located at stripe 2 - this partial write
> >>> (because it doesn't cover all stripes of the full stripe), will read
> >>> the pages from the first stripe and assume they are all good, and then
> >>> use those for computing the parity stripe - based on a corrupt extent
> >>> as well. Same problem I described, but this time the corrupt extent is
> >>> in a different stripe of the same full stripe.
> >>
> >> Yep, I also recognized that problem after some time.
> >>
> >> Another possible solution is, always write 0 bytes for pinned extents
> >> (I'm only thinking metadata yet).
> >>
> >> This means, at transaction commit time, we also need to write 0 for
> >> pinned extents before next transaction starts.
> > 
> > I'm assuming you mean to write zeroes to pinned extents when unpinning
> > them- after writing the superblock of the committing transaction.
> 
> So the timing of unpinning them would also need to be changed.
> 
> As mentioned, it needs to be before starting next transaction.
> 
> Anyway, my point is, if we ensure all unwritten data contains certain
> pattern (for metadata), then we can at least use them to detect out of
> sync full stripe.

Does that mean that we will have to write zero to those blocks upon
dellocation?  And format unused blocks in newly allocated RAID stripes?

If we can treat newly allocated RAID stripes specially, it might be
far simpler to use that capability to not do raid5/6 RMW at all.

> Thanks,
> Qu
> 
> > But
> > way before that, the next transaction may have already started, and
> > metadata and data writes may have already started as well, think of
> > fsync() or writepages() being called by the vm due to memory pressure
> > for example (or page migration, etc).
> > 
> >> This needs some extra work, and will definite re-do a lot of parity
> >> re-calculation, which would definitely affect performance.
> >>
> >> So for a new partial write, before we write the new stripe, we read the
> >> remaining data stripes (which we already need) and the parity stripe
> >> (the new thing).
> >>
> >> We do the rebuild, if the rebuild result is all zero, then it means the
> >> full stripe is OK, we do regular write.
> >>
> >> If the rebuild result is not all zero, it means the full stripe is not
> >> consistent, do some repair before write the partial stripe.
> >>
> >> However this only works for metadata, and metadata is never all 0, so
> >> all zero page can be an indicator.
> >>
> >> How this crazy idea looks?
> > 
> > Extremely crazy :/
> > I don't see how it would work due to the above comment.
> > 
> > thanks
> > 
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Thanks.
> >>>
> >>>>
> >>>> It would make metadata scrubbing suffer, and would cause performance
> >>>> problems I guess, but it looks a little more feasible.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>
> >>>>
> >>>
> >>>
> >>
> > 
> > 
> 



