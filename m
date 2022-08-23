Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC859E421
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiHWM4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 08:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbiHWMzy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 08:55:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7591123C86;
        Tue, 23 Aug 2022 03:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D41C2B81B1F;
        Tue, 23 Aug 2022 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC76C433D6;
        Tue, 23 Aug 2022 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661248821;
        bh=Fz6T4pAKdcT/lUNu0ZLLTw5HZ9Pw1Ljb7l2xDS0PqDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvWRv9ElvPtUtONa6pCmqOoCPE5jxjCqodHw6pYyZ3g7qngvm1rsmwpnMUjAQBrsQ
         lEbe9GRcM+CbH9tn1nUD3Kj8iWgiWuy5qCOy4Yce5ir/PDJxfX8ltoInsqPR4R7cyT
         NwkngEMtP45fGNVYG4Ii5iNBOw6Ety04hgHA4YfaCpqkx7pepE129QJH4tmK0iQMz4
         5X0wGhILhQ4ofg1BZ4Bh/WuEmoY9C6Hq2rIezpPtYWSYQVd5aYWPycKg2vR+Cu4JcP
         Z1QrrHyD8MwP1jdA9PeGYGe4rf8FvUjykrTpSfoKAX4kKpmBPyFWOvHKXrEqNVPR0a
         aGoHFS71+difg==
Date:   Tue, 23 Aug 2022 11:00:18 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: fix use-after-free in btrfs_get_global_root
Message-ID: <20220823100018.GA3180928@falcondesktop>
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

In addition to what I mentioned in the previous mail, this is also not
correct because the qgroup_rescan_init() call will always fail if
BTRFS_FS_QUOTA_ENABLED is not set (with an -EBUSY error).

Have you tested this at all? Every attempt to enable quotas will result
in a -EBUSY being returned from the ioctl.

All we need is:

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db723c0026bd..67818b2f316f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1174,6 +1174,17 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
                fs_info->qgroup_rescan_running = true;
                btrfs_queue_work(fs_info->qgroup_rescan_workers,
                                 &fs_info->qgroup_rescan_work);
+       } else {
+               /*
+                * We have set both BTRFS_FS_QUOTA_ENABLED and
+                * BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with
+                * -EINPROGRESS because someone started the rescan worker with
+                * the ioctl before we attempted to initialize it.
+                * Ignore such error, and any other error would need to undo
+                * everything we did in the transaction we just committed.
+                */
+               ASSERT(ret == -EINPROGRESS);
+               ret = 0;
        }
 
 out_free_path:



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
>  	        qgroup_rescan_zero_tracking(fs_info);
>  		fs_info->qgroup_rescan_running = true;
>  	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
> -- 
> 2.31.1
> 
