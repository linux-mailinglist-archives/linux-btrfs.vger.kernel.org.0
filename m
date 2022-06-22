Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75455495B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiFVJPI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 05:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352653AbiFVJOx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 05:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4A21E3C
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 02:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C648619D2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AFAC34114;
        Wed, 22 Jun 2022 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655889273;
        bh=KuShWLFEYc9p73pKSgD04yt0/83ROKa4+Vc+yoh67UQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWjiC0nyubwVDM7oU3IqgnB7hQmMteU23aqqoIBcEVwKEjGzKxh88x/b8kz3n4TCS
         MIKXB9ZlvEwxC/UGyYxMUDxQPThTxjSCOeMEzalg3XiFjdy7E7/vltRV123nP2KD85
         hPxr/qTpJd3rx8wwzFVga/Mt0ZQq1ZaXcwcX9g00LR8hX6z9zSBBDMWQtRmS6P+Sh2
         FJheoIscVtiER34BmBxXDtAu0WPO/xpfR82niaMBJInJgjcDJPZakRJXe6c/8JiT9U
         rq+N46EPgd3yG56B8ZHIbzgZDk0MreReur7/+ygWQVgwibN81G6cnzkTQZommxZUMs
         jYxodqySHOGEQ==
Date:   Wed, 22 Jun 2022 10:14:30 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: fix error handling of
 cow_file_range(unlock = 0)
