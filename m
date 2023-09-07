Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547CC7976DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjIGQRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbjIGQR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:17:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C53A95A
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 08:58:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19F662187A;
        Thu,  7 Sep 2023 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694089138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbCm6T0VxK0Xzjfawyh7BIh1wON0WHr+hDmPTwE1H9E=;
        b=D2BnK+eu41XSTFljoeX3ptNgQxKR1LECFp+bIxEBXBqVyn+pqe7ML9IueAzEXK4+0A3pkd
        D4QWQWT4RmOkgBNWM21WHhorCKs9dPgiwjwb7xdueTRcrmLoLnLAVGusujWvsAPBp5ipH1
        oWDW69HloIXSBf158jHH/zeBACh4ZAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694089138;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbCm6T0VxK0Xzjfawyh7BIh1wON0WHr+hDmPTwE1H9E=;
        b=UQhbOpKPlTY0QePHSXXPlC1rMqVPtcEyHBF5taUPeFw2pnHtTNQ6wP3kfPkC5jlsFj+acA
        44K1W7iQ2rX9OCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6EDE138F9;
        Thu,  7 Sep 2023 12:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pwKdM7G/+WT2FwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:18:57 +0000
Date:   Thu, 7 Sep 2023 14:12:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 13/18] btrfs: record simple quota deltas
Message-ID: <20230907121225.GJ3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <749ea44143d910a3aeef915f2cb19081ac8d2ede.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749ea44143d910a3aeef915f2cb19081ac8d2ede.1690495785.git.boris@bur.io>
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

