Return-Path: <linux-btrfs+bounces-17802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63DBDC625
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDF4E31DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6802D8767;
	Wed, 15 Oct 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xihu+FiY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u4lg5HE3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C201A23B9
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500574; cv=none; b=s8av2+2M7JoQcdQMPp1IExOorrztNS5ATwMo7K+z9142LTLkIwVPLbLkOpkIdpiiPI2+mrUAmgBMNrY7iWgYFdXFhXi1H2AmEYFGWPmkZf3dc+xMA0WxIM6tnWXpuz6/Ydk5+FlVDhyyxcI4xHPL8E8ScsV/RHg4tqqRhWvEavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500574; c=relaxed/simple;
	bh=JQioXkhUh3qX7pTRwMIFOn1fgXB25FBxUtz6daUutKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9tTSD+fcf0xCC68jSy3AVLvxKDM2dqNt8iSsyAbvps+lVgHin+hJvl09FNYfLKuQEhBJfG+vT31wypuRNUUUfZU2Nrfwy+sqPsRcrfHXW30ZlZGxdCxOJwzZ2QWyDDzwrmkLYi1LFPJashBkGSPsZUlbmJjyp0A/Db3p8F54rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=xihu+FiY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u4lg5HE3; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EF11EC0260;
	Tue, 14 Oct 2025 23:56:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Oct 2025 23:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760500569; x=1760586969; bh=B7JBWewK4A
	2ZLRFzA69qkpw2pnktf/Wr7YXxGVpCbGA=; b=xihu+FiYdi99NH95zwuu8lD4EU
	8dxmmfa0UOPpdTCuOePfh6tkGWWJD0jjJpj4GV8vdek91LLP8+HllIXD2EPWAGQE
	1+SdDRnrC+Q4ezQdp5mv1hnuq+1jkR9z0cfdEvsQBIkpYJvc5juvxOnyxm+Zazs4
	7hzlXsG7qFxZRWcujpeylVUNOXIk8ePylBR4QWOIT7qSpmnjrEFpsVaIH+uxSc1F
	yZpkzQcHgzKqL9oFCZKW00ydoKvHL6dvVI2PPy9wLkkyNDmMRzYvBEXfL4g3+gIQ
	O37hYzmPZ/j8J42E3yGZufoxFPos283FWCrdiJ3/xIUcIfK/hQkiBw8o4xrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760500569; x=1760586969; bh=B7JBWewK4A2ZLRFzA69qkpw2pnktf/Wr7YX
	xGVpCbGA=; b=u4lg5HE3xdnglN9KFx1hAsoQCDWm+ADPEm0hXST3HdgcBLwGHlC
	3Ziygyt37Lc3NUVf8+8cUr8D0Aj9FUE7Hp/7u7EqBn9s8mbNBrsiklXpGMXzvWcI
	vPzFc2x5FFmn120Ea0jv1j2UyGKqnzQSDfR9jujBbTQ42ikaKtwUxaRdGz+V5yLn
	ARedjfdMaqj8kCh0LBuFNw5C56PV0+uahebAEuvyBV4roN0GiD2mPpcm1ZIkemKC
	5Z3oH3qqBBLbW9Q4zy9wpsLbyQ6/AONY3VUO08t36ciYlPACknXrJqLMbfO1QClJ
	DrPurPfCh6g8cZLPZY9YlrYy2DtEnLM4eYw==
X-ME-Sender: <xms:WBvvaKP3faWSndy7oESHgBls7nqE9TZLiyIKLNIRwe3XNiYg9cAWiw>
    <xme:WBvvaO-B9h_3osAKI2aWHMgEEB8kIAyOs1DFfFRemI8twxlUgeeDDTWr1qwvJdhTg
    2s80K6nUYRl6jHGieY10kmeIuAyyrUVGOsRakiRP5aZYYFCCeuNZGs>
X-ME-Received: <xmr:WBvvaO4CT1OeHr-mwzgWAT6R1OsGV9Jm0iXnsjq2l0des-rM1YJcaZUwC5nXLqZuUBc1hQWEgOoL3OSiE9EoLdrpkcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WBvvaF1ciLQKVhEkTHXQIPVWh9qIeDcIyVAzRU657g_o2w4cOAXhVA>
    <xmx:WRvvaFBfjRYyyX62pVvag4UDoOP7ZrMZrVRpVYhIj1DchUifpymmTw>
    <xmx:WRvvaH1gK3nJCL8Zj9lzc0PZ6uNvHH-uq8q0k9BOh8H8aiiTzsm1uw>
    <xmx:WRvvaPsV-cQWwgmJniNJxFKufa8YGIH7T-KGj5WI7OT2OHsHrq-bPg>
    <xmx:WRvvaJgcmEAaJYlubUYOcQMLK7l63eVNiA2XEfzEkDzTee1s5uTrIjfV>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 23:56:08 -0400 (EDT)