Message-ID: <20220622091430.GB81185@falcondesktop>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655791781.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 03:40:58PM +0900, Naohiro Aota wrote:
> This series is a revisit of patch "btrfs: ensure pages are unlocked on
> cow_file_range() failure" [1].
> 
> [1] https://lore.kernel.org/linux-btrfs/20211213034338.949507-1-naohiro.aota@wdc.com/
> 
> Changes
> - v2:
>   - Rephrase comment in patch 1 (Filipe)
>   - Add stable target to patch 3
>     - I choose 5.18+ as the target as they are after refactoring and we can
>       apply the series cleanly.
>   - Rephrase subject of patch 4 (Filipe)
> 
> We have a hang report like below which is caused by a locked page.
> 
> [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241 seconds.
> [  726.329839]       Not tainted 5.16.0-rc1+ #1
> [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid: 11082 flags:0x00000000
> [  726.331608] Call Trace:
> [  726.331611]  <TASK>
> [  726.331614]  __schedule+0x2e5/0x9d0
> [  726.331622]  schedule+0x58/0xd0
> [  726.331626]  io_schedule+0x3f/0x70
> [  726.331629]  __folio_lock+0x125/0x200
> [  726.331634]  ? find_get_entries+0x1bc/0x240
> [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> [  726.331649]  truncate_inode_pages_final+0x44/0x50
> [  726.331653]  btrfs_evict_inode+0x67/0x480
> [  726.331658]  evict+0xd0/0x180
> [  726.331661]  iput+0x13f/0x200
> [  726.331664]  do_unlinkat+0x1c0/0x2b0
> [  726.331668]  __x64_sys_unlink+0x23/0x30
> [  726.331670]  do_syscall_64+0x3b/0xc0
> [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> When cow_file_range(unlock = 0), we never unlock a page after an ordered
> extent is allocated for the page. When the allocation loop fails after some
> ordered extents are allocated, we have three things to do: (1) unlock the
> pages in the successfully allocated ordered extents, (2) clean-up the
> allocated ordered extents, and (3) propagate the error to the userland.
> 
> However, current code fails to do (1) in the all cow_file_range(unlock = 0)
> case and cause the above hang. Also, it fails to do (2) and (3) in
> submit_uncompressed_range() case.
> 
> This series addresses these three issues on error handling of
> cow_file_range(unlock = 0) case.
> 
> To test the series, I applied the following two patches to stress
> submit_uncompressed_range() and to inject an error.
> 
> The following first diff forces the compress_type to be
> BTRFS_COMPRESS_NONE, so that all "compress" writes go through
> submit_uncompressed_range path.
> 
>     diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>     index 7a54f964ff37..eb12c47d02b8 100644
>     --- a/fs/btrfs/inode.c
>     +++ b/fs/btrfs/inode.c
>     @@ -706,6 +706,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>      			compress_type = BTRFS_I(inode)->defrag_compress;
>      		else if (BTRFS_I(inode)->prop_compress)
>      			compress_type = BTRFS_I(inode)->prop_compress;
>     +		compress_type = BTRFS_COMPRESS_NONE;
>      
>      		/*
>      		 * we need to call clear_page_dirty_for_io on each
> 
> The following second diff limits the allocation size at most 256KB to run
> the loop many times. Also, it fails the allocation at the specific offset
> (fail_offset).
> 
>     diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>     index eb12c47d02b8..1247690e7021 100644
>     --- a/fs/btrfs/inode.c
>     +++ b/fs/btrfs/inode.c
>     @@ -1155,6 +1155,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>      	bool extent_reserved = false;
>      	int ret = 0;
>      
>     +	u64 fail_offset = SZ_1M + (u64)SZ_256K * 0;
>     +
>      	if (btrfs_is_free_space_inode(inode)) {
>      		ret = -EINVAL;
>      		goto out_unlock;
>     @@ -1239,9 +1241,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>      
>      	while (num_bytes > 0) {
>      		cur_alloc_size = num_bytes;
>     -		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
>     -					   min_alloc_size, 0, alloc_hint,
>     -					   &ins, 1, 1);
>     +		cur_alloc_size = min_t(u64, SZ_256K, num_bytes);
>     +		if (start != fail_offset)
>     +			ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
>     +						   min_alloc_size, 0, alloc_hint,
>     +						   &ins, 1, 1);
>     +		else
>     +			ret = -ENOSPC;
>      		if (ret < 0)
>      			goto out_unlock;
>      		cur_alloc_size = ins.offset;
> 
> I ran the following script with these patches + the series applied changing
> the fail_offset from "1MB + 256KB * 0" to "1MB + 256KB * 15" step by 256KB,
> and confirmed the above three error handlings are properly done.
> 
>     run() {
>     	local mkfs_opts=$1
>     	local mount_opts=$2
>     
>     	for x in $(seq 100); do
>     		echo $x
>     		mkfs.btrfs -f -d single -m single ${mkfs_opts} /dev/nullb0
>     		mount ${mount_opts} /dev/nullb0 /mnt/test
>     		dd if=/dev/zero of=/mnt/test/file bs=1M count=4 seek=1 oflag=sync 2>&1 | tee /tmp/err
>     		# check error propagation
>     		grep -q 'No space left' /tmp/err || exit 1
>     		sync
>     		umount /mnt/test
>     		dmesg | grep -q WARN && exit 1
>     	done
>     }
>     
>     run ""         ""
>     run ""         "-o compress-force"
>     run "-O zoned" ""
>     run "-O zoned" "-o compress-force"
> 
> Patch 1 addresses the (1) by unlocking the pages in the error case. Also,
> it adds a figure to clarify what to do for each range in the error case.
> 
> Patches 2 and 3 do (2) and (3) by fixing the error case of
> submit_uncompressed_range().
> 
> Patch 4 is a refactoring patch to replace unnecessary "goto out"s with
> direct return.
> 
> Naohiro Aota (4):
>   btrfs: ensure pages are unlocked on cow_file_range() failure
>   btrfs: extend btrfs_cleanup_ordered_extens for NULL locked_page
>   btrfs: fix error handling of fallbacked uncompress write
>   btrfs: replace unnecessary goto with direct return at cow_file_range()
> 
>  fs/btrfs/inode.c | 132 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 103 insertions(+), 29 deletions(-)

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> 
> -- 
> 2.35.1
> 
