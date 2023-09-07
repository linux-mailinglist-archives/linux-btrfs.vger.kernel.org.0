Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E32797C09
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjIGSgz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbjIGSgy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 14:36:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF29D
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 11:36:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B69B32187E;
        Thu,  7 Sep 2023 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694090068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeThfLjvaCACKQrFTaFqaIX4x3+TM9U+WjXWZ7/4haQ=;
        b=IrralYgdcL/WI+S5sJ5nkHig2DAcD5swOLo2zYoiTaTGOy0B2LAhJ2ZPNlRlLr7hEEnutX
        6BZN6AztBeCZXGleIKrXA7h6kxOHk8SNODrSy9St8MX/DebKytZ8Ws2HXcWYERZE1m3tQK
        ux9lCo5vF82deKpXtpP/raLL1Mm9SFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694090068;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeThfLjvaCACKQrFTaFqaIX4x3+TM9U+WjXWZ7/4haQ=;
        b=hFvHLFSUJT1S9RFOjwFiJBJ1k6G8cX8Hzmm/IkL6B2XX0/r0+24nu5MHnxrBaU3IGjtj00
        oS9wloHjhib4WVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C93C138FA;
        Thu,  7 Sep 2023 12:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2yuYHVTD+WRrIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:34:28 +0000
Date:   Thu, 7 Sep 2023 14:27:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 16/18] btrfs: track metadata relocation cow with
 simple quota
Message-ID: <20230907122756.GM3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <88d41836e1f44a21ab284db9eba5aa01365e9458.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d41836e1f44a21ab284db9eba5aa01365e9458.1690495785.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:03PM -0700, Boris Burkov wrote:
> Relocation cows metadata blocks in two cases for the reloc root:
> - copying the subvol root item when creating the reloc root
> - copying a btree node when there is a cow during relocation
> 
> In both cases, the resulting btree node hits an abnormal code path with
> respect to the owner field in its btrfs_header. It first creates the
> root item for the new objectid, which populates the reloc root id, and
> it at this point that delayed refs are created.
> 
> Later, it fully copies the old node into the new node (including the
> original owner field) which overwrites it. This results in a simple
> quotas mismatch where we run the delayed ref for the reloc root which
> has no simple quota effect (reloc root is not an fstree) but when we
> ultimately delete the node, the owner is the real original fstree and we
> do free the space.
> 
> To work around this without tampering with the behavior of relocation,
> add a parameter to btrfs_add_tree_block that lets the relocation code
> path specify a different owning root than the "operating" root (in this
> case, owning root is the real root and the operating root is the reloc
> root). These can naturally be plumbed into delayed refs that have the
> same concept.
> 
> Note that this is a double count in some sense, but a relatively natural
> one, as there are really two extents, and the old one will be deleted
> soon. This is consistent with how data relocation extents are accounted
> by simple quotas.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.c       | 22 ++++++++++++++--------
>  fs/btrfs/disk-io.c     |  4 ++--
>  fs/btrfs/extent-tree.c |  8 ++++++--
>  fs/btrfs/extent-tree.h |  3 ++-
>  fs/btrfs/ioctl.c       |  2 +-
>  5 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a4cb4b642987..cb0d4535de37 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -316,6 +316,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  	int ret = 0;
>  	int level;
>  	struct btrfs_disk_key disk_key;
> +	u64 reloc_src_root = 0;
>  
>  	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
>  		trans->transid != fs_info->running_transaction->transid);
> @@ -328,9 +329,11 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  	else
>  		btrfs_node_key(buf, &disk_key, 0);
>  
> +	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
> +		reloc_src_root = btrfs_header_owner(buf);
>  	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
>  				     &disk_key, level, buf->start, 0,
> -				     BTRFS_NESTING_NEW_ROOT);
> +				     BTRFS_NESTING_NEW_ROOT, reloc_src_root);
>  	if (IS_ERR(cow))
>  		return PTR_ERR(cow);
>  
> @@ -522,6 +525,7 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
>  	int last_ref = 0;
>  	int unlock_orig = 0;
>  	u64 parent_start = 0;
> +	u64 reloc_src_root = 0;
>  
>  	if (*cow_ret == buf)
>  		unlock_orig = 1;
> @@ -540,12 +544,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
>  	else
>  		btrfs_node_key(buf, &disk_key, 0);
>  
> -	if ((root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) && parent)
> -		parent_start = parent->start;
> -
> +	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
> +		if (parent)
> +			parent_start = parent->start;
> +		reloc_src_root = btrfs_header_owner(buf);
> +	}
>  	cow = btrfs_alloc_tree_block(trans, root, parent_start,
>  				     root->root_key.objectid, &disk_key, level,
> -				     search_start, empty_size, nest);
> +				     search_start, empty_size, nest, reloc_src_root);
>  	if (IS_ERR(cow))
>  		return PTR_ERR(cow);
>  
> @@ -2956,7 +2962,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
>  
>  	c = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
>  				   &lower_key, level, root->node->start, 0,
> -				   BTRFS_NESTING_NEW_ROOT);
> +				   BTRFS_NESTING_NEW_ROOT, 0);
>  	if (IS_ERR(c))
>  		return PTR_ERR(c);
>  
> @@ -3100,7 +3106,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
>  
>  	split = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
>  				       &disk_key, level, c->start, 0,
> -				       BTRFS_NESTING_SPLIT);
> +				       BTRFS_NESTING_SPLIT, 0);
>  	if (IS_ERR(split))
>  		return PTR_ERR(split);
>  
> @@ -3853,7 +3859,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
>  	right = btrfs_alloc_tree_block(trans, root, 0, root->root_key.objectid,
>  				       &disk_key, 0, l->start, 0,
>  				       num_doubles ? BTRFS_NESTING_NEW_ROOT :
> -				       BTRFS_NESTING_SPLIT);
> +				       BTRFS_NESTING_SPLIT, 0);
>  	if (IS_ERR(right))
>  		return PTR_ERR(right);
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b4495d4c1533..e2b0e11800fc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -862,7 +862,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>  	root->root_key.offset = 0;
>  
>  	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
> -				      BTRFS_NESTING_NORMAL);
> +				      BTRFS_NESTING_NORMAL, 0);
>  	if (IS_ERR(leaf)) {
>  		ret = PTR_ERR(leaf);
>  		leaf = NULL;
> @@ -939,7 +939,7 @@ int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
>  	 */
>  
>  	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
> -			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
> +			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL, 0);
>  	if (IS_ERR(leaf))
>  		return PTR_ERR(leaf);
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 395ab46e520b..50db75529a83 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4989,7 +4989,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  					     const struct btrfs_disk_key *key,
>  					     int level, u64 hint,
>  					     u64 empty_size,
> -					     enum btrfs_lock_nesting nest)
> +					     enum btrfs_lock_nesting nest,
> +					     u64 reloc_src_root)

