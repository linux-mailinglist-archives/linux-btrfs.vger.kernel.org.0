Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3704F6A75
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiDFTyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiDFTx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 15:53:27 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 750C6193166
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:07:48 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 1D5432B20A2; Wed,  6 Apr 2022 14:07:47 -0400 (EDT)
Date:   Wed, 6 Apr 2022 14:07:47 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <Yk3W88Eyh0pSm9mQ@hungrycats.org>
References: <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
 <20220406040913.GE3307770@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406040913.GE3307770@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 09:09:13PM -0700, Marc MERLIN wrote:
> On Tue, Apr 05, 2022 at 09:40:51PM -0400, Zygo Blaxell wrote:
> > Based on the history, I'd expect the filesystem is missing some number
> > of tree nodes, from a few dozen to thousands, depending on how many
> > writes were dropped after the 2nd drive failure before it was detected.
> > Since the array was also degraded at that time, with 4 drives in raid5,
> > there's 3 data drives, and if one of them was offline then we'd have a 2/3
> > success rate reading metadata blocks and 1/3 garbage.  That's definitely
> > in the "we need to write new software to recover from this" territory.
>  
> I think your conclusion is correct. I'm very dismayed that the
> filesystem didn't go read only right away.
> Hell, the mdadm block device should have done read only as soon as it
> lost more than one drive.
> Why were any writes allowed once more than one drive was missing?

> Let's look at this for a second:
> Mar 28 02:28:11 gargamel kernel: [1512988.446844] sd 6:1:8:0: Device offlined - not ready after error recovery
> Mar 28 02:28:11 gargamel kernel: [1512988.475270] sd 6:1:8:0: rejecting I/O to offline device
> Mar 28 02:28:11 gargamel kernel: [1512988.491531] blk_update_request: I/O error, dev sdi, sector 261928312 op 0x0:(READ) flags 0x84700
>  phys_seg 42 prio class 0
> Mar 28 02:28:11 gargamel kernel: [1512988.525073] blk_update_request: I/O error, dev sdi, sector 261928824 op 0x0:(READ) flags 0x80700
>  phys_seg 5 prio class 0
> Mar 28 02:28:12 gargamel kernel: [1512988.579667] blk_update_request: I/O error, dev sdi, sector 261927936 op 0x0:(READ) flags 0x80700
>  phys_seg 47 prio class 0
> (..)
> Mar 28 02:28:12 gargamel kernel: [1512988.615910] md: super_written gets error=10
> Mar 28 02:28:12 gargamel kernel: [1512988.619241] md/raid:md7: Disk failure on sdi1, disabling device.
> Mar 28 02:28:12 gargamel kernel: [1512988.619241] md/raid:md7: Operation continuing on 4 devices.
> Mar 28 02:28:21 gargamel kernel: [1512998.170192] usb 2-1.6-port1: disabled by hub (EMI?), re-enabling...
> Mar 28 02:28:21 gargamel kernel: [1512998.240404] print_req_error: 134 callbacks suppressed
> Mar 28 02:28:21 gargamel kernel: [1512998.240406] blk_update_request: I/O error, dev sdi, sector 11721044992 op 0x0:(READ) flags 0x807
> 00 phys_seg 1 prio class 0
> Mar 28 02:28:21 gargamel kernel: [1512998.243415] ftdi_sio 2-1.6.1:1.0: device disconnected
> Mar 28 02:28:21 gargamel kernel: [1512998.341221] blk_update_request: I/O error, dev sdi, sector 11721044992 op 0x0:(READ) flags 0x0 p
> (...)
> Mar 28 02:28:22 gargamel kernel: [1512998.716351] blk_update_request: I/O error, dev sdi, sector 2058 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> Mar 28 02:28:22 gargamel kernel: [1512998.716362] blk_update_request: I/O error, dev sdi, sector 2059 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> 
> Ok, one drive died, but raid5 continues degraded.
> md7 : active raid5 sdi1[5](F) sdo1[7] sdg1[6] sdj1[3] sdh1[1]
>       23441561600 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUUU_]
>       bitmap: 0/44 pages [0KB], 65536KB chunk
> 
> not sure what these were:
> Mar 29 00:00:08 gargamel kernel: [1590505.415665] bcache: bch_count_backing_io_errors() md7: Read-ahead I/O failed on backing device, ignore
> Mar 29 00:00:09 gargamel kernel: [1590505.866094] bcache: bch_count_backing_io_errors() md7: Read-ahead I/O failed on backing device, ignore

