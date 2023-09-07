Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BA7978D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbjIGQ4T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjIGQ4R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:56:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C04171F
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 09:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B2311F8A4;
        Thu,  7 Sep 2023 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694088042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jk+Tdn0PDpC6hH4PFGwbJw9HirdxBN1k/1OUVhdELdE=;
        b=fxomYMeonOMYKn2qXRhdVa99rUf0bXTZMudkyeVCvRwudcq9FGzZnU4nULdYa12bINeDlz
        jXL5GcM0lqkpnbNlbuyg7KEo8nmgwAkh6hWR+fMpNFCxT5XOQm9bpnfT+KGVybJH4h05ga
        SJhVA0P/Sv6dvPPrCn4WlS2n8bQiG4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694088042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jk+Tdn0PDpC6hH4PFGwbJw9HirdxBN1k/1OUVhdELdE=;
        b=2fiSRHq5n+BJwJjUmUfsT3WOksHnIn7Yfw7zOI81YG9CcDm4WvsIgkPJ26Rgzv1y8LyDDV
        kNt2lM0YCBnpKqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18192138F9;
        Thu,  7 Sep 2023 12:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ne8zBWq7+WTODQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:00:42 +0000
Date:   Thu, 7 Sep 2023 13:54:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 10/18] btrfs: track original extent owner in head_ref
Message-ID: <20230907115410.GG3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <1e87e9b6be869c41c9f4f8faab803c9391b5502e.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e87e9b6be869c41c9f4f8faab803c9391b5502e.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:57PM -0700, Boris Burkov wrote:
> Simple quotas requires tracking the original creating root of any given
> extent. This gets complicated when multiple subvolumes create
> overlapping/contradictory refs in the same transaction. For example,
> due to modifying or deleting an extent while also snapshotting it.
> 
> To resolve this in a general way, take advantage of the fact that we are
> essentially already tracking this for handling releasing reservations.
> The head ref coalesces the various refs and uses must_insert_reserved to
> check if it needs to create an extent/free reservation. Store the ref
> that set must_insert_reserved as the owning ref on the head ref.
> 
> Note that this can result in writing an extent for the very first time
> with an owner different from its only ref, but it will look the same as
> if you first created it with the original owning ref, then added the
> other ref, then removed the owning ref.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c | 20 ++++++++++++++++----
>  fs/btrfs/delayed-ref.h |  7 +++++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index f0bae1e1c455..28ba7a9eb3c3 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -623,6 +623,16 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
>  	BUG_ON(existing->is_data != update->is_data);
>  
>  	spin_lock(&existing->lock);
> +
> +	/*
> +	 * When freeing an extent, we may not know the owning root
> +	 * when we first create the head_ref. However, some deref before the
> +	 * last deref will know it, so we just need to update the head_ref
> +	 * accordingly

We now write comments as full sentences so please use a "." at the end.

> +	 */
> +	if (!existing->owning_root)
> +		existing->owning_root = update->owning_root;
> +
>  	if (update->must_insert_reserved) {
>  		/* if the extent was freed and then
>  		 * reallocated before the delayed ref
> @@ -632,6 +642,7 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
>  		 * Set it again here
>  		 */
>  		existing->must_insert_reserved = update->must_insert_reserved;
> +		existing->owning_root = update->owning_root;
>  
>  		/*
>  		 * update the num_bytes so we make sure the accounting
> @@ -694,7 +705,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
>  				  struct btrfs_qgroup_extent_record *qrecord,
>  				  u64 bytenr, u64 num_bytes, u64 ref_root,
>  				  u64 reserved, int action, bool is_data,
> -				  bool is_system)
> +				  bool is_system, u64 owning_root)
>  {
>  	int count_mod = 1;
>  	bool must_insert_reserved = false;
> @@ -735,6 +746,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
>  	head_ref->num_bytes = num_bytes;
>  	head_ref->ref_mod = count_mod;
>  	head_ref->must_insert_reserved = must_insert_reserved;
> +	head_ref->owning_root = owning_root;
>  	head_ref->is_data = is_data;
>  	head_ref->is_system = is_system;
>  	head_ref->ref_tree = RB_ROOT_CACHED;
> @@ -922,7 +934,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  
>  	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
>  			      generic_ref->tree_ref.ref_root, 0, action,
> -			      false, is_system);
> +			      false, is_system, generic_ref->owning_root);
>  	head_ref->extent_op = extent_op;
>  
>  	delayed_refs = &trans->transaction->delayed_refs;
> @@ -1014,7 +1026,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  	}
>  
>  	init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_root,
> -			      reserved, action, true, false);
> +			      reserved, action, true, false, generic_ref->owning_root);
>  	head_ref->extent_op = NULL;
>  
>  	delayed_refs = &trans->transaction->delayed_refs;
> @@ -1060,7 +1072,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  
>  	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
> -			      BTRFS_UPDATE_DELAYED_HEAD, false, false);
> +			      BTRFS_UPDATE_DELAYED_HEAD, false, false, 0);
>  	head_ref->extent_op = extent_op;
>  
>  	delayed_refs = &trans->transaction->delayed_refs;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 0729850a9193..71f0a6e5d583 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -117,6 +117,13 @@ struct btrfs_delayed_ref_head {
>  	 * the free has happened.
>  	 */
>  	bool must_insert_reserved;
> +
> +	/*
> +	 * The root which triggered the allocation when
> +	 * must_insert_reserved is true
> +	 */
> +	u64 owning_root;

Please reorder this so it's not among bools, this would create a gap of
7 bytes before that.

> +
>  	bool is_data;
>  	bool is_system;
>  	bool processing;
> -- 
> 2.41.0
