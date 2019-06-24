Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0A506BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfFXKBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 06:01:34 -0400
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:53286
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbfFXKBd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 06:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1561370491;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=gJ4CpB+lWP+4sMfQ56TYjoNJRdnbkMQ65SURTxQKSNQ=;
        b=jzr8Vg7BRW9CszVSgccm4yUSDYlDZLO0JxYhcuVYWzZEEHsoSbWfJYB0inbDL4cA
        n0fqcW3EinvOE5xlJH+267BG8P4MFLA5/rJqjP11hxmHxFMkeUlWVXflhKwx2fU3OFm
        pePDHClXL5eavTlh+MViy1Ro1opPJ3yDbEDMRRVU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1561370491;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=gJ4CpB+lWP+4sMfQ56TYjoNJRdnbkMQ65SURTxQKSNQ=;
        b=bjnYw6/xAGMrSn/zqxlxkdcIubxrloFPRffAxfu2uStTEemnwRr4M6l6LQ79KVz2
        DlchHa4D5S26/cmVNpnZIkj9L6o+fX1ObrZpQLvVD7gRnlkE7NxcXu+nm38LEmNK7cf
        5eF/mBn9NAzoIjRrQj0UpQESw3o/0mJp27HK6W54=
Subject: Re: Global reserve and ENOSPC while deleting snapshots on 5.0.9 -
 still happens on 5.1.11
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190423230649.GB11530@hungrycats.org>
 <20190623141434.GB11831@hungrycats.org>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016b88eef8ed-42aa5e72-7483-4c58-9555-5b1991a0da5e-000000@eu-west-1.amazonses.com>
Date:   Mon, 24 Jun 2019 10:01:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190623141434.GB11831@hungrycats.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.06.24-54.240.4.15
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've fixed the same problem(s) by increasing the global metadata size as
well. Though I haven't encountered them since Josef Bacik's block rsv
rework in 5.0.
Another problem with increasing the global metadata size is, that I
think it is the only way dirty metadata is throttled. If increased too
much (as a percentage of RAM) the system goes OOM depending on work
load. As far as I can see dirty metdata isn't included into the
dirty_ratio calculation as well, causing issues on that front as well.
Another thing that I think helps is to run with "nodatasum" -- probably
because then less metadata needs to be changed when deleting.

