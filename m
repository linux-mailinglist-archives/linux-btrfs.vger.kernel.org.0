Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6053AAE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356058AbiFAQUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFAQUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 12:20:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4B7938A
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 09:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C9AFB8190F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99576C385A5;
        Wed,  1 Jun 2022 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654100443;
        bh=aLkWtRRDmD6L8w53q9OOTlg1C+caQR92dnC1KgLUoC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MN+lBwo3YE87GtJawBpOMCz+1ND8oL309xWi2kH4wdYACHBOSF+sjUbBdx6hgKEKw
         9EYSnAzvZRHjv9aq4sy+cXgyRCDLlbppj809iyQvdvqPGLf370Xkh3Q94UHy7h7/6N
         Y+X/WY8Vgdl9dEenYMdXWhu4Y6T+MtMQejDpkSFvPGs6j+v5nVcPVeLiX35ivx4xqt
         8vj2uRDlt0VQ4tV8s89L5p7TgUq8fwokj6M85yO+KM/IPjLYYMYC/SaaN2jjTgz4pO
         mEIJicRoNXekoZ8hUxmz3t+5RCGItosH/fcyIuVp0HhQ6vskXHjiJigCBOLBL+Wdsc
         BkDGt7CYCQ+Fw==
Date:   Wed, 1 Jun 2022 17:20:40 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: fix deadlock with fsync+fiemap+full sync
Message-ID: <20220601162040.GA3307738@falcondesktop>
References: <cover.1654096526.git.josef@toxicpanda.com>
 <b069a36b638b96c599b5d31d46d789039341ad9f.1654096526.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b069a36b638b96c599b5d31d46d789039341ad9f.1654096526.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 11:16:25AM -0400, Josef Bacik wrote:
> We are hitting the following deadlock in production occasionally
> 
> Task 1		Task 2		Task 3		Task 4		Task 5
> 		fsync(A)
> 		 start trans
> 						start commit
> 				falloc(A)
> 				 lock 5m-10m
> 				 start trans
> 				  wait for commit
> fiemap(A)
>  lock 0-10m
>   wait for 5m-10m
>    (have 0-5m locked)
> 
> 		 have btrfs_need_log_full_commit
> 		  !full_sync
> 		  wait_ordered_extents
> 								finish_ordered_io(A)
> 								lock 0-5m
> 								DEADLOCK
> 
> We have an existing dependency of file extent lock -> transaction.
> However in fsync if we tried to do the fast logging, but then had to
> fall back to committing the transaction, we will be forced to call
> btrfs_wait_ordered_range() to make sure all of our extents are updated.
> 
> This creates a dependency of transaction -> file extent lock, because
> btrfs_finish_ordered_io() will need to take the file extent lock in
> order to run the ordered extents.
> 
> Fix this by stopping the transaction if we have to do the full commit
> and we attempted to do the fast logging.  Then attach to the transaction
> and commit it if we need to.

The subject is confusing, it mentions deadlock with "full fsync". With that
you mean a transaction commit, and not the slow fsync mode (related to the
inode flag BTRFS_INODE_NEEDS_FULL_SYNC). And looking at the diagram and the
code we mention !full_sync, the fast fsync path, so that makes it even more
confusing.

Can we replace "full fsync" with transaction commit (subject)?

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file.c | 67 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1fd827b99c1b..9c799731cc70 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2323,25 +2323,62 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	 */
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>  
> -	if (ret != BTRFS_NO_LOG_SYNC) {
> +	if (ret == BTRFS_NO_LOG_SYNC) {
> +		ret = btrfs_end_transaction(trans);
> +		goto out;
> +	}
> +
> +	/* We successfully logged the inode, attempt to sync the log. */
> +	if (!ret) {
> +		ret = btrfs_sync_log(trans, root, &ctx);
>  		if (!ret) {
> -			ret = btrfs_sync_log(trans, root, &ctx);
> -			if (!ret) {
> -				ret = btrfs_end_transaction(trans);
> -				goto out;
> -			}
> -		}
> -		if (!full_sync) {
> -			ret = btrfs_wait_ordered_range(inode, start, len);
> -			if (ret) {
> -				btrfs_end_transaction(trans);
> -				goto out;
> -			}
> +			ret = btrfs_end_transaction(trans);
> +			goto out;
>  		}
> -		ret = btrfs_commit_transaction(trans);
> -	} else {
> +	}
> +
> +	/*
> +	 * At this point we need to commit the transaction because we had
> +	 * btrfs_need_log_full_commit() or some other error.
> +	 *
> +	 * If we didn't do a full sync we have to stop the trans handle, wait on
> +	 * the ordered extents, start it again and commit the transaction.  If
> +	 * we attempt to wait on the ordered extents here we could deadlock with
> +	 * something like fallocate() that is holding the extent lock trying to
> +	 * start a transaction while some other thread is trying to commit the
> +	 * transaction while we (fsync) are currently holding the transaction
> +	 * open.
> +	 */
> +	if (!full_sync) {
>  		ret = btrfs_end_transaction(trans);
> +		if (ret)
> +			goto out;
> +		ret = btrfs_wait_ordered_range(inode, start, len);

We could wait only on the ordered extents collected at ctx.ordered_extents,
like this it would avoid the need to flush and wait for any new writes that
may have started after we unlocked the inode.

There's no helper to just wait for a list of ordered extents, so that's
probably why you made it like that, to make it as short as possible.

But still, something to consider even if for later only.

Otherwise it looks good, thanks.

> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * This is safe to use here because we're only interested in
> +		 * making sure the transaction that had the ordered extents is
> +		 * committed.  We aren't waiting on anything past this point,
> +		 * we're purely getting the transaction and committing it.
> +		 */
> +		trans = btrfs_attach_transaction_barrier(root);
> +		if (IS_ERR(trans)) {
> +			ret = PTR_ERR(trans);
> +
> +			/*
> +			 * We committed the transaction and there's no currently
> +			 * running transaction, this means everything we care
> +			 * about made it to disk and we are done.
> +			 */
> +			if (ret == -ENOENT)
> +				ret = 0;
> +			goto out;
> +		}
>  	}
> +
> +	ret = btrfs_commit_transaction(trans);
>  out:
>  	ASSERT(list_empty(&ctx.list));
>  	err = file_check_and_advance_wb_err(file);
> -- 
> 2.26.3
> 