Please move the new parameter before 'nest'.

>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_key ins;
> @@ -5001,6 +5002,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  	int ret;
>  	u32 blocksize = fs_info->nodesize;
>  	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
> +	u64 owning_root;
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  	if (btrfs_is_testing(fs_info)) {
> @@ -5027,11 +5029,13 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  		ret = PTR_ERR(buf);
>  		goto out_free_reserved;
>  	}
> +	owning_root = btrfs_header_owner(buf);
>  
>  	if (root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
>  		if (parent == 0)
>  			parent = ins.objectid;
>  		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
> +		owning_root = reloc_src_root;
>  	} else
>  		BUG_ON(parent > 0);
>  
> @@ -5051,7 +5055,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  		extent_op->level = level;
>  
>  		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
> -				       ins.objectid, ins.offset, parent, btrfs_header_owner(buf));
> +				       ins.objectid, ins.offset, parent, owning_root);
>  		btrfs_init_tree_ref(&generic_ref, level, root_objectid,
>  				    root->root_key.objectid, false);
>  		btrfs_ref_tree_mod(fs_info, &generic_ref);
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index 7c27652880a2..99b11e278ae4 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -118,7 +118,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  					     const struct btrfs_disk_key *key,
>  					     int level, u64 hint,
>  					     u64 empty_size,
> -					     enum btrfs_lock_nesting nest);
> +					     enum btrfs_lock_nesting nest,
> +					     u64 reloc_src_root);
>  void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  			   u64 root_id,
>  			   struct extent_buffer *buf,
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c9b069077fd0..f3807def6596 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -657,7 +657,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>  		goto out;
>  
>  	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
> -				      BTRFS_NESTING_NORMAL);
> +				      BTRFS_NESTING_NORMAL, 0);
>  	if (IS_ERR(leaf)) {
>  		ret = PTR_ERR(leaf);
>  		goto out;
> -- 
> 2.41.0
