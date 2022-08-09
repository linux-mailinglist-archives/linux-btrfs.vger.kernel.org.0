Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7458E073
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbiHITrg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 9 Aug 2022 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbiHITqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 15:46:43 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8300DE5
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 12:46:42 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id F078E490603; Tue,  9 Aug 2022 15:46:41 -0400 (EDT)
Date:   Tue, 9 Aug 2022 15:46:41 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Message-ID: <YvK5oY6ctbDFspCm@hungrycats.org>
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <aac1dade-646a-8bf9-6b63-754b03bf1cd1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <aac1dade-646a-8bf9-6b63-754b03bf1cd1@gmx.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 12:36:44PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/8/9 11:31, Zygo Blaxell wrote:
> > Test case is:
> > 
> > 	- start with a -draid5 -mraid1 filesystem on 2 disks
> > 
> > 	- run assorted IO with a mix of reads and writes (randomly
> > 	run rsync, bees, snapshot create/delete, balance, scrub, start
> > 	replacing one of the disks...)
> > 
> > 	- cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
> > 	blkdiscard on the underlying SSD in the VM host, to simulate
> > 	single-disk data corruption
> > 
> > 	- repeat until something goes badly wrong, like unrecoverable
> > 	read error or crash
> > 
> > This test case always failed quickly before (corruption was rarely
> > if ever fully repaired on btrfs raid5 data), and it still doesn't work
> > now, but now it doesn't work for a new reason.  Progress?
> 
> The new read repair work for compressed extents, adding HCH to the thread.
> 
> But just curious, have you tested without compression?

All of the ~200 BUG_ON stack traces in my logs have the same list of
functions as above.  If the bug affected uncompressed data, I'd expect
to see two different stack traces.  It's a fairly decent sample size,
so I'd say it's most likely not happening with uncompressed extents.

All the production workloads have compression enabled, so we don't
normally test with compression disabled.  I can run a separate test for
that if you'd like.

> Thanks,
> Qu
> > 
> > There is now a BUG_ON arising from this test case:
> > 
> > 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks suppressed
> > 	[  241.100910][   T45] ------------[ cut here ]------------
> > 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
> > 	[  241.103261][   T45] invalid opcode: 0000 [#2] PREEMPT SMP PTI
> > 	[  241.104044][   T45] CPU: 2 PID: 45 Comm: kworker/u8:4 Tainted: G      D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b1f12383cf0d5e6b898
> > 	[  241.105652][   T45] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > 	[  241.106726][   T45] Workqueue: btrfs-endio-raid56 raid_recover_end_io_work
> > 	[  241.107716][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
> > 	[  241.108569][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
> > 	7 c7 b0 1d 45 88 e8 d0 8e 98
> > 	[  241.111990][   T45] RSP: 0018:ffffbca9009f7a08 EFLAGS: 00010246
> > 	[  241.112911][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > 	[  241.115676][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > 	[  241.118009][   T45] RBP: ffffbca9009f7b00 R08: 0000000000000000 R09: 0000000000000000
> > 	[  241.119484][   T45] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9cd1b9da4000
> > 	[  241.120717][   T45] R13: 0000000000000000 R14: ffffe60cc81a4200 R15: ffff9cd235b4dfa4
> > 	[  241.122594][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600000(0000) knlGS:0000000000000000
> > 	[  241.123831][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	[  241.125003][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR4: 0000000000170ee0
> > 	[  241.126226][   T45] Call Trace:
> > 	[  241.126646][   T45]  <TASK>
> > 	[  241.127165][   T45]  ? __bio_clone+0x1c0/0x1c0
> > 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
> > 	[  241.128384][   T45]  end_compressed_bio_read+0x2a9/0x470
> > 	[  241.128411][   T45]  bio_endio+0x361/0x3c0
> > 	[  241.128427][   T45]  rbio_orig_end_io+0x127/0x1c0
> > 	[  241.128447][   T45]  __raid_recover_end_io+0x405/0x8f0
> > 	[  241.128477][   T45]  raid_recover_end_io_work+0x8c/0xb0
> > 	[  241.128494][   T45]  process_one_work+0x4e5/0xaa0
> > 	[  241.128528][   T45]  worker_thread+0x32e/0x720
> > 	[  241.128541][   T45]  ? _raw_spin_unlock_irqrestore+0x7d/0xa0
> > 	[  241.128573][   T45]  ? process_one_work+0xaa0/0xaa0
> > 	[  241.128588][   T45]  kthread+0x1ab/0x1e0
> > 	[  241.128600][   T45]  ? kthread_complete_and_exit+0x40/0x40
> > 	[  241.128628][   T45]  ret_from_fork+0x22/0x30
> > 	[  241.128659][   T45]  </TASK>
> > 	[  241.128667][   T45] Modules linked in:
> > 	[  241.129700][   T45] ---[ end trace 0000000000000000 ]---
> > 	[  241.152310][   T45] RIP: 0010:repair_io_failure+0x359/0x4b0
> > 	[  241.153328][   T45] Code: 2b e8 cb 12 79 ff 48 c7 c6 20 23 ac 85 48 c7 c7 00 b9 14 88 e8 d8 e3 72 ff 48 8d bd 48 ff ff ff e8 5c 7e 26 00 e9 f6 fd ff ff <0f> 0b e8 60 d1 5e 01 85 c0 74 cc 48 c
> > 	7 c7 b0 1d 45 88 e8 d0 8e 98
> > 	[  241.156882][   T45] RSP: 0018:ffffbca902487a08 EFLAGS: 00010246
> > 	[  241.158103][   T45] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > 	[  241.160072][   T45] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > 	[  241.161984][   T45] RBP: ffffbca902487b00 R08: 0000000000000000 R09: 0000000000000000
> > 	[  241.164067][   T45] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9cd1b9da4000
> > 	[  241.165979][   T45] R13: 0000000000000000 R14: ffffe60cc7589740 R15: ffff9cd1f45495e4
> > 	[  241.167928][   T45] FS:  0000000000000000(0000) GS:ffff9cd2b7600000(0000) knlGS:0000000000000000
> > 	[  241.169978][   T45] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	[  241.171649][   T45] CR2: 00007fbb76b1a738 CR3: 0000000109c26001 CR4: 0000000000170ee0
> > 
> > KFENCE and UBSAN aren't reporting anything before the BUG_ON.
> > 
> > KCSAN complains about a lot of stuff as usual, including several issues
> > in the btrfs allocator, but it doesn't look like anything that would
> > mess with a bio.
> > 
> > 	$ git log --no-walk --oneline FETCH_HEAD
> > 	6130a25681d4 (kdave/for-next) Merge branch 'for-next-next-v5.20-20220804' into for-next-20220804
> > 
> > 	repair_io_failure at fs/btrfs/extent_io.c:2350 (discriminator 1)
> > 	 2345           u64 sector;
> > 	 2346           struct btrfs_io_context *bioc = NULL;
> > 	 2347           int ret = 0;
> > 	 2348
> > 	 2349           ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
> > 	>2350<          BUG_ON(!mirror_num);
> > 	 2351
> > 	 2352           if (btrfs_repair_one_zone(fs_info, logical))
> > 	 2353                   return 0;
> > 	 2354
> > 	 2355           map_length = length;
