Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945A3191FDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 04:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYDx7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 24 Mar 2020 23:53:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32936 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYDx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 23:53:59 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C2ECD62EDEC; Tue, 24 Mar 2020 23:53:57 -0400 (EDT)
Date:   Tue, 24 Mar 2020 23:53:57 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     halfdog <me@halfdog.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: FIDEDUPERANGE woes may continue (or unrelated issue?)
Message-ID: <20200325035357.GU13306@hungrycats.org>
References: <2442-1582352330.109820@YWu4.f8ka.f33u>
 <31deea37-053d-1c8e-0205-549238ced5ac@gmx.com>
 <1560-1582396254.825041@rTOD.AYhR.XHry>
 <13266-1585038442.846261@8932.E3YE.qSfc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <13266-1585038442.846261@8932.E3YE.qSfc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 08:27:22AM +0000, halfdog wrote:
> Hello list,
> 
> It seems the woes really continued ... After trashing the old,
> corrupted filesystem (see old message below) I started rebuilding
> the storage. Synchronization from another (still working) storage
> roughly should have performed the same actions as during initial
> build (minus count and time of mounts/unmounts, transfer interrupts,
> ...).
> 
> It does not seem to be a mere coincidence, that the corruption
> occured when deduplicating the exact same file as last time.
> While corruption last time made disk completely inaccessible,
> this time it just was mounted readonly with a different error
> message:
> 
> [156603.177699] BTRFS error (device dm-1): parent transid verify failed on 6680428544 wanted 12947 found 12945
> [156603.177707] BTRFS: error (device dm-1) in __btrfs_free_extent:3080: errno=-5 IO failure
> [156603.177708] BTRFS info (device dm-1): forced readonly
> [156603.177711] BTRFS: error (device dm-1) in btrfs_run_delayed_refs:2188: errno=-5 IO failure

Normally those messages mean your hardware is dropping writes somewhere;
however, you previously reported running kernels 5.3.0 and 5.3.9, so
there may be another explanation.

Try kernel 4.19.x, 5.4.19, 5.5.3, or later.  Definitely do not use kernels
from 5.1-rc1 to 5.4.13 inclusive unless backported fixes are included.

I mention 5.5.3 and 5.4.19 instead of 5.5.0 and 5.4.14 because the
later ones include the EOF dedupe fix.  4.19 avoids the regressions of
later kernels.

> As it seems that the bug here is somehow reproducible, I would
> like to try to develop a reproducer exploit and fix for that
> bug as an excercise. Unfortunately the fault occurs only after
> transfering and deduplicating ~20TB of data.
> 
> Are there any recommendations e.g. how to "bisect" that problem?

Find someone who has already done it and ask.  ;)

Upgrade straight from 5.0.21 to 5.4.14 (or 5.4.19 if you want the dedupe
fix too).  Don't run any kernel in between for btrfs.

There was a bug introduced in 5.1-rc1, fixed in 5.4.14, which corrupts
metadata.  It's a UAF bug, so its behavior can be unpredictable, but quite
often the symptom is corrupted metadata or write-time tree-checker errors.
Sometimes you just get a harmless NULL dereference crash, or some noise
warnings.

There are at least two other filesystem corrupting bugs with lifetimes
overlapping that range of kernel versions; however both of those were
fixed by 5.3.

> Is there a way (switch or source code modification) to log all
> internal btrfs state transitions for later analysis? 

There are (e.g. the dm write logger), but most bugs that would be
found in unit tests by such tools have been fixed by the time a kernel
is released, and they'll only tell you that btrfs did something wrong,
not why.

Also, there can be tens of thousands of btrfs state transitions per
second during dedupe, so the volume of logs themselves can present data
wrangling challenges.

The more invasively you try to track internal btrfs state, the more the
tools become _part_ of that state, and introduce additional problems.
e.g. there is the ref verifier, and the _bug fix history_ of the ref
verifier...

> Other ideas for debugging that?

Run dedupe on a test machine with a few TB test corpus (or whatever your
workload is) on a debug-enabled kernel, report every bug that kills the
box or hurts the data, update the kernel to get fixes for the bugs that
were reported.  Repeat until the box stops crapping itself, then use the
kernel it stopped on (5.4.14 in this case).  Do that for every kernel
upgrade because regressions are a thing.

> Just creating the same number of snapshots
> and putting just that single file into each of them did not trigger
> the bug during deduplication.

Dedupe itself is fine, but some of the supporting ioctls a deduper has to
use to get information about the filesystem structure triggered a lot of
bugs.

