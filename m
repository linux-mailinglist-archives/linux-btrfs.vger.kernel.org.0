Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AA77E1D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbjHPMps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjHPMpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 08:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A33826B7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 05:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF2D6201C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 12:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A168C433C8;
        Wed, 16 Aug 2023 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692189931;
        bh=6N54LuLBSnPDDR/sbI9Nfk/a59rYhCfqM5SDD8atkTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efA2JHIECRjJ/AysGvTxAWQzhMS24R8VilrGuqRQr4X01PuPbBbEMIgaluqsX3oO5
         9HmXrmAQZYmj9JxSUs1l5X5yT+sxB5t1hfa+XBKPg2v1DlwFdCx7hd4RZOadTtTWUw
         GedJG9UMG0drCCBLp8/+zhQa00USmz1ltgSrzX1+2NRXWhCoV99D5hLxvPXeHjJ8se
         tRuGAMNjjT9feWKcmkH4LXkhvhGZ5VViOzdFvZWnxqOCFWEtooqvMneC/ZXfdk024w
         nXMBXyIx3KEa8DWDB5Qm1FTsnHxMt4+327LhUjUO1aRO1xTCEXApepZkY7mvp+1IuR
         /j7JFe0nfoOxA==
Date:   Wed, 16 Aug 2023 13:45:28 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: retry flushing for del_balance_item() if the
 transaction is interrupted
Message-ID: <ZNzE6CFOzu9kDG+G@debian0.Home>
References: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 16, 2023 at 06:28:16PM +0800, Qu Wenruo wrote:
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
> For our case, the -EINTR is deadly because we don't handle the error at
> all, and immediately mark the fs read-only in the following call chain:
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
> This patch would fix the error by retry until either we got a valid
> transaction handle, or got an error other than -EINTR.
> 
> Since we're here, also enhance the error message a little to make it
> more readable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 189da583bb67..e83711fe31bb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3507,7 +3507,15 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
>  	if (!path)
>  		return -ENOMEM;
>  
> -	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
> +	do {
> +		/*
> +		 * The transaction starting here can be interrupted, but if we
> +		 * just error out we would mark the fs read-only.
> +		 * Thus here we try to start the transaction again if it's
> +		 * interrupted.
> +		 */
> +		trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
> +	} while (IS_ERR(trans) && PTR_ERR(trans) == -EINTR);

This condition can be simply:  trans == ERR_PTR(-EINTR)

My only concern is if this can turn into an infinite loop due to a high enough rate of
signals being sent to the process...

Instead of this I would make reset_balance_state() just print a warning, and not
call btrfs_handle_fs_error()  and then change insert_balance_item() to not fail in
case the item already exists - instead just overwrite it.

Thanks.


>  	if (IS_ERR(trans)) {
>  		btrfs_free_path(path);
>  		return PTR_ERR(trans);
> @@ -3594,7 +3602,7 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
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
