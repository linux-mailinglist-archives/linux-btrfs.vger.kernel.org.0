Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B34BE1CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 18:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358067AbiBUMib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 07:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348408AbiBUMia (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 07:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBFF10
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 04:38:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400DB61313
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 12:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213F1C340E9;
        Mon, 21 Feb 2022 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645447085;
        bh=q/g/S7UlhTe7rDfL5UnJUXeiGsCmUtY6D6vNPuK4ctw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA0H2G2rXSIICCCU8PP6qps1FQ3pBaVyt3hUxFEEPCTEAp61T/Mumv+XXF3piumSR
         9yuAdHa1xgqThVlnkzChwqAuzClrUkNKxqDA7XMNqKqdbrhP3ETb4A6rlUiVrAyW3e
         eNgwL0zzkj+jBic+2hqfn8tTEtdgepQUsBqWMbewnvJm7GSy0uExzBHp3YCGrI8W7l
         sopMsuHoikt33QJ1feyr94Rrcy8z6chk7TCgKOQhblVx8UzalBE6WPm1yEwe/AFcJN
         AtnwqT39x+SwVS+7D750y2ceU5To6ujLjHh+jcn5W25m6qBygkesO0w3jS7cucQv6A
         0KSmgomIv+v3w==
Date:   Mon, 21 Feb 2022 12:38:02 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: do not start relocation until in progress
 drops are done
Message-ID: <YhOHqtAM/JbfTKdo@debian9.Home>
References: <cover.1645214059.git.josef@toxicpanda.com>
 <78d6f8e496b367fc520549ab00465cbd704ea22f.1645214059.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d6f8e496b367fc520549ab00465cbd704ea22f.1645214059.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 02:56:10PM -0500, Josef Bacik wrote:
> We hit a bug with a recovering relocation on mount for one of our file
> systems in production.  I reproduced this locally by injecting errors
> into snapshot delete with balance running at the same time.  This
> presented as an error while looking up an extent item
> 
> ------------[ cut here ]------------
> WARNING: CPU: 5 PID: 1501 at fs/btrfs/extent-tree.c:866 lookup_inline_extent_backref+0x647/0x680
> CPU: 5 PID: 1501 Comm: btrfs-balance Not tainted 5.16.0-rc8+ #8
> RIP: 0010:lookup_inline_extent_backref+0x647/0x680
> RSP: 0018:ffffae0a023ab960 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000000000
> RBP: ffff943fd2a39b60 R08: 0000000000000000 R09: 0000000000000001
> R10: 0001434088152de0 R11: 0000000000000000 R12: 0000000001d05000
> R13: ffff943fd2a39b60 R14: ffff943fdb96f2a0 R15: ffff9442fc923000
> FS:  0000000000000000(0000) GS:ffff944e9eb40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1157b1fca8 CR3: 000000010f092000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  insert_inline_extent_backref+0x46/0xd0
>  __btrfs_inc_extent_ref.isra.0+0x5f/0x200
>  ? btrfs_merge_delayed_refs+0x164/0x190
>  __btrfs_run_delayed_refs+0x561/0xfa0
>  ? btrfs_search_slot+0x7b4/0xb30
>  ? btrfs_update_root+0x1a9/0x2c0
>  btrfs_run_delayed_refs+0x73/0x1f0
>  ? btrfs_update_root+0x1a9/0x2c0
>  btrfs_commit_transaction+0x50/0xa50
>  ? btrfs_update_reloc_root+0x122/0x220
>  prepare_to_merge+0x29f/0x320
>  relocate_block_group+0x2b8/0x550
>  btrfs_relocate_block_group+0x1a6/0x350
>  btrfs_relocate_chunk+0x27/0xe0
>  btrfs_balance+0x777/0xe60
>  balance_kthread+0x35/0x50
>  ? btrfs_balance+0xe60/0xe60
>  kthread+0x16b/0x190
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x22/0x30
>  </TASK>
> ---[ end trace 7ebc95131709d2b0 ]---
> 
> Normally snapshot deletion and relocation are excluded from running at
> the same time by the fs_info->cleaner_mutex.  However if we had a
> pending balance waiting to get the ->cleaner_mutex, and a snapshot
> deletion was running, and then the box crashed, we would come up in a
> state where we have a half deleted snapshot.
> 
> Again, in the normal case the snapshot deletion needs to complete before
> relocation can start, but in this case relocation could very well start
> before the snapshot deletion completes, as we simply add the root to the
> dead roots list and wait for the next time the cleaner runs to clean up
> the snapshot.
> 
> Fix this by setting a bit on the fs_info if we have any DEAD_ROOT's that
> had a pending drop_progress key.  If they do then we know we were in the
> middle of the drop operation and set a flag on the fs_info.  Then
> balance can wait until this flag is cleared to start up again.
> 
> If there are DEAD_ROOT's that don't have a drop_progress set then we're
> safe to start balance right away as we'll be properly protected by the
> cleaner_mutex.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h       | 13 +++++++++++++
>  fs/btrfs/disk-io.c     | 10 ++++++++++
>  fs/btrfs/extent-tree.c |  7 +++++++
>  fs/btrfs/relocation.c  | 14 ++++++++++++++
>  fs/btrfs/root-tree.c   | 18 ++++++++++++++++++
>  fs/btrfs/transaction.c | 33 ++++++++++++++++++++++++++++++++-
>  fs/btrfs/transaction.h |  1 +
>  7 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f870d893d13b..1e238748dc73 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -629,6 +629,9 @@ enum {
>  	/* Indicate that we want the transaction kthread to commit right now. */
>  	BTRFS_FS_COMMIT_TRANS,
>  
> +	/* Indicate we have half completed snapshot deletions pending. */
> +	BTRFS_FS_UNFINISHED_DROPS,
> +
>  #if BITS_PER_LONG == 32
>  	/* Indicate if we have error/warn message printed on 32bit systems */
>  	BTRFS_FS_32BIT_ERROR,
> @@ -1136,8 +1139,18 @@ enum {
>  	BTRFS_ROOT_QGROUP_FLUSHING,
>  	/* We started the orphan cleanup for this root. */
>  	BTRFS_ROOT_ORPHAN_CLEANUP,
> +	/* This root has a drop operation that was started previously. */
> +	BTRFS_ROOT_UNFINISHED_DROP,
>  };
>  
> +static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
> +{
> +	clear_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> +	/* Needs to be here so the clear_bit is seen by the sleeper. */
> +	smp_mb__after_atomic();
> +	wake_up_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS);
> +}

clear_and_wake_up_bit() does exactly that, we could use it instead.

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
>  /*
>   * Record swapped tree blocks of a subvolume tree for delayed subtree trace
>   * code. For detail check comment in fs/btrfs/qgroup.c.
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b6a81c39d5f4..ed62e81c0b66 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3891,6 +3891,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  
>  	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
>  
> +	/* Kick the cleaner thread so it'll start deleting snapshots. */
> +	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
> +		wake_up_process(fs_info->cleaner_kthread);
> +
>  clear_oneshot:
>  	btrfs_clear_oneshot_options(fs_info);
>  	return 0;
> @@ -4616,6 +4620,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	 */
>  	kthread_park(fs_info->cleaner_kthread);
>  
> +	/*
> +	 * If we had UNFINISHED_DROPS we could still be processing them, so
> +	 * clear that bit and wake up relocation so it can stop.
> +	 */
> +	btrfs_wake_unfinished_drop(fs_info);
> +
>  	/* wait for the qgroup rescan worker to stop */
>  	btrfs_qgroup_wait_for_completion(fs_info, false);
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 99e550b83794..e94b8f168a85 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5837,6 +5837,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>  	kfree(wc);
>  	btrfs_free_path(path);
>  out:
> +	/*
> +	 * We were an unfinished drop root, check to see if there are any
> +	 * pending, and if not clear and wake up any waiters.
> +	 */
> +	if (!err && test_bit(BTRFS_ROOT_UNFINISHED_DROP, &root->state))
> +		btrfs_maybe_wake_unfinished_drop(fs_info);
> +
>  	/*
>  	 * So if we need to stop dropping the snapshot for whatever reason we
>  	 * need to make sure to add it back to the dead root list so that we
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f5465197996d..f528c5283f25 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3960,6 +3960,20 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	int rw = 0;
>  	int err = 0;
>  
> +	/*
> +	 * This only gets set if we had a half-deleted snapshot on mount.  We
> +	 * cannot allow relocation to start while we're still trying to clean up
> +	 * these pending deletions.
> +	 */
> +	ret = wait_on_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS,
> +			  TASK_INTERRUPTIBLE);
> +	if (ret)
> +		return ret;
> +
> +	/* We may have been woken up by close_ctree, so bail if we're closing. */
> +	if (btrfs_fs_closing(fs_info))
> +		return -EINTR;
> +
>  	bg = btrfs_lookup_block_group(fs_info, group_start);
>  	if (!bg)
>  		return -ENOENT;
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 3d68d2dcd83e..36770bf42d1a 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -278,6 +278,24 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  
>  		WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state));
>  		if (btrfs_root_refs(&root->root_item) == 0) {
> +			struct btrfs_key drop_key;
> +
> +			btrfs_disk_key_to_cpu(&drop_key,
> +					      &root->root_item.drop_progress);
> +			/*
> +			 * If we have a non-zero drop_progress then we know we
> +			 * made it partly through deleting this snapshot, and
> +			 * thus we need to make sure we block any balance from
> +			 * happening until this snapshot is completely dropped.
> +			 */
> +			if (drop_key.objectid != 0 || drop_key.type != 0 ||
> +			    drop_key.offset != 0) {
> +				set_bit(BTRFS_FS_UNFINISHED_DROPS,
> +					&fs_info->flags);
> +				set_bit(BTRFS_ROOT_UNFINISHED_DROP,
> +					&root->state);
> +			}
> +
>  			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>  			btrfs_add_dead_root(root);
>  		}
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index c6e550fa4d55..dfceee28a149 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1319,6 +1319,32 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
>  	return 0;
>  }
>  
> +/*
> + * If we had a pending drop we need to see if there are any others left in our
> + * dead roots list, and if not clear our bit and wake any waiters.
> + */
> +void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
> +{
> +	/*
> +	 * We put the drop in progress roots at the front of the list, so if the
> +	 * first entry doesn't have UNFINISHED_DROP set we can wake everybody
> +	 * up.
> +	 */
> +	spin_lock(&fs_info->trans_lock);
> +	if (!list_empty(&fs_info->dead_roots)) {
> +		struct btrfs_root *root = list_first_entry(&fs_info->dead_roots,
> +							   struct btrfs_root,
> +							   root_list);
> +		if (test_bit(BTRFS_ROOT_UNFINISHED_DROP, &root->state)) {
> +			spin_unlock(&fs_info->trans_lock);
> +			return;
> +		}
> +	}
> +	spin_unlock(&fs_info->trans_lock);
> +
> +	btrfs_wake_unfinished_drop(fs_info);
> +}
> +
>  /*
>   * dead roots are old snapshots that need to be deleted.  This allocates
>   * a dirty root struct and adds it into the list of dead roots that need to
> @@ -1331,7 +1357,12 @@ void btrfs_add_dead_root(struct btrfs_root *root)
>  	spin_lock(&fs_info->trans_lock);
>  	if (list_empty(&root->root_list)) {
>  		btrfs_grab_root(root);
> -		list_add_tail(&root->root_list, &fs_info->dead_roots);
> +
> +		/* We want to process the partially complete drops first. */
> +		if (test_bit(BTRFS_ROOT_UNFINISHED_DROP, &root->state))
> +			list_add(&root->root_list, &fs_info->dead_roots);
> +		else
> +			list_add_tail(&root->root_list, &fs_info->dead_roots);
>  	}
>  	spin_unlock(&fs_info->trans_lock);
>  }
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 9402d8d94484..ba8a9826eb37 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -216,6 +216,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
>  
>  void btrfs_add_dead_root(struct btrfs_root *root);
>  int btrfs_defrag_root(struct btrfs_root *root);
> +void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
>  int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
>  int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
>  void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans);
> -- 
> 2.26.3
> 
