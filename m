Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9C57B8C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiGTOsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiGTOsV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04C5004D
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:48:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m6so13612537qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWU/wnGDSgEcAQTeg21OzOvzWZN+QGUFU1Ny3iAEF/M=;
        b=u0l1TGn62AUl1Oi+JKXZ5ka4/KldNFBORzidoqC3tHG8DgMeExH7aK6ibcFtUHwW+f
         gYJj9jlkPxgWqLx4jgdcdmlmIJCg8w5mx/fn/Mylie1yUwdNdv4HYa4DZpd6jz1wf3QZ
         xz/dnMA1ztLLwRZTS9ppK14btYzp522QUEEt8TEszXIh/0iolvqYksNwA3YJUAra1b56
         URlLU81K56kinBQTogJI6jjBgE6RXod/C69TetGyDe9o2uWONdcJ9qZBhhhwYOc+pzGg
         kRalsak9P1ZGFkTNLzfbcoz2k8k/IwxdGRaev46DAslLy6zyhlNzzjPhjhEb/quGTM3B
         5Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JWU/wnGDSgEcAQTeg21OzOvzWZN+QGUFU1Ny3iAEF/M=;
        b=sfQP/Kb8se99OS44MV2axG8odomr2Cfxxn7MRkLDFIYroQRYMuBWZ87JCqrxVDlGW1
         ZjKtHUwj3s6FAQ5gFAMBF1NmqYN8OmxBEHe3tHqmFuXuIH63Y9XctN6rcsJq4OSrMGDc
         fmXXiiTimUMIV9Q8DxBdwwUY8uZW/kF+e8RD/rDkWU0AC7YA82TvawLgJl0HRkuFWclZ
         gDFCH4JBs2FHjINkALuWLP8vIKlXwz4qOniq77+2IrxANpIzP4rbtl6p7pGJuwitkSd+
         NeATIyb3JyYz8edoglHn+dLkmmFWs24/ct6+LsY2eo6FYV3bFjM3Al4D5ZmQgESHhYmf
         niqw==
X-Gm-Message-State: AJIora8g6MKUnd1ZCAMB/W6z6X2BCxR7fev69NqHt2q0xK1BJQ9skp4P
        NPOq87QXSsyMxV3/XehfUVNXbO9Nm7eC3Q==
X-Google-Smtp-Source: AGRyM1v0MVs2fokpogskc4C7g8jhvjrPANn15kBnH15Io1tWsNJLqtK/58zFibsjqyPmHeVhf1aKcw==
X-Received: by 2002:a05:6214:5e04:b0:473:6b81:a725 with SMTP id li4-20020a0562145e0400b004736b81a725mr29680678qvb.111.1658328499176;
        Wed, 20 Jul 2022 07:48:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a288f00b006a5d2eb58b2sm17905300qkp.33.2022.07.20.07.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:18 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:48:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/5] btrfs: Add lockdep models for the transaction
 states wait events
Message-ID: <YtgVsY3FOxm+04NV@localhost.localdomain>
References: <20220719040954.3964407-1-iangelak@fb.com>
 <20220719040954.3964407-4-iangelak@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719040954.3964407-4-iangelak@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 09:09:56PM -0700, Ioannis Angelakopoulos wrote:
> Add a lockdep annotation for the transaction states that have wait
> events; 1) TRANS_STATE_COMMIT_START, 2) TRANS_STATE_UNBLOCKED, 3)
> TRANS_STATE_SUPER_COMMITTED, and 4) TRANS_STATE_COMPLETED in
> fs/btrfs/transaction.c.
> 
> With the exception of the lockdep annotation for TRANS_STATE_COMMIT_START
> the transaction thread has to acquire the lockdep maps for the transaction
> states as reader after the lockdep map for num_writers is released so that
> lockdep does not complain.
> 
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>  fs/btrfs/ctree.h       | 20 +++++++++++++++
>  fs/btrfs/disk-io.c     | 17 +++++++++++++
>  fs/btrfs/transaction.c | 57 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 88 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 586756f831e5..e6c7cafcd296 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1097,6 +1097,7 @@ struct btrfs_fs_info {
>  
>  	struct lockdep_map btrfs_trans_num_writers_map;
>  	struct lockdep_map btrfs_trans_num_extwriters_map;
> +	struct lockdep_map btrfs_state_change_map[4];
>  
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
> @@ -1178,6 +1179,13 @@ enum {
>  	BTRFS_ROOT_UNFINISHED_DROP,
>  };
>  
> +enum btrfs_lockdep_trans_states {
> +	BTRFS_LOCKDEP_TRANS_COMMIT_START,
> +	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
> +	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
> +	BTRFS_LOCKDEP_TRANS_COMPLETED,
> +};
> +
>  #define btrfs_might_wait_for_event(b, lock) \
>  	do { \
>  		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
> @@ -1190,6 +1198,18 @@ enum {
>  #define btrfs_lockdep_release(b, lock) \
>  	rwsem_release(&b->lock##_map, _THIS_IP_)
>  
> +#define btrfs_might_wait_for_state(b, i) \
> +	do { \
> +		rwsem_acquire(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_); \
> +		rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_); \
> +	} while (0)
> +
> +#define btrfs_trans_state_lockdep_acquire(b, i) \
> +	rwsem_acquire_read(&b->btrfs_state_change_map[i], 0, 0, _THIS_IP_)
> +
> +#define btrfs_trans_state_lockdep_release(b, i) \
> +	rwsem_release(&b->btrfs_state_change_map[i], _THIS_IP_)
> +
>  static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>  {
>  	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b1193584ba49..be5cf86fa992 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3048,6 +3048,10 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  {
>  	static struct lock_class_key btrfs_trans_num_writers_key;
>  	static struct lock_class_key btrfs_trans_num_extwriters_key;
> +	static struct lock_class_key btrfs_trans_commit_start_key;
> +	static struct lock_class_key btrfs_trans_unblocked_key;
> +	static struct lock_class_key btrfs_trans_sup_committed_key;
> +	static struct lock_class_key btrfs_trans_completed_key;
>  
>  	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
>  	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> @@ -3084,6 +3088,19 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  					 "btrfs_trans_num_extwriters",
>  					 &btrfs_trans_num_extwriters_key, 0);
>  
> +	lockdep_init_map(&fs_info->btrfs_state_change_map[0],
> +					 "btrfs_trans_commit_start",
> +					 &btrfs_trans_commit_start_key, 0);
> +	lockdep_init_map(&fs_info->btrfs_state_change_map[1],
> +					 "btrfs_trans_unblocked",
> +					 &btrfs_trans_unblocked_key, 0);
> +	lockdep_init_map(&fs_info->btrfs_state_change_map[2],
> +					 "btrfs_trans_sup_commited",

s/commited/committed/

> +					 &btrfs_trans_sup_committed_key, 0);
> +	lockdep_init_map(&fs_info->btrfs_state_change_map[3],
> +					 "btrfs_trans_completed",
> +					 &btrfs_trans_completed_key, 0);
> +
>  	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
>  	INIT_LIST_HEAD(&fs_info->space_info);
>  	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index c9751a05c029..e4efaa27ec17 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -550,6 +550,7 @@ static void wait_current_trans(struct btrfs_fs_info *fs_info)
>  		refcount_inc(&cur_trans->use_count);
>  		spin_unlock(&fs_info->trans_lock);
>  
> +		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
>  		wait_event(fs_info->transaction_wait,
>  			   cur_trans->state >= TRANS_STATE_UNBLOCKED ||
>  			   TRANS_ABORTED(cur_trans));
> @@ -949,6 +950,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
>  			goto out;  /* nothing committing|committed */
>  	}
>  
> +	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
>  	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
>  	btrfs_put_transaction(cur_trans);
>  out:
> @@ -1980,6 +1982,7 @@ void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
>  	 * Wait for the current transaction commit to start and block
>  	 * subsequent transaction joins
>  	 */
> +	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
>  	wait_event(fs_info->transaction_blocked_wait,
>  		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
>  		   TRANS_ABORTED(cur_trans));
> @@ -2137,14 +2140,16 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	ktime_t interval;
>  
>  	ASSERT(refcount_read(&trans->use_count) == 1);
> +	btrfs_trans_state_lockdep_acquire(fs_info,
> +					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
>  
>  	/* Stop the commit early if ->aborted is set */
>  	if (TRANS_ABORTED(cur_trans)) {
>  		ret = cur_trans->aborted;
> -		btrfs_end_transaction(trans);
> -		return ret;
> +		goto lockdep_trans_commit_start_release;
>  	}
>  
> +
>  	btrfs_trans_release_metadata(trans);
>  	trans->block_rsv = NULL;
>  
> @@ -2160,8 +2165,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		 */
>  		ret = btrfs_run_delayed_refs(trans, 0);
>  		if (ret) {
> -			btrfs_end_transaction(trans);
> -			return ret;
> +			goto lockdep_trans_commit_start_release;
>  		}
>  	}
>  
> @@ -2192,8 +2196,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		if (run_it) {
>  			ret = btrfs_start_dirty_block_groups(trans);
>  			if (ret) {
> -				btrfs_end_transaction(trans);
> -				return ret;
> +				goto lockdep_trans_commit_start_release;
>  			}
>  		}
>  	}
> @@ -2209,7 +2212,17 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  		if (trans->in_fsync)
>  			want_state = TRANS_STATE_SUPER_COMMITTED;
> +
> +		btrfs_trans_state_lockdep_release(fs_info,
> +						  BTRFS_LOCKDEP_TRANS_COMMIT_START);
>  		ret = btrfs_end_transaction(trans);
> +
> +		if (want_state == TRANS_STATE_COMPLETED)
> +			btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
> +		else
> +			btrfs_might_wait_for_state(fs_info,
> +						   BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
> +
>  		wait_for_commit(cur_trans, want_state);
>  
>  		if (TRANS_ABORTED(cur_trans))
> @@ -2222,6 +2235,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	cur_trans->state = TRANS_STATE_COMMIT_START;
>  	wake_up(&fs_info->transaction_blocked_wait);
> +	btrfs_trans_state_lockdep_release(fs_info,
> +					  BTRFS_LOCKDEP_TRANS_COMMIT_START);
>  
>  	if (cur_trans->list.prev != &fs_info->trans_list) {
>  		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
> @@ -2235,6 +2250,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  			refcount_inc(&prev_trans->use_count);
>  			spin_unlock(&fs_info->trans_lock);
>  
> +			if (want_state == TRANS_STATE_COMPLETED)
> +				btrfs_might_wait_for_state(fs_info,
> +							   BTRFS_LOCKDEP_TRANS_COMPLETED);
> +			else
> +				btrfs_might_wait_for_state(fs_info,
> +							   BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);

You do this everywhere we call wait_for_commit(), you can push these
btrfs_might_wait_for_state() into wait_for_commit and make everything a bit
cleaner.  Thanks,

Josef