Readahead can fail for a number of reasons that aren't real problems,
e.g. if it's necessary to swap or evict pages to do the readahead,
the kernel doesn't bother, and fails the readahead operation instead.
Another common case is lower layers of block IO stack, where a readahead
request can't be satisfied because of some geometry constraint specific
to one device in a multi-device LV.  e.g.  a drive is no longer present
so it can't receive block IO requests.

Normally readahead errors are ignored.  If there's a real problem,
the application will issue a normal read later on and the error will be
reported then.  Or the readahead might have been entirely speculative,
but the app never tries to read the data at all.

> 9H later a 2nd drive dies just when I'm replacing the failed one:
> Mar 29 09:30:12 gargamel kernel: [1624709.301830] sd 6:1:5:0: [sdh] tag#523 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> Mar 29 09:30:12 gargamel kernel: [1624709.331812] sd 6:1:5:0: [sdh] tag#523 CDB: Read(16) 88 00 00 00 00 00 00 26 3f d0 00 00 00 18 00 00
> Mar 29 09:30:12 gargamel kernel: [1624709.359459] blk_update_request: I/O error, dev sdh, sector 2506704 op 0x0:(READ) flags 0x0 phys_seg 3 prio class 0
> Mar 29 09:30:12 gargamel kernel: [1624709.359465] md/raid:md7: read error not correctable (sector 2504656 on sdh1).
> Mar 29 09:30:12 gargamel kernel: [1624709.359471] md/raid:md7: read error not correctable (sector 2504664 on sdh1).
> Mar 29 09:30:12 gargamel kernel: [1624709.359472] md/raid:md7: read error not correctable (sector 2504672 on sdh1).
> Mar 29 09:30:12 gargamel kernel: [1624709.359486] md/raid:md7: read error not correctable (sector 2504656 on sdh1).
> Mar 29 09:30:12 gargamel kernel: [1624709.455886] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.681637] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.695785] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.717624] md/raid:md7: read error not correctable (sector 2504664 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624709.739746] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.757206] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.770348] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.790298] md/raid:md7: read error not correctable (sector 2504672 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624709.812546] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.825856] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.839006] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.866656] md/raid:md7: read error not correctable (sector 24815552 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624709.898796] md/raid:md7: read error not correctable (sector 24815552 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624709.921135] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.934315] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.947500] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624709.988589] md/raid:md7: read error not correctable (sector 1763985936 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624710.036204] md/raid:md7: read error not correctable (sector 1763985936 on sdh1).
> Mar 29 09:30:13 gargamel kernel: [1624710.059121] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624710.088858] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624710.102026] md: super_written gets error=10
> Mar 29 09:30:13 gargamel kernel: [1624710.158830] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.096055] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:36:37 gargamel kernel: [1625094.122910] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
> Mar 29 09:36:37 gargamel kernel: [1625094.153249] md/raid:md7: read error not correctable (sector 6562801616 on sdh1).
> Mar 29 09:36:37 gargamel kernel: [1625094.176011] md/raid:md7: read error not correctable (sector 6562801624 on sdh1).
> Mar 29 09:36:37 gargamel kernel: [1625094.223351] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.250628] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.263726] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.276989] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.290121] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.303267] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.325084] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.342083] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.355206] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.368394] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.383304] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.396423] md: super_written gets error=10
> Mar 29 09:36:37 gargamel kernel: [1625094.409498] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:36:37 gargamel kernel: [1625094.436355] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
> Mar 29 09:36:37 gargamel kernel: [1625094.466729] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:36:37 gargamel kernel: [1625094.493600] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
> Mar 29 09:36:37 gargamel kernel: [1625094.523998] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:36:38 gargamel kernel: [1625094.550938] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 4, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.066422] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.093309] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 5, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.124768] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.151651] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 6, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.182803] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.209677] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 7, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.239972] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.266862] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 8, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.297234] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.324094] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 9, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.354422] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.381286] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 10, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.411926] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.438770] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 11, flush 0, corrupt 0, gen 0
> Mar 29 09:37:34 gargamel kernel: [1625151.469361] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:34 gargamel kernel: [1625151.496269] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 12, flush 0, corrupt 0, gen 0
> Mar 29 09:37:35 gargamel kernel: [1625151.527455] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:35 gargamel kernel: [1625151.554360] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 13, flush 0, corrupt 0, gen 0
> Mar 29 09:37:35 gargamel kernel: [1625151.584963] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
> Mar 29 09:37:35 gargamel kernel: [1625151.611842] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 14, flush 0, corrupt 0, gen 0
> 
> 24 seconds are lost before btrfs notices anything, and then it seems to
> continue without going read only for another full minute before things
> stopped.
> 
> Why would the raid5 not go read only immediately after 2 drives are lost?

