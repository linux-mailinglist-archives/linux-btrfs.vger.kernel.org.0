Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF24F6089
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiDFNdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDFNcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 09:32:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB67D38CD02
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 21:09:16 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48732 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nbwyo-00082d-6i by authid <merlins.org> with srv_auth_plain; Tue, 05 Apr 2022 21:09:14 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nbwyn-00EXde-Ue; Tue, 05 Apr 2022 21:09:13 -0700
Date:   Tue, 5 Apr 2022 21:09:13 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406040913.GE3307770@merlins.org>
References: <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org>
 <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
 <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org>
 <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykzvoz47Rvknw7aH@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 09:40:51PM -0400, Zygo Blaxell wrote:
> Based on the history, I'd expect the filesystem is missing some number
> of tree nodes, from a few dozen to thousands, depending on how many
> writes were dropped after the 2nd drive failure before it was detected.
> Since the array was also degraded at that time, with 4 drives in raid5,
> there's 3 data drives, and if one of them was offline then we'd have a 2/3
> success rate reading metadata blocks and 1/3 garbage.  That's definitely
> in the "we need to write new software to recover from this" territory.
 
I think your conclusion is correct. I'm very dismayed that the
filesystem didn't go read only right away.
Hell, the mdadm block device should have done read only as soon as it
lost more than one drive.
Why were any writes allowed once more than one drive was missing?

Let's look at this for a second:
Mar 28 02:28:11 gargamel kernel: [1512988.446844] sd 6:1:8:0: Device offlined - not ready after error recovery
Mar 28 02:28:11 gargamel kernel: [1512988.475270] sd 6:1:8:0: rejecting I/O to offline device
Mar 28 02:28:11 gargamel kernel: [1512988.491531] blk_update_request: I/O error, dev sdi, sector 261928312 op 0x0:(READ) flags 0x84700
 phys_seg 42 prio class 0
Mar 28 02:28:11 gargamel kernel: [1512988.525073] blk_update_request: I/O error, dev sdi, sector 261928824 op 0x0:(READ) flags 0x80700
 phys_seg 5 prio class 0
Mar 28 02:28:12 gargamel kernel: [1512988.579667] blk_update_request: I/O error, dev sdi, sector 261927936 op 0x0:(READ) flags 0x80700
 phys_seg 47 prio class 0
(..)
Mar 28 02:28:12 gargamel kernel: [1512988.615910] md: super_written gets error=10
Mar 28 02:28:12 gargamel kernel: [1512988.619241] md/raid:md7: Disk failure on sdi1, disabling device.
Mar 28 02:28:12 gargamel kernel: [1512988.619241] md/raid:md7: Operation continuing on 4 devices.
Mar 28 02:28:21 gargamel kernel: [1512998.170192] usb 2-1.6-port1: disabled by hub (EMI?), re-enabling...
Mar 28 02:28:21 gargamel kernel: [1512998.240404] print_req_error: 134 callbacks suppressed
Mar 28 02:28:21 gargamel kernel: [1512998.240406] blk_update_request: I/O error, dev sdi, sector 11721044992 op 0x0:(READ) flags 0x807
00 phys_seg 1 prio class 0
Mar 28 02:28:21 gargamel kernel: [1512998.243415] ftdi_sio 2-1.6.1:1.0: device disconnected
Mar 28 02:28:21 gargamel kernel: [1512998.341221] blk_update_request: I/O error, dev sdi, sector 11721044992 op 0x0:(READ) flags 0x0 p
(...)
Mar 28 02:28:22 gargamel kernel: [1512998.716351] blk_update_request: I/O error, dev sdi, sector 2058 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
Mar 28 02:28:22 gargamel kernel: [1512998.716362] blk_update_request: I/O error, dev sdi, sector 2059 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

