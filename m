Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4553AB06
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiFAQZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345573AbiFAQZP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 12:25:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A758D6A5
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 09:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A399B8190F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 16:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A86C385B8;
        Wed,  1 Jun 2022 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654100711;
        bh=4BpFXtzX1gA1uqy4/JDRojTWEHRxPkxsDN1tqSov8u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9ro7WGXY8woMCsPiFVdqgtcIQUrzaE4fuak8HU1b9hDbxmk3CQTEgf3VCnyJf0kj
         N9qGDAvHYyRgsWMYa0mai6SsFmmeL+qjY+37Kvn9yHSoIvLOeKjmmb9zcXGsZdS4ti
         oszE4GxusG8vJqip+C7Qgx7y5se0DboaMxkMWcCADy6SuSDxEjloOgh7T6GicQ0vJL
         0aSto98QrJF0JPRsxWnbCEuvFX2QJuITtnKsiqIQtZsoTsmBRh5gE8a3stuU7GHds9
         fQdzqDb1cj3sXxvrK4xeS+adLF7FTPemmXx9M2n2JzGy2bqw/vDsfPxGI6tjdSJIXl
         pHuV/5rb34ugQ==
Date:   Wed, 1 Jun 2022 17:25:08 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: make the return value for log syncing
 consistent
Message-ID: <20220601162508.GB3307738@falcondesktop>
References: <cover.1654096526.git.josef@toxicpanda.com>
 <249998ea8b056e9d69d85f32c1996a34a305c4c3.1654096526.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249998ea8b056e9d69d85f32c1996a34a305c4c3.1654096526.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 11:16:24AM -0400, Josef Bacik wrote:
> Currently we will return 1 or -EAGAIN if we decide we need to commit
> the transaction rather than sync the log.  In practice this doesn't
> really matter, we interpret any !0 and !BTRFS_NO_LOG_SYNC as needing to
> commit the transaction.  However this makes it hard to figure out what
> the correct thing to do is.  Fix this up by defining
> BTRFS_LOG_FORCE_COMMIT and using this in all the places where we want to
> force the transaction to be committed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/tree-log.c | 18 +++++++++---------
>  fs/btrfs/tree-log.h |  3 +++
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 1201f083d4db..d898ba13285f 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -171,7 +171,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  		int index = (root->log_transid + 1) % 2;
>  
>  		if (btrfs_need_log_full_commit(trans)) {
> -			ret = -EAGAIN;
> +			ret = BTRFS_LOG_FORCE_COMMIT;
>  			goto out;
>  		}
>  
> @@ -194,7 +194,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
>  		 * writing.
>  		 */
>  		if (zoned && !created) {
> -			ret = -EAGAIN;
> +			ret = BTRFS_LOG_FORCE_COMMIT;
>  			goto out;
>  		}
>  
> @@ -3121,7 +3121,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  
>  	/* bail out if we need to do a full commit */
>  	if (btrfs_need_log_full_commit(trans)) {
> -		ret = -EAGAIN;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		mutex_unlock(&root->log_mutex);
>  		goto out;
>  	}
> @@ -3222,7 +3222,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  		}
>  		btrfs_wait_tree_log_extents(log, mark);
>  		mutex_unlock(&log_root_tree->log_mutex);
> -		ret = -EAGAIN;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		goto out;
>  	}
>  
> @@ -3261,7 +3261,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
>  		blk_finish_plug(&plug);
>  		btrfs_wait_tree_log_extents(log, mark);
>  		mutex_unlock(&log_root_tree->log_mutex);
> -		ret = -EAGAIN;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		goto out_wake_log_root;
>  	}
>  
> @@ -5848,7 +5848,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
>  	    inode_only == LOG_INODE_ALL &&
>  	    inode->last_unlink_trans >= trans->transid) {
>  		btrfs_set_log_full_commit(trans);
> -		ret = 1;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		goto out_unlock;
>  	}
>  
> @@ -6562,12 +6562,12 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
>  	bool log_dentries = false;
>  
>  	if (btrfs_test_opt(fs_info, NOTREELOG)) {
> -		ret = 1;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		goto end_no_trans;
>  	}
>  
>  	if (btrfs_root_refs(&root->root_item) == 0) {
> -		ret = 1;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  		goto end_no_trans;
>  	}
>  
> @@ -6665,7 +6665,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
>  end_trans:
>  	if (ret < 0) {
>  		btrfs_set_log_full_commit(trans);
> -		ret = 1;
> +		ret = BTRFS_LOG_FORCE_COMMIT;
>  	}
>  
>  	if (ret)
> diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
> index 1620f8170629..c3baa9d979a9 100644
> --- a/fs/btrfs/tree-log.h
> +++ b/fs/btrfs/tree-log.h
> @@ -12,6 +12,9 @@
>  /* return value for btrfs_log_dentry_safe that means we don't need to log it at all */
>  #define BTRFS_NO_LOG_SYNC 256
>  
> +/* we can't use the tree log for whatever reason, force a transaction commit */
> +#define BTRFS_LOG_FORCE_COMMIT 1

At btrfs_sync_file(), we shoudl also replace 1 with BTRFS_LOG_FORCE_COMMIT.
Otherwise it looks good, thanks.

> +
>  struct btrfs_log_ctx {
>  	int log_ret;
>  	int log_transid;
> -- 
> 2.26.3
> 
