Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E0797ADC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbjIGRxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjIGRxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:53:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C61717;
        Thu,  7 Sep 2023 10:52:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BADC433CB;
        Thu,  7 Sep 2023 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104540;
        bh=UBuzMRShgw1qGwKcp5icerNaUWSaGcKJhV1zuNEabRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYQrgorUVUYtbEBnqMCJk+ppdOr7JCB+Ug4vURzNnaB6+rt6DIM+EH51CBJHQPR5T
         yYSfxUmicOlsHCdIld4Uv8yS7oQVyJsNJVu/66RcCBYpxw07ZuA5KmH3waiiwIuPIV
         6oSNm9LlVdLtv7ZgOo0Lw5/eTTUox0fZ/FctdWDXrshlwkaANbHg3RnMp0uBQ0CESu
         U2+TbLuuG+PTnroavQpwFnM5BF//nAGseNSXdyj3jSut+bAZ7vJ58oz6m0fqn6NjBR
         h1p91iPsOfVryPPs4TchcwRolehJYodDEHtVclBQx4//CTMm8xXSE16QC9KcUYVNoq
         j0u/b4NAFPyKQ==
Date:   Thu, 7 Sep 2023 17:35:37 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 3/6] btrfs: return real error when orphan
 cleanup fails due to a transaction abort
Message-ID: <ZPn72VXv1LjO0vq4@debian0.Home>
References: <20230907154338.3421582-1-sashal@kernel.org>
 <20230907154338.3421582-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907154338.3421582-3-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 11:43:34AM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit a7f8de500e28bb227e02a7bd35988cf37b816c86 ]

Please don't add this patch to any stable release.
Besides not being that important for stable, backporting it alone would not
be correct as it depends on:

   commit ae3364e5215bed9ce89db6b0c2d21eae4b66f4ae
   Author: Filipe Manana <fdmanana@suse.com>
   Date:   Wed Jul 26 16:57:04 2023 +0100

        btrfs: store the error that turned the fs into error state

Thanks.