On Thu, Jul 27, 2023 at 03:13:00PM -0700, Boris Burkov wrote:
> At the moment that we run delayed refs, we make the final ref-count
> based decision on creating/removing extent (and metadata) items.
> Therefore, it is exactly the spot to hook up simple quotas.
> 
> There are a few important subtleties to the fields we must collect to
> accurately track simple quotas, particularly when removing an extent.
> When removing a data extent, the ref could be in any tree (due to
> reflink, for example) and so we need to recover the owning root id from
> the owner ref item. When removing a metadata extent, we know the owning
> root from the owner field in the header when we create the delayed ref,
> so we can recover it from there.
> 
> We must also be careful to handle reservations properly to not leaked
> reserved space. The happy path is freeing the reservation when the
> simple quota delta runs on a data extent. If that doesn't happen, due to
> refs canceling out or some error, the ref head already has the
> must_insert_reserved machinery to handle this, so we piggy back on that
> and use it to clean up the reserved data.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c |  1 +
>  fs/btrfs/delayed-ref.h |  6 +++
>  fs/btrfs/extent-tree.c | 85 +++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 28ba7a9eb3c3..874c1853d9b1 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -745,6 +745,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
>  	head_ref->bytenr = bytenr;
>  	head_ref->num_bytes = num_bytes;
>  	head_ref->ref_mod = count_mod;
> +	head_ref->reserved_bytes = reserved;
>  	head_ref->must_insert_reserved = must_insert_reserved;
>  	head_ref->owning_root = owning_root;
>  	head_ref->is_data = is_data;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 71f0a6e5d583..221d400dd88f 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -104,6 +104,12 @@ struct btrfs_delayed_ref_head {
>  	 */
>  	int ref_mod;
>  
> +	/*
> +	 * Track reserved bytes when setting must_insert_reserved.
> +	 * On success or cleanup, we will need to free the reservation.
> +	 */
> +	u64 reserved_bytes;
> +
>  	/*
>  	 * when a new extent is allocated, it is just reserved in memory
>  	 * The actual extent isn't inserted into the extent allocation tree
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 09fb321fa560..1b5efd03ef83 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -47,6 +47,7 @@
>  
>  
>  static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
> +			       struct btrfs_delayed_ref_head *href,
>  			       struct btrfs_delayed_ref_node *node, u64 parent,
>  			       u64 root_objectid, u64 owner_objectid,
>  			       u64 owner_offset, int refs_to_drop,
> @@ -1482,6 +1483,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>  }
>  
>  static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
> +				struct btrfs_delayed_ref_head *href,
>  				struct btrfs_delayed_ref_node *node,
>  				struct btrfs_delayed_extent_op *extent_op,
>  				bool insert_reserved)
> @@ -1505,18 +1507,28 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  	ref_root = ref->root;
>  
>  	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
> +		struct btrfs_simple_quota_delta delta = {
> +			.root = href->owning_root,
> +			.num_bytes = node->num_bytes,
> +			.rsv_bytes = href->reserved_bytes,
> +			.is_data = true,
> +			.is_inc	= true,
> +		};
> +
>  		if (extent_op)
>  			flags |= extent_op->flags_to_set;
>  		ret = alloc_reserved_file_extent(trans, parent, ref_root,
>  						 flags, ref->objectid,
>  						 ref->offset, &ins,
>  						 node->ref_mod);
> +		if (!ret)
> +			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>  		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
>  					     ref->objectid, ref->offset,
>  					     node->ref_mod, extent_op);
>  	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
> -		ret = __btrfs_free_extent(trans, node, parent,
> +		ret = __btrfs_free_extent(trans, href, node, parent,
>  					  ref_root, ref->objectid,
>  					  ref->offset, node->ref_mod,
>  					  extent_op);
> @@ -1632,11 +1644,13 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
>  }
>  
>  static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
> +				struct btrfs_delayed_ref_head *href,
>  				struct btrfs_delayed_ref_node *node,
>  				struct btrfs_delayed_extent_op *extent_op,
>  				bool insert_reserved)
>  {
>  	int ret = 0;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_delayed_tree_ref *ref;
>  	u64 parent = 0;
>  	u64 ref_root = 0;
> @@ -1656,13 +1670,23 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  		return -EIO;
>  	}
>  	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
> +		struct btrfs_simple_quota_delta delta = {
> +			.root = href->owning_root,
> +			.num_bytes = fs_info->nodesize,
> +			.rsv_bytes = 0,
> +			.is_data = false,
> +			.is_inc = true,
> +		};
> +
>  		BUG_ON(!extent_op || !extent_op->update_flags);
>  		ret = alloc_reserved_tree_block(trans, node, extent_op);
> +		if (!ret)
> +			btrfs_record_simple_quota_delta(fs_info, &delta);
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>  		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
>  					     ref->level, 0, 1, extent_op);
>  	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
> -		ret = __btrfs_free_extent(trans, node, parent, ref_root,
> +		ret = __btrfs_free_extent(trans, href, node, parent, ref_root,
>  					  ref->level, 0, 1, extent_op);
>  	} else {
>  		BUG();
> @@ -1672,6 +1696,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  
>  /* helper function to actually process a single delayed ref entry */
>  static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
> +			       struct btrfs_delayed_ref_head *href,
>  			       struct btrfs_delayed_ref_node *node,
>  			       struct btrfs_delayed_extent_op *extent_op,
>  			       bool insert_reserved)
> @@ -1686,12 +1711,12 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
>  
>  	if (node->type == BTRFS_TREE_BLOCK_REF_KEY ||
>  	    node->type == BTRFS_SHARED_BLOCK_REF_KEY)
> -		ret = run_delayed_tree_ref(trans, node, extent_op,
> +		ret = run_delayed_tree_ref(trans, href, node, extent_op,
>  					   insert_reserved);
>  	else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
>  		 node->type == BTRFS_SHARED_DATA_REF_KEY)
> -		ret = run_delayed_data_ref(trans, node, extent_op,
> -					   insert_reserved);
> +		ret = run_delayed_data_ref(trans, href, node,
> +					   extent_op, insert_reserved);
>  	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
>  		ret = 0;
>  	else
> @@ -1788,6 +1813,11 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
>  		spin_unlock(&delayed_refs->lock);
>  		nr_items += btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
>  	}
> +	if (head->must_insert_reserved && head->is_data &&
> +	    btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)

The check for qgroup mode should be the first condition.

