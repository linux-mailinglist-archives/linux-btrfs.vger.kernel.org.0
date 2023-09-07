Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACCF797658
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjIGQG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjIGQGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:06:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608713A963
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 08:58:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8DBF021877;
        Thu,  7 Sep 2023 12:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694088758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8Z/HrYydCfCEHCLG29l/CwjC83zvsCaBUreOtZbI+U=;
        b=o5NKctV6tSB+GT/f686MD8S8ejpEnLT6sqkeGYYvvVmKZt0JO1pLhCHMwNf6CkPGlnQ0tc
        J10CtrRoYqSj9U0zmKZxmrFLWOePACgE4Ms/2h5QozR4sxePXGidgDiLoz3FZY7DpVEC/4
        UXdYxZTCXhmrMBsPU1obIoB7/TB9CIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694088758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8Z/HrYydCfCEHCLG29l/CwjC83zvsCaBUreOtZbI+U=;
        b=+32u2zvz+ENb2Up54k+DWkOUSdFaGd2p3p4FrDSdTFRGO0oL42GXqtJVyf64IXBkmcT1wM
        KEzCCYGHkfiOtZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C348138F9;
        Thu,  7 Sep 2023 12:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qxHvETa++WSYFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 12:12:38 +0000
Date:   Thu, 7 Sep 2023 14:06:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 11/18] btrfs: new inline ref storing owning subvol of
 data extents
Message-ID: <20230907120606.GH3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <deb2d2bcfb7d6a9dbe9657b1a39659efc0e9f258.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb2d2bcfb7d6a9dbe9657b1a39659efc0e9f258.1690495785.git.boris@bur.io>
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

On Thu, Jul 27, 2023 at 03:12:58PM -0700, Boris Burkov wrote:
> In order to implement simple quota groups, we need to be able to
> associate a data extent with the subvolume that created it. Once you
> account for reflink, this information cannot be recovered without
> explicitly storing it. Options for storing it are:
> - a new key/item
> - a new extent inline ref item
> 
> The former is backwards compatible, but wastes space, the latter is
> incompat, but is efficient in space and reuses the existing inline ref
> machinery, while only abusing it a tiny amount -- specifically, the new
> item is not a ref, per-se.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/accessors.h            |  4 +++
>  fs/btrfs/backref.c              |  3 ++
>  fs/btrfs/extent-tree.c          | 56 ++++++++++++++++++++++++++-------
>  fs/btrfs/print-tree.c           | 12 +++++++
>  fs/btrfs/ref-verify.c           |  3 ++
>  fs/btrfs/tree-checker.c         |  3 ++
>  include/uapi/linux/btrfs_tree.h |  6 ++++
>  7 files changed, 76 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 8cfc8214109c..a23045c05937 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -349,6 +349,8 @@ BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 3
>  
>  BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
>  
> +BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
> +
>  BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
>  		   type, 8);
>  BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
> @@ -365,6 +367,8 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
>  	if (type == BTRFS_EXTENT_DATA_REF_KEY)
>  		return sizeof(struct btrfs_extent_data_ref) +
>  		       offsetof(struct btrfs_extent_inline_ref, offset);
> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
> +		return sizeof(struct btrfs_extent_inline_ref);
>  	return 0;
>  }
>  
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 79336fa853db..d5bb6a880713 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1129,6 +1129,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
>  						       count, sc, GFP_NOFS);
>  			break;
>  		}
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));

Please turn this to an ASSERT, we must catch this during development but
hte warning makes no sense for end users.

> +			break;
>  		default:
>  			WARN_ON(1);
>  		}
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 4f0115553cd3..c6d537bf5ad4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -342,9 +342,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  				     struct btrfs_extent_inline_ref *iref,
>  				     enum btrfs_inline_ref_type is_data)
>  {
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
>  	int type = btrfs_extent_inline_ref_type(eb, iref);
>  	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
>  
> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY && btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))