> Kind regards,
> hd
> 
> 
> 
> halfdog writes:
> > Qu Wenruo writes:
> >> On 2020/2/22 下午2:18, halfdog wrote:
> >>> Hello list,
> >>>
> >>> Thanks for the fix to the bug reported in "FIDEDUPERANGE
> >>> woes".
> >>>
> >>> I now got a kernel including that fix. I verified, that
> >>> deduplication now also worked on file ends. Deduplication
> >>> also picked up the unfragmented version of a file in cases,
> >>> where the second file was fragmented due to the bug having
> >>> a single tail block extent.
> >>>
> >>> Looking now at the statistics, I noticed that the "duperemove"
> >>> did not submit all small files to deduplication for unknown
> >>> reason (also not relevant for the current problem).
> >>>
> >>> So I modified the process to submit all identical files and
> >>> started to run it on a drive with bad fragmentation of small
> >>> files due to earlier bug. This procedure terminated middle
> >>> of night with following errors:
> >>>
> >>> [53011.819395] BTRFS error (device dm-1): bad tree block
> >>> start, want 90184380416 have 5483876589805514108 [53011.819426]
> >>> BTRFS: error (device dm-1) in __btrfs_free_extent:3080: errno=-5
> >>> IO failure
> >>
> >> Extent tree already screwed up.
> >>
> >> This means your fs is already screwed up.
> >
> > This is what I assumed. It is just a funny coincidence, that
> > this happened exactly using the disk the first time after a
> > fsck to run massive deduplication on a filesystem with approximately
> > each file existing in 20x copies, with at least one duplicated
> > copy for each set of same files.
> >
> >>> [53011.819434] BTRFS info (device dm-1): forced readonly
> >>> [53011.819441] BTRFS: error (device dm-1) in
> >>> btrfs_run_delayed_refs:2188: errno=-5 IO failure [53624.948618]
> >>> BTRFS error (device dm-1): parent transid verify failed on
> >>> 67651596288 wanted 27538 found 27200 [53651.093717] BTRFS
> >>> error (device dm-1): parent transid verify failed on 67651596288
> >>> wanted 27538 found 27200 [53706.250680] BTRFS error (device
> >>> dm-1): parent transid verify failed on 67651596288 wanted
> >>> 27538 found 27200
> >>
> >> Transid error is not a good sign either.
> >>
> >>>
> >>> Could this be related to the previous fix or is this more
> >>> likely just a random hardware/software bug at a weird time?
> >>
> >> Not sure, but I don't think the reflink-beyond-eof fix is
> >> related to the bug, as the main problem is the tree block
> >> COW.
> >>
> >> Normally such transid corruption is related to extent tree
> >> corruption, which matches the result from btrfs check.
> >
> > So it seems, but the reason is unclear. At least there were
> > no hardware failures (SMART, ECC, processor temperature) reported,
> > no bus transfer errors, so this might be a software fault.
> >
> > As the data on the disk is not really needed, the disk is currently
> > cold without any need to bring it online soon, this would allow
> > to use it for debugging the cause of corruption.
> >
> > If there is any interest in that, I could try to assist, e.g.
> > creating VM with trunk kernel/tools for debugging and execute
> > the tests. Otherwise I would just flatten the filesystem and
> > initialize the disk anew.
> >
> >
> >>> I also tried to apply the btrfs-check to that, but it fails
> >>> opening the device, thus not attempting to repair it ...
> >>>
> >>> # btrfs check --progress --clear-space-cache v1
> >>> --clear-space-cache v2 --super 1 [device] using SB copy 1,
> >>> bytenr 67108864 Opening filesystem to check... checksum verify
> >>> failed on 90184388608 found 00000000 wanted FFFFFF96 checksum
> >>> verify failed on 90184388608 found 00000000 wanted FFFFFF96
> >>> bad tree block 90184388608, bytenr mismatch, want=90184388608,
> >>> have=15484548251864346855 ERROR: failed to read block groups:
> >>> Input/output error ERROR: cannot open file system
> >>>
> >>> Any ideas?
> >>>
> >>>
> >>> PS: I have a database of all file checksums on another drive
> >>> for comparison of file content, if useful.
> >>>
> >>>
> >>> Filipe Manana writes:
> >>>> On Sat, Dec 14, 2019 at 5:46 AM Zygo Blaxell
> >>>> <ce3g8jdj@umail.furryterror.org> wrote:
> >>>>>
> >>>>> On Fri, Dec 13, 2019 at 05:32:14PM +0800, Qu Wenruo wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2019/12/13 =E4=B8=8A=E5=8D=8812:15, halfdog wrote:
> >>>>>>> Hello list,
> >>>>>>>
> >>>>>>> Using btrfs on
> >>>>>>>
> >>>>>>> Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org)
> >>>>>>> (gcc ver=
> >>>> sion 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3
> >>>> (2019-11-19)
> >>>>>>>
> >>>>>>> the FIDEDUPERANGE exposes weird behaviour on two identical
> >>>>>>> but not too large files that seems to be depending on
> >>>>>>> the file size. Before FIDEDUPERANGE both files have a
> >>>>>>> single extent, afterwards first file is still single
> >>>>>>> extent, second file has all bytes sharing with the extent
> >>>>>>> of the first file except for the last 4096 bytes.
> >>>>>>>
> >>>>>>> Is there anything known about a bug fixed since the above
> >>>>>>> mentioned kernel version?
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> If no, does following reproducer still show the same
> >>>>>>> behaviour on current Linux kernel (my Python test tools
> >>>>>>> also attached)?
> >>>>>>>
> >>>>>>>> dd if=3D/dev/zero bs=3D1M count=3D32 of=3Ddisk mkfs.btrfs
> >>>>>>>> --mixed --metadata single --data single --nodesize 4096
> >>>>>>>> d=
> >>>> isk
> >>>>>>>> mount disk /mnt/test mkdir /mnt/test/x dd bs=3D1
> >>>>>>>> count=3D155489 if=3D/dev/urandom of=3D/mnt/test/x/file-0
> >>>>>>
> >>>>>> 155489 is not sector size aligned, thus the last extent
> >>>>>> will be padded with zero.
> >>>>>>
> >>>>>>>> cat /mnt/test/x/file-0 > /mnt/test/x/file-1
> >>>>>>
> >>>>>> Same for the new file.
> >>>>>>
> >>>>>> For the tailing padding part, it's not aligned, and it's
> >>>>>> smaller than the inode size.
> >>>>>>
> >>>>>> Thus we won't dedupe that tailing part.
> >>>>>
> >>>>> We definitely *must* dedupe the tailing part on btrfs;
> >>>>> otherwise, we can'=
> >>>> t
> >>>>> eliminate the reference to the last (partial) block in
> >>>>> the last extent of the file, and there is no way to dedupe
> >>>>> the _entire_ file in this example=
> >>>> .
> >>>>> It does pretty bad things to dedupe hit rates on uncompressed
> >>>>> contiguous files, where you can lose an average of 64MB
> >>>>> of space per file.
> >>>>>
> >>>>> I had been wondering why dedupe scores seemed so low on
> >>>>> recent kernels, and this bug would certainly contribute
> >>>>> to that.
> >>>>>
> >>>>> It worked in 4.20, broken in 5.0.  My guess is commit
> >>>>> 34a28e3d77535efc7761aa8d67275c07d1fe2c58 ("Btrfs: use
> >>>>> generic_remap_file_range_prep() for cloning and deduplication")
> >>>>> but I haven't run a test to confirm.
> >>>>
> >>>> The problem comes from the generic (vfs) code, which always
> >>>> rounds down the deduplication length to a multiple of the
> >>>> filesystem's sector size. That should be done only when
> >>>> the destination range's end does not match the destination's
> >>>> file size, to avoid the corruption I found over a year ago
> >>>> [1]. For some odd reason it has the correct behavior for
> >>>> cloning, it only rounds down the destination range's end
> >>>> is less then the destination's file size.
> >>>>
> >>>> I'll see if I get that fixed next week.
> >>>>
> >>>> [1]
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
> >>>> it/?id=3Dde02b9f6bb65a6a1848f346f7a3617b7a9b930c0
> >>>>
> >>>>>
> >>>>>
> >>>>>> Thanks, Qu
> >>>>>>
> >>>>>>>
> >>>>>>>> ./SimpleIndexer x > x.json ./IndexDeduplicationAnalyzer
> >>>>>>>> --IndexFile /mnt/test/x.json /mnt/test/=
> >>>> x > dedup.list
> >>>>>>> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)],
> >>>>>>> b'/mnt/test=
> >>>> /x/file-1': [(0, 5472256, 155648)]}
> >>>>>>> ...
> >>>>>>>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0
> >>>>>>>> 0 /mnt/t=
> >>>> est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> >>>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE,
> >>>>>>> {src_offset=3D0=
> >>>> , src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4,
> >>>> dest_offset=3D= 0}]} =3D> {info=3D[{bytes_deduped=3D155489,
> >>>> status=3D0}]}) =3D 0
> >>>>>>>> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json
> >>>>>>>> /mnt/test/=
> >>>> x > dedup.list
> >>>>>>> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)],
> >>>>>>> b'/mnt/test=
> >>>> /x/file-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
> >>>>>>> ...
> >>>>>>>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0
> >>>>>>>> 0 /mnt/t=
> >>>> est/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> >>>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE,
> >>>>>>> {src_offset=3D0=
> >>>> , src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4,
> >>>> dest_offset=3D= 0}]} =3D> {info=3D[{bytes_deduped=3D155489,
> >>>> status=3D0}]}) =3D 0
> >>>>>>>> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0
> >>>>>>>> 151552 /mn=
> >>>> t/test/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
> >>>>>>> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE,
> >>>>>>> {src_offset=3D1=
> >>>> 51552, src_length=3D4096, dest_count=3D1, info=3D[{dest_fd=3D4,
> >>>> dest_offset= =3D151552}]}) =3D -1 EINVAL (Invalid argument)
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>> --=20 Filipe David Manana,
> >>>>
> >>>> =E2=80=9CWhether you think you can, or you think you can't
> >>>> =E2=80=94 you're= right.=E2=80=9D
> >>>
> >>
> 
