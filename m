Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95877F17A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348579AbjHQHuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 03:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348588AbjHQHue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 03:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBE71728
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 00:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0987D62682
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 07:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CEBC433C7;
        Thu, 17 Aug 2023 07:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692258631;
        bh=iQyDyoQ5I5DezDucHMEpZ39MK350YLtBq23Wh2gDh3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQQbEU8IhDC/mRQhkZsRmgwOfHowPeTMT732XKQFtmS8b1cSPgAIDDSMkRvGDYXCT
         kV+j8pO1vRGK6oDi0SO2hYl5/TBmpfXSfeUFzeTt37AAAguFuR3MQBOhlIavGdokfZ
         f9y76icBdlajFyYQNseZu9olsa69sQwhaCDejynucZod7I4XL3TzwG2Ryp9NBMjhLQ
         gUhxxGWtbYNYHR6d2Be+BtMwb+g96ByugTyOb+VCkV3+z9l+2sJ7aoyokDEbLNrIhG
         E0cNbeRVBpD7FlyBByHJPf4ZYyCupno+w7/LDotzncXqOCo/+1XHyymaLjVZNHgrQI
         XPQ4KeaTJOB4Q==
Date:   Thu, 17 Aug 2023 08:50:28 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: prevent metadata flush from being interrupted
 for del_balance_item()
