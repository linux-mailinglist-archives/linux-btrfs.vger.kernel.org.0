Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BDD57F915
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiGYFli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:41:37 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFCA7658
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:41:35 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 3FC2D45463A; Mon, 25 Jul 2022 01:41:34 -0400 (EDT)
Date:   Mon, 25 Jul 2022 01:41:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Message-ID: <Yt4tDieKURNGuysK@hungrycats.org>
References: <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
 <Yt3dLAZQk1QGhVo2@hungrycats.org>
 <5f8d4e01-5ede-6f0f-aa86-3337e8e5ecb1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8d4e01-5ede-6f0f-aa86-3337e8e5ecb1@gmx.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 08:25:44AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/7/25 08:00, Zygo Blaxell wrote:
> > On Tue, Jul 19, 2022 at 09:19:21AM +0800, Qu Wenruo wrote:
> > > > > > Doing so we don't need any disk format change and it would be backward compatible.
> > > > 
> > > > Do we need to implement RAID56 in the traditional sense? As the
> > > user/sysadmin I care about redundancy and performance and cost. The
> > > option to create redundancy for any 'n drives is appealing from a cost
> > > perspective, otherwise I'd use RAID1/10.
> > > 
> > > Have you heard any recent problems related to dm-raid56?
> > > 
> > > If your answer is no, then I guess we already have an  answer to your
> > > question.
> > 
> > With plain dm-raid56 the problems were there since the beginning, so
> > they're not recent.
> 
> Are you talking about mdraid? They go internal write-intent bitmap and
> PPL by default.

resync is the default for mdadm raid5, not PPL.  Write-intent and PPL
are mutually exclusive options.  mdadm raid5 doesn't default to bitmap
either.  (Verified with mdadm v4.2 - 2021-12-30).

> >  If there's a way to configure PPL or a journal
> > device with raid5 LVs on LVM, I can't find it.
> 
> LVM is another story.
> 
> >  AFAIK nobody who knows
> > what they're doing would choose dm-raid56 for high-value data, especially
> > when alternatives like ZFS exist.
> 
> Isn't it the opposite? mdraid is what most people go, other than LVM raid.

You said dm-raid, so I thought we were talking about dm-raid here.
It's a different interface to the core mdadm raid code, so the practical
differences between dm-raid and md-raid for most users are in what lvm
exposes (or does not expose).

> > Before btrfs, we had a single-digit-percentage rate of severe data losses
> > (more than 90% data lost) on filesystems and databases using mdadm +
> > ext3/4 with no journal in degraded mode.  Multiply by per-drive AFR
> > and that's a lot of full system rebuilds over the years.
> > 
> > > > Since the current RAID56 mode have several important drawbacks
> > > 
> > > Let me to be clear:
> > > 
> > > If you can ensure you didn't hit power loss, or after a power loss do a
> > > scrub immediately before any new write, then current RAID56 is fine, at
> > > least not obviously worse than dm-raid56.
> > 
> > I'm told that scrub doesn't repair parity errors on btrfs.
> 
> That's totally untrue.
> 
> You can easily verify that using "btrfs check --check-data-csum", as
> recent btrfs-progs has the extra code to verify the rebuilt data using
> parity.
> 
> In fact, I'm testing my write-intent bitmaps code with manually
> corrupted parity to emulate a power loss after write-intent bitmaps update.
> 
> And I must say, the scrub code works as expected.

That's good, but if it's true, it's a (welcome) change since last week.
Every time I've run a raid5 repair test with a single corrupted disk,
there has been some lost data, both from scrub and reads.  5.18.12 today
behaves the way I'm used to, with read repair unable to repair csum
errors and scrub leaving a few uncorrected blocks behind.

