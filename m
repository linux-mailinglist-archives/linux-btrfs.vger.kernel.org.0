Return-Path: <linux-btrfs+bounces-18076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F782BF2C8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0420834D2AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED753321DD;
	Mon, 20 Oct 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YBHSmGbi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7e87I96"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE73321DB
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982286; cv=none; b=lyhLly9w5f/Pk2AXDdeEogsrmMQMfF1oXtchVumU8RCcKEOe0O57etw4HYgbAgzUNR/6ihcMPL5csDOWT5LUkKHN2DmhB2iIvGnTBdrxXFAmjAxNoNT2vo7sMBOzgBvTp3GuYldYyOOxIeHiZXfShJDgxUYYijvmKZvmq4+b+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982286; c=relaxed/simple;
	bh=lyPtZjTMVzn/K6CocThN/za4DIXv8PqgLVGysaC7mqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAJU6L1zC99jLZcrSC1dmnQK0bX/Mqy/j4tpkd9Xxlnrj0rjp6NQL5+Eho3tkYX/zvE8wX4zTFmQXECcTJTS02jwSj3Hgo52NRhPG5BvlxDLzJoNS/lAe+f7cCaNve0XjjXLe/lKhwhZ2Xx/2p5i7jdjGGpP8SACPUzXBecQ5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YBHSmGbi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7e87I96; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CF111D0012B;
	Mon, 20 Oct 2025 13:44:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Oct 2025 13:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760982282; x=1761068682; bh=aMmH0vx6b4
	gta8M2xgX6TDUH67t4jkdnKdUh/skUOAs=; b=YBHSmGbinxwIX/+eA492pMo7lp
	JmIQ4+omuAKUYU4aq2XeDJeJ3ggBjTSN1yyQt5NJyTNWf01KX7PG9WLT9ZG6QW8u
	wzgtnroEqrbaz1vR9tcKT4m6mNEpHECHmQyiwdoDFUXbYUsJL4RkiQVQdPjDFX/y
	nULtXpeW8x9oa+cZRZQsZ7phbXPWx1HYxRIXoVDWLmXlArs4BpQfzd7XaZCyoLwY
	8lUfyxwoR27+8qDJNpSHOTUXS3rs2RTHXnftZKgh3uf59RKYuozZydZcR1MmHvp0
	xR9V6AWlvhUSwL5KA5yz3Et3mwd5ZnKXoAau6q4+uDP6IY6PSoKrG9kdbWrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760982282; x=1761068682; bh=aMmH0vx6b4gta8M2xgX6TDUH67t4jkdnKdU
	h/skUOAs=; b=q7e87I96rkaqpSZASAz1G1pxs5AX6tuj3ICZAjt096U3TWvraoe
	llr2e3jxkoZNbHg8f0xdbPs59+pkncDrwddeTc/RwP9EVJYMkRQY1ktfCcXskcAM
	nYEhJqsK7KJWG9XRuoKRPXO848xhiiyw3/7wmdMKY7Ls0eYHQHhVjxJNNzM5+pPV
	JXJReIiGsM5yvkmTTkUq/7ybKnVLttD5gWgy9leHB1CBsKmfkjpulC7ljB0lMrM8
	QjHw5tubESCy/SQuFdyd9OuhykXF5nsXk050gHQTN9x7EpM7f0PrAqxB6Q8YDQVs
	D6aFxYgmttG2fKakcQkWJBtZjtKLOQaxEmQ==
X-ME-Sender: <xms:CnX2aIJJzO4DdPQlem49LmYFdLYZdBTyGy_fLOaCR-kSruALu00RPw>
    <xme:CnX2aOK3cY8uc2zkiRplySC89R3lOeW1HUsgqDckvLNpieC1V0m-oiMYabPc6UOhS
    vPKpFTvgIEr0f7j5TZfoGkaVObnBOjXqnv7P5pQK1k_guoPgToiaFQ>