> 
> During mount we will call btrfs_orphan_cleanup() to remove any inodes that
> were previously deleted (have a link count of 0) but for which we were not
> able before to remove their items from the subvolume tree. The removal of
> the items will happen by triggering eviction, when we do the final iput()
> on them at btrfs_orphan_cleanup(), which will end in the loop at
> btrfs_evict_inode() that truncates inode items.
> 
> In a dire situation we may have a transaction abort due to -ENOSPC when
> attempting to truncate the inode items, and in that case the orphan item
> (key type BTRFS_ORPHAN_ITEM_KEY) will remain in the subvolume tree and
> when we hit the next iteration of the while loop at btrfs_orphan_cleanup()
> we will find the same orphan item as before, and then we will return
> -EINVAL from btrfs_orphan_cleanup() through the following if statement:
> 
>     if (found_key.offset == last_objectid) {
>        btrfs_err(fs_info,
>                  "Error removing orphan entry, stopping orphan cleanup");
>        ret = -EINVAL;
>        goto out;
>     }
> 
> This makes the mount operation fail with -EINVAL, when it should have been
> -ENOSPC. This is confusing because -EINVAL might lead a user into thinking
> it provided invalid mount options for example.
> 
> An example where this happens:
> 
>    $ mount test.img /mnt
>    mount: /mnt: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
> 
>    $ dmesg
>    [ 2542.356934] BTRFS: device fsid 977fff75-1181-4d2b-a739-384fa710d16e devid 1 transid 47409973 /dev/loop0 scanned by mount (4459)
>    [ 2542.357451] BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
>    [ 2542.357461] BTRFS info (device loop0): disk space caching is enabled
>    [ 2542.742287] BTRFS info (device loop0): auto enabling async discard
>    [ 2542.764554] BTRFS info (device loop0): checking UUID tree
>    [ 2551.743065] ------------[ cut here ]------------
>    [ 2551.743068] BTRFS: Transaction aborted (error -28)
>    [ 2551.743149] WARNING: CPU: 7 PID: 215 at fs/btrfs/block-group.c:3494 btrfs_write_dirty_block_groups+0x397/0x3d0 [btrfs]
>    [ 2551.743311] Modules linked in: btrfs blake2b_generic (...)
>    [ 2551.743353] CPU: 7 PID: 215 Comm: kworker/u24:5 Not tainted 6.4.0-rc6-btrfs-next-134+ #1
>    [ 2551.743356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>    [ 2551.743357] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
>    [ 2551.743405] RIP: 0010:btrfs_write_dirty_block_groups+0x397/0x3d0 [btrfs]
>    [ 2551.743449] Code: 8b 43 0c (...)
>    [ 2551.743451] RSP: 0018:ffff982c005a7c40 EFLAGS: 00010286
>    [ 2551.743452] RAX: 0000000000000000 RBX: ffff88fc6e44b400 RCX: 0000000000000000
>    [ 2551.743453] RDX: 0000000000000002 RSI: ffffffff8dff0878 RDI: 00000000ffffffff
>    [ 2551.743454] RBP: ffff88fc51817208 R08: 0000000000000000 R09: ffff982c005a7ae0
>    [ 2551.743455] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88fc43d2e570
>    [ 2551.743456] R13: ffff88fc43d2e400 R14: ffff88fc8fb08ee0 R15: ffff88fc6e44b530
>    [ 2551.743457] FS:  0000000000000000(0000) GS:ffff89035fbc0000(0000) knlGS:0000000000000000
>    [ 2551.743458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 2551.743459] CR2: 00007fa8cdf2f6f4 CR3: 0000000124850003 CR4: 0000000000370ee0
>    [ 2551.743462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 2551.743463] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 2551.743464] Call Trace:
>    [ 2551.743472]  <TASK>
>    [ 2551.743474]  ? __warn+0x80/0x130
>    [ 2551.743478]  ? btrfs_write_dirty_block_groups+0x397/0x3d0 [btrfs]
>    [ 2551.743520]  ? report_bug+0x1f4/0x200
>    [ 2551.743523]  ? handle_bug+0x42/0x70
>    [ 2551.743526]  ? exc_invalid_op+0x14/0x70
>    [ 2551.743528]  ? asm_exc_invalid_op+0x16/0x20
>    [ 2551.743532]  ? btrfs_write_dirty_block_groups+0x397/0x3d0 [btrfs]
>    [ 2551.743574]  ? _raw_spin_unlock+0x15/0x30
>    [ 2551.743576]  ? btrfs_run_delayed_refs+0x1bd/0x200 [btrfs]
>    [ 2551.743609]  commit_cowonly_roots+0x1e9/0x260 [btrfs]
>    [ 2551.743652]  btrfs_commit_transaction+0x42e/0xfa0 [btrfs]
>    [ 2551.743693]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 2551.743697]  flush_space+0xf1/0x5d0 [btrfs]
>    [ 2551.743743]  ? _raw_spin_unlock+0x15/0x30
>    [ 2551.743745]  ? finish_task_switch+0x91/0x2a0
>    [ 2551.743748]  ? _raw_spin_unlock+0x15/0x30
>    [ 2551.743750]  ? btrfs_get_alloc_profile+0xc9/0x1f0 [btrfs]
>    [ 2551.743793]  btrfs_async_reclaim_metadata_space+0xe1/0x230 [btrfs]
>    [ 2551.743837]  process_one_work+0x1d9/0x3e0
>    [ 2551.743844]  worker_thread+0x4a/0x3b0
>    [ 2551.743847]  ? __pfx_worker_thread+0x10/0x10
>    [ 2551.743849]  kthread+0xee/0x120
>    [ 2551.743852]  ? __pfx_kthread+0x10/0x10
>    [ 2551.743854]  ret_from_fork+0x29/0x50
>    [ 2551.743860]  </TASK>
>    [ 2551.743861] ---[ end trace 0000000000000000 ]---
>    [ 2551.743863] BTRFS info (device loop0: state A): dumping space info:
>    [ 2551.743866] BTRFS info (device loop0: state A): space_info DATA has 126976 free, is full
>    [ 2551.743868] BTRFS info (device loop0: state A): space_info total=13458472960, used=13458137088, pinned=143360, reserved=0, may_use=0, readonly=65536 zone_unusable=0
>    [ 2551.743870] BTRFS info (device loop0: state A): space_info METADATA has -51625984 free, is full
>    [ 2551.743872] BTRFS info (device loop0: state A): space_info total=771751936, used=770146304, pinned=1605632, reserved=0, may_use=51625984, readonly=0 zone_unusable=0
>    [ 2551.743874] BTRFS info (device loop0: state A): space_info SYSTEM has 14663680 free, is not full
>    [ 2551.743875] BTRFS info (device loop0: state A): space_info total=14680064, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
>    [ 2551.743877] BTRFS info (device loop0: state A): global_block_rsv: size 53231616 reserved 51544064
>    [ 2551.743878] BTRFS info (device loop0: state A): trans_block_rsv: size 0 reserved 0
>    [ 2551.743879] BTRFS info (device loop0: state A): chunk_block_rsv: size 0 reserved 0
>    [ 2551.743880] BTRFS info (device loop0: state A): delayed_block_rsv: size 0 reserved 0
>    [ 2551.743881] BTRFS info (device loop0: state A): delayed_refs_rsv: size 786432 reserved 0
>    [ 2551.743886] BTRFS: error (device loop0: state A) in btrfs_write_dirty_block_groups:3494: errno=-28 No space left
>    [ 2551.743911] BTRFS info (device loop0: state EA): forced readonly
>    [ 2551.743951] BTRFS warning (device loop0: state EA): could not allocate space for delete; will truncate on mount
>    [ 2551.743962] BTRFS error (device loop0: state EA): Error removing orphan entry, stopping orphan cleanup
>    [ 2551.743973] BTRFS warning (device loop0: state EA): Skipping commit of aborted transaction.
>    [ 2551.743989] BTRFS error (device loop0: state EA): could not do orphan cleanup -22
> 
> So make the btrfs_orphan_cleanup() return the value of BTRFS_FS_ERROR(),
> if it's set, and -EINVAL otherwise.
> 
> For that same example, after this change, the mount operation fails with
> -ENOSPC:
> 
>    $ mount test.img /mnt
>    mount: /mnt: mount(2) system call failed: No space left on device.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/inode.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index aa090b0b5d298..02d9640699b80 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3662,9 +3662,16 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  		 */
>  
>  		if (found_key.offset == last_objectid) {
> +			/*
> +			 * We found the same inode as before. This means we were
> +			 * not able to remove its items via eviction triggered
> +			 * by an iput(). A transaction abort may have happened,
> +			 * due to -ENOSPC for example, so try to grab the error
> +			 * that lead to a transaction abort, if any.
> +			 */
>  			btrfs_err(fs_info,
>  				  "Error removing orphan entry, stopping orphan cleanup");
> -			ret = -EINVAL;
> +			ret = BTRFS_FS_ERROR(fs_info) ?: -EINVAL;
>  			goto out;
>  		}
>  
> -- 
> 2.40.1
> 
