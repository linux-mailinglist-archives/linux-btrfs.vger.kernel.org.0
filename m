Return-Path: <linux-btrfs+bounces-16308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC2B322A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B221D282D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789792C3257;
	Fri, 22 Aug 2025 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CAtoq4Hf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABRzYc6o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7F22A80D
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889983; cv=none; b=JsROxY8Y3V9OsbvMRQgFoLo4xrvWMUdKVce6Ni0KaCIn7jbMzzqYTSB0zA1JvLWi9cfsDOKZYXMNJBPNIHj61JnsPV4du/nXbr1rASEfH1NifUn8kgtciK3fGDdTqqDtO57K+sFZ9VlNYjImTJugXcxt52lE5bW3zQHfAKtq0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889983; c=relaxed/simple;
	bh=4iHiBOzBgWJyq94dA6uCyhIpP+fVGRd6GZJvRIVt3PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1F6VRtX9AD1zhwq8E0TEMRB29jlvYVOs3o9cpv9OIRFoOcIyRx4J8SHBdPDw1OwjjeXvmN6QfWcE89j/B6ZpHWwdJ+KD7S6xNOjOQROZkcIJy8VUna4Oi0snmhZ/KCcUThk8tz6KapAckq8g1155eBBH0tLkmfGP1My0iA5LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CAtoq4Hf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABRzYc6o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A2F11EC008A;
	Fri, 22 Aug 2025 15:12:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 22 Aug 2025 15:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755889978; x=1755976378; bh=nSlESuB+gI
	3nFOAWkVaAtSPw31zmii7/ixB0SEUUocw=; b=CAtoq4HfPR4OSNEPbmExqGUZv9
	lJPiU2YKs8TG3Qnv2wfwgpAVepm3qNmajbefDp4eezf79xwWD5Zkaa2PS7aynbIs
	8llpkRWNq7Uuw1/bBtzcHzybOzXsai7kJ+u5sofF6MPkzxwNxwKAIvZSZn2QINg9
	TURR2Q6jZ4aQ9hoUSPdn0L/42yaJrxmSROOUR7/yPIwIh6/Ba7M+qcPbG7kgYy51
	P2Eovfj0Wd9lroYclq71+gPT/i7D/vbByA4Jf1bAxdiMi+NUUuz6NBb898N54AKl
	RArN8+50aP1/22yeGy1ABwrM1OqFEaiwKdH8UVB/A8dXN8B7Si20nZB3DcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755889978; x=1755976378; bh=nSlESuB+gI3nFOAWkVaAtSPw31zmii7/ixB
	0SEUUocw=; b=ABRzYc6ok7aKSCcpLXr0NSr/uAoB345SzLTz/CVI+Vj25Lv5bJs
	47ZitF6M+K0oYlQirDTeEbMUH/669Hm3b2uB/rz4yBOF2VFdndI2b8iGZ1Y85xN3
	SRR0z0MI9BZVjrppbp5U226I2DX66fmQR5k7jtsIbdiWYyfszW+Xd2+6zcZsOOFw
	K86ldIYtaceRHgXG+Rpp4xmAHIq5d1gFut7aCQxnFAEFmklyURg6tga30ktj+Xjg
	KVzff+shEmMmG91NaGpXiaAJmAjSZDrzVwUOlonFRymcfoeu4HcU4jips29HV3jI
	96o05k9Ei1014jXLoCD2ZfRRmSIZ+f8JWHg==
X-ME-Sender: <xms:OcGoaFZV7aECFf9FifKdi1u0D0boXhrUhjE5s1GpgK78Yrl3Usb0ow>
    <xme:OcGoaMmPSaDV6kz2eDyHH89ZVw1KoDnkQN-xIjoM8cA5h_NNFynDAdK8AOukFSGwC
    ukGzbgGUGRnCBG5CIM>