Message-ID: <ZN3RRO83qL6UDay2@debian0.Home>
References: <dfcb047887dbec9f252835fce458564f991fcd02.1692252334.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfcb047887dbec9f252835fce458564f991fcd02.1692252334.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 17, 2023 at 02:06:24PM +0800, Qu Wenruo wrote:
> [BUG]
> 
> There is an internal bug report that there are only 3 lines of btrfs
> errors, then btrfs falls read-only:
> 
>  [358958.022131] BTRFS info (device dm-9): balance: canceled
>  [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014: errno=-4 unknown
>  [358958.022150] BTRFS info (device dm-9): forced readonly
> 
> [CAUSE]
> The error number -4 is -EINTR, and according to the code line (although
> backported kernel, the code is still relevant upstream), it's the
> btrfs_handle_fs_error() call inside reset_balance_state().
> 
> This can happen when we try to start a transaction which requires
> metadata flushing.
> 
> This metadata flushing can be interrupted by signal, thus it can return
> -EINTR.
> 
> For our case, the -EINTR is deadly because we are unable to handle the
> interrupted metadata flushing at this timing, and would immediately mark
> the fs read-only in the following call chain:
> 
> reset_balance_state()
> |- del_balance_item()
> |  `- btrfs_start_transation_fallback_global_rsv()
> |     `- start_transaction()
> |	 `- btrfs_block_rsv_add()
> |	    `- __reserve_bytes()
> |	       `- handle_reserve_ticket()
> |		  `- wait_reserve_ticket()
> |		     `- prepare_to_wait_event()
> |			This wait has TASK_KILLABLE, thus can be
> |			interrupted.
> |			Thus we return -EINTR.
> |
> |- IS_ERR(trans) triggered
> |- btrfs_handle_fs_error()
>    The fs is marked read-only.
> 
> [FIX]
> For this particular call site, we can not afford just erroring out with
> -EINTR.
> 
> Thus here we introduce a new flush type,
> BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE, for this call site.
> 
> This new flush type would wait for the ticket using TASK_UNINTERRUPTIBLE
> instead, thus it won't be interrupted by signal.
> 
> Since we're here, also enhance the error message a little to make it
> more readable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Instead retrying, introduce a new flush type
>   The retrying can lead to dead loop as inside kernel space the signal
>   won't be cleared until we reach user space.
>   Thus we may retry forever.
> 
>   Instead going TASK_UNINTERRUPTIBLE for this particular callsite would
>   be a safer bet.
> ---
>  fs/btrfs/space-info.c  | 11 +++++++++--
>  fs/btrfs/space-info.h  |  5 +++++
>  fs/btrfs/transaction.c |  9 +++++++++
>  fs/btrfs/transaction.h |  3 +++
>  fs/btrfs/volumes.c     |  8 ++++++--
>  5 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d7e8cd4f140c..6fce57c6f2a1 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1454,15 +1454,21 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
>  
>  static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info,
> +				enum btrfs_reserve_flush_enum flush,
>  				struct reserve_ticket *ticket)
>  
>  {
> +	int state;
>  	DEFINE_WAIT(wait);
>  	int ret = 0;
>  
> +	if (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE)
> +		state = TASK_UNINTERRUPTIBLE;
> +	else
> +		state = TASK_KILLABLE;
>  	spin_lock(&space_info->lock);
>  	while (ticket->bytes > 0 && ticket->error == 0) {
> -		ret = prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
> +		ret = prepare_to_wait_event(&ticket->wait, &wait, state);
>  		if (ret) {
>  			/*
>  			 * Delete us from the list. After we unlock the space
> @@ -1511,7 +1517,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  	case BTRFS_RESERVE_FLUSH_DATA:
>  	case BTRFS_RESERVE_FLUSH_ALL:
>  	case BTRFS_RESERVE_FLUSH_ALL_STEAL:
> -		wait_reserve_ticket(fs_info, space_info, ticket);
> +	case BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE:
> +		wait_reserve_ticket(fs_info, space_info, flush, ticket);
>  		break;
>  	case BTRFS_RESERVE_FLUSH_LIMIT:
>  		priority_reclaim_metadata_space(fs_info, space_info, ticket,
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 0bb9d14e60a8..e9d8243da0fc 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -50,6 +50,11 @@ enum btrfs_reserve_flush_enum {
>  	 */
>  	BTRFS_RESERVE_FLUSH_ALL_STEAL,
>  
> +	/*
> +	 * The same as BTRFS_RESERVE_FLUSH_ALL_STEAL, but won't be interrupred.
> +	 */
> +	BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
> +
>  	/*
>  	 * This is for btrfs_use_block_rsv only.  We have exhausted our block
>  	 * rsv and our global block rsv.  This can happen for things like
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index ab09542f2170..6a09e80b6875 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -785,6 +785,15 @@ struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
>  				 BTRFS_RESERVE_FLUSH_ALL_STEAL, false);
>  }
>  
> +struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterruptible(
> +					struct btrfs_root *root,
> +					unsigned int num_items)
> +{
> +	return start_transaction(root, num_items, TRANS_START,
> +				 BTRFS_RESERVE_FLUSH_ALL_STEAL_UNINTERRUPTIBLE,
> +				 false);
> +}
> +
>  struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root)
>  {
>  	return start_transaction(root, 0, TRANS_JOIN, BTRFS_RESERVE_NO_FLUSH,
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 8e9fa23bd7fe..06f245e6c546 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -233,6 +233,9 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
>  struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
>  					struct btrfs_root *root,
>  					unsigned int num_items);
> +struct btrfs_trans_handle *btrfs_start_transaction_fallback_uninterruptible(
> +					struct btrfs_root *root,
> +					unsigned int num_items);
>  struct btrfs_trans_handle *btrfs_join_transaction(struct btrfs_root *root);
>  struct btrfs_trans_handle *btrfs_join_transaction_spacecache(struct btrfs_root *root);
>  struct btrfs_trans_handle *btrfs_join_transaction_nostart(struct btrfs_root *root);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 189da583bb67..389e14fc2c3e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3507,7 +3507,11 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
>  	if (!path)
>  		return -ENOMEM;
>  
> -	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
> +	/*
> +	 * Here we don't want this transaction start to be interrupted, or we
> +	 * will mark the fs read-only.
> +	 */
> +	trans = btrfs_start_transaction_fallback_uninterruptible(root, 0);

Ouch, adding a new flush method, a new transaction start API, etc, just for this.

So I replied to you on the thread for v1, but before I could reply you went this
way anyway:

https://lore.kernel.org/linux-btrfs/CAL3q7H5g1E8ZWqtAA6Ltb+_aWAqOm6iR57ojnGCyskZZrFDMuQ@mail.gmail.com/

I'm not convinded the -EINTR comes from btrfs_start_transaction_fallback_global_rsv(),
it should not since it's not doing any space reservation.  Correct me if I missed something.

Thanks.

>  	if (IS_ERR(trans)) {
>  		btrfs_free_path(path);
>  		return PTR_ERR(trans);
> @@ -3594,7 +3598,7 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
>  	kfree(bctl);
>  	ret = del_balance_item(fs_info);
>  	if (ret)
> -		btrfs_handle_fs_error(fs_info, ret, NULL);
> +		btrfs_handle_fs_error(fs_info, ret, "failed to delete balance item");
>  }
>  
>  /*
> -- 
> 2.41.0
> 
