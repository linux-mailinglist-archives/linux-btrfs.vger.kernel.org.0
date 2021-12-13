Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75D4728FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhLMKQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 05:16:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57592 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbhLMKOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 05:14:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7424CE0B20
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 10:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A3C34600;
        Mon, 13 Dec 2021 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639390477;
        bh=g2ZbQi9eAH7ZZSpdhRlaJyP1nByXkgI4T1hk8GbD9s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVnV+4SNg48nRpijSHAsJ7xrn19bmPQVMXx5mVzkKgjg1XUNqD80MK7Pg4cy0BS01
         RLs9HLC4CxFkkU7HSp644JCk5PQfuxuue9feKWolicO9lKGunBushDAg5yLah2bWuA
         oioPAsJ27BQlBKlfalNoPouajGpVRkJBbWIgUrJ1lqk4qo20ykpbrernEsOz8Yyrw8
         e5p8iqXOTjxCkysSuXtrbPJ6drto10Z4J0PZEXTHmTQYZIHkN8jovGFcN4/k8wYpHA
         rmCirXNrqTheAKvkmA7K3gDqGGm1isyPl/i85JNtbBDR4HkNoyN6x2RqCsLV5So+i6
         pq2eGa3Ic2grA==
Date:   Mon, 13 Dec 2021 10:14:34 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Message-ID: <YbcdCsSVfZ4MAsXs@debian9.Home>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213034338.949507-1-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 12:43:38PM +0900, Naohiro Aota wrote:
> There is a hung_task report regarding page lock on zoned btrfs like below.
> 
> https://github.com/naota/linux/issues/59
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
> [  726.331677] RIP: 0033:0x7fb9490a171b
> [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb9490a171b
> [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb94400d300
> [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000000000000
> [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb943ffb000
> [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb943ffd260
> [  726.331693]  </TASK>
> 
> While we debug the issue, we found running fstests generic/551 on 5GB
> non-zoned null_blk device in the emulated zoned mode also had a
> similar hung issue.
> 
> The hang occurs when cow_file_range() fails in the middle of
> allocation. cow_file_range() called from do_allocation_zoned() can
> split the give region ([start, end]) for allocation depending on
> current block group usages. When btrfs can allocate bytes for one part
> of the split regions but fails for the other region (e.g. because of
> -ENOSPC), we return the error leaving the pages in the succeeded regions
> locked. Technically, this occurs only when @unlock == 0. Otherwise, we
> unlock the pages in an allocated region after creating an ordered
> extent.
> 
> Theoretically, the same issue can happen on
> submit_uncompressed_range(). However, I could not make it happen even
> if I modified the code to go always through
> submit_uncompressed_range().
> 
> Considering the callers of cow_file_range(unlock=0) won't write out
> the pages, we can unlock the pages on error exit from
> cow_file_range(). So, we can ensure all the pages except @locked_page
> are unlocked on error case.
> 
> In summary, cow_file_range now behaves like this:
> 
> - page_started == 1 (return value)
>   - All the pages are unlocked. IO is started.
> - unlock == 0
>   - All the pages except @locked_page are unlocked in any case
> - unlock == 1
>   - On success, all the pages are locked for writing out them
>   - On failure, all the pages except @locked_page are unlocked
> 
> Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path for zoned filesystems")
> CC: stable@vger.kernel.org # 5.12+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> Theoretically, this can fix a potential issue in
> submit_uncompressed_range(). However, I set the stable target only
> related to zoned code, because I cannot make compress writes fail on
> regular btrfs.
> ---
>  fs/btrfs/inode.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b8c911a4a320..e21c94bbc56c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1109,6 +1109,22 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>   * *page_started is set to one if we unlock locked_page and do everything
>   * required to start IO on it.  It may be clean and already done with
>   * IO when we return.
> + *
> + * When unlock == 1, we unlock the pages in successfully allocated regions. We
> + * leave them locked otherwise for writing them out.
> + *
> + * However, we unlock all the pages except @locked_page in case of failure.
> + *
> + * In summary, page locking state will be as follow:
> + *
> + * - page_started == 1 (return value)
> + *     - All the pages are unlocked. IO is started.
> + *     - Note that this can happen only on success
> + * - unlock == 0
> + *     - All the pages except @locked_page are unlocked in any case

That should be the unlock == 1 case.

> + * - unlock == 1
> + *     - On success, all the pages are locked for writing out them
> + *     - On failure, all the pages except @locked_page are unlocked

And that should be the unlock == 0 case.

Otherwise it looks fine.

Thanks.

>   */
>  static noinline int cow_file_range(struct btrfs_inode *inode,
>  				   struct page *locked_page,
> @@ -1118,6 +1134,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	u64 alloc_hint = 0;
> +	u64 orig_start = start;
>  	u64 num_bytes;
>  	unsigned long ram_size;
>  	u64 cur_alloc_size = 0;
> @@ -1305,6 +1322,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
>  		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>  	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> +	/* Ensure we unlock all the pages except @locked_page in the error case */
> +	if (!unlock && orig_start < start)
> +		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> +					     locked_page, clear_bits, page_ops);
>  	/*
>  	 * If we reserved an extent for our delalloc range (or a subrange) and
>  	 * failed to create the respective ordered extent, then it means that
> -- 
> 2.34.1
> 
