Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF77AF1CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjIZRiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 13:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjIZRiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 13:38:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E5DC
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 10:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA81B1F749;
        Tue, 26 Sep 2023 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695749888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tL7V1eBfg90VrVaZnfsU+BLZBgbIxvOWPZUUWyao2QM=;
        b=UbH0drDhPvw7o8l8iHZXheMc8nhL1CUhKp5ODfni0z7LseZd6vvpxhKMjIcv8qXU4tSHjt
        S7MnL/RokWCuFO+wxCet2oBOPwWlTeON0vo3MP1MOF8BG6mQJQGLAxp2WCv2RcPpsb1leh
        ExmkoBNMics1jRMn6mBWbtcI9wMK8i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695749888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tL7V1eBfg90VrVaZnfsU+BLZBgbIxvOWPZUUWyao2QM=;
        b=7uyrjNCKozsZf15tPy0nifisWw/tIIG6zPjxpthRvXG9fL9ptaa+5gbP3jvUBF2SoHoM7k
        7Tj81iJ+fUoUzzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D85913434;
        Tue, 26 Sep 2023 17:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pcC1IQAXE2XJQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Sep 2023 17:38:08 +0000
Date:   Tue, 26 Sep 2023 19:31:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: error out when COWing block using a stale
 transaction
Message-ID: <20230926173130.GU13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695731838.git.fdmanana@suse.com>
 <a678551d318d5dd9835ad9800dfb41c787654dd1.1695731841.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a678551d318d5dd9835ad9800dfb41c787654dd1.1695731841.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 01:45:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_cow_block() we have these checks to verify we are not using a
> stale transaction (a past transaction with an unblocked state or higher),
> and the only thing we do is to trigger a WARN with a message and a stack
> trace. This however is a critical problem, highly unexpected and if it
> happens it's most likely due to a bug, so we should error out and turn the
> fs into error state so that such issue is much more easily noticed if it's
> triggered.
> 
> The problem is critical because using such stale transaction will lead to
> not persisting the extent buffer used for the COW operation, as allocating
> a tree block adds the range of the respective extent buffer to the
> ->dirty_pages iotree of the transaction, and a stale transaction, in the
> unlocked state or higher, will not flush dirty extent buffers anymore,
> therefore resulting in not persisting the tree block and resource leaks
> (not cleaning the dirty_pages iotree for example).
> 
> So do the following changes:
> 
> 1) Return -EUCLEAN if we find a stale transaction;
> 
> 2) Turn the fs into error state, with error -EUCLEAN, so that no
>    transaction can be committed, and generate a stack trace;
> 
> 3) Combine both conditions into a single if statement, as both are related
>    and have the same error message;
> 
> 4) Mark the check as unlikely, since this is not expected to ever happen.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 56d2360e597c..dff2e07ba437 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -686,14 +686,22 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
>  		btrfs_err(fs_info,
>  			"COW'ing blocks on a fs root that's being dropped");
>  
> -	if (trans->transaction != fs_info->running_transaction)
> -		WARN(1, KERN_CRIT "trans %llu running %llu\n",
> -		       trans->transid,
> -		       fs_info->running_transaction->transid);
> -
> -	if (trans->transid != fs_info->generation)
> -		WARN(1, KERN_CRIT "trans %llu running %llu\n",
> -		       trans->transid, fs_info->generation);
> +	/*
> +	 * COWing must happen through a running transaction, which always
> +	 * matches the current fs generation (it's a transaction with a state
> +	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
> +	 * into error state to prevent the commit of any transaction.
> +	 */
> +	if (unlikely(trans->transaction != fs_info->running_transaction ||
> +		     trans->transid != fs_info->generation)) {
> +		btrfs_handle_fs_error(fs_info, -EUCLEAN,

Can this be a transaction abort? The helper btrfs_handle_fs_error() is
from times before we had the abort mechanism and should not be used in
new code when the abort can be done. There are cases where transaction
is not available (like superblock commit), but these are exceptions.

> +"unexpected transaction when attempting to COW block %llu on root %llu, transaction %llu running transaction %llu fs generation %llu",
> +				      buf->start, btrfs_root_id(root),
> +				      trans->transid,
> +				      fs_info->running_transaction->transid,
> +				      fs_info->generation);
> +		return -EUCLEAN;
> +	}
>  
>  	if (!should_cow_block(trans, root, buf)) {
>  		*cow_ret = buf;
> -- 
> 2.40.1