I think the conditions should be swapped, first you check that squotas
are enabled then that the type is the one you look for.

> +		return type;
> +
>  	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
>  	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
>  	    type == BTRFS_SHARED_DATA_REF_KEY ||
> @@ -353,26 +357,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  			if (type == BTRFS_TREE_BLOCK_REF_KEY)
>  				return type;
>  			if (type == BTRFS_SHARED_BLOCK_REF_KEY) {
> -				ASSERT(eb->fs_info);
> +				ASSERT(fs_info);

I'm not sure what's the point of this assertion, each eb is created with
a valid fs_info. It's not in your new code so you can keep it but would
be good to remove it evenntually.

>  				/*
>  				 * Every shared one has parent tree block,
>  				 * which must be aligned to sector size.
>  				 */
> -				if (offset &&
> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> +				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
>  					return type;
>  			}
>  		} else if (is_data == BTRFS_REF_TYPE_DATA) {
>  			if (type == BTRFS_EXTENT_DATA_REF_KEY)
>  				return type;
>  			if (type == BTRFS_SHARED_DATA_REF_KEY) {
> -				ASSERT(eb->fs_info);
> +				ASSERT(fs_info);

Same.

>  				/*
>  				 * Every shared one has parent tree block,
>  				 * which must be aligned to sector size.
>  				 */
>  				if (offset &&
> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> +				    IS_ALIGNED(offset, fs_info->sectorsize))
>  					return type;
>  			}
>  		} else {
> @@ -382,7 +385,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  	}
>  
>  	btrfs_print_leaf(eb);
> -	btrfs_err(eb->fs_info,
> +	btrfs_err(fs_info,
>  		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
>  		  eb->start, (unsigned long)iref, type);
>  	WARN_ON(1);
> @@ -891,6 +894,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>  		}
>  		iref = (struct btrfs_extent_inline_ref *)ptr;
>  		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
> +		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));

ASSERT()

