Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A68336A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfHFN5t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 09:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfHFN5s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 09:57:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F631AD18
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2019 13:57:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CD49DA7D7; Tue,  6 Aug 2019 15:58:19 +0200 (CEST)
Date:   Tue, 6 Aug 2019 15:58:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
Message-ID: <20190806135818.GK28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725061222.9581-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 02:12:20PM +0800, Qu Wenruo wrote:
>  
>  	if (!first_key)
>  		return 0;
> +	/* We have @first_key, so this @eb must have at least one item */
> +	if (btrfs_header_nritems(eb) == 0) {
> +		btrfs_err(fs_info,
> +		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> +			  eb->start);
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		return -EUCLEAN;
> +	}

generic/015 complains:

generic/015             [13:51:40][ 5949.416657] run fstests generic/015 at 2019-08-06 13:51:40
[ 5949.603473] BTRFS: device fsid 6a7e1bd0-42d2-4bab-9d9e-791635466751 devid 1 transid 5 /dev/vdb
[ 5949.616969] BTRFS info (device vdb): turning on discard
[ 5949.619414] BTRFS info (device vdb): disk space caching is enabled
[ 5949.622493] BTRFS info (device vdb): has skinny extents
[ 5949.624694] BTRFS info (device vdb): flagging fs with big metadata feature
[ 5949.629003] BTRFS info (device vdb): checking UUID tree
[ 5949.802548] BTRFS error (device vdb): invalid tree nritems, bytenr=30736384 nritems=0 expect >0
[ 5949.806259] ------------[ cut here ]------------
[ 5949.808127] WARNING: CPU: 1 PID: 27019 at fs/btrfs/disk-io.c:417 btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 5949.811946] Modules linked in: dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet
[ 5949.816321] CPU: 1 PID: 27019 Comm: kworker/u8:10 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 5949.819269] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 5949.822202] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 5949.824231] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 5949.825348] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7
 c7 40
[ 5949.828251] RSP: 0018:ffffab1288803ab8 EFLAGS: 00010246
[ 5949.829759] RAX: 0000000000000024 RBX: ffff9d4f6ed47b10 RCX: 0000000000000001
[ 5949.830961] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa00d02ca
[ 5949.832107] RBP: ffff9d4f60568000 R08: 0000000000000000 R09: 0000000000000000
[ 5949.833414] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[ 5949.834508] R13: ffffab1288803b6e R14: ffff9d4f3325e850 R15: 0000000000000000
[ 5949.835572] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) knlGS:0000000000000000
[ 5949.837190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5949.838135] CR2: 00005645c3a0c078 CR3: 0000000014011000 CR4: 00000000000006e0
[ 5949.839197] Call Trace:
[ 5949.839729]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
[ 5949.840909]  btrfs_search_slot+0x25d/0xc10 [btrfs]
[ 5949.841796]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
[ 5949.842561]  ? kmem_cache_alloc+0x1f2/0x280
[ 5949.843268]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
[ 5949.844305]  add_pending_csums+0x50/0x70 [btrfs]
[ 5949.845553]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
[ 5949.846963]  normal_work_helper+0xd1/0x540 [btrfs]
[ 5949.848258]  process_one_work+0x22d/0x580
[ 5949.849337]  worker_thread+0x50/0x3b0
[ 5949.850361]  kthread+0xfe/0x140
[ 5949.851267]  ? process_one_work+0x580/0x580
[ 5949.852405]  ? kthread_park+0x80/0x80
[ 5949.853429]  ret_from_fork+0x24/0x30
[ 5949.854422] irq event stamp: 0
[ 5949.855341] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 5949.856688] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 5949.858104] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 5949.859400] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 5949.860611] ---[ end trace f6f3adf90f4ea40f ]---
[ 5949.862745] ------------[ cut here ]------------
[ 5949.864103] BTRFS: Transaction aborted (error -117)
[ 5949.865577] WARNING: CPU: 1 PID: 27019 at fs/btrfs/inode.c:3175 btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
[ 5949.868267] Modules linked in: dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet
[ 5949.872781] CPU: 1 PID: 27019 Comm: kworker/u8:10 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 5949.875535] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 5949.878428] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 5949.880211] RIP: 0010:btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
[ 5949.881317] Code: e9 aa fc ff ff 49 8b 47 50 f0 48 0f ba a8 e8 33 00 00 02 72 17 41 83 fd fb 74 5b 44 89 ee 48 c7 c7 08 b4 48 c0 e8 22 55 c9 df <0f> 0b 44 89 e9 ba 67 0c 00 00 eb b0 88 5c 24 10 41 89 de 41
 bd fb
