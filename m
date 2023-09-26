Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52D7AF1EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjIZRsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRsL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 13:48:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524279F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 10:48:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C465321870;
        Tue, 26 Sep 2023 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695750482;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGsb1jF4Phrv29tjdXWUX5Xo3e1tT4O7R66b09O38lo=;
        b=uxAji1notHgZKkjaTterpRBofloSqSlp33JlIIhFx2cYStFV4rXAmUBJ0BKuY8OEw+4n/0
        QKus6ARB9ltwJCCAIyt22k1FabhNcyaPTVyRQpmEAk4qY+/IlU9ueNZyFHn2/EIY9zgZIQ
        QxVDQIXrVZKALdZjjn3LmuBOHw78m6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695750482;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGsb1jF4Phrv29tjdXWUX5Xo3e1tT4O7R66b09O38lo=;
        b=vFWlzUNkwrz/qzMREDoCi1x5NNadbMYmRQ3TP9XNO9wdipdpJAv+f8jhmxwlflt15PEckA
        CyO7hfpyhXtuu4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A784513434;
        Tue, 26 Sep 2023 17:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H7YTKFIZE2WkSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 26 Sep 2023 17:48:02 +0000
Date:   Tue, 26 Sep 2023 19:41:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/8] btrfs: error out when reallocating block for defrag
 using a stale transaction
Message-ID: <20230926174125.GV13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695731838.git.fdmanana@suse.com>
 <c8083f9239853dc397beda6a3dc97c93da62137b.1695731842.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8083f9239853dc397beda6a3dc97c93da62137b.1695731842.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 01:45:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_realloc_node() we have these checks to verify we are not using a
> stale transaction (a past transaction with an unblocked state or higher),
> and the only thing we do is to trigger two WARN_ON(). This however is a
> critical problem, highly unexpected and if it happens it's most likely due
> to a bug, so we should error out and turn the fs into error state so that
> such issue is much more easily noticed if it's triggered.
> 
> The problem is critical because in btrfs_realloc_node() we COW tree blocks,
> and using such stale transaction will lead to not persisting the extent
> buffers used for the COW operations, as allocating tree block adds the
> range of the respective extent buffers to the ->dirty_pages iotree of the
> transaction, and a stale transaction, in the unlocked state or higher,
> will not flush dirty extent buffers anymore, therefore resulting in not
> persisting the tree block and resource leaks (not cleaning the dirty_pages
> iotree for example).
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
>  fs/btrfs/ctree.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4eef1a7d1db6..8619172bcba1 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -817,8 +817,22 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
>  	int progress_passed = 0;
>  	struct btrfs_disk_key disk_key;
>  
> -	WARN_ON(trans->transaction != fs_info->running_transaction);
> -	WARN_ON(trans->transid != fs_info->generation);
> +	/*
> +	 * COWing must happen through a running transaction, which always
> +	 * matches the current fs generation (it's a transaction with a state
> +	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
> +	 * into error state to prevent the commit of any transaction.
> +	 */
> +	if (unlikely(trans->transaction != fs_info->running_transaction ||
> +		     trans->transid != fs_info->generation)) {
> +		btrfs_handle_fs_error(fs_info, -EUCLEAN,

Same question as in patch 1, could this be btrfs_abort_transaction()?

> +"unexpected transaction when attempting to reallocate parent %llu for root %llu, transaction %llu running transaction %llu fs generation %llu",
> +				      parent->start, btrfs_root_id(root),
> +				      trans->transid,
> +				      fs_info->running_transaction->transid,
> +				      fs_info->generation);
> +		return -EUCLEAN;
> +	}
>  
>  	parent_nritems = btrfs_header_nritems(parent);
>  	blocksize = fs_info->nodesize;
> -- 
> 2.40.1