X-ME-Received: <xmr:CnX2aGVNQfMfT4-boUoFXIByVXWDrI-Kj2ad9xzg5LQjoJiRH_B2v_RHLgi1kl_ZMDuNCGYwEBKBQYQEdlMGUe3gzYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CnX2aAj7TFWl4A-3sBFfO3sT0Xe25VbN1r17dE-TFyq8O8PgtZrb1g>
    <xmx:CnX2aB-QdsACigqq4VKN97NZ-Z0xcfIF_yVkEWDHZg4Yg2IrRk9vgA>
    <xmx:CnX2aKAiI9RcDMYbGkzJJi8xi_kaGg0JJNw77yuCAmGAy00-ibo2aw>
    <xmx:CnX2aOIwJmvI3vV0uq2njledH3nuQ7YAGiOr_69B0KM4xvqNv2kVWg>
    <xmx:CnX2aP-2R7GV8wIoSL2IwGFI6TQB___cApyLwZlmiZXMkK2iU3ztmahU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 13:44:41 -0400 (EDT)
Date: Mon, 20 Oct 2025 10:44:12 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 07/17] btrfs: allow mounting filesystems with
 remap-tree incompat flag
Message-ID: <20251020174412.GB696792@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-8-mark@harmstone.com>
 <20251015035548.GF1702774@zen.localdomain>
 <64405423-edf8-4c60-b8f1-4064d1f1d21f@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64405423-edf8-4c60-b8f1-4064d1f1d21f@harmstone.com>

