Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50383831
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHFRrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 13:47:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfHFRrH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 13:47:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65A26AED0;
        Tue,  6 Aug 2019 17:47:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CF71DA7D7; Tue,  6 Aug 2019 19:47:34 +0200 (CEST)
Date:   Tue, 6 Aug 2019 19:47:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
Message-ID: <20190806174733.GP28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190725061222.9581-1-wqu@suse.com>
 <20190725061222.9581-4-wqu@suse.com>
 <20190806135818.GK28208@twin.jikos.cz>
 <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ee4b55b-8453-e07f-70dc-fa56eb15e0ad@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 06, 2019 at 10:04:51PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/8/6 下午9:58, David Sterba wrote:
> > On Thu, Jul 25, 2019 at 02:12:20PM +0800, Qu Wenruo wrote:
> >>  
> >>  	if (!first_key)
> >>  		return 0;
> >> +	/* We have @first_key, so this @eb must have at least one item */
> >> +	if (btrfs_header_nritems(eb) == 0) {
> >> +		btrfs_err(fs_info,
> >> +		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> >> +			  eb->start);
> >> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> +		return -EUCLEAN;
> >> +	}
> > 
> > generic/015 complains:
> > 
> > generic/015             [13:51:40][ 5949.416657] run fstests generic/015 at 2019-08-06 13:51:40
> 
> I hit this once, but not this test case.
> The same backtrace for csum tree.
> 
> Have you ever hit it again?

Yes I found a few more occurences, the last one seems to be interesting so it's
pasted as-is.

generic/449

[21423.875017]  read_block_for_search+0x144/0x380 [btrfs]
[21423.876433]  btrfs_search_slot+0x297/0xfc0 [btrfs]
[21423.877830]  ? btrfs_update_delayed_refs_rsv+0x59/0x70 [btrfs]
[21423.880038]  btrfs_lookup_csum+0xa9/0x210 [btrfs]
[21423.881304]  btrfs_csum_file_blocks+0x205/0x800 [btrfs]
[21423.882674]  ? unpin_extent_cache+0x27/0xc0 [btrfs]
[21423.884050]  add_pending_csums+0x50/0x70 [btrfs]
[21423.885285]  btrfs_finish_ordered_io+0x403/0x7b0 [btrfs]
[21423.886781]  ? _raw_spin_unlock_bh+0x30/0x40
[21423.888164]  normal_work_helper+0xe2/0x520 [btrfs]
[21423.889521]  process_one_work+0x22f/0x5b0
[21423.890332]  worker_thread+0x50/0x3b0
[21423.891001]  ? process_one_work+0x5b0/0x5b0
[21423.892025]  kthread+0x11a/0x130

generic/511

[45857.582982]  read_block_for_search+0x144/0x380 [btrfs]
[45857.584197]  btrfs_search_slot+0x297/0xfc0 [btrfs]
[45857.585363]  ? btrfs_update_delayed_refs_rsv+0x59/0x70 [btrfs]
[45857.586758]  btrfs_lookup_csum+0xa9/0x210 [btrfs]
[45857.587919]  btrfs_csum_file_blocks+0x205/0x800 [btrfs]
[45857.589023]  ? unpin_extent_cache+0x27/0xc0 [btrfs]
[45857.590311]  add_pending_csums+0x50/0x70 [btrfs]
[45857.591482]  btrfs_finish_ordered_io+0x403/0x7b0 [btrfs]
[45857.592671]  ? _raw_spin_unlock_bh+0x30/0x40
[45857.593759]  normal_work_helper+0xe2/0x520 [btrfs]
[45857.595274]  process_one_work+0x22f/0x5b0
[45857.596372]  worker_thread+0x50/0x3b0
[45857.597221]  ? process_one_work+0x5b0/0x5b0
[45857.598438]  kthread+0x11a/0x130

generic/129