On 23.06.2019 16:14 Zygo Blaxell wrote:
> On Tue, Apr 23, 2019 at 07:06:51PM -0400, Zygo Blaxell wrote:
>> I had a test filesystem that ran out of unallocated space, then ran
>> out of metadata space during a snapshot delete, and forced readonly.
>> The workload before the failure was a lot of rsync and bees dedupe
>> combined with random snapshot creates and deletes.
> Had this happen again on a production filesystem, this time on 5.1.11,
> and it happened during orphan inode cleanup instead of snapshot delete:
>
> 	[14303.076134][T20882] BTRFS: error (device dm-21) in add_to_free_space_tree:1037: errno=-28 No space left
> 	[14303.076144][T20882] BTRFS: error (device dm-21) in __btrfs_free_extent:7196: errno=-28 No space left
> 	[14303.076157][T20882] BTRFS: error (device dm-21) in btrfs_run_delayed_refs:3008: errno=-28 No space left
> 	[14303.076203][T20882] BTRFS error (device dm-21): Error removing orphan entry, stopping orphan cleanup
> 	[14303.076210][T20882] BTRFS error (device dm-21): could not do orphan cleanup -22
> 	[14303.076281][T20882] BTRFS error (device dm-21): commit super ret -30
> 	[14303.357337][T20882] BTRFS error (device dm-21): open_ctree failed
>
> Same fix:  I bumped the reserved size limit from 512M to 2G and mounted
> normally.  (OK, technically, I booted my old 5.0.21 kernel--but my 5.0.21
> kernel has the 2G reserved space patch below in it.)
>
> I've not been able to repeat this ENOSPC behavior under test conditions
> in the last two months of trying, but it's now happened twice in different
> places, so it has non-zero repeatability.
>
>> I tried the usual fix strategies:
>>
>> 	1.  Immediately after mount, try to balance to free space for
>> 	metadata
>>
>> 	2.  Immediately after mount, add additional disks to provide
>> 	unallocated space for metadata
>>
>> 	3.  Mount -o nossd to increase metadata density
>>
>> #3 had no effect.  #1 failed consistently.
>>
>> #2 was successful, but the additional space was not used because
>> btrfs couldn't allocate chunks for metadata because it ran out of
>> metadata space for new metadata chunks.
>>
>> When btrfs-cleaner tried to remove the first pending deleted snapshot,
>> it started a transaction that failed due to lack of metadata space.
>> Since the transaction failed, the filesystem reverts to its earlier state,
>> and exactly the same thing happens on the next mount.  The 'btrfs dev
>> add' in #2 is successful only if it is executed immediately after mount,
>> before the btrfs-cleaner thread wakes up.
>>
>> Here's what the kernel said during one of the attempts:
>>
>> 	[41263.822252] BTRFS info (device dm-3): use zstd compression, level 0
>> 	[41263.825135] BTRFS info (device dm-3): using free space tree
>> 	[41263.827319] BTRFS info (device dm-3): has skinny extents
>> 	[42046.463356] ------------[ cut here ]------------
>> 	[42046.463387] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: errno=-28 No space left
>> 	[42046.463404] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: errno=-28 No space left
>> 	[42046.463407] BTRFS info (device dm-3): forced readonly
>> 	[42046.463414] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011: errno=-28 No space left
>> 	[42046.463429] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10517: errno=-28 No space left
>> 	[42046.463548] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10520: errno=-28 No space left
>> 	[42046.471363] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011: errno=-28 No space left
>> 	[42046.471475] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10517: errno=-28 No space left
>> 	[42046.471506] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10520: errno=-28 No space left
>> 	[42046.473672] BTRFS: error (device dm-3) in btrfs_drop_snapshot:9489: errno=-28 No space left
>> 	[42046.475643] WARNING: CPU: 0 PID: 10187 at fs/btrfs/extent-tree.c:7056 __btrfs_free_extent+0x364/0xf60
>> 	[42046.475645] Modules linked in: mq_deadline bfq dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio joydev ppdev crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel dm_mod snd_pcm aesni_intel aes_x86_64 snd_timer crypto_simd cryptd glue_helper sr_mod snd cdrom psmouse sg soundcore input_leds pcspkr serio_raw ide_pci_generic i2c_piix4 bochs_drm parport_pc piix rtc_cmos floppy parport pcc_cpufreq ide_core qemu_fw_cfg evbug evdev ip_tables x_tables ipv6 crc_ccitt autofs4
>> 	[42046.475677] CPU: 0 PID: 10187 Comm: btrfs-transacti Tainted: G    B   W         5.0.8-zb64-10a85e8a1569+ #1
>> 	[42046.475678] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> 	[42046.475681] RIP: 0010:__btrfs_free_extent+0x364/0xf60
>> 	[42046.475684] Code: 50 f0 48 0f ba a8 90 22 00 00 02 72 1f 8b 85 88 fe ff ff 83 f8 fb 0f 84 59 04 00 00 89 c6 48 c7 c7 00 85 be b8 e8 3c 1b 9b ff <0f> 0b 8b 8d 88 fe ff ff 48 8b bd 90 fe ff ff ba 90 1b 00 00 48 c7
>> 	[42046.475685] RSP: 0018:ffff888103d8f8e0 EFLAGS: 00010282
>> 	[42046.475688] RAX: 0000000000000000 RBX: ffff88802d9ce370 RCX: ffffffffb7224ca2
>> 	[42046.475689] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88811960dfac
>> 	[42046.475691] RBP: ffff888103d8fa98 R08: ffffed10232c24c1 R09: ffffed10232c24c0
>> 	[42046.475693] R10: ffff888025c94aeb R11: ffffed10232c24c1 R12: 0000000000a5054e
>> 	[42046.475694] R13: 0000000000003000 R14: 000000000000214a R15: ffff888103d8fa70
>> 	[42046.475696] FS:  0000000000000000(0000) GS:ffff888119400000(0000) knlGS:0000000000000000
>> 	[42046.475698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 	[42046.475700] CR2: 00007f1b84271718 CR3: 00000000a3636001 CR4: 00000000001606f0
>> 	[42046.475702] Call Trace:
>> 	[42046.475707]  ? trace_hardirqs_off+0x24/0x120
>> 	[42046.475714]  ? update_block_group+0x6d0/0x6d0
>> 	[42046.475718]  ? __lock_acquire+0xf8/0x26e0
>> 	[42046.475721]  ? __kasan_slab_free+0x14d/0x230
>> 	[42046.475724]  ? btrfs_delayed_ref_lock+0x3e/0x100
>> 	[42046.475727]  ? __lock_acquire+0xf8/0x26e0
>> 	[42046.475730]  ? kthread+0x1a9/0x200
>> 	[42046.475733]  ? debug_show_all_locks+0x210/0x210
>> 	[42046.475737]  ? __btrfs_run_delayed_refs+0xce/0x210
>> 	[42046.475742]  ? debug_show_all_locks+0x210/0x210
>> 	[42046.475747]  run_delayed_data_ref+0x15a/0x400
>> 	[42046.475752]  ? alloc_reserved_file_extent+0x520/0x520
>> 	[42046.475756]  ? rb_next+0x25/0x90
>> 	[42046.475761]  run_one_delayed_ref+0x71/0xe0
>> 	[42046.475765]  btrfs_run_delayed_refs_for_head+0x284/0x580
>> 	[42046.475772]  __btrfs_run_delayed_refs+0xeb/0x210
>> 	[42046.475777]  ? btrfs_run_delayed_refs_for_head+0x580/0x580
>> 	[42046.475781]  ? debug_show_all_locks+0x210/0x210
>> 	[42046.475786]  btrfs_run_delayed_refs+0xc0/0x260
>> 	[42046.475792]  btrfs_commit_transaction+0xf0/0x10f0
>> 	[42046.475795]  ? do_raw_spin_unlock+0xa8/0x140
>> 	[42046.475799]  ? _raw_spin_unlock+0x27/0x40
>> 	[42046.475803]  ? btrfs_record_root_in_trans+0x24/0xb0
>> 	[42046.475807]  ? btrfs_apply_pending_changes+0xb0/0xb0
>> 	[42046.475809]  ? start_transaction+0x14a/0x760
>> 	[42046.475816]  transaction_kthread+0x218/0x250
>> 	[42046.475822]  kthread+0x1a9/0x200
>> 	[42046.475824]  ? btrfs_cleanup_transaction+0xb80/0xb80
>> 	[42046.475827]  ? kthread_park+0xb0/0xb0
>> 	[42046.475831]  ret_from_fork+0x3a/0x50
>> 	[42046.475837] irq event stamp: 0
>> 	[42046.475839] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
>> 	[42046.475843] hardirqs last disabled at (0): [<ffffffffb70efe95>] copy_process.part.7+0xad5/0x3b80
>> 	[42046.475846] softirqs last  enabled at (0): [<ffffffffb70efe95>] copy_process.part.7+0xad5/0x3b80
>> 	[42046.475847] softirqs last disabled at (0): [<0000000000000000>]           (null)
>> 	[42046.475849] ---[ end trace b02d556137ea688c ]---
>> 	[42046.475852] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: errno=-28 No space left
>> 	[42046.475859] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011: errno=-28 No space left
>> 	[42046.475878] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10517: errno=-28 No space left
>> 	[42046.475905] BTRFS: error (device dm-3) in btrfs_create_pending_block_groups:10520: errno=-28 No space left
>>
>> I noticed that during the few minutes when the filesystem was running,
>> the "global reserve" number in "btrfs fi usage" output kept going up to
>> 503M or so, then the transaction failed.
>>
>> I then applied this patch to the kernel (5.0.8):
>>
>> 	diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> 	index 83791d13c204..59ba456e2314 100644
>> 	--- a/fs/btrfs/extent-tree.c
>> 	+++ b/fs/btrfs/extent-tree.c
>> 	@@ -5790,7 +5790,7 @@ static void update_global_block_rsv(struct btrfs_fs_info *fs_info)
>> 		spin_lock(&sinfo->lock);
>> 		spin_lock(&block_rsv->lock);
>>
>> 	-       block_rsv->size = min_t(u64, num_bytes, SZ_512M);
>> 	+       block_rsv->size = min_t(u64, num_bytes, SZ_1G);
>>
>> 		if (block_rsv->reserved < block_rsv->size) {
>> 			num_bytes = btrfs_space_info_used(sinfo, true);
>>
>> Then mounted the filesystem.
>>
>> With the larger reserved block size, btrfs-cleaner was able to get
>> past its earlier failures, allocating 3GB of new metadata chunks in the
>> first transaction after it started deleting snapshots.  After this, the
>> filesystem deleted some more snapshots (there are currently 2470 deleted
>> snapshots remaining on this filesystem).
>>
>> This isn't really a solution, though, for two reasons:
>>
>> 1.  The commit that adds the limit on block_rsv->size (fdf30d1c1b3
>> "Btrfs: limit the global reserve to 512mb") points out:
>>
>>     A user reported a problem where he was getting early ENOSPC with
>>     hundreds of gigs of free data space and 6 gigs of free metadata space.
>>     This is because the global block reserve was taking up the entire
>>     free metadata space.  This is ridiculous, we have infrastructure in
>>     place to throttle if we start using too much of the global reserve,
>>     so instead of letting it get this huge just limit it to 512mb so that
>>     users can still get work done.  This allowed the user to complete
>>     his rsync without issues. 
>>
>> In other words, something should be handling the case when reserved
>> space runs out, and that something is failing.
>>
>> 2.  The 1G reserved limit still isn't sufficient.  The filesystem deletes
>> a few dozen snapshots, then fails again later:
>>
>> 	[ 3705.477036] CPU: 2 PID: 8388 Comm: btrfs-transacti Tainted: G    B             5.0.9-zb64-b6eed6abc880+ #3
>> 	[ 3705.481510] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> 	[ 3705.484038] RIP: 0010:__btrfs_free_extent+0x364/0xf60
>> 	[ 3705.485061] Code: 50 f0 48 0f ba a8 90 22 00 00 02 72 1f 8b 85 88 fe ff ff 83 f8 fb 0f 84 59 04 00 00 89 c6 48 c7 c7 80 85 be 8b e8 fc 1b 9b ff <0f> 0b 8b 8d 88 fe ff ff 48 8b bd 90 fe ff ff ba 90 1b 00 00 48 c7
>> 	[ 3705.488046] RSP: 0018:ffff8881c29cf8e0 EFLAGS: 00010282
>> 	[ 3705.488868] RAX: 0000000000000000 RBX: ffff888121dbdf20 RCX: ffffffff8a224a92
>> 	[ 3705.490129] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881f5e0dfac
>> 	[ 3705.491246] RBP: ffff8881c29cfa98 R08: ffffed103ebc24c1 R09: ffffed103ebc24c0
>> 	[ 3705.492376] R10: ffff88819e6d430b R11: ffffed103ebc24c1 R12: 00000000009ecb21
>> 	[ 3705.493501] R13: 0000000000040000 R14: 00000000000021b3 R15: ffff8881c29cfa70
>> 	[ 3705.494619] FS:  0000000000000000(0000) GS:ffff8881f5c00000(0000) knlGS:0000000000000000
>> 	[ 3705.495883] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> 	[ 3705.496781] CR2: 0000556bc833ec70 CR3: 00000001ef9e0001 CR4: 00000000001606e0
>> 	[ 3705.497872] Call Trace:
>> 	[ 3705.498279]  ? update_block_group+0x6d0/0x6d0
>> 	[ 3705.498950]  ? btrfs_run_delayed_refs_for_head+0x352/0x580
>> 	[ 3705.499816]  ? kthread+0x1a9/0x200
>> 	[ 3705.500379]  ? debug_show_all_locks+0x210/0x210
>> 	[ 3705.501078]  ? __btrfs_run_delayed_refs+0xce/0x210
>> 	[ 3705.501813]  ? debug_show_all_locks+0x210/0x210
>> 	[ 3705.502516]  run_delayed_data_ref+0x15a/0x400
>> 	[ 3705.503193]  ? alloc_reserved_file_extent+0x520/0x520
>> 	[ 3705.503968]  ? rb_next+0x3c/0x90
>> 	[ 3705.504479]  run_one_delayed_ref+0x71/0xe0
>> 	[ 3705.505116]  btrfs_run_delayed_refs_for_head+0x284/0x580
>> 	[ 3705.505935]  __btrfs_run_delayed_refs+0xeb/0x210
>> 	[ 3705.506649]  ? btrfs_run_delayed_refs_for_head+0x580/0x580
>> 	[ 3705.507495]  ? debug_show_all_locks+0x210/0x210
>> 	[ 3705.508201]  btrfs_run_delayed_refs+0xc0/0x260
>> 	[ 3705.508912]  btrfs_commit_transaction+0xf0/0x10f0
>> 	[ 3705.509654]  ? do_raw_spin_unlock+0xa8/0x140
>> 	[ 3705.510343]  ? _raw_spin_unlock+0x27/0x40
>> 	[ 3705.510979]  ? btrfs_record_root_in_trans+0x24/0xb0
>> 	[ 3705.511748]  ? btrfs_apply_pending_changes+0xb0/0xb0
>> 	[ 3705.512533]  ? start_transaction+0x14a/0x760
>> 	[ 3705.513216]  transaction_kthread+0x218/0x250
>> 	[ 3705.513900]  kthread+0x1a9/0x200
>> 	[ 3705.514425]  ? btrfs_cleanup_transaction+0xb80/0xb80
>> 	[ 3705.515233]  ? kthread_park+0xb0/0xb0
>> 	[ 3705.515829]  ret_from_fork+0x3a/0x50
>> 	[ 3705.516408] irq event stamp: 0
>> 	[ 3705.516898] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
>> 	[ 3705.518054] hardirqs last disabled at (0): [<ffffffff8a0efe65>] copy_process.part.7+0xad5/0x3b80
>> 	[ 3705.519419] softirqs last  enabled at (0): [<ffffffff8a0efe65>] copy_process.part.7+0xad5/0x3b80
>> 	[ 3705.520779] softirqs last disabled at (0): [<0000000000000000>]           (null)
>> 	[ 3705.521944] ---[ end trace 3a5f720e889bc0d3 ]---
>> 	[ 3705.522713] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: errno=-28 No space left
>> 	[ 3705.524069] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011: errno=-28 No space left
>>
>> If I increase the reserved limit again to 2G, btrfs-cleaner gets past
>> this shapshot (so far).  It takes more than 10 minutes to delete some
>> of the snapshots, so this will take a while to finish all 2470.
>>
>> The current btrfs fi usage output worries me:
>>
>> 	Overall:
>> 	    Device size:                   2.02TiB
>> 	    Device allocated:              2.01TiB
>> 	    Device unallocated:           10.03GiB
>> 	    Device missing:                  0.00B
>> 	    Used:                          1.70TiB
>> 	    Free (estimated):            296.02GiB      (min: 291.01GiB)
>> 	    Data ratio:                       1.00
>> 	    Metadata ratio:                   2.00
>> 	    Global reserve:                2.00GiB      (used: 864.00KiB)
>>
>> 	Data,single: Size:1.81TiB, Used:1.53TiB
>> 	   /dev/mapper/vgnebtest-tvdb    928.97GiB
>> 	   /dev/mapper/vgnebtest-tvdc    929.00GiB
>>
>> 	Metadata,RAID1: Size:99.99GiB, Used:82.29GiB
>> 	   /dev/mapper/vgnebtest-lvol1     5.00GiB
>> 	   /dev/mapper/vgnebtest-lvol2     5.00GiB
>> 	   /dev/mapper/vgnebtest-tvdb     94.99GiB
>> 	   /dev/mapper/vgnebtest-tvdc     94.99GiB
>>
>> 	System,RAID1: Size:8.00MiB, Used:240.00KiB
>> 	   /dev/mapper/vgnebtest-tvdb      8.00MiB
>> 	   /dev/mapper/vgnebtest-tvdc      8.00MiB
>>
>> 	Unallocated:
>> 	   /dev/mapper/vgnebtest-lvol1     5.00GiB
>> 	   /dev/mapper/vgnebtest-lvol2     5.00GiB
>> 	   /dev/mapper/vgnebtest-tvdb     30.00MiB
>> 	   /dev/mapper/vgnebtest-tvdc      1.00MiB
>>
>> Note "lvol1" and "lvol2" were added after the initial failure.  
>>
>> There is clearly a lot of metadata space available, but the filesystem still
>> intermittently hits ENOSPC while trying to free space.
>

