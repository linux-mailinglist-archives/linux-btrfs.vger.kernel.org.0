Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3767157B8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiGTOrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGTOrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:47:14 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58474E628
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:47:13 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0D1BA808FF;
        Wed, 20 Jul 2022 10:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658328433; bh=kjI9tFoWkDfJJmM8q0aUjrBdR9SMT+M++hj1SAA8gKc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=okYX2/c425/t0+5S5wC+R4tvc2bHxFMkmZvbRxMiZ75f06vu4NCs7/96BT9x2BV4W
         kHtCtv4v59Njn3HJENVR23NX8DezJdI3KtPMX8kF6Jmhc+8s3XahDyfHwPTCPkggPz
         lhmnXy3Ip9wcojvbG7O3e4hYORptoHZ9TNfhub8OZnxwxsnaJMadYuupxK1kZ93FiT
         S/e5k2M7r82TakW/nSIhKTC0gpCPPGCVxVch919nUabOYJUk7HaZVqxFwCt+VvRngd
         elT0clYhVy+Na2PEJAteIe2IS65tUV0oyKjq7i9m695ueyC0DRZ39vG/s1y1LGskF9
         6lbhsxaCJFU7w==
Message-ID: <4f52398b-4238-7d90-df30-a5073c411b36@dorminy.me>
Date:   Wed, 20 Jul 2022 10:47:12 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] btrfs: Add a lockdep model for the num_writers
 wait event
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-2-iangelak@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220719040954.3964407-2-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/19/22 00:09, Ioannis Angelakopoulos wrote:
> Annotate the num_writers wait event in fs/btrfs/transaction.c with lockdep
> in order to catch deadlocks involving this wait event.
> 
> Use a read/write lockdep map for the annotation. A thread starting/joining
> the transaction acquires the map as a reader when it increments
> cur_trans->num_writers and it acquires the map as a writer before it
> blocks on the wait events

> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>   fs/btrfs/ctree.h       | 14 ++++++++++++++
>   fs/btrfs/disk-io.c     |  6 ++++++
>   fs/btrfs/transaction.c | 37 ++++++++++++++++++++++++++++++++-----
>   3 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 202496172059..999868734be7 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1095,6 +1095,8 @@ struct btrfs_fs_info {
>   	/* Updates are not protected by any lock */
>   	struct btrfs_commit_stats commit_stats;
>   
> +	struct lockdep_map btrfs_trans_num_writers_map;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> @@ -1175,6 +1177,18 @@ enum {
>   	BTRFS_ROOT_UNFINISHED_DROP,
>   };
>   
> +#define btrfs_might_wait_for_event(b, lock) \
> +	do { \
> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
> +		rwsem_release(&b->lock##_map, _THIS_IP_); \
> +	} while (0)
> +
This confuses me a lot. btrfs_might_wait_for_event() doesn't have the 
same lockdep prefix that the other annotations do, so it's not obvious 
reading the callsites that it's lockdep-related. I also don't understand 
what parameters I should pass this function easily, so a comment would 
be nice.

And I think, after reading lockdep code, I understand why it's 
rwsem_acquire() here, vs rwsem_acquire_read() below, but it might be 
nice to have a comment block explaining why there's a difference in 
which one is called.

(Stylistically, it would be nice IMO for all of the slashes to be lined 
up vertically, a la tree-checker.c:102)

> +#define btrfs_lockdep_acquire(b, lock) \
> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
> +
Reading the lockdep stuff, it seems that they draw distinction between 
_acquire and _acquire_read. Maybe worth a comment to note all the 
notional locks start off shared and only become exclusive in 
btrfs_might_wait_for_event()?

> +#define btrfs_lockdep_release(b, lock) \
> +	rwsem_release(&b->lock##_map, _THIS_IP_)
> +
>   static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>   {
>   	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3fac429cf8a4..01a5a49a3a11 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3046,6 +3046,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>   
>   void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   {
> +	static struct lock_class_key btrfs_trans_num_writers_key;
> +
>   	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
>   	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
>   	INIT_LIST_HEAD(&fs_info->trans_list);
> @@ -3074,6 +3076,10 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	mutex_init(&fs_info->zoned_data_reloc_io_lock);
>   	seqlock_init(&fs_info->profiles_lock);
>   
> +	lockdep_init_map(&fs_info->btrfs_trans_num_writers_map,
> +					 "btrfs_trans_num_writers",
> +					 &btrfs_trans_num_writers_key, 0);
Sort of a non-standard indentation, as far as I know. Might I suggest 
lining up the second and third lines like so:
+	lockdep_init_map(&fs_info->btrfs_trans_num_writers_map,
+			 "btrfs_trans_num_writers",
+			 &btrfs_trans_num_writers_key, 0);

Also, it looks like you call this function with the same sort of pattern 
in all the patches. You could make a macro that does something like 
(untested)
do {
	static struct lock_class_key lockname##_key
	lockdep_init_map(&fs_info->lockname##_map, lockname,
			 &lockname##_key, 0);
} while (0);
and not have to separately define the keys.


> +
>   	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>   	INIT_LIST_HEAD(&fs_info->space_info);
>   	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 0bec10740ad3..d8287ec890bc 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -313,6 +313,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   		atomic_inc(&cur_trans->num_writers);
>   		extwriter_counter_inc(cur_trans, type);
>   		spin_unlock(&fs_info->trans_lock);
> +		btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
>   		return 0;
>   	}
>   	spin_unlock(&fs_info->trans_lock);
> @@ -334,16 +335,20 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   	if (!cur_trans)
>   		return -ENOMEM;
>   
> +	btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
> +
>   	spin_lock(&fs_info->trans_lock);
>   	if (fs_info->running_transaction) {
>   		/*
>   		 * someone started a transaction after we unlocked.  Make sure
>   		 * to redo the checks above
>   		 */
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>   		kfree(cur_trans);
>   		goto loop;
>   	} else if (BTRFS_FS_ERROR(fs_info)) {
>   		spin_unlock(&fs_info->trans_lock);
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>   		kfree(cur_trans);
>   		return -EROFS;
>   	}
> @@ -1022,6 +1027,9 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>   	extwriter_counter_dec(cur_trans, trans->type);
>   
>   	cond_wake_up(&cur_trans->writer_wait);
> +
> +	btrfs_lockdep_release(info, btrfs_trans_num_writers);
> +
>   	btrfs_put_transaction(cur_trans);
>   
>   	if (current->journal_info == trans)
> @@ -1994,6 +2002,12 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
>   	if (cur_trans == fs_info->running_transaction) {
>   		cur_trans->state = TRANS_STATE_COMMIT_DOING;
>   		spin_unlock(&fs_info->trans_lock);
> +
> +		/*
> +		 * The thread has already released the lockdep map as reader already in
> +		 * btrfs_commit_transaction().
> +		 */
> +		btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
>   		wait_event(cur_trans->writer_wait,
>   			   atomic_read(&cur_trans->num_writers) == 1);
>   
> @@ -2222,7 +2236,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   
>   			btrfs_put_transaction(prev_trans);
>   			if (ret)
> -				goto cleanup_transaction;
> +				goto lockdep_release;
>   		} else {
>   			spin_unlock(&fs_info->trans_lock);
>   		}
> @@ -2236,7 +2250,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   		 */
>   		if (BTRFS_FS_ERROR(fs_info)) {
>   			ret = -EROFS;
> -			goto cleanup_transaction;
> +			goto lockdep_release;
>   		}
>   	}
>   
> @@ -2250,19 +2264,21 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   
>   	ret = btrfs_start_delalloc_flush(fs_info);
>   	if (ret)
> -		goto cleanup_transaction;
> +		goto lockdep_release;
>   
>   	ret = btrfs_run_delayed_items(trans);
>   	if (ret)
> -		goto cleanup_transaction;
> +		goto lockdep_release;
>   
>   	wait_event(cur_trans->writer_wait,
>   		   extwriter_counter_read(cur_trans) == 0);
>   
>   	/* some pending stuffs might be added after the previous flush. */
>   	ret = btrfs_run_delayed_items(trans);
> -	if (ret)
> +	if (ret) {
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>   		goto cleanup_transaction;
> +	}
Could this just be goto lockdep_release; like the earlier sites?
>   
>   	btrfs_wait_delalloc_flush(fs_info);
>   
> @@ -2284,6 +2300,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	add_pending_snapshot(trans);
>   	cur_trans->state = TRANS_STATE_COMMIT_DOING;
>   	spin_unlock(&fs_info->trans_lock);
> +
> +	/*
> +	 * The thread has started/joined the transaction thus it holds the lockdep
> +	 * map as a reader. It has to release it before acquiring the lockdep map
> +	 * as a writer.
> +	 */
> +	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
> +	btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);

I am really unsure if this is more readable, but: you could do here:
lockdep_release:
	btrfs_lockdep_release(...)
	if (ret)
		goto cleanup_transaction;
	btrfs_might_wait_for_event()
which has the merit of keeping the control flow relatively linear for 
cleanup at the end. I find the end a little confusing, with the lockdep 
release at the end and then jumping backwards to other cleanup, but I 
can't find a better way than this proposal to untangle it, and I'm not
sure it's better...

>   	cleanup_transaction(trans, ret);
>   
>   	return ret;
> +lockdep_release:
> +	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
> +	goto cleanup_transaction;
>   }
>   
>   /*
