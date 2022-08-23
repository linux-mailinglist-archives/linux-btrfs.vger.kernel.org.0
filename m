Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCB59DC9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353600AbiHWKhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355506AbiHWKgV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 06:36:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D982A61CC;
        Tue, 23 Aug 2022 02:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD023CE1B5C;
        Tue, 23 Aug 2022 09:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B25C433B5;
        Tue, 23 Aug 2022 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661245620;
        bh=hAggGE8+OMUY52LWGZnvUhEBRK6XhKVWZUXs8+5eN7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAPk4ROlbCmeyHvQXmvke0mnlr1HnPe2+SSez1l3HK+Adf+9flN2JTFHWNtlf+qTa
         GnAXtmPxDHwI7xKCYeV383DXoVeLW/BENwCC5A+RhC+Z7cceOlzgkYahQFp1Qdw9Ba
         ZguUwElNeppkXp/jYsrDds1rwLBgIhNkrkypl8fTRJToeLmHAbSR9LWUSRQ4Wqg3l1
         3lVqnSxaGMwK25LuY0nRYh0iwq4BLNwAu+6pmUynQ4HXi/JFplBermLzDgWpztVNtV
         VEBu/fhgQZMP3+xL6ljwQH5fWCAM8Jet/ShfO7cj5RO5YBhnxX2kO+ZJDBztn1w6xB
         ln7U6TfOT4zrQ==