Ok, one drive died, but raid5 continues degraded.
md7 : active raid5 sdi1[5](F) sdo1[7] sdg1[6] sdj1[3] sdh1[1]
      23441561600 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUUU_]
      bitmap: 0/44 pages [0KB], 65536KB chunk

not sure what these were:
Mar 29 00:00:08 gargamel kernel: [1590505.415665] bcache: bch_count_backing_io_errors() md7: Read-ahead I/O failed on backing device, ignore
Mar 29 00:00:09 gargamel kernel: [1590505.866094] bcache: bch_count_backing_io_errors() md7: Read-ahead I/O failed on backing device, ignore

9H later a 2nd drive dies just when I'm replacing the failed one:
Mar 29 09:30:12 gargamel kernel: [1624709.301830] sd 6:1:5:0: [sdh] tag#523 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
Mar 29 09:30:12 gargamel kernel: [1624709.331812] sd 6:1:5:0: [sdh] tag#523 CDB: Read(16) 88 00 00 00 00 00 00 26 3f d0 00 00 00 18 00 00
Mar 29 09:30:12 gargamel kernel: [1624709.359459] blk_update_request: I/O error, dev sdh, sector 2506704 op 0x0:(READ) flags 0x0 phys_seg 3 prio class 0
Mar 29 09:30:12 gargamel kernel: [1624709.359465] md/raid:md7: read error not correctable (sector 2504656 on sdh1).
Mar 29 09:30:12 gargamel kernel: [1624709.359471] md/raid:md7: read error not correctable (sector 2504664 on sdh1).
Mar 29 09:30:12 gargamel kernel: [1624709.359472] md/raid:md7: read error not correctable (sector 2504672 on sdh1).
Mar 29 09:30:12 gargamel kernel: [1624709.359486] md/raid:md7: read error not correctable (sector 2504656 on sdh1).
Mar 29 09:30:12 gargamel kernel: [1624709.455886] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.681637] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.695785] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.717624] md/raid:md7: read error not correctable (sector 2504664 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624709.739746] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.757206] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.770348] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.790298] md/raid:md7: read error not correctable (sector 2504672 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624709.812546] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.825856] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.839006] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.866656] md/raid:md7: read error not correctable (sector 24815552 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624709.898796] md/raid:md7: read error not correctable (sector 24815552 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624709.921135] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.934315] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.947500] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624709.988589] md/raid:md7: read error not correctable (sector 1763985936 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624710.036204] md/raid:md7: read error not correctable (sector 1763985936 on sdh1).
Mar 29 09:30:13 gargamel kernel: [1624710.059121] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624710.088858] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624710.102026] md: super_written gets error=10
Mar 29 09:30:13 gargamel kernel: [1624710.158830] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.096055] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:36:37 gargamel kernel: [1625094.122910] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
Mar 29 09:36:37 gargamel kernel: [1625094.153249] md/raid:md7: read error not correctable (sector 6562801616 on sdh1).
Mar 29 09:36:37 gargamel kernel: [1625094.176011] md/raid:md7: read error not correctable (sector 6562801624 on sdh1).
Mar 29 09:36:37 gargamel kernel: [1625094.223351] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.250628] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.263726] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.276989] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.290121] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.303267] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.325084] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.342083] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.355206] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.368394] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.383304] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.396423] md: super_written gets error=10
Mar 29 09:36:37 gargamel kernel: [1625094.409498] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:36:37 gargamel kernel: [1625094.436355] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Mar 29 09:36:37 gargamel kernel: [1625094.466729] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:36:37 gargamel kernel: [1625094.493600] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
Mar 29 09:36:37 gargamel kernel: [1625094.523998] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:36:38 gargamel kernel: [1625094.550938] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 4, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.066422] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.093309] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 5, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.124768] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.151651] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 6, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.182803] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.209677] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 7, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.239972] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.266862] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 8, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.297234] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.324094] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 9, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.354422] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.381286] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 10, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.411926] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.438770] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 11, flush 0, corrupt 0, gen 0
Mar 29 09:37:34 gargamel kernel: [1625151.469361] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:34 gargamel kernel: [1625151.496269] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 12, flush 0, corrupt 0, gen 0
Mar 29 09:37:35 gargamel kernel: [1625151.527455] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:35 gargamel kernel: [1625151.554360] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 13, flush 0, corrupt 0, gen 0
Mar 29 09:37:35 gargamel kernel: [1625151.584963] bcache: bch_count_backing_io_errors() md7: IO error on backing device, unrecoverable
Mar 29 09:37:35 gargamel kernel: [1625151.611842] BTRFS error (device dm-17): bdev /dev/mapper/dshelf1a errs: wr 0, rd 14, flush 0, corrupt 0, gen 0