> +			ptr += btrfs_extent_inline_ref_size(type);
> +			continue;
> +		}
>  		if (type == BTRFS_REF_TYPE_INVALID) {
>  			err = -EUCLEAN;
>  			goto out;
> @@ -1684,6 +1692,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
>  		 node->type == BTRFS_SHARED_DATA_REF_KEY)
>  		ret = run_delayed_data_ref(trans, node, extent_op,
>  					   insert_reserved);
> +	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
> +		ret = 0;
>  	else
>  		BUG();
>  	if (ret && insert_reserved)
> @@ -2250,6 +2260,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>  	struct btrfs_extent_item *ei;
>  	struct btrfs_key key;
>  	u32 item_size;
> +	u32 expected_size;
>  	int type;
>  	int ret;
>  
> @@ -2276,10 +2287,22 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>  	ret = 1;
>  	item_size = btrfs_item_size(leaf, path->slots[0]);
>  	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
> +	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
> +
> +	/* No inline refs; we need to bail before checking for owner ref */
> +	if (item_size == sizeof(*ei))
> +		goto out;
> +
> +	/* Check for an owner ref; skip over it to the real inline refs */
> +	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> +	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
> +		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> +		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
> +	}
>  
>  	/* If extent item has more than 1 inline ref then it's shared */
> -	if (item_size != sizeof(*ei) +
> -	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
> +	if (item_size != expected_size)
>  		goto out;
>  
>  	/*
> @@ -2291,8 +2314,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>  	     btrfs_root_last_snapshot(&root->root_item)))
>  		goto out;
>  
> -	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> -
>  	/* If this extent has SHARED_DATA_REF then it's shared */
>  	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
>  	if (type != BTRFS_EXTENT_DATA_REF_KEY)
> @@ -4543,18 +4564,23 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	struct btrfs_root *extent_root;
>  	int ret;
>  	struct btrfs_extent_item *extent_item;
> +	struct btrfs_extent_owner_ref *oref;
>  	struct btrfs_extent_inline_ref *iref;
>  	struct btrfs_path *path;
>  	struct extent_buffer *leaf;
>  	int type;
>  	u32 size;
> +	bool simple_quota = btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE;

	const bool simple_quota = (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE);

>  
>  	if (parent > 0)
>  		type = BTRFS_SHARED_DATA_REF_KEY;
>  	else
>  		type = BTRFS_EXTENT_DATA_REF_KEY;
>  
> -	size = sizeof(*extent_item) + btrfs_extent_inline_ref_size(type);
> +	size = sizeof(*extent_item);
> +	if (simple_quota)
> +		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> +	size += btrfs_extent_inline_ref_size(type);
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -4575,8 +4601,16 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	btrfs_set_extent_flags(leaf, extent_item,
>  			       flags | BTRFS_EXTENT_FLAG_DATA);
>  
> +

Stray newline

>  	iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
> +	if (simple_quota) {
> +		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
> +		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> +		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
> +		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
> +	}
>  	btrfs_set_extent_inline_ref_type(leaf, iref, type);
> +
>  	if (parent > 0) {
>  		struct btrfs_shared_data_ref *ref;
>  		ref = (struct btrfs_shared_data_ref *)(iref + 1);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index aa06d9ca911d..3fac15ce0db0 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -80,12 +80,20 @@ static void print_extent_data_ref(const struct extent_buffer *eb,
>  	       btrfs_extent_data_ref_count(eb, ref));
>  }
>  
> +static void print_extent_owner_ref(const struct extent_buffer *eb,
> +				   struct btrfs_extent_owner_ref *ref)

ref type can be also made const

> +{
> +	WARN_ON(!btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));

ASSERT()

> +	pr_cont("extent data owner root %llu\n", btrfs_extent_owner_ref_root_id(eb, ref));
> +}
> +
>  static void print_extent_item(const struct extent_buffer *eb, int slot, int type)
>  {
>  	struct btrfs_extent_item *ei;
>  	struct btrfs_extent_inline_ref *iref;
>  	struct btrfs_extent_data_ref *dref;
>  	struct btrfs_shared_data_ref *sref;
> +	struct btrfs_extent_owner_ref *oref;
>  	struct btrfs_disk_key key;
>  	unsigned long end;
>  	unsigned long ptr;
> @@ -159,6 +167,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
>  			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>  				     offset, eb->fs_info->sectorsize);
>  			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> +			print_extent_owner_ref(eb, oref);
> +			break;
>  		default:
>  			pr_cont("(extent %llu has INVALID ref type %d)\n",
>  				  eb->start, type);
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index b7b3bd86f5e2..c0660233feb4 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -485,6 +485,9 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
>  			ret = add_shared_data_ref(fs_info, offset, count,
>  						  key->objectid, key->offset);
>  			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> +			break;
>  		default:
>  			btrfs_err(fs_info, "invalid key type in iref");
>  			ret = -EINVAL;
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 038dfa8f1788..72d29ab74a01 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1451,6 +1451,9 @@ static int check_extent_item(struct extent_buffer *leaf,
>  			}
>  			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
>  			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> +			break;
>  		default:
>  			extent_err(leaf, slot, "unknown inline ref type: %u",
>  				   inline_type);
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 47aca414a41b..eacb26caf3c6 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -226,6 +226,8 @@
>  
>  #define BTRFS_SHARED_DATA_REF_KEY	184
>  
> +#define BTRFS_EXTENT_OWNER_REF_KEY	190

Please add some description of the new key and use number 188 so it
leaves roughly equal space around it.

> +
>  /*
>   * block groups give us hints into the extent allocation trees.  Which
>   * blocks are free etc etc
> @@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
>  	__le32 count;
>  } __attribute__ ((__packed__));
>  
> +struct btrfs_extent_owner_ref {
> +	__le64 root_id;
> +} __attribute__ ((__packed__));
> +
>  struct btrfs_extent_inline_ref {
>  	__u8 type;
>  	__le64 offset;
> -- 
> 2.41.0