X-ME-Received: <xmr:OcGoaJwXp1myJ4Y5KsLU2TZsylTqrwOc_qcqBFrGVKrogcJ5W2m0D5tEf967B-DVTnDDImnwkGDGf7nXj8n-jb4bUak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OcGoaCOz8UC8Bu2XsEiMNx4ME-8hVas_yLrAycKEJkR_MuEn8c0Psg>
    <xmx:OcGoaFSjtunutrSTo5FeYHVxxqO-WzPsvAJQwiNZoNecbJmfop5IMw>
    <xmx:OcGoaIa1hd67TPPKdCvqid8Bp-jEl9h4C8vvzobNiLg3F3pNzn1XFQ>
    <xmx:OcGoaK2lXh1z7UeVibUGMbXy2pNJz2TuXGSgJ_o__EobvegmtVPXfA>
    <xmx:OsGoaC9uB7mO2K4oQ_vyuB2LYiriNuWWzBBlJW9-CUi9w0rZoBcMSs5h>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 15:12:57 -0400 (EDT)
Date: Fri, 22 Aug 2025 12:14:57 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/16] btrfs: allow mounting filesystems with
 remap-tree incompat flag
Message-ID: <20250822191457.GA492925@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-8-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-8-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:49PM +0100, Mark Harmstone wrote:
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
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/Kconfig                |  2 +
>  fs/btrfs/accessors.h            |  6 +++
>  fs/btrfs/disk-io.c              | 86 ++++++++++++++++++++++++++++-----
>  fs/btrfs/extent-tree.c          |  2 +
>  fs/btrfs/fs.h                   |  4 +-
>  fs/btrfs/transaction.c          |  7 +++
>  include/uapi/linux/btrfs_tree.h |  5 +-
>  7 files changed, 97 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index ea95c90c8474..598a4af4ce4b 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -116,6 +116,8 @@ config BTRFS_EXPERIMENTAL
>  
>  	  - large folio support
>  
> +	  - remap-tree - logical address remapping tree
> +
>  	  If unsure, say N.
>  
>  config BTRFS_FS_REF_VERIFY
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
> index 8e9520119d4f..563aea5e3b1b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1181,6 +1181,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
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
> @@ -2256,20 +2260,31 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
> -		}
> -	} else {
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		/* remap_root already loaded in load_important_roots() */
> +		root = fs_info->remap_root;
> +
>  		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->data_reloc_root = root;
> +
> +		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
> +		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
> +		root->root_key.offset = 0;
> +	} else {

It might be a good idea to vomit on finding a reloc tree if the
REMAP_TREE incompat bit is set. If that would happen elsewhere in tree
checker, that's great, the idea just struck me while reading this.

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
> @@ -2509,6 +2524,28 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> +	/* Ditto for remap_tree */

Don't care strongly, but "ditto" is less clear and more prone to
breaking when other code gets refactored than just writing out what
you mean (perhaps with a reference to something above).

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
> @@ -2667,6 +2704,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
> @@ -3278,6 +3327,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>  	struct btrfs_root *tree_root;
>  	struct btrfs_root *chunk_root;
> +	struct btrfs_root *remap_root;
>  	int ret;
>  	int level;
>  
> @@ -3312,6 +3362,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_alloc;
>  	}
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

This feels like it should come after the csum verification stuff in the
bootstrap process. The csum stuff is from the super so it shouldn't
depend on remap, but remap is an eb and has csums, so it does "rely" on
that (obviously it will break anyway, but then why bother doing the
explicit checking at all)

As the most general statement, I think it putting it as "late as possible"
is the most self documenting option.

>  	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
>  	/*
>  	 * Verify the type first, if that or the checksum value are
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5e038ae1a93f..c1b96c728fe6 100644
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
> index 9ce75843b578..6ea96e76655e 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -288,7 +288,8 @@ enum {
>  #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>  	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
> -	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
> +	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
> +	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
>  
>  #else
>  
> @@ -438,6 +439,7 @@ struct btrfs_fs_info {
>  	struct btrfs_root *data_reloc_root;
>  	struct btrfs_root *block_group_root;
>  	struct btrfs_root *stripe_root;
> +	struct btrfs_root *remap_root;
>  
>  	/* The log root tree is a directory of all the other log roots */
>  	struct btrfs_root *log_root_tree;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index c5c0d9cf1a80..64b9c427af6a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1953,6 +1953,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
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