24 seconds are lost before btrfs notices anything, and then it seems to
continue without going read only for another full minute before things
stopped.

Why would the raid5 not go read only immediately after 2 drives are lost?

> Normally, I'd expect that once we dig through a few layers of simple
> dropped write blocks, we'll start hitting metadata pages with bad csums
> and trashed contents, since the parity blocks will be garbage in the raid5
> stripes where the writes were lost.  One important data point against
> this theory is that we have not seen a csum failure yet, so maybe this
> is a different (possibly better) scenario.  Possibly some of the lost
> writes on the raid5 are still stored in the bcache, so there's few or no
> garbage blocks (though reading the array through the cache might evict
> the last copy of usable data and make some damage permanent--you might
> want to make a backup copy of the cache device).
 
Interesting, thanks.

> Backup roots only work if writes are dropped only in the most recent
> transaction, maybe two, because only these trees are guaranteed to be
> intact on disk.  After that, previously occupied pages are fair game
> for new write allocations, and old metadata will be lost.  Unlike other
> filesystems, btrfs never writes metadata in the same place twice, so when
> a write is dropped, there isn't an old copy of the data still available at
> the location of the dropped write--that location contains some completely
> unrelated piece of the metadata tree whose current version now lives
> at some other location.  Later tree updates will overwrite old copies
> of the updated page, destroying the data in the affected page forever.
> Essentially there will be a set of metadata pages where you have two
> versions of different ages, and another set of metadata pages where you
> have zero versions, and (hopefully) most of the other pages are intact.
 
I see. It's definitely a lot more complex and much more likely to break when some
amount of recent writes get lost/corrupted.

> If we have a superblock, the chunk tree, and a subvol tree, we can
> drop all the other trees and rebuild them (bonus points if the csum
> tree survived, then we can verify all the data was recovered correctly;
> otherwise, we can read all the files and make a new csum tree but it won't
> detect any data corruption that might have happened in degraded mode).
> This is roughly what 'btrfs check --init-extent-tree' does (though due
> to implementation details it has a few extra dependencies that might
> get in the way) and you can find subvol roots with btrfs-find-root.
 
Got it, thanks.

> If we don't have any intact subvol trees (or the subvol trees we really
> want aren't intact), then we can't recover this way.  Instead we'd have
> to scrape the disk looking for metadata leaf nodes, and try to reinsert
> those into a new tree structure.  The trick here is that we'll have the
> duplicated and inconsitent nodes and we won't have some nodes at all,
> and we'll have to make sense of those (or pass it to the existing btrfs
> check and hope it can cope with them).  I'm guessing that a simplified
> version of this is what Josef is building at this point, or will be
> building soon if we aren't extremely lucky and find an intact subvol tree.
> After building an intact subvol tree (even with a few garbage items in it
> as long as check can handle them) we can go back to the --init-extent-tree
> step and rebuild the rest of the filesystem.

I see. In that case, I'm still happy to help, to help improve the tools, but if
I'm looking at some amount of non trivial loss/corruption, at soe point
I'll go back to backups, since they'll be more intact than this now
damaged filesystem.

Thanks for the detailed answers.
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
