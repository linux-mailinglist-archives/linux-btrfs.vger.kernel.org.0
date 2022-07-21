Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CAF57C1B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiGUAnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 20:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGUAnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 20:43:14 -0400
Received: from out20-206.mail.aliyun.com (out20-206.mail.aliyun.com [115.124.20.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AD8422CE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 17:43:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04438395|-1;BR=01201311R731S33rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.348375-0.033158-0.618467;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.OZHTrZs_1658364162;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OZHTrZs_1658364162)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 08:42:43 +0800
Date:   Thu, 21 Jul 2022 08:42:46 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Subject: Re: [PATCH v3 1/6] btrfs: Add a lockdep model for the num_writers wait event
Cc:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
In-Reply-To: <20220720233818.3107724-2-iangelak@fb.com>
References: <20220720233818.3107724-1-iangelak@fb.com> <20220720233818.3107724-2-iangelak@fb.com>
Message-Id: <20220721084245.2C65.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,


> Annotate the num_writers wait event in fs/btrfs/transaction.c with lockdep
> in order to catch deadlocks involving this wait event.
> 
> Use a read/write lockdep map for the annotation. A thread starting/joining
> the transaction acquires the map as a reader when it increments
> cur_trans->num_writers and it acquires the map as a writer before it
> blocks on the wait event.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/ctree.h       | 47 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/disk-io.c     |  2 ++
>  fs/btrfs/transaction.c | 37 ++++++++++++++++++++++++++++-----
>  3 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 202496172059..d4d69c0e001e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1095,6 +1095,8 @@ struct btrfs_fs_info {
>  	/* Updates are not protected by any lock */
>  	struct btrfs_commit_stats commit_stats;
>  
> +	struct lockdep_map btrfs_trans_num_writers_map;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> @@ -1175,6 +1177,51 @@ enum {
>  	BTRFS_ROOT_UNFINISHED_DROP,
>  };
>  
> +/*
> + * Lockdep annotation for wait events.
> + *
> + * @b: The struct where the lockdep map is defined
> + * @lock: The lockdep map corresponding to a wait event
> + *
> + * This macro is used to annotate a wait event. In this case a thread acquires
> + * the lockdep map as writer (exclusive lock) because it has to block until all
> + * the threads that hold the lock as readers signal the condition for the wait
> + * event and release their locks.
> + */
> +#define btrfs_might_wait_for_event(b, lock)					\
> +	do {									\
> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_);			\
> +		rwsem_release(&b->lock##_map, _THIS_IP_);			\
> +	} while (0)
> +
> +/*
> + * Protection for the resource/condition of a wait event.
> + *
> + * @b: The struct where the lockdep map is defined
> + * @lock: The lockdep map corresponding to a wait event
> + *
> + * Many threads can modify the condition for the wait event at the same time
> + * and signal the threads that block on the wait event. The threads that
> + * modify the condition and do the signaling acquire the lock as readers
> + * (shared lock).
> + */
> +#define btrfs_lockdep_acquire(b, lock)						\
> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
> +
> +/*
> + * Used after signaling the condition for a wait event to release the
> + * lockdep map held by a reader thread.
> + */
> +#define btrfs_lockdep_release(b, lock)						\
> +	rwsem_release(&b->lock##_map, _THIS_IP_)
> +
> +/* Initialization of the lockdep map */
> +#define btrfs_lockdep_init_map(b, lock)                                        \
> +	do {									\
> +		static struct lock_class_key lock##_key;			\
> +		lockdep_init_map(&b->lock##_map, #lock, &lock##_key, 0);	\
> +	} while (0)
> +
>  static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>  {
>  	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3fac429cf8a4..38831c730d61 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3074,6 +3074,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	mutex_init(&fs_info->zoned_data_reloc_io_lock);
>  	seqlock_init(&fs_info->profiles_lock);
>  
> +	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_writers);
> +
>  	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>  	INIT_LIST_HEAD(&fs_info->space_info);
>  	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 0bec10740ad3..d8287ec890bc 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -313,6 +313,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  		atomic_inc(&cur_trans->num_writers);
>  		extwriter_counter_inc(cur_trans, type);
>  		spin_unlock(&fs_info->trans_lock);
> +		btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
>  		return 0;
>  	}
>  	spin_unlock(&fs_info->trans_lock);
> @@ -334,16 +335,20 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  	if (!cur_trans)
>  		return -ENOMEM;
>  
> +	btrfs_lockdep_acquire(fs_info, btrfs_trans_num_writers);
> +
>  	spin_lock(&fs_info->trans_lock);
>  	if (fs_info->running_transaction) {
>  		/*
>  		 * someone started a transaction after we unlocked.  Make sure
>  		 * to redo the checks above
>  		 */
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		kfree(cur_trans);
>  		goto loop;
>  	} else if (BTRFS_FS_ERROR(fs_info)) {
>  		spin_unlock(&fs_info->trans_lock);
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		kfree(cur_trans);
>  		return -EROFS;
>  	}
> @@ -1022,6 +1027,9 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>  	extwriter_counter_dec(cur_trans, trans->type);
>  
>  	cond_wake_up(&cur_trans->writer_wait);
> +
> +	btrfs_lockdep_release(info, btrfs_trans_num_writers);
> +
>  	btrfs_put_transaction(cur_trans);
>  
>  	if (current->journal_info == trans)
> @@ -1994,6 +2002,12 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
>  	if (cur_trans == fs_info->running_transaction) {
>  		cur_trans->state = TRANS_STATE_COMMIT_DOING;
>  		spin_unlock(&fs_info->trans_lock);
> +
> +		/*
> +		 * The thread has already released the lockdep map as reader already in
> +		 * btrfs_commit_transaction().
> +		 */
> +		btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
>  		wait_event(cur_trans->writer_wait,
>  			   atomic_read(&cur_trans->num_writers) == 1);
>  
> @@ -2222,7 +2236,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  			btrfs_put_transaction(prev_trans);
>  			if (ret)
> -				goto cleanup_transaction;
> +				goto lockdep_release;
>  		} else {
>  			spin_unlock(&fs_info->trans_lock);
>  		}
> @@ -2236,7 +2250,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		 */
>  		if (BTRFS_FS_ERROR(fs_info)) {
>  			ret = -EROFS;
> -			goto cleanup_transaction;
> +			goto lockdep_release;
>  		}
>  	}
>  
> @@ -2250,19 +2264,21 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	ret = btrfs_start_delalloc_flush(fs_info);
>  	if (ret)
> -		goto cleanup_transaction;
> +		goto lockdep_release;
>  
>  	ret = btrfs_run_delayed_items(trans);
>  	if (ret)
> -		goto cleanup_transaction;
> +		goto lockdep_release;
>  
>  	wait_event(cur_trans->writer_wait,
>  		   extwriter_counter_read(cur_trans) == 0);
>  
>  	/* some pending stuffs might be added after the previous flush. */
>  	ret = btrfs_run_delayed_items(trans);
> -	if (ret)
> +	if (ret) {
> +		btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
>  		goto cleanup_transaction;
> +	}
>  
>  	btrfs_wait_delalloc_flush(fs_info);
>  
> @@ -2284,6 +2300,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	add_pending_snapshot(trans);
>  	cur_trans->state = TRANS_STATE_COMMIT_DOING;
>  	spin_unlock(&fs_info->trans_lock);
> +
> +	/*
> +	 * The thread has started/joined the transaction thus it holds the lockdep
> +	 * map as a reader. It has to release it before acquiring the lockdep map
> +	 * as a writer.
> +	 */
> +	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
> +	btrfs_might_wait_for_event(fs_info, btrfs_trans_num_writers);
>  	wait_event(cur_trans->writer_wait,
>  		   atomic_read(&cur_trans->num_writers) == 1);
>  
> @@ -2515,6 +2539,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	cleanup_transaction(trans, ret);
>  
>  	return ret;
> +lockdep_release:
> +	btrfs_lockdep_release(fs_info, btrfs_trans_num_writers);
> +	goto cleanup_transaction;
>  }


Could we rename 'lockdep_release' to 'cleanup_transaction_with_lockdep_release',
and put it just before 'cleanup_transaction:'?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/21



