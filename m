Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38592213D94
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCQas (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 12:30:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCQar (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 12:30:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2117AB98;
        Fri,  3 Jul 2020 16:30:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE1A0DA87C; Fri,  3 Jul 2020 18:30:28 +0200 (CEST)
Date:   Fri, 3 Jul 2020 18:30:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/23] Change data reservations to use the ticketing infra
Message-ID: <20200703163028.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 30, 2020 at 09:58:58AM -0400, Josef Bacik wrote:
> We've had two different things in place to reserve data and metadata space,
> because generally speaking data is much simpler.  However the data reservations
> still suffered from the same issues that plagued metadata reservations, you
> could get multiple tasks racing in to get reservations.  This causes problems
> with cases like write/delete loops where we should be able to fill up the fs,
> delete everything, and go again.  You would sometimes race with a flusher that's
> trying to unpin the free space, take it's reservations, and then it would fail.
> 
> Fix this by moving the data reservations under the metadata ticketing
> infrastructure.  This gets rid of that problem, and simplifies our enospc code
> more by consolidating it into a single path.  Thanks,

I created a for-next-20200703 snapshot with this branch included, and it
went up to generic/102 and got stuck due to softlockups. This could mean
the machine is overloaded but it usually recovers from that, while not
in this case as it took more than 7 hours before I killed the VM.

There is the dio-iomap so the patchsets could interact in some way, I'll
do more tests next week, this is an early warning that something might
be going on.

generic/102             [02:56:08][11376.253779] run fstests generic/102 at 2020-07-03 02:56:08
[11376.582218] BTRFS info (device vda): disk space caching is enabled
[11376.585713] BTRFS info (device vda): has skinny extents
[11376.692139] BTRFS: device fsid 55b09ca8-60e8-4488-8fa0-3ff05c3e6906 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (5196)
[11376.717361] BTRFS info (device vdb): disk space caching is enabled
[11376.720437] BTRFS info (device vdb): has skinny extents
[11376.722974] BTRFS info (device vdb): flagging fs with big metadata feature
[11376.731535] BTRFS info (device vdb): checking UUID tree
[11436.612816] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/u8:17:8005]
[11436.615341] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes dm_flakey dm_mod dax btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compres
[11436.621957] irq event stamp: 0
[11436.623062] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[11436.624882] hardirqs last disabled at (0): [<ffffffff9a07fd9b>] copy_process+0x67b/0x1b00
[11436.627545] softirqs last  enabled at (0): [<ffffffff9a07fd9b>] copy_process+0x67b/0x1b00
[11436.630161] softirqs last disabled at (0): [<0000000000000000>] 0x0
[11436.631919] CPU: 1 PID: 8005 Comm: kworker/u8:17 Tainted: G             L    5.8.0-rc3-default+ #1173
[11436.634311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[11436.637193] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
[11436.638878] RIP: 0010:__slab_alloc+0x5c/0x70
[11436.644622] RSP: 0018:ffffbc1dc60f7cd0 EFLAGS: 00000246
[11436.645961] RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000120001
[11436.647989] RDX: ffffa2a70b349cc0 RSI: ffffffff9a262774 RDI: ffffffff9a2639ba
[11436.649924] RBP: 0000000000000d40 R08: ffffa2a76d1cf138 R09: 0000000000000001
[11436.652014] R10: 0000000000000000 R11: ffffa2a76d1cec10 R12: ffffa2a76d1cf138
[11436.654134] R13: 00000000ffffffff R14: ffffffffc0149633 R15: ffffdc1dbf802b50
[11436.656186] FS:  0000000000000000(0000) GS:ffffa2a77d800000(0000) knlGS:0000000000000000
[11436.658920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11436.660679] CR2: 00005641be0178b8 CR3: 0000000041011002 CR4: 0000000000160ee0
[11436.662693] Call Trace:
[11436.663642]  ? start_transaction+0x133/0x5e0 [btrfs]
[11436.664991]  kmem_cache_alloc+0x1a2/0x2f0
[11436.666248]  start_transaction+0x133/0x5e0 [btrfs]
[11436.667733]  flush_space+0x315/0x670 [btrfs]
[11436.669116]  btrfs_async_reclaim_data_space+0xd8/0x1a0 [btrfs]
[11436.670853]  process_one_work+0x22c/0x600
[11436.672182]  worker_thread+0x50/0x3b0
[11436.673436]  ? process_one_work+0x600/0x600
[11436.674675]  kthread+0x137/0x150
[11436.675795]  ? kthread_stop+0x2a0/0x2a0
[11436.677099]  ret_from_fork+0x1f/0x30