Once a degraded array has an IO failure, mdadm assumes you're in
a data-scraping recovery mode and simply passes errors through.
bcache does something similar when the backing store fails.

btrfs is the agent that has to stop attempting writes, and make sure
any transaction in progress doesn't get committed.  ext4 has similar
responsibility and implements its own force-read-only feature.

I note that btrfs is reporting only read errors here.

There's a possibility that the drive dropped the writes during the
bus reset at the start of the second drive failure.  If write caching
was enabled in the drive, and the drive has a firmware bug that drops
the write cache contents (or it's just failing hardware, i.e. the CPU
running the drive firmware is getting killed by electrical problems on the
controller board, causing both the bus drop and the loss of write cache
contents), then writes in the drive's cache could be lost _after_ mdadm,
bcache and btrfs had been told by the drive that they were completed.

If the failing drive also reorders cached writes across flush
commands, then we go directly to parent transid verify failed in btrfs.
Parent transid verification is designed to detect this exact firmware
failure mode, and it usually works as intended.  It's a pretty direct
and reliable signal that write ordering is broken in a lower level of
the storage stack, and must be fixed or disabled before trying again.

Even if a single drive doesn't reorder writes, multiple drives in
raid effectively reorder writes between drives as each drive has its
own distinct write queue.  A dropped write that would be harmless in a
single-device filesystem could be harmful in a multi-device array as the
non-failing drives will have writes that occurred after the lost writes
on the failing drive.  Normally mdadm enforces flush ordering across all
component devices so that this isn't a problem, but if you have optimistic
firmware and a drive failure after the flush command returns success,
the inter-drive ordering enforcement fails and the result is the same
as if an individual drive had a write/flush reordering bug.

Firmware bugs are fairly rare across drive models, but failing drive
models are vastly overrepresented in the field.  I've tested hundreds
of firmware revisions and only about 4% fail with bad write reordering.
The few firmwares that do fail are found in popular low-end consumer
drives and cheap enterprise drives (they're the same drive underneath,
just a different label and price), so there are a lot of bad drives in
the field.  Once we identify a bad firmware revision, we avoid buying
any more of it, disable write caching in the firmware on the drives
we already have, and try to find a workload for the drive that is less
sensitive to failure (or performance--fsync latency goes up when the
drive can't use its cache for writes).

Some years ago we did a fleetwide audit of bad firmware drives and
found about a third of our drives were bad.  We disabled write cache on
all affected drives and prioritized replacement of the affected models.
This stopped the worst btrfs problems we had been having up to that point.
It also stopped a lot of strange one-off application data corruptions we
had been chasing for years before on ext4/mdadm arrays and in postgresql
databases.  We'd assumed those were some kind of application bug, but
we never found an app bug, and the problem disappeared once we turned
off the write cache.

> > If we don't have any intact subvol trees (or the subvol trees we really
> > want aren't intact), then we can't recover this way.  Instead we'd have
> > to scrape the disk looking for metadata leaf nodes, and try to reinsert
> > those into a new tree structure.  The trick here is that we'll have the
> > duplicated and inconsitent nodes and we won't have some nodes at all,
> > and we'll have to make sense of those (or pass it to the existing btrfs
> > check and hope it can cope with them).  I'm guessing that a simplified
> > version of this is what Josef is building at this point, or will be
> > building soon if we aren't extremely lucky and find an intact subvol tree.
> > After building an intact subvol tree (even with a few garbage items in it
> > as long as check can handle them) we can go back to the --init-extent-tree
> > step and rebuild the rest of the filesystem.
> 
> I see. In that case, I'm still happy to help, to help improve the tools, but if
> I'm looking at some amount of non trivial loss/corruption, at soe point
> I'll go back to backups, since they'll be more intact than this now
> damaged filesystem.

Yeah, experimental recovery code is fun, but robust backups and a working
disaster recovery plan is usually better.  Even if the filesystem is
up and running again, I'd want to compare all the files against backups
because I'd trust nothing on a filesystem after fsck touched it.

On the other hand, if you get lucky and the filesystem isn't too badly
damaged, then comparing the data with backups will be more convenient
than starting over with a new filesystem.

> Thanks for the detailed answers.
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