> +		btrfs_qgroup_free_refroot(fs_info, head->owning_root,
> +					  head->reserved_bytes,
> +					  BTRFS_QGROUP_RSV_DATA);
>  
>  	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
>  }
> @@ -1934,8 +1964,8 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
>  		locked_ref->extent_op = NULL;
>  		spin_unlock(&locked_ref->lock);
>  
> -		ret = run_one_delayed_ref(trans, ref, extent_op,
> -					  must_insert_reserved);
> +		ret = run_one_delayed_ref(trans, locked_ref, ref,
> +					  extent_op, must_insert_reserved);
>  
>  		btrfs_free_delayed_extent_op(extent_op);
>  		if (ret) {
> @@ -2857,11 +2887,12 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
>  }
>  
>  static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
> -				     u64 bytenr, u64 num_bytes, bool is_data)
> +				     u64 bytenr, struct btrfs_simple_quota_delta *delta)
>  {
>  	int ret;
> +	u64 num_bytes = delta->num_bytes;
>  
> -	if (is_data) {
> +	if (delta->is_data) {
>  		struct btrfs_root *csum_root;
>  
>  		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
> @@ -2872,6 +2903,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>  		}
>  	}
>  
> +	ret = btrfs_record_simple_quota_delta(trans->fs_info, delta);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
>  	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
>  	if (ret) {
>  		btrfs_abort_transaction(trans, ret);
> @@ -2952,6 +2989,7 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>   * And that (13631488 EXTENT_DATA_REF <HASH>) gets removed.
>   */
>  static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
> +			       struct btrfs_delayed_ref_head *href,
>  			       struct btrfs_delayed_ref_node *node, u64 parent,
>  			       u64 root_objectid, u64 owner_objectid,
>  			       u64 owner_offset, int refs_to_drop,
> @@ -2974,6 +3012,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  	u64 bytenr = node->bytenr;
>  	u64 num_bytes = node->num_bytes;
>  	bool skinny_metadata = btrfs_fs_incompat(info, SKINNY_METADATA);
> +	u64 delayed_ref_root = href->owning_root;
>  
>  	extent_root = btrfs_extent_root(info, bytenr);
>  	ASSERT(extent_root);
> @@ -3172,6 +3211,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  			}
>  		}
>  	} else {
> +		struct btrfs_simple_quota_delta delta = {
> +			.root = delayed_ref_root,
> +			.num_bytes = num_bytes,
> +			.rsv_bytes = 0,
> +			.is_data = is_data,
> +			.is_inc = false,
> +		};
> +
>  		/* In this branch refs == 1 */
>  		if (found_extent) {
>  			if (is_data && refs_to_drop !=
> @@ -3210,6 +3257,16 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  				num_to_del = 2;
>  			}
>  		}
> +		/*
> +		 * We can't infer the data owner from the delayed ref, so we
> +		 * need to try to get it from the owning ref item.
> +		 *
> +		 * If it is not present, then that extent was not written under
> +		 * simple quotas mode, so we don't need to account for its
> +		 * deletion.
> +		 */
> +		if (is_data)
> +			delta.root = btrfs_get_extent_owner_root(trans->fs_info, leaf, extent_slot);
>  
>  		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
>  				      num_to_del);
> @@ -3219,7 +3276,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  		}
>  		btrfs_release_path(path);
>  
> -		ret = do_free_extent_accounting(trans, bytenr, num_bytes, is_data);
> +		ret = do_free_extent_accounting(trans, bytenr, &delta);
>  	}
>  	btrfs_release_path(path);
>  
> @@ -4790,6 +4847,13 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
>  	int ret;
>  	struct btrfs_block_group *block_group;
>  	struct btrfs_space_info *space_info;
> +	struct btrfs_simple_quota_delta delta = {
> +		.root = root_objectid,
> +		.num_bytes = ins->offset,
> +		.rsv_bytes = 0,
> +		.is_data = true,
> +		.is_inc = true,
> +	};
>  
>  	/*
>  	 * Mixed block groups will exclude before processing the log so we only
> @@ -4818,6 +4882,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
>  					 offset, ins, 1);
>  	if (ret)
>  		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
> +	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
>  	btrfs_put_block_group(block_group);
>  	return ret;
>  }
> -- 
> 2.41.0