[ 7512.874839] BTRFS info (device vda): disk space caching is enabled
[ 7512.877660] BTRFS info (device vda): has skinny extents
[ 7512.951947] BTRFS: device fsid 815ae95d-a328-472d-8299-a373d67af54e devid 1 transid 5 /dev/vdb
[ 7512.969169] BTRFS info (device vdb): turning on discard
[ 7512.971138] BTRFS info (device vdb): disk space caching is enabled
[ 7512.973506] BTRFS info (device vdb): has skinny extents
[ 7512.975497] BTRFS info (device vdb): flagging fs with big metadata feature
[ 7513.005926] BTRFS info (device vdb): checking UUID tree
[ 7513.395115] ------------[ cut here ]------------
[ 7513.395120] BTRFS error (device vdb): invalid tree nritems, bytenr=30736384 nritems=0 expect >0
[ 7513.395122] ------------[ cut here ]------------
[ 7513.395124] BTRFS error (device vdb): invalid tree nritems, bytenr=30736384 nritems=0 expect >0
[ 7513.395125] ------------[ cut here ]------------
[ 7513.395185] WARNING: CPU: 1 PID: 17085 at fs/btrfs/disk-io.c:417 btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.395186] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet [last unloaded: scsi_debug]
[ 7513.395193] CPU: 1 PID: 17085 Comm: kworker/u8:4 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 7513.395194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 7513.395212] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 7513.395230] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.395232] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
[ 7513.395232] RSP: 0018:ffffab1286483ab8 EFLAGS: 00010246
[ 7513.395233] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000000000001
[ 7513.395234] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa00d1ca8
[ 7513.395235] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000000000000
[ 7513.395235] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[ 7513.395247] R13: ffffab1286483b6e R14: ffff9d4f2267aaf0 R15: 0000000000000000
[ 7513.395251] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) knlGS:0000000000000000
[ 7513.395252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7513.395253] CR2: 00007f5d921edef4 CR3: 0000000014011000 CR4: 00000000000006e0
[ 7513.395254] Call Trace:
[ 7513.395277]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
[ 7513.395300]  btrfs_search_slot+0x25d/0xc10 [btrfs]
[ 7513.395325]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
[ 7513.395330]  ? kmem_cache_alloc+0x1f2/0x280
[ 7513.395354]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
[ 7513.395378]  add_pending_csums+0x50/0x70 [btrfs]
[ 7513.395403]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
[ 7513.395432]  normal_work_helper+0xd1/0x540 [btrfs]
[ 7513.395437]  process_one_work+0x22d/0x580
[ 7513.395440]  worker_thread+0x50/0x3b0
[ 7513.395443]  kthread+0xfe/0x140
[ 7513.395446]  ? process_one_work+0x580/0x580
[ 7513.395447]  ? kthread_park+0x80/0x80
[ 7513.395452]  ret_from_fork+0x24/0x30
[ 7513.395454] irq event stamp: 0
[ 7513.395457] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 7513.395461] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.395463] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.395465] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 7513.395466] ---[ end trace f6f3adf90f4ea411 ]---
[ 7513.395470] ------------[ cut here ]------------
[ 7513.395471] BTRFS: Transaction aborted (error -117)
[ 7513.395528] WARNING: CPU: 1 PID: 17085 at fs/btrfs/inode.c:3175 btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
[ 7513.395529] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet [last unloaded: scsi_debug]
[ 7513.395540] CPU: 1 PID: 17085 Comm: kworker/u8:4 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 7513.395542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 7513.395570] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 7513.395588] RIP: 0010:btrfs_finish_ordered_io+0x781/0x7f0 [btrfs]
[ 7513.395590] Code: e9 aa fc ff ff 49 8b 47 50 f0 48 0f ba a8 e8 33 00 00 02 72 17 41 83 fd fb 74 5b 44 89 ee 48 c7 c7 08 b4 48 c0 e8 22 55 c9 df <0f> 0b 44 89 e9 ba 67 0c 00 00 eb b0 88 5c 24 10 41 89 de 41 bd fb
[ 7513.395592] RSP: 0018:ffffab1286483d90 EFLAGS: 00010286
[ 7513.395593] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[ 7513.395594] RDX: 0000000000000002 RSI: 0000000000000001 RDI: ffffffffa00d1ca8
[ 7513.395596] RBP: ffff9d4f573d8c80 R08: 0000000000000000 R09: 0000000000000000
[ 7513.395597] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d4f06120e80
[ 7513.395598] R13: 00000000ffffff8b R14: ffff9d4f03e85000 R15: ffff9d4f57763750
[ 7513.395603] FS:  0000000000000000(0000) GS:ffff9d4f7d800000(0000) knlGS:0000000000000000
[ 7513.395605] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7513.395606] CR2: 00007f5d921edef4 CR3: 0000000014011000 CR4: 00000000000006e0
[ 7513.395607] Call Trace:
[ 7513.395638]  normal_work_helper+0xd1/0x540 [btrfs]
[ 7513.395642]  process_one_work+0x22d/0x580
[ 7513.395645]  worker_thread+0x50/0x3b0
[ 7513.395648]  kthread+0xfe/0x140
[ 7513.395651]  ? process_one_work+0x580/0x580
[ 7513.395653]  ? kthread_park+0x80/0x80
[ 7513.395656]  ret_from_fork+0x24/0x30
[ 7513.395658] irq event stamp: 0
[ 7513.395659] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 7513.395662] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.395665] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.395666] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 7513.395668] ---[ end trace f6f3adf90f4ea412 ]---
[ 7513.395671] BTRFS: error (device vdb) in btrfs_finish_ordered_io:3175: errno=-117 unknown
[ 7513.395674] BTRFS info (device vdb): forced readonly
[ 7513.396527] WARNING: CPU: 3 PID: 2709 at fs/btrfs/disk-io.c:417 btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.399117] WARNING: CPU: 2 PID: 29478 at fs/btrfs/disk-io.c:417 btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.400326] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet [last unloaded: scsi_debug]
[ 7513.402828] Modules linked in: dm_snapshot dm_bufio dm_log_writes dm_flakey dm_mod btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop af_packet [last unloaded: scsi_debug]
[ 7513.404136] CPU: 3 PID: 2709 Comm: kworker/u8:8 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 7513.406553] CPU: 2 PID: 29478 Comm: kworker/u8:14 Tainted: G        W         5.3.0-rc3-next-20190806-default #5
[ 7513.411174] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 7513.413441] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 7513.413464] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 7513.415124] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[ 7513.416431] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.416433] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
[ 7513.417412] RIP: 0010:btrfs_verify_level_key.cold+0x1e/0x2b [btrfs]
[ 7513.420742] RSP: 0000:ffffab1283b83ab8 EFLAGS: 00010246
[ 7513.421912] Code: ff ff e8 9f c8 ff ff e9 4d 58 f5 ff 48 8b 13 48 c7 c6 48 9c 48 c0 48 89 ef e8 88 c8 ff ff 48 c7 c7 c0 95 48 c0 e8 c0 e9 c6 df <0f> 0b 41 be 8b ff ff ff e9 dd 5a f5 ff be e9 05 00 00 48 c7 c7 40
[ 7513.423177] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000000000001
[ 7513.423178] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa00d040b
[ 7513.424570] RSP: 0018:ffffab1287043ab8 EFLAGS: 00010246
[ 7513.426005] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000000000000
[ 7513.427876] RAX: 0000000000000024 RBX: ffff9d4f06a493b0 RCX: 0000000000000001
[ 7513.429411] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[ 7513.429412] R13: ffffab1283b83b6e R14: ffff9d4f47b27150 R15: 0000000000000000
[ 7513.430963] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa00d040b
[ 7513.432092] FS:  0000000000000000(0000) GS:ffff9d4f7da00000(0000) knlGS:0000000000000000
[ 7513.433535] RBP: ffff9d4f069d4000 R08: 0000000000000000 R09: 0000000000000000
[ 7513.434145] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7513.434146] CR2: 00007f907ab328e0 CR3: 000000007d2cb000 CR4: 00000000000006e0
[ 7513.435037] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[ 7513.435038] R13: ffffab1287043b6e R14: ffff9d4f61e75af0 R15: 0000000000000000
[ 7513.436009] Call Trace:
[ 7513.436973] FS:  0000000000000000(0000) GS:ffff9d4f7dc00000(0000) knlGS:0000000000000000
[ 7513.437892]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
[ 7513.438806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7513.439932]  btrfs_search_slot+0x25d/0xc10 [btrfs]
[ 7513.441229] CR2: 00007f5d91fa7e40 CR3: 000000007d2cb000 CR4: 00000000000006e0
[ 7513.442323]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
[ 7513.442994] Call Trace:
[ 7513.443764]  ? kmem_cache_alloc+0x1f2/0x280
[ 7513.444346]  read_block_for_search.isra.0+0x13d/0x3d0 [btrfs]
[ 7513.445182]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
[ 7513.445815]  btrfs_search_slot+0x25d/0xc10 [btrfs]
[ 7513.446570]  add_pending_csums+0x50/0x70 [btrfs]
[ 7513.447126]  btrfs_lookup_csum+0x6a/0x160 [btrfs]
[ 7513.448462]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
[ 7513.450730]  ? kmem_cache_alloc+0x1f2/0x280
[ 7513.452643]  normal_work_helper+0xd1/0x540 [btrfs]
[ 7513.454315]  btrfs_csum_file_blocks+0x198/0x6f0 [btrfs]
[ 7513.455379]  process_one_work+0x22d/0x580
[ 7513.456451]  add_pending_csums+0x50/0x70 [btrfs]
[ 7513.457570]  worker_thread+0x50/0x3b0
[ 7513.460066]  btrfs_finish_ordered_io+0x3cb/0x7f0 [btrfs]
[ 7513.463658]  kthread+0xfe/0x140
[ 7513.465743]  normal_work_helper+0xd1/0x540 [btrfs]
[ 7513.467701]  ? process_one_work+0x580/0x580
[ 7513.467703]  ? kthread_park+0x80/0x80
[ 7513.468978]  process_one_work+0x22d/0x580
[ 7513.470096]  ret_from_fork+0x24/0x30
[ 7513.473537]  worker_thread+0x50/0x3b0
[ 7513.474525] irq event stamp: 0
[ 7513.475631]  kthread+0xfe/0x140
[ 7513.477203] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 7513.477207] hardirqs last disabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.479011]  ? process_one_work+0x580/0x580
[ 7513.480541] softirqs last  enabled at (0): [<ffffffffa005ff00>] copy_process+0x6d0/0x1ac0
[ 7513.480542] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 7513.482354]  ? kthread_park+0x80/0x80
[ 7513.484191] ---[ end trace f6f3adf90f4ea413 ]---
[ 7513.591444]  ret_from_fork+0x24/0x30
[ 7513.592257] irq event stamp: 13768774
[ 7513.592975] hardirqs last  enabled at (13768773): [<ffffffffa06575b9>] _raw_spin_unlock_irq+0x29/0x40
[ 7513.594386] hardirqs last disabled at (13768774): [<ffffffffa064fb7e>] __schedule+0xae/0x830
[ 7513.595732] softirqs last  enabled at (13768770): [<ffffffffa0a0035c>] __do_softirq+0x35c/0x45c
[ 7513.597472] softirqs last disabled at (13768759): [<ffffffffa006a713>] irq_exit+0xb3/0xc0