> The myth may come from some bad advice on only scrubbing a single device
> for RAID56 to avoid duplicated IO.
> 
> But the truth is, if only scrubbing one single device, for data stripes
> on that device, if no csum error detected, scrub won't check the parity
> or the other data stripes in the same vertical stripe.
> 
> On the other hand, if scrub is checking the parity stripe, it will also
> check the csum for the data stripes in the same vertical stripe, and
> rewrite the parity if needed.
> 
> >  That was a
> > thing I got wrong in my raid5 bug list from 2020.  Scrub will fix data
> > blocks if they have csum errors, but it will not detect or correct
> > corruption in the parity blocks themselves.
> 
> That's exactly what I mentioned, the user is trying to be a smartass
> without knowing the details.
> 
> Although I think we should enhance the man page to discourage the usage
> of single device scrub.

If we have something better to replace it now, sure.  The reason for
running the scrub on devices sequentially was because it behaved so
terribly when the per-device threads ran in parallel.  If scrub is now
behaving differently on raid56 then the man page should be updated to
reflect that.

> By default, we scrub all devices (using mount point).

The scrub userspace code enumerates the devices and runs a separate
thread to scrub each one.  Running them on one device at a time makes
those threads run sequentially instead of in parallel, and avoids a
lot of bad stuff with competing disk accesses and race conditions.
See below for a recent example.

> >  AFAICT the only way to
> > get the parity blocks rewritten is to run something like balance,
> > which carries risks of its own due to the sheer volume of IO from
> > data and metadata updates.
> 
> Completely incorrect.

And yet consistent with testing evidence going back 6 years so far.