On Mon, Oct 20, 2025 at 12:32:57PM +0100, Mark Harmstone wrote:
> On 15/10/2025 4.55 am, Boris Burkov wrote:
> > On Thu, Oct 09, 2025 at 12:28:02PM +0100, Mark Harmstone wrote:
> > > If we encounter a filesystem with the remap-tree incompat flag set,
> > > valdiate its compatibility with the other flags, and load the remap tree
> > > using the values that have been added to the superblock.
> > > 
> > > The remap-tree feature depends on the free space tere, but no-holes and
> > > block-group-tree have been made dependencies to reduce the testing
> > > matrix. Similarly I'm not aware of any reason why mixed-bg and zoned would be
> > > incompatible with remap-tree, but this is blocked for the time being
> > > until it can be fully tested.
> > > 
> > 
> > Bonus points on offer for moving the open ctree bit as late as humanly
> > possible for that good "partial ordering" self documentation. (Or
> > explaining why it is already so).
> > 
> > Thanks.
> > 
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > 
> > > Signed-off-by: Mark Harmstone <mark@harmstone.com>
> > > ---
> > >   fs/btrfs/Kconfig                |   2 +
> > >   fs/btrfs/accessors.h            |   6 ++
> > >   fs/btrfs/disk-io.c              | 101 ++++++++++++++++++++++++++++----
> > >   fs/btrfs/extent-tree.c          |   2 +
> > >   fs/btrfs/fs.h                   |   4 +-
> > >   fs/btrfs/transaction.c          |   7 +++
> > >   include/uapi/linux/btrfs_tree.h |   5 +-
> > >   7 files changed, 113 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > > index 4438637c8900..77b5a9f27840 100644
> > > --- a/fs/btrfs/Kconfig
> > > +++ b/fs/btrfs/Kconfig
> > > @@ -117,4 +117,6 @@ config BTRFS_EXPERIMENTAL
> > >   	  - large folio support
> > > +	  - remap-tree - logical address remapping tree
> > > +
> > >   	  If unsure, say N.
> > > diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> > > index 0dd161ee6863..392eaad75e72 100644
> > > --- a/fs/btrfs/accessors.h
> > > +++ b/fs/btrfs/accessors.h
> > > @@ -882,6 +882,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
> > >   			 uuid_tree_generation, 64);
> > >   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
> > >   			 nr_global_roots, 64);
> > > +BTRFS_SETGET_STACK_FUNCS(super_remap_root, struct btrfs_super_block,
> > > +			 remap_root, 64);
> > > +BTRFS_SETGET_STACK_FUNCS(super_remap_root_generation, struct btrfs_super_block,
> > > +			 remap_root_generation, 64);
> > > +BTRFS_SETGET_STACK_FUNCS(super_remap_root_level, struct btrfs_super_block,
> > > +			 remap_root_level, 8);
> > >   /* struct btrfs_file_extent_item */
> > >   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 92cb789957b4..60507e971aad 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -1180,6 +1180,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
> > >   		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
> > >   	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
> > >   		return btrfs_grab_root(fs_info->stripe_root);
> > > +	case BTRFS_REMAP_TREE_OBJECTID:
> > > +		return btrfs_grab_root(fs_info->remap_root);
> > >   	default:
> > >   		return NULL;
> > >   	}
> > > @@ -1271,6 +1273,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
> > >   	btrfs_put_root(fs_info->data_reloc_root);
> > >   	btrfs_put_root(fs_info->block_group_root);
> > >   	btrfs_put_root(fs_info->stripe_root);
> > > +	btrfs_put_root(fs_info->remap_root);
> > >   	btrfs_check_leaked_roots(fs_info);
> > >   	btrfs_extent_buffer_leak_debug_check(fs_info);
> > >   	kfree(fs_info->super_copy);
> > > @@ -1825,6 +1828,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
> > >   	free_root_extent_buffers(info->data_reloc_root);
> > >   	free_root_extent_buffers(info->block_group_root);
> > >   	free_root_extent_buffers(info->stripe_root);
> > > +	free_root_extent_buffers(info->remap_root);
> > >   	if (free_chunk_root)
> > >   		free_root_extent_buffers(info->chunk_root);
> > >   }
> > > @@ -2256,20 +2260,45 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
> > >   	if (ret)
> > >   		goto out;
> > > -	/*
> > > -	 * This tree can share blocks with some other fs tree during relocation
> > > -	 * and we need a proper setup by btrfs_get_fs_root
> > > -	 */
> > > -	root = btrfs_get_fs_root(tree_root->fs_info,
> > > -				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> > > -	if (IS_ERR(root)) {
> > > -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> > > -			ret = PTR_ERR(root);
> > > -			goto out;
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> > > +		/* remap_root already loaded in load_important_roots() */
> > > +		root = fs_info->remap_root;
> > > +
> > > +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> > > +
> > > +		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
> > > +		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
> > > +		root->root_key.offset = 0;
> > > +
> > > +		/* Check that data reloc tree doesn't also exist */
> > > +		location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
> > > +		root = btrfs_read_tree_root(fs_info->tree_root, &location);
> > > +		if (!IS_ERR(root)) {
> > > +			btrfs_err(fs_info,
> > > +			   "data reloc tree exists when remap-tree enabled");
> > > +			btrfs_put_root(root);
> > > +			return -EIO;
> > > +		} else if (PTR_ERR(root) != -ENOENT) {
> > > +			btrfs_warn(fs_info,
> > > +			   "error %ld when checking for data reloc tree",
> > > +				   PTR_ERR(root));
> > >   		}
> > >   	} else {
> > > -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> > > -		fs_info->data_reloc_root = root;
> > > +		/*
> > > +		 * This tree can share blocks with some other fs tree during
> > > +		 * relocation and we need a proper setup by btrfs_get_fs_root
> > > +		 */
> > > +		root = btrfs_get_fs_root(tree_root->fs_info,
> > > +					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> > > +		if (IS_ERR(root)) {
> > > +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> > > +				ret = PTR_ERR(root);
> > > +				goto out;
> > > +			}
> > > +		} else {
> > > +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> > > +			fs_info->data_reloc_root = root;
> > > +		}
> > >   	}
> > >   	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
> > > @@ -2509,6 +2538,31 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
> > >   		ret = -EINVAL;
> > >   	}
> > > +	/*
> > > +	 * Reduce test matrix for remap tree by requiring block-group-tree
> > > +	 * and no-holes. Free-space-tree is a hard requirement.
> > > +	 */
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> > > +	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
> > > +	     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
> > > +	     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
> > > +		btrfs_err(fs_info,
> > > +"remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> > > +	    btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
> > > +		btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> > > +	    btrfs_fs_incompat(fs_info, ZONED)) {
> > > +		btrfs_err(fs_info, "remap-tree not supported with zoned devices");
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > >   	/*
> > >   	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
> > >   	 * done later
> > > @@ -2667,6 +2721,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
> > >   		btrfs_warn(fs_info, "couldn't read tree root");
> > >   		return ret;
> > >   	}
> > > +
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> > > +		bytenr = btrfs_super_remap_root(sb);
> > > +		gen = btrfs_super_remap_root_generation(sb);
> > > +		level = btrfs_super_remap_root_level(sb);
> > > +		ret = load_super_root(fs_info->remap_root, bytenr, gen, level);
> > > +		if (ret) {
> > > +			btrfs_warn(fs_info, "couldn't read remap root");
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > >   	return 0;
> > >   }
> > > @@ -3284,6 +3350,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> > >   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> > >   	struct btrfs_root *tree_root;
> > >   	struct btrfs_root *chunk_root;
> > > +	struct btrfs_root *remap_root;
> > >   	int ret;
> > >   	int level;
> > > @@ -3417,6 +3484,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> > >   	if (ret < 0)
> > >   		goto fail_alloc;
> > > +	if (btrfs_super_incompat_flags(disk_super) & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
> > > +		remap_root = btrfs_alloc_root(fs_info, BTRFS_REMAP_TREE_OBJECTID,
> > > +					      GFP_KERNEL);
> > > +		fs_info->remap_root = remap_root;
> > > +		if (!remap_root) {
> > > +			ret = -ENOMEM;
> > > +			goto fail_alloc;
> > > +		}
> > > +	}
> > > +
> > 
> > Thanks for scooting it down. Does this need to be before reading the sys
> > array / chunk tree? I would guess no, as we can't remap that, but
> > perhaps I have misunderstood.
> 
> Yes, that's right. The dependency ordering when loading is:
> 
> 1. System chunks (contained in superblock)
> 2. Chunk tree (located in system chunks)
> 3. Remap tree (needs chunk tree to map logicals to physicals, logical address is in superblock)
> 4. Root tree (may be remapped)
> 5. All other trees (found in root tree)

I mixed up allocating the root and filling it out in
load_important_roots.. This all makes sense to me know, thanks for the
extra explanation on the dependencies. That would be good to document in
some bootstrapping document, by the way :)

> > >   	/*
> > >   	 * At this point our mount options are validated, if we set ->max_inline
> > >   	 * to something non-standard make sure we truncate it to sectorsize.
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index d964147b8097..7805a148bbd8 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -2589,6 +2589,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
> > >   		flags = BTRFS_BLOCK_GROUP_DATA;
> > >   	else if (root == fs_info->chunk_root)
> > >   		flags = BTRFS_BLOCK_GROUP_SYSTEM;
> > > +	else if (root == fs_info->remap_root)
> > > +		flags = BTRFS_BLOCK_GROUP_REMAP;
> > >   	else
> > >   		flags = BTRFS_BLOCK_GROUP_METADATA;
> > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > > index c4dba7e7ce5a..c76f4c2701f9 100644
> > > --- a/fs/btrfs/fs.h
> > > +++ b/fs/btrfs/fs.h
> > > @@ -291,7 +291,8 @@ enum {
> > >   #define BTRFS_FEATURE_INCOMPAT_SUPP		\
> > >   	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
> > >   	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
> > > -	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
> > > +	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
> > > +	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
> > >   #else
> > > @@ -451,6 +452,7 @@ struct btrfs_fs_info {
> > >   	struct btrfs_root *data_reloc_root;
> > >   	struct btrfs_root *block_group_root;
> > >   	struct btrfs_root *stripe_root;
> > > +	struct btrfs_root *remap_root;
> > >   	/* The log root tree is a directory of all the other log roots */
> > >   	struct btrfs_root *log_root_tree;
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index 89ae0c7a610a..b1c41982e7b2 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -1950,6 +1950,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
> > >   		super->cache_generation = 0;
> > >   	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
> > >   		super->uuid_tree_generation = root_item->generation;
> > > +
> > > +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> > > +		root_item = &fs_info->remap_root->root_item;
> > > +		super->remap_root = root_item->bytenr;
> > > +		super->remap_root_generation = root_item->generation;
> > > +		super->remap_root_level = root_item->level;
> > > +	}
> > >   }
> > >   int btrfs_transaction_blocked(struct btrfs_fs_info *info)
> > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > index 500e3a7df90b..89bcb80081a6 100644
> > > --- a/include/uapi/linux/btrfs_tree.h
> > > +++ b/include/uapi/linux/btrfs_tree.h
> > > @@ -721,9 +721,12 @@ struct btrfs_super_block {
> > >   	__u8 metadata_uuid[BTRFS_FSID_SIZE];
> > >   	__u64 nr_global_roots;
> > > +	__le64 remap_root;
> > > +	__le64 remap_root_generation;
> > > +	__u8 remap_root_level;
> > >   	/* Future expansion */
> > > -	__le64 reserved[27];
> > > +	__u8 reserved[199];
> > >   	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
> > >   	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
> > > -- 
> > > 2.49.1
> > > 
> 