Date: Tue, 14 Oct 2025 20:55:48 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 07/17] btrfs: allow mounting filesystems with
 remap-tree incompat flag
Message-ID: <20251015035548.GF1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-8-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-8-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:28:02PM +0100, Mark Harmstone wrote:
> If we encounter a filesystem with the remap-tree incompat flag set,
> valdiate its compatibility with the other flags, and load the remap tree
> using the values that have been added to the superblock.
> 
> The remap-tree feature depends on the free space tere, but no-holes and
> block-group-tree have been made dependencies to reduce the testing
> matrix. Similarly I'm not aware of any reason why mixed-bg and zoned would be
> incompatible with remap-tree, but this is blocked for the time being
> until it can be fully tested.
> 

Bonus points on offer for moving the open ctree bit as late as humanly
possible for that good "partial ordering" self documentation. (Or
explaining why it is already so).

Thanks.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/Kconfig                |   2 +
>  fs/btrfs/accessors.h            |   6 ++
>  fs/btrfs/disk-io.c              | 101 ++++++++++++++++++++++++++++----
>  fs/btrfs/extent-tree.c          |   2 +
>  fs/btrfs/fs.h                   |   4 +-
>  fs/btrfs/transaction.c          |   7 +++
>  include/uapi/linux/btrfs_tree.h |   5 +-
>  7 files changed, 113 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 4438637c8900..77b5a9f27840 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -117,4 +117,6 @@ config BTRFS_EXPERIMENTAL
>  
>  	  - large folio support
>  
> +	  - remap-tree - logical address remapping tree
> +
>  	  If unsure, say N.
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 0dd161ee6863..392eaad75e72 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -882,6 +882,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
>  			 uuid_tree_generation, 64);
>  BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
>  			 nr_global_roots, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_remap_root, struct btrfs_super_block,
> +			 remap_root, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_remap_root_generation, struct btrfs_super_block,
> +			 remap_root_generation, 64);
> +BTRFS_SETGET_STACK_FUNCS(super_remap_root_level, struct btrfs_super_block,
> +			 remap_root_level, 8);
>  
>  /* struct btrfs_file_extent_item */
>  BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 92cb789957b4..60507e971aad 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1180,6 +1180,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
>  		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
>  	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
>  		return btrfs_grab_root(fs_info->stripe_root);
> +	case BTRFS_REMAP_TREE_OBJECTID:
> +		return btrfs_grab_root(fs_info->remap_root);
>  	default:
>  		return NULL;
>  	}
> @@ -1271,6 +1273,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_put_root(fs_info->data_reloc_root);
>  	btrfs_put_root(fs_info->block_group_root);
>  	btrfs_put_root(fs_info->stripe_root);
> +	btrfs_put_root(fs_info->remap_root);
>  	btrfs_check_leaked_roots(fs_info);
>  	btrfs_extent_buffer_leak_debug_check(fs_info);
>  	kfree(fs_info->super_copy);
> @@ -1825,6 +1828,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
>  	free_root_extent_buffers(info->data_reloc_root);
>  	free_root_extent_buffers(info->block_group_root);
>  	free_root_extent_buffers(info->stripe_root);
> +	free_root_extent_buffers(info->remap_root);
>  	if (free_chunk_root)
>  		free_root_extent_buffers(info->chunk_root);
>  }
> @@ -2256,20 +2260,45 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>  	if (ret)
>  		goto out;
>  
> -	/*
> -	 * This tree can share blocks with some other fs tree during relocation
> -	 * and we need a proper setup by btrfs_get_fs_root
> -	 */
> -	root = btrfs_get_fs_root(tree_root->fs_info,
> -				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> -	if (IS_ERR(root)) {
> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> -			ret = PTR_ERR(root);
> -			goto out;
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		/* remap_root already loaded in load_important_roots() */
> +		root = fs_info->remap_root;
> +
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +
> +		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
> +		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
> +		root->root_key.offset = 0;
> +
> +		/* Check that data reloc tree doesn't also exist */
> +		location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
> +		root = btrfs_read_tree_root(fs_info->tree_root, &location);
> +		if (!IS_ERR(root)) {
> +			btrfs_err(fs_info,
> +			   "data reloc tree exists when remap-tree enabled");
> +			btrfs_put_root(root);
> +			return -EIO;
> +		} else if (PTR_ERR(root) != -ENOENT) {
> +			btrfs_warn(fs_info,
> +			   "error %ld when checking for data reloc tree",
> +				   PTR_ERR(root));
>  		}
>  	} else {
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->data_reloc_root = root;
> +		/*
> +		 * This tree can share blocks with some other fs tree during
> +		 * relocation and we need a proper setup by btrfs_get_fs_root
> +		 */
> +		root = btrfs_get_fs_root(tree_root->fs_info,
> +					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret = PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->data_reloc_root = root;
> +		}
>  	}
>  
>  	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
> @@ -2509,6 +2538,31 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> +	/*
> +	 * Reduce test matrix for remap tree by requiring block-group-tree
> +	 * and no-holes. Free-space-tree is a hard requirement.
> +	 */
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> +	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
> +	     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
> +	     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
> +		btrfs_err(fs_info,
> +"remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
> +		ret = -EINVAL;
> +	}
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> +	    btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
> +		btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
> +		ret = -EINVAL;
> +	}
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> +	    btrfs_fs_incompat(fs_info, ZONED)) {
> +		btrfs_err(fs_info, "remap-tree not supported with zoned devices");
> +		ret = -EINVAL;
> +	}
> +
>  	/*
>  	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
>  	 * done later
> @@ -2667,6 +2721,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
>  		btrfs_warn(fs_info, "couldn't read tree root");
>  		return ret;
>  	}
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		bytenr = btrfs_super_remap_root(sb);
> +		gen = btrfs_super_remap_root_generation(sb);
> +		level = btrfs_super_remap_root_level(sb);
> +		ret = load_super_root(fs_info->remap_root, bytenr, gen, level);
> +		if (ret) {
> +			btrfs_warn(fs_info, "couldn't read remap root");
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -3284,6 +3350,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>  	struct btrfs_root *tree_root;
>  	struct btrfs_root *chunk_root;
> +	struct btrfs_root *remap_root;
>  	int ret;
>  	int level;
>  
> @@ -3417,6 +3484,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	if (ret < 0)
>  		goto fail_alloc;
>  
> +	if (btrfs_super_incompat_flags(disk_super) & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
> +		remap_root = btrfs_alloc_root(fs_info, BTRFS_REMAP_TREE_OBJECTID,
> +					      GFP_KERNEL);
> +		fs_info->remap_root = remap_root;
> +		if (!remap_root) {
> +			ret = -ENOMEM;
> +			goto fail_alloc;
> +		}
> +	}
> +

Thanks for scooting it down. Does this need to be before reading the sys
array / chunk tree? I would guess no, as we can't remap that, but
perhaps I have misunderstood.

>  	/*
>  	 * At this point our mount options are validated, if we set ->max_inline
>  	 * to something non-standard make sure we truncate it to sectorsize.
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d964147b8097..7805a148bbd8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2589,6 +2589,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
>  		flags = BTRFS_BLOCK_GROUP_DATA;
>  	else if (root == fs_info->chunk_root)
>  		flags = BTRFS_BLOCK_GROUP_SYSTEM;
> +	else if (root == fs_info->remap_root)
> +		flags = BTRFS_BLOCK_GROUP_REMAP;
>  	else
>  		flags = BTRFS_BLOCK_GROUP_METADATA;
>  
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index c4dba7e7ce5a..c76f4c2701f9 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -291,7 +291,8 @@ enum {
>  #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>  	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
> -	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
> +	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
> +	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
>  
>  #else
>  
> @@ -451,6 +452,7 @@ struct btrfs_fs_info {
>  	struct btrfs_root *data_reloc_root;
>  	struct btrfs_root *block_group_root;
>  	struct btrfs_root *stripe_root;
> +	struct btrfs_root *remap_root;
>  
>  	/* The log root tree is a directory of all the other log roots */
>  	struct btrfs_root *log_root_tree;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 89ae0c7a610a..b1c41982e7b2 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1950,6 +1950,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
>  		super->cache_generation = 0;
>  	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
>  		super->uuid_tree_generation = root_item->generation;
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		root_item = &fs_info->remap_root->root_item;
> +		super->remap_root = root_item->bytenr;
> +		super->remap_root_generation = root_item->generation;
> +		super->remap_root_level = root_item->level;
> +	}
>  }
>  
>  int btrfs_transaction_blocked(struct btrfs_fs_info *info)
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 500e3a7df90b..89bcb80081a6 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -721,9 +721,12 @@ struct btrfs_super_block {
>  	__u8 metadata_uuid[BTRFS_FSID_SIZE];
>  
>  	__u64 nr_global_roots;
> +	__le64 remap_root;
> +	__le64 remap_root_generation;
> +	__u8 remap_root_level;
>  
>  	/* Future expansion */
> -	__le64 reserved[27];
> +	__u8 reserved[199];
>  	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>  	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>  
> -- 
> 2.49.1
> 