Date:   Tue, 23 Aug 2022 10:06:57 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: fix use-after-free in btrfs_get_global_root
Message-ID: <20220823090657.GB3171944@falcondesktop>
References: <20220823015931.421355-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823015931.421355-1-yebin10@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 09:59:31AM +0800, Ye Bin wrote:
> Syzkaller reported UAF as follows:
> ==================================================================
> BUG: KASAN: use-after-free in btrfs_get_global_root+0x663/0xa10
> Read of size 4 at addr ffff88811ddbb3c0 by task kworker/u16:1/11
> 
> CPU: 4 PID: 11 Comm: kworker/u16:1 Not tainted 6.0.0-rc1-next-20220822+ #2
> Workqueue: btrfs-qgroup-rescan btrfs_work_helper
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0x91
>  print_report.cold+0xb2/0x6bb
>  kasan_report+0xa8/0x130
>  kasan_check_range+0x13f/0x1d0
>  btrfs_get_global_root+0x663/0xa10
>  btrfs_get_fs_root_commit_root+0xa5/0x150
>  find_parent_nodes+0x92f/0x2990
>  btrfs_find_all_roots_safe+0x12d/0x220
>  btrfs_find_all_roots+0xbb/0xd0
>  btrfs_qgroup_rescan_worker+0x600/0xc30
>  btrfs_work_helper+0xff/0x750
>  process_one_work+0x52c/0x930
>  worker_thread+0x352/0x8c0
>  kthread+0x1b9/0x200
>  ret_from_fork+0x22/0x30
>  </TASK>
> 
> Allocated by task 1895:
>  kasan_save_stack+0x1e/0x40
>  __kasan_kmalloc+0xa9/0xe0
>  btrfs_alloc_root+0x40/0x820
>  btrfs_create_tree+0xf8/0x500
>  btrfs_quota_enable+0x30a/0x1120
>  btrfs_ioctl+0x50a3/0x59f0
>  __x64_sys_ioctl+0x130/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 1895:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_set_free_info+0x20/0x40
>  __kasan_slab_free+0x127/0x1c0
>  kfree+0xa8/0x2d0
>  btrfs_put_root+0x1ca/0x230
>  btrfs_quota_enable+0x87c/0x1120
>  btrfs_ioctl+0x50a3/0x59f0
>  __x64_sys_ioctl+0x130/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ==================================================================
> 
> Above issue may happens as follows:
>           p1                                  p2
> btrfs_quota_enable
>   spin_lock(&fs_info->qgroup_lock);
>   fs_info->quota_root = quota_root;
>   spin_unlock(&fs_info->qgroup_lock);
> 
>   ret = qgroup_rescan_init -> return error
>   if (ret)
>     btrfs_put_root(quota_root);
>      kfree(root);
> 
>   if (ret) {
>    ulist_free(fs_info->qgroup_ulist);
>    fs_info->qgroup_ulist = NULL;
>    btrfs_sysfs_del_qgroups(fs_info);
>   }                                btrfs_qgroup_rescan_worker
>                                      btrfs_find_all_roots
> 				       btrfs_find_all_roots_safe
> 				         find_parent_nodes
> 					   btrfs_get_fs_root_commit_root
> 					     btrfs_grab_root(fs_info->quota_root)
> 	                                  -> quota_root already freed
> 
> Syzkaller also reported another issue:
> ==================================================================
> BUG: KASAN: use-after-free in ulist_release+0x30/0xb3
> Read of size 8 at addr ffff88811413d048 by task rep/2921
> 
> CPU: 3 PID: 2921 Comm: rep Not tainted 6.0.0-rc1-next-20220822+ #3
> rep[2921] cmdline: ./rep
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0x91
>  print_report.cold+0xb2/0x6bb
>  kasan_report+0xa8/0x130
>  ulist_release+0x30/0xb3
>  ulist_reinit+0x16/0x56
>  btrfs_qgroup_free_refroot+0x288/0x3f0
>  btrfs_qgroup_free_meta_all_pertrans+0xed/0x1e0
>  commit_fs_roots+0x28c/0x430
>  btrfs_commit_transaction+0x9a6/0x1b40
>  btrfs_qgroup_rescan+0x7e/0x130
>  btrfs_ioctl+0x48ed/0x59f0
>  __x64_sys_ioctl+0x130/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
> 
> Allocated by task 2900:
>  kasan_save_stack+0x1e/0x40
>  __kasan_kmalloc+0xa9/0xe0
>  ulist_alloc+0x5c/0xe0
>  btrfs_quota_enable+0x1b2/0x1160
>  btrfs_ioctl+0x50a3/0x59f0
>  __x64_sys_ioctl+0x130/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 2900:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_set_free_info+0x20/0x40
>  __kasan_slab_free+0x127/0x1c0
>  kfree+0xa8/0x2d0
>  ulist_free.cold+0x15/0x1a
>  btrfs_quota_enable+0x8bf/0x1160
>  btrfs_ioctl+0x50a3/0x59f0
>  __x64_sys_ioctl+0x130/0x170
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ==================================================================
> 
> To solve above issues just set 'fs_info->quota_root' after qgroup_rescan_init
> return success.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/btrfs/qgroup.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index db723c0026bd..16f0b038295a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1158,18 +1158,18 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	if (ret)
>  		goto out_free_path;
>  
> -	/*
> -	 * Set quota enabled flag after committing the transaction, to avoid
> -	 * deadlocks on fs_info->qgroup_ioctl_lock with concurrent snapshot
> -	 * creation.
> -	 */
> -	spin_lock(&fs_info->qgroup_lock);
> -	fs_info->quota_root = quota_root;
> -	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -	spin_unlock(&fs_info->qgroup_lock);
> -
>  	ret = qgroup_rescan_init(fs_info, 0, 1);
>  	if (!ret) {
> +		/*
> +		 * Set quota enabled flag after committing the transaction, to
> +		 * avoid deadlocks on fs_info->qgroup_ioctl_lock with concurrent
> +		 * snapshot creation.
> +		 */
> +		spin_lock(&fs_info->qgroup_lock);
> +		fs_info->quota_root = quota_root;
> +		set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> +		spin_unlock(&fs_info->qgroup_lock);
> +

But how can the race happen? The changelog should explain that.

To me this suggests that after we set BTRFS_FS_QUOTA_ENABLED and set the
quota root, but before we called qgroup_rescan_init() at btrfs_quota_enable(),
some other task started the rescan worker first - I can only think of
someone else calling the ioctl to start the rescan worker (btrfs_ioctl_quota_rescan()).

In that case we get "ret == -EINPROGRESS" at btrfs_quota_enable().

So please provide a detailed explanation in the log of how the race can
happen.

This solution is also buggy. Because in case of an error, we will leave the
quota tree created, the qgroup relation, etc. That is, we don't undo
what btrfs_create_tree(), add_qgroup_item(), add_qgroup_rb(), etc did
Which means a future btrfs_quota_enable() call would fail, and calling
btrfs_quota_disable() to undo all those things will not work either,
because fs_info->quota_root is NULL.

I would suggest ignoring the error of qgroup_rescan_init() if it's
-EINPROGRESS, and ASSERT if it's anything different from 0 or
-EINPROGRESS. Also add a comment mentioning we can get -EINPROGRESS
because someone may have called the qgroup rescan ioctl.

Thanks.




>  	        qgroup_rescan_zero_tracking(fs_info);
>  		fs_info->qgroup_rescan_running = true;
>  	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -- 
> 2.31.1
> 
