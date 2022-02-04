Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB64A986A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiBDL34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiBDL3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:29:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5CCC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF1361AD7
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 11:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BCDC004E1;
        Fri,  4 Feb 2022 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643974194;
        bh=epoAnmYLiahWkJJ4dP5ayWi5SVyqoZjLQ7Fny6muvhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zm3Z2YgBQJwQi9a1mRTiQ9SXel5h0k38CmH9Xr8LMJFTpYhZCuc1J6shM5WuKGlIL
         UEglLkEXyBACRfi2lP69MBn4+S9TGiq5ILf1pzmnbR6Qrh35H8e0BpDUHEb30a1YyT
         sdR2t6EoTZlsc1oO9Ol/DF5HC+xsw3MsuAQRlKCuAKRK+RUo/Xwlk3YQ+xgwSbdVtW
         jh06ucVE3SO2dkjgYX0pazecnMd9BkvCT8G82M/DU73YTZ7WgjCW7stT253uNQerAO
         I5U9jnKBdOU+r35WoteeRJrG3Sxi5B0dcGHQcIamVnFxGU1N80dcbSYN4/XFlEsUJL
         lISrYpmOut80w==
Date:   Fri, 4 Feb 2022 11:29:51 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: fail transaction when a setget bounds check
 failure is detected
Message-ID: <Yf0OLxcQ5mxiwWM5@debian9.Home>
References: <cover.1643904960.git.dsterba@suse.com>
 <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617931b8ee53e8fcde1560eb86758024ca753f42.1643904960.git.dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 06:26:31PM +0100, David Sterba wrote:
> As the setget check only sets the bit, we need to use it in the
> transaction:
> 
> - when attempting to start a new one, fail with EROFS as if would be
>   aborted in another way already
> 
> - in should_end_transaction
> 
> - when transaction is about to end, insert an explicit abort
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/transaction.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 6db634ebae17..f48194df6c33 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -591,6 +591,9 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	if (BTRFS_FS_ERROR(fs_info))
>  		return ERR_PTR(-EROFS);
>  
> +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> +		return ERR_PTR(-EROFS);
> +
>  	if (current->journal_info) {
>  		WARN_ON(type & TRANS_EXTWRITERS);
>  		h = current->journal_info;
> @@ -924,6 +927,9 @@ static bool should_end_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  
> +	if (test_bit(BTRFS_FS_SETGET_COMPLAINS, &fs_info->flags))
> +		return true;
> +
>  	if (btrfs_check_space_for_delayed_refs(fs_info))
>  		return true;
>  
> @@ -969,6 +975,11 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
>  	struct btrfs_transaction *cur_trans = trans->transaction;
>  	int err = 0;
>  
> +	/* If a serious error was detected abort the transaction early */
> +	if (!TRANS_ABORTED(trans) &&
> +	    test_bit(BTRFS_FS_SETGET_COMPLAINS, &info->flags))
> +		btrfs_abort_transaction(trans, -EIO);

Instead of sprinkling the test for BTRFS_FS_SETGET_COMPLAINS in all
these places, it seems to me it could be included in BTRFS_FS_ERROR().
And then having check_setget_bounds() call btrfs_handle_fs_error().

That would remove the need for all this code. Wouldn't it?

> +
>  	if (refcount_read(&trans->use_count) > 1) {
>  		refcount_dec(&trans->use_count);
>  		trans->block_rsv = trans->orig_rsv;

This misses one important case:

  task starts/joins/attaches a transaction

  fails one of the bounds check when accessing some extent buffer

  calls btrfs_commit_transaction()

The transaction ends up committed.

So a check and abort in the commit path, right before writing the super blocks,
should be in place.

With the above suggestions for check_setget_bounds() and BTRFS_FS_ERROR(),
this case would be handled automatically like the others, so no need for
sprinkling the checks and aborts in several places.

Thanks.

> -- 
> 2.34.1
> 