If scrub works, it should be possible to corrupt one drive, scrub,
then corrupt the other drive, scrub again, and have zero errors
and zero kernel crashes.  Instead:

	# mkfs.btrfs -draid5 -mraid1 -f /dev/vdb /dev/vdc
	# mount -ospace_cache=v2,compress=zstd /dev/vdb /testfs
	# cp -a /testdata/. /testfs/. &  # 40TB of files, average size 23K

	[...wait a few minutes for some data, we don't need the whole thing...]

	# compsize /testfs/.
	Processed 15271 files, 7901 regular extents (7909 refs), 6510 inline.
	Type       Perc     Disk Usage   Uncompressed Referenced  
	TOTAL       73%      346M         472M         473M       
	none       100%      253M         253M         253M       
	zstd        42%       92M         219M         219M       

	# cat /dev/zero > /dev/vdb
	# sync
	# btrfs scrub start /dev/vdb  # or '/testfs', doesn't matter
	# cat /dev/zero > /dev/vdc
	# sync

	# btrfs scrub start /dev/vdc  # or '/testfs', doesn't matter
	ERROR: there are uncorrectable errors
	# btrfs scrub status -d .
	UUID:             8237e122-35af-40ef-80bc-101693e878e3

	Scrub device /dev/vdb (id 1)
		no stats available

	Scrub device /dev/vdc (id 2) history
	Scrub started:    Mon Jul 25 00:02:25 2022
	Status:           finished
	Duration:         0:00:22
	Total to scrub:   2.01GiB
	Rate:             1.54MiB/s
	Error summary:    csum=1690
	  Corrected:      1032
	  Uncorrectable:  658
	  Unverified:     0
	# cat /proc/version
	Linux version 5.19.0-ba37a9d53d71-for-next+ (zblaxell@tester) (gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #82 SMP PREEMPT_DYNAMIC Sun Jul 24 15:12:57 EDT 2022

Running scrub threads in parallel sometimes triggers stuff like this,
which killed one of the test runs while I was writing this:

	[ 1304.696921] BTRFS info (device vdb): read error corrected: ino 411 off 135168 (dev /dev/vdb sector 3128840)
	[ 1304.697705] BTRFS info (device vdb): read error corrected: ino 411 off 139264 (dev /dev/vdb sector 3128848)
	[ 1304.701196] ==================================================================
	[ 1304.716463] ------------[ cut here ]------------
	[ 1304.717094] BUG: KFENCE: use-after-free read in free_io_failure+0x157/0x210

	[ 1304.723346] kernel BUG at fs/btrfs/extent_io.c:2350!
	[ 1304.725076] Use-after-free read at 0x000000001e0043a6 (in kfence-#228):
	[ 1304.725103]  free_io_failure+0x157/0x210
	[ 1304.725115]  clean_io_failure+0x11d/0x260
	[ 1304.725126]  end_compressed_bio_read+0x2a9/0x470
	[ 1304.727698] invalid opcode: 0000 [#1] PREEMPT SMP PTI
	[ 1304.729516]  bio_endio+0x361/0x3c0
	[ 1304.731048] CPU: 1 PID: 12615 Comm: kworker/u8:10 Not tainted 5.19.0-ba37a9d53d71-for-next+ #82 d82f965b2e84525cfbba07129899b46c497cda69
	[ 1304.733084]  rbio_orig_end_io+0x127/0x1c0
	[ 1304.736876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[ 1304.738720]  __raid_recover_end_io+0x405/0x8f0
	[ 1304.740310] Workqueue: btrfs-endio btrfs_end_bio_work
	[ 1304.748199]  raid_recover_end_io_work+0x8c/0xb0

	[ 1304.750028] RIP: 0010:repair_io_failure+0x359/0x4b0
	[ 1304.752434]  process_one_work+0x4e5/0xaa0
	[ 1304.752449]  worker_thread+0x32e/0x720
	[ 1304.754214] Code: 2b e8 2b 2f 79 ff 48 c7 c6 70 06 ac 91 48 c7 c7 00 b9 14 94 e8 38 00 73 ff 48 8d bd 48 ff ff ff e8 8c 7a 26 00 e9 f6 fd ff ff <0f> 0b e8 10 be 5e 01 85 c0 74 cc 48 c7 c7 f0 1c 45 94 e8 30 ab 98
	[ 1304.756561]  kthread+0x1ab/0x1e0
	[ 1304.758398] RSP: 0018:ffffa429c6adbb10 EFLAGS: 00010246
	[ 1304.759278]  ret_from_fork+0x22/0x30

	[ 1304.761343] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000

	[ 1304.762308] kfence-#228: 0x00000000cc0e17b4-0x0000000004ce48de, size=48, cache=kmalloc-64

	[ 1304.763692] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
	[ 1304.764649] allocated by task 12615 on cpu 1 at 1304.670070s:
	[ 1304.765617] RBP: ffffa429c6adbc08 R08: 0000000000000000 R09: 0000000000000000
	[ 1304.766421]  btrfs_repair_one_sector+0x370/0x500
	[ 1304.767638] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9108baaec000
	[ 1304.768341]  end_compressed_bio_read+0x187/0x470
	[ 1304.770163] R13: 0000000000000000 R14: ffffe44885d55040 R15: ffff9108114e66a4
	[ 1304.770993]  bio_endio+0x361/0x3c0
	[ 1304.772226] FS:  0000000000000000(0000) GS:ffff9109b7200000(0000) knlGS:0000000000000000
	[ 1304.773128]  btrfs_end_bio_work+0x1f/0x30
	[ 1304.773914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 1304.774856]  process_one_work+0x4e5/0xaa0
	[ 1304.774869]  worker_thread+0x32e/0x720
	[ 1304.775172] CR2: 00007fb7a88c1738 CR3: 00000000bc03e002 CR4: 0000000000170ee0
	[ 1304.776397]  kthread+0x1ab/0x1e0
	[ 1304.776429]  ret_from_fork+0x22/0x30
	[ 1304.778282] Call Trace:

	[ 1304.779009] freed by task 21948 on cpu 2 at 1304.694620s:
	[ 1304.781760]  <TASK>
	[ 1304.782419]  free_io_failure+0x19a/0x210
	[ 1304.783213]  ? __bio_clone+0x1c0/0x1c0
	[ 1304.783952]  clean_io_failure+0x11d/0x260
	[ 1304.783963]  end_compressed_bio_read+0x2a9/0x470
	[ 1304.784263]  clean_io_failure+0x21a/0x260
	[ 1304.785674]  bio_endio+0x361/0x3c0
	[ 1304.785995]  end_compressed_bio_read+0x2a9/0x470
	[ 1304.787645]  btrfs_end_bio_work+0x1f/0x30
	[ 1304.788597]  bio_endio+0x361/0x3c0
	[ 1304.789674]  process_one_work+0x4e5/0xaa0
	[ 1304.790786]  btrfs_end_bio_work+0x1f/0x30
	[ 1304.791776]  worker_thread+0x32e/0x720
	[ 1304.791788]  kthread+0x1ab/0x1e0
	[ 1304.792895]  process_one_work+0x4e5/0xaa0
	[ 1304.793882]  ret_from_fork+0x22/0x30
	[ 1304.795043]  worker_thread+0x32e/0x720

	[ 1304.795802] CPU: 3 PID: 12616 Comm: kworker/u8:11 Not tainted 5.19.0-ba37a9d53d71-for-next+ #82 d82f965b2e84525cfbba07129899b46c497cda69
	[ 1304.796945]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
	[ 1304.797662] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[ 1304.798453]  ? process_one_work+0xaa0/0xaa0
	[ 1304.799175] Workqueue: btrfs-endio-raid56 raid_recover_end_io_work
	[ 1304.799739]  kthread+0x1ab/0x1e0

	[ 1304.801288] ==================================================================
	[ 1304.801873]  ? kthread_complete_and_exit+0x40/0x40
	[ 1304.809362] ==================================================================
	[ 1304.809933]  ret_from_fork+0x22/0x30
	[ 1304.809977]  </TASK>
	[ 1304.809982] Modules linked in:
	[ 1304.810068] ---[ end trace 0000000000000000 ]---
	[ 1304.810079] RIP: 0010:repair_io_failure+0x359/0x4b0
	[ 1304.810092] Code: 2b e8 2b 2f 79 ff 48 c7 c6 70 06 ac 91 48 c7 c7 00 b9 14 94 e8 38 00 73 ff 48 8d bd 48 ff ff ff e8 8c 7a 26 00 e9 f6 fd ff ff <0f> 0b e8 10 be 5e 01 85 c0 74 cc 48 c7 c7 f0 1c 45 94 e8 30 ab 98
	[ 1304.810114] RSP: 0018:ffffa429c6adbb10 EFLAGS: 00010246
	[ 1304.810125] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
	[ 1304.810133] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
	[ 1304.810140] RBP: ffffa429c6adbc08 R08: 0000000000000000 R09: 0000000000000000
	[ 1304.810149] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9108baaec000
	[ 1304.810157] R13: 0000000000000000 R14: ffffe44885d55040 R15: ffff9108114e66a4
	[ 1304.810165] FS:  0000000000000000(0000) GS:ffff9109b7200000(0000) knlGS:0000000000000000
	[ 1304.810175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 1304.810184] CR2: 00007fb7a88c1738 CR3: 00000000bc03e002 CR4: 0000000000170ee0
	[ 1304.903432] BUG: KFENCE: invalid free in free_io_failure+0x19a/0x210

	[ 1304.906815] Invalid free of 0x00000000cc0e17b4 (in kfence-#228):
	[ 1304.909006]  free_io_failure+0x19a/0x210
	[ 1304.909666]  clean_io_failure+0x11d/0x260
	[ 1304.910358]  end_compressed_bio_read+0x2a9/0x470
	[ 1304.911121]  bio_endio+0x361/0x3c0
	[ 1304.911722]  rbio_orig_end_io+0x127/0x1c0
	[ 1304.912405]  __raid_recover_end_io+0x405/0x8f0
	[ 1304.919917]  raid_recover_end_io_work+0x8c/0xb0
	[ 1304.927494]  process_one_work+0x4e5/0xaa0
	[ 1304.934191]  worker_thread+0x32e/0x720
	[ 1304.940524]  kthread+0x1ab/0x1e0
	[ 1304.945963]  ret_from_fork+0x22/0x30

	[ 1304.953057] kfence-#228: 0x00000000cc0e17b4-0x0000000004ce48de, size=48, cache=kmalloc-64

	[ 1304.955733] allocated by task 12615 on cpu 1 at 1304.670070s:
	[ 1304.957225]  btrfs_repair_one_sector+0x370/0x500
	[ 1304.958574]  end_compressed_bio_read+0x187/0x470
	[ 1304.959937]  bio_endio+0x361/0x3c0
	[ 1304.960960]  btrfs_end_bio_work+0x1f/0x30
	[ 1304.962193]  process_one_work+0x4e5/0xaa0
	[ 1304.963403]  worker_thread+0x32e/0x720
	[ 1304.965498]  kthread+0x1ab/0x1e0
	[ 1304.966515]  ret_from_fork+0x22/0x30

	[ 1304.968681] freed by task 21948 on cpu 2 at 1304.694620s:
	[ 1304.970160]  free_io_failure+0x19a/0x210
	[ 1304.971725]  clean_io_failure+0x11d/0x260
	[ 1304.973082]  end_compressed_bio_read+0x2a9/0x470
	[ 1304.974277]  bio_endio+0x361/0x3c0
	[ 1304.975245]  btrfs_end_bio_work+0x1f/0x30
	[ 1304.976623]  process_one_work+0x4e5/0xaa0
	[ 1304.979141]  worker_thread+0x32e/0x720
	[ 1304.980044]  kthread+0x1ab/0x1e0
	[ 1304.981002]  ret_from_fork+0x22/0x30

	[ 1304.982520] CPU: 2 PID: 12616 Comm: kworker/u8:11 Tainted: G    B D           5.19.0-ba37a9d53d71-for-next+ #82 d82f965b2e84525cfbba07129899b46c497cda69
	[ 1304.986522] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[ 1304.988636] Workqueue: btrfs-endio-raid56 raid_recover_end_io_work
	[ 1304.990234] ==================================================================

On kernels without KASAN or page poisoning, that use-after-free might lead
to a hang at the end of a btrfs replace.  I don't know exactly what's
going on there--there is often a hang at the end of a raid5 replace,
it's caused by a mismatch between the count of active bios and the actual
number of active bios, and a use-after-free might be causing that by
forgetting to decrement the counter.  There are multiple overlapping
bugs in btrfs raid5 and it's hard to reliably separate them until some
of them get fixed.

Another data point:  I ran 5 test runs while writing this, and the third
one did fix all the errors in scrub.  It sometimes does happen over test
cases of a few gigabytes.  It's just not anywhere near reliable enough
to fix a 50TB array with one busted disk.

I think you need better test cases.  btrfs raid5 has been broken like this
since the beginning, with failures that can be demonstrated in minutes.
btrfs raid1 can run these tests all day.

> > Most of the raid56 bugs I've identified have nothing to do with power
> > loss.  The data on disks is fine, but the kernel can't read it correctly
> > in degraded mode, or the diagnostic data from scrub are clearly garbage.
> 
> Unable to read in degraded mode just means parity is out-of-sync with data.

No, the degraded mode case is different.  It has distinct behavior from
the above test case where all the drives are online but csums are failing.
In degraded mode one of the devices is unavailable, so the read code
is trying to reconstruct data on the fly.  The parity and data on disk
is often OK on the surviving disks if I dump it out by hand, and often
all the data can be recovered by 'btrfs replace' without error (as
long as 'btrfs replace' is the only active process on the filesystem).

Rebooting the test VM will make a different set of data unreadable
through the filesystem, and the set of unreadable blocks changes over
time if running something like:

	sysctl vm.drop_caches=3; find -type f -exec cat {} + >/dev/null

in a loop, especially if something is writing to the filesystem at the
same time.  Note there is never a write hole in these test cases--the
filesystem is always cleanly umounted, and sometimes there's no umount
at all, one device is simply disconnected with no umount or reboot.

> There are several other bugs related to this, mostly related to the
> cached raid bio and how we rebuild the data. (aka, btrfs/125)
> Thankfully I have submitted patches for that bug and now btrfs/125
> should pass without problems.

xfstests btrfs/125 is an extremely simple test case.  I'm using btrfs
raid5 on 20-80TB filesystems, millions to billions of files.  The error
rate is quantitatively low (only 0.01% of data is lost after one disk
failure) but it should be zero, as none of my test cases involve write
hole, nodatacow, or raid5 metadata.

for-next and misc-next are still quite broken, though to be fair they
definitely have issues beyond raid5.  5.18.12 can get through the
test without tripping over KASAN or blowing up the metadata, but it
has uncorrectable errors and fake read errors:

	# btrfs scrub start -Bd /testfs/

	Scrub device /dev/vdb (id 1) done
	Scrub started:    Mon Jul 25 00:49:28 2022
	Status:           finished
	Duration:         0:03:03
	Total to scrub:   4.01GiB
	Rate:             1.63MiB/s
	Error summary:    read=3 csum=7578
	  Corrected:      7577
	  Uncorrectable:  4
	  Unverified:     1

I know the read errors are fake because /dev/vdb is a file on a tmpfs.

> But the powerloss can still lead to out-of-sync parity and that's why
> I'm fixing the problem using write-intent-bitmaps.

None of my test cases involve write hole, as I know write-hole test cases
will always fail.  There's no point in testing write hole if recovery
from much simpler failures isn't working yet.

> > I noticed you and others have done some work here recently, so some of
> > these issues might be fixed in 5.19.  I haven't re-run my raid5 tests
> > on post-5.18 kernels yet (there have been other bugs blocking testing).
> > 
> > > (There are still common problems shared between both btrfs raid56 and
> > > dm-raid56, like destructive-RMW)
> > 
> > Yeah, that's one of the critical things to fix because btrfs is in a good
> > position to do as well or better than dm-raid56.  btrfs has definitely
> > fallen behind the other available solutions in the 9 years since raid5 was
> > first added to btrfs, as btrfs implements only the basic configuration
> > of raid56 (no parity integrity or rmw journal) that is fully vulnerable
> > to write hole and drive-side data corruption.
> > 
> > > > - and that it's officially not recommended for production use - it
> > > is a good idea to reconstruct new btrfs 'redundant-n' profiles that
> > > doesn't have the inherent issues of traditional RAID.
> > > 
> > > I'd say the complexity is hugely underestimated.
> > 
> > I'd agree with that.  e.g. some btrfs equivalent of ZFS raidZ (put parity
> > blocks inline with extents during writes) is not much more complex to
> > implement on btrfs than compression; however, the btrfs kernel code
> > couldn't read compressed data correctly for 12 years out of its 14-year
> > history, and nobody wants to wait another decade or more for raid5
> > to work.
> > 
> > It seems to me the biggest problem with write hole fixes is that all
> > the potential fixes have cost tradeoffs, and everybody wants to veto
> > the fix that has a cost they don't like.
> 
> Well, that's why I prefer multiple solutions for end users to choose,
> other than really trying to get a silver bullet solution.
> 
> (That's also why I'm recently trying to separate block group tree from
> extent tree v2, as I really believe progressive improvement over a death
> ball feature)

Yeah I'm definitely in favor of getting bgtree done sooner rather
than later.  It's a simple, stand-alone feature that has well known
beneficial effect.  If the extent tree v2 project wants to do something
incompatible with it later on, that's extent tree v2's problem, not a
reason to block bgtree in the short term.

> Thanks,
> Qu
> 
> > 
> > We could implement multiple fix approaches at the same time, as AFAIK
> > most of the proposed solutions are orthogonal to each other.  e.g. a
> > write-ahead log can safely enable RMW at a higher IO cost, while the
> > allocator could place extents to avoid RMW and thereby avoid the logging
> > cost as much as possible (paid for by a deferred relocation/garbage
> > collection cost), and using both at the same time would combine both
> > benefits.  Both solutions can be used independently for filesystems at
> > extreme ends of the performance/capacity spectrum (if the filesystem is
> > never more than 50% full, then logging is all cost with no gain compared
> > to allocator avoidance of RMW, while a filesystem that is always near
> > full will have to journal writes and also throttle writes on the journal.
> > 
> > > > For example a non-striped redundant-n profile as well as a striped redundant-n profile.
> > > 
> > > Non-striped redundant-n profile is already so complex that I can't
> > > figure out a working idea right now.
> > > 
> > > But if there is such way, I'm pretty happy to consider.
> > > 
> > > > 
> > > > > 
> > > > > My 2 cents...
> > > > > 
> > > > > Regarding the current raid56 support, in order of preference:
> > > > > 
> > > > > a. Fix the current bugs, without changing format. Zygo has an extensive list.
> > > > 
> > > > I agree that relatively simple fixes should be made. But it seems we will need quite a large rewrite to solve all issues? Is there a minium viable option here?
> > > 
> > > Nope. Just see my write-intent code, already have prototype (just needs
> > > new scrub based recovery code at mount time) working.
> > > 
> > > And based on my write-intent code, I don't think it's that hard to
> > > implement a full journal.
> > 
> > FWIW I think we can get a very usable btrfs raid5 with a small format
> > change (add a journal for stripe RMW, though we might disagree about
> > details of how it should be structured and used) and fixes to the
> > read-repair and scrub problems.  The read-side problems in btrfs raid5
> > were always much more severe than the write hole.  As soon as a disk
> > goes offline, the read-repair code is unable to read all the surviving
> > data correctly, and the filesystem has to be kept inactive or data on
> > the disks will be gradually corrupted as bad parity gets mixed with data
> > and written back to the filesystem.
> > 
> > A few of the problems will require a deeper redesign, but IMHO they're not
> > important problems.  e.g. scrub can't identify which drive is corrupted
> > in all cases, because it has no csum on parity blocks.  The current
> > on-disk format needs every data block in the raid5 stripe to be occupied
> > by a file with a csum so scrub can eliminate every other block as the
> > possible source of mismatched parity.  While this could be fixed by
> > a future new raid5 profile (and/or csum tree) specifically designed
> > to avoid this, it's not something I'd insist on having before deploying
> > a fleet of btrfs raid5 boxes.  Silent corruption failures are so
> > rare on spinning disks that I'd use the feature maybe once a decade.
> > Silent corruption due to a failing or overheating HBA chip will most
> > likely affect multiple disks at once and trash the whole filesystem,
> > so individual drive-level corruption reporting isn't helpful.
> > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > > b. Mostly fix the write hole, also without changing the format, by
> > > > > only doing COW with full stripe writes. Yes you could somehow get
> > > > > corrupt parity still and not know it until degraded operation produces
> > > > > a bad reconstruction of data - but checksum will still catch that.
> > > > > This kind of "unreplicated corruption" is not quite the same thing as
> > > > > the write hole, because it isn't pernicious like the write hole.
> > > > 
> > > > What is the difference to a)? Is write hole the worst issue? Judging from the #brtfs channel discussions there seems to be other quite severe issues, for example real data corruption risks in degraded mode.
> > > > 
> > > > > c. A new de-clustered parity raid56 implementation that is not
> > > > > backwards compatible.
> > > > 
> > > > Yes. We have a good opportunity to work out something much better than current implementations. We could have  redundant-n profiles that also works with tired storage like ssd/nvme similar to the metadata on ssd idea.
> > > > 
> > > > Variable stripe width has been brought up before, but received cool responses. Why is that? IMO it could improve random 4k ios by doing equivalent to RAID1 instead of RMW, while also closing the write hole. Perhaps there is a middle ground to be found?
> > > > 
> > > > 
> > > > > 
> > > > > Ergo, I think it's best to not break the format twice. Even if a new
> > > > > raid implementation is years off.
> > > > 
> > > > I very agree here. Btrfs already suffers in public opinion from the lack of a stable and safe-for-data RAID56, and requiring several non-compatible chances isn't going to help.
> > > > 
> > > > I also think it's important that the 'temporary' changes actually leads to a stable filesystem. Because what is the point otherwise?
> > > > 
> > > > Thanks
> > > > Forza
> > > > 
> > > > > 
> > > > > Metadata centric workloads suck on parity raid anyway. If Btrfs always
> > > > > does full stripe COW won't matter even if the performance is worse
> > > > > because no one should use parity raid for this workload anyway.
> > > > > 
> > > > > 
> > > > > --
> > > > > Chris Murphy
> > > > 
> > > > 
> 
