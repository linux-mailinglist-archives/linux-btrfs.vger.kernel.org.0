Return-Path: <linux-btrfs+bounces-18491-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28CC27138
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759263BD3A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A84309DCD;
	Fri, 31 Oct 2025 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oksPbZzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="va1FIGA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6B2E1EF4
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947273; cv=none; b=QsiYtAnDVzJ20dgdsjMfCdKt03pQXq0HzUF4wmK3QiI7XNUWK5vJ7smjkiRHkyI+KwgBKkWRfobIslh16T9jAdIyzuE7fHXIz4utqu0r0lgkJybS5uD00AzPiDv+23bMeJ7cdS+0Fv1szd/qmYP6fP3bw0HKaEa/XexVjszNdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947273; c=relaxed/simple;
	bh=HA0byHOyplvFJfofnvmpv/uTeyMTvq0c1d9WjF75BVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcaxU73ZasYMiYGJKjyTpklfJ8Mqv4cajpHFfjgJOQxLqT1J0ZypvMmidV7oXwnAUQKXLCtAsnFFCRXanEttbWA0X3y0MgLzTtcJvALoCIHhK74AtJY05cM3pYNtEn4z6ygw6I3J6KQSwW6uir2+jjsRGIJ7pdwRvX8f95hzj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oksPbZzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=va1FIGA2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BDBD140008D;
	Fri, 31 Oct 2025 17:47:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 17:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761947270; x=1762033670; bh=o9R+yMBW3m
	JB6rPLQVqSwQC7hJ2/V0taYBDQX7nohVU=; b=oksPbZzwHBNo0IeJ/wyAUcVPtR
	JGdeUFtlZqpVqiDkenBbs3SqqVZz2qavosrS6za4cLRfkUa+eE/GLLVFa1BAlS2S
	GKoTlKj6C+HFk0JgW51jMt5PnY3O4GnZCfxncAENMuf+tPF8yN/sxn1My20QX08L
	0dXejv1lgiGRnVi6RE3k0fIJUnzRB65PY4Dah/fvtl6YuKjzFGd5AQlemhoS9D2f
	CKer6BxhStoDgls9UXhfGDkcttAXDh9+m/UD97u6uV8uafin5v4tMQT6CNdKFFgu
	mPR84bV/QAWBdULpoazCHcSNAZNhnTstN9xxXUk44YOFHEZf/HzU26vho19Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761947270; x=1762033670; bh=o9R+yMBW3mJB6rPLQVqSwQC7hJ2/V0taYBD
	QX7nohVU=; b=va1FIGA2LrsGV+GkcXRTtwajEN+lOORjFl25FVOFDalJ+pWzT/9
	GCoUrdCRw4s6FtV3CGUN/BsqVWmUdnAxzRu3BXXMcdbYsG6iM81nMdGANzA4drtA
	QpHD3aPEN52et49ACOTrht9Ic8W4LCbR7q+ZK0DgvYzBZmShYBX5ukqaF0YjSHuj
	vKqnnj5LArhmsJ/p+5K9Ij5EzpTOqtEu7+45CV0l/yNzRZOe+aYZpGo4FYJVuI0k
	ifPJBNsNw8C34q50P6z8oyPG4+2ch2ZW3rbe02PSprF0HQZ5ddVgXZ5NaSB+wqS7
	SCo6S8yLseOhVCrzx4sw3hbDr3DM/MLVC9Q==
X-ME-Sender: <xms:hS4FaUbI2wpPtGZizrtklZyp_h6QJmPbpRzwCH-R3u9GmrGDnCcPRA>
    <xme:hS4FaVbJnkL5PntCxouph2hwDf7p29_cB80yGPjehLJSBvcoye44k0sXkyaD9hrUZ
    wrs9KGjNuwrPedr2X1eymWXkig68gW1bpXQIO-Qwi33xSkjpkD3nhY>
X-ME-Received: <xmr:hS4FacnzD2oC_qaHozAjpde--PToXyUrhORxNvbyqpcZr7i29-9o0ekjKMGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hS4FaZyr97B33ykJBwV74OK9xZGO-JRud0u6z93Txc43xsiYzoSuhg>
    <xmx:hS4FaSO3OEM7gm79O98SZV15SC-MmHMwSPH1kxjWDweAgKBW0Ptkgw>
    <xmx:hS4FaVRXi1_O85jFODSO7qYYT8Zfw_485RqJj2A7eMMU6b2Jf-oLTQ>
    <xmx:hS4FaYZZzhMETI2ZJIZSlnWHDP7ED9GJD2dsQppsONgn2KldTxMuzQ>
    <xmx:hi4FaaMBBdlD5LF-srTVS4q_OVcrIatv-swh6pJvdnoH2_QMPBhHehu6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 17:47:49 -0400 (EDT)
Date: Fri, 31 Oct 2025 14:47:46 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 06/16] btrfs: add extended version of struct
 block_group_item
Message-ID: <aQUugkU1TkymUM1T@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-7-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-7-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:07PM +0100, Mark Harmstone wrote:
> Add a struct btrfs_block_group_item_v2, which is used in the block group
> tree if the remap-tree incompat flag is set.
> 
> This adds two new fields to the block group item: `remap_bytes` and
> `identity_remap_count`.
> 
> `remap_bytes` records the amount of data that's physically within this
> block group, but nominally in another, remapped block group. This is
> necessary because this data will need to be moved first if this block
> group is itself relocated. If `remap_bytes` > 0, this is an indicator to
> the relocation thread that it will need to search the remap-tree for
> backrefs. A block group must also have `remap_bytes` == 0 before it can
> be dropped.
> 
> `identity_remap_count` records how many identity remap items are located
> in the remap tree for this block group. When relocation is begun for
> this block group, this is set to the number of holes in the free-space
> tree for this range. As identity remaps are converted into actual remaps
> by the relocation process, this number is decreased. Once it reaches 0,
> either because of relocation or because extents have been deleted, the
> block group has been fully remapped and its chunk's device extents are
> removed.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/accessors.h            |  20 +++++++
>  fs/btrfs/block-group.c          | 100 ++++++++++++++++++++++++--------
>  fs/btrfs/block-group.h          |  14 ++++-
>  fs/btrfs/discard.c              |   2 +-
>  fs/btrfs/tree-checker.c         |  10 +++-
>  include/uapi/linux/btrfs_tree.h |   8 +++
>  6 files changed, 126 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 95a1ca8c099b..0dd161ee6863 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -239,6 +239,26 @@ BTRFS_SETGET_FUNCS(block_group_flags, struct btrfs_block_group_item, flags, 64);
>  BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
>  			struct btrfs_block_group_item, flags, 64);
>  
> +/* struct btrfs_block_group_item_v2 */
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_used, struct btrfs_block_group_item_v2,
> +			 used, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_used, struct btrfs_block_group_item_v2, used, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_chunk_objectid,
> +			 struct btrfs_block_group_item_v2, chunk_objectid, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_chunk_objectid,
> +		   struct btrfs_block_group_item_v2, chunk_objectid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_flags,
> +			 struct btrfs_block_group_item_v2, flags, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_flags, struct btrfs_block_group_item_v2, flags, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_remap_bytes,
> +			 struct btrfs_block_group_item_v2, remap_bytes, 64);
> +BTRFS_SETGET_FUNCS(block_group_v2_remap_bytes, struct btrfs_block_group_item_v2,
> +		   remap_bytes, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_block_group_v2_identity_remap_count,
> +			 struct btrfs_block_group_item_v2, identity_remap_count, 32);
> +BTRFS_SETGET_FUNCS(block_group_v2_identity_remap_count, struct btrfs_block_group_item_v2,
> +		   identity_remap_count, 32);
> +
>  /* struct btrfs_free_space_info */
>  BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
>  		   extent_count, 32);
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b5f2ec8d013f..27173aca6fc1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2374,7 +2374,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>  }
>  
>  static int read_one_block_group(struct btrfs_fs_info *info,
> -				struct btrfs_block_group_item *bgi,
> +				struct btrfs_block_group_item_v2 *bgi,
>  				const struct btrfs_key *key,
>  				int need_clear)
>  {
> @@ -2389,11 +2389,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  		return -ENOMEM;
>  
>  	cache->length = key->offset;
> -	cache->used = btrfs_stack_block_group_used(bgi);
> +	cache->used = btrfs_stack_block_group_v2_used(bgi);
>  	cache->commit_used = cache->used;
> -	cache->flags = btrfs_stack_block_group_flags(bgi);
> -	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
> +	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
> +	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
>  	cache->space_info = btrfs_find_space_info(info, cache->flags);
> +	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
> +	cache->commit_remap_bytes = cache->remap_bytes;
> +	cache->identity_remap_count =
> +		btrfs_stack_block_group_v2_identity_remap_count(bgi);
> +	cache->commit_identity_remap_count = cache->identity_remap_count;
>  
>  	btrfs_set_free_space_tree_thresholds(cache);
>  
> @@ -2458,7 +2463,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  	} else if (cache->length == cache->used) {
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		btrfs_free_excluded_extents(cache);
> -	} else if (cache->used == 0) {
> +	} else if (cache->used == 0 && cache->remap_bytes == 0) {
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		ret = btrfs_add_new_free_space(cache, cache->start,
>  					       cache->start + cache->length, NULL);
> @@ -2478,7 +2483,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  
>  	set_avail_alloc_bits(info, cache->flags);
>  	if (btrfs_chunk_writeable(info, cache->start)) {
> -		if (cache->used == 0) {
> +		if (cache->used == 0 && cache->remap_bytes == 0) {
>  			ASSERT(list_empty(&cache->bg_list));
>  			if (btrfs_test_opt(info, DISCARD_ASYNC))
>  				btrfs_discard_queue_work(&info->discard_ctl, cache);
> @@ -2582,9 +2587,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  		need_clear = 1;
>  
>  	while (1) {
> -		struct btrfs_block_group_item bgi;
> +		struct btrfs_block_group_item_v2 bgi;
>  		struct extent_buffer *leaf;
>  		int slot;
> +		size_t size;
>  
>  		ret = find_first_block_group(info, path, &key);
>  		if (ret > 0)
> @@ -2595,8 +2601,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  		leaf = path->nodes[0];
>  		slot = path->slots[0];
>  
> +		if (btrfs_fs_incompat(info, REMAP_TREE)) {
> +			size = sizeof(struct btrfs_block_group_item_v2);
> +		} else {
> +			size = sizeof(struct btrfs_block_group_item);
> +			btrfs_set_stack_block_group_v2_remap_bytes(&bgi, 0);
> +			btrfs_set_stack_block_group_v2_identity_remap_count(&bgi, 0);
> +		}
> +
>  		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
> -				   sizeof(bgi));
> +				   size);
>  
>  		btrfs_item_key_to_cpu(leaf, &key, slot);
>  		btrfs_release_path(path);
> @@ -2666,25 +2680,38 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>  				   struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_block_group_item bgi;
> +	struct btrfs_block_group_item_v2 bgi;
>  	struct btrfs_root *root = btrfs_block_group_root(fs_info);
>  	struct btrfs_key key;
>  	u64 old_commit_used;
> +	size_t size;
>  	int ret;
>  
>  	spin_lock(&block_group->lock);
> -	btrfs_set_stack_block_group_used(&bgi, block_group->used);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -						   block_group->global_root_id);
> -	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
> +	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
> +	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
> +						      block_group->global_root_id);
> +	btrfs_set_stack_block_group_v2_flags(&bgi, block_group->flags);
> +	btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
> +						   block_group->remap_bytes);
> +	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
> +					block_group->identity_remap_count);
>  	old_commit_used = block_group->commit_used;
>  	block_group->commit_used = block_group->used;
> +	block_group->commit_remap_bytes = block_group->remap_bytes;
> +	block_group->commit_identity_remap_count =
> +		block_group->identity_remap_count;
>  	key.objectid = block_group->start;
>  	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>  	key.offset = block_group->length;
>  	spin_unlock(&block_group->lock);
>  
> -	ret = btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		size = sizeof(struct btrfs_block_group_item_v2);
> +	else
> +		size = sizeof(struct btrfs_block_group_item);
> +
> +	ret = btrfs_insert_item(trans, root, &key, &bgi, size);
>  	if (ret < 0) {
>  		spin_lock(&block_group->lock);
>  		block_group->commit_used = old_commit_used;
> @@ -3139,10 +3166,12 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  	struct btrfs_root *root = btrfs_block_group_root(fs_info);
>  	unsigned long bi;
>  	struct extent_buffer *leaf;
> -	struct btrfs_block_group_item bgi;
> +	struct btrfs_block_group_item_v2 bgi;
>  	struct btrfs_key key;
> -	u64 old_commit_used;
> -	u64 used;
> +	u64 old_commit_used, old_commit_remap_bytes;
> +	u32 old_commit_identity_remap_count;
> +	u64 used, remap_bytes;
> +	u32 identity_remap_count;
>  
>  	/*
>  	 * Block group items update can be triggered out of commit transaction
> @@ -3152,13 +3181,21 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  	 */
>  	spin_lock(&cache->lock);
>  	old_commit_used = cache->commit_used;
> +	old_commit_remap_bytes = cache->commit_remap_bytes;
> +	old_commit_identity_remap_count = cache->commit_identity_remap_count;
>  	used = cache->used;
> -	/* No change in used bytes, can safely skip it. */
> -	if (cache->commit_used == used) {
> +	remap_bytes = cache->remap_bytes;
> +	identity_remap_count = cache->identity_remap_count;
> +	/* No change in values, can safely skip it. */
> +	if (cache->commit_used == used &&
> +	    cache->commit_remap_bytes == remap_bytes &&
> +	    cache->commit_identity_remap_count == identity_remap_count) {
>  		spin_unlock(&cache->lock);
>  		return 0;
>  	}
>  	cache->commit_used = used;
> +	cache->commit_remap_bytes = remap_bytes;
> +	cache->commit_identity_remap_count = identity_remap_count;
>  	spin_unlock(&cache->lock);
>  
>  	key.objectid = cache->start;
> @@ -3174,11 +3211,23 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  
>  	leaf = path->nodes[0];
>  	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
> -	btrfs_set_stack_block_group_used(&bgi, used);
> -	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -						   cache->global_root_id);
> -	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
> -	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
> +	btrfs_set_stack_block_group_v2_used(&bgi, used);
> +	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi,
> +						      cache->global_root_id);
> +	btrfs_set_stack_block_group_v2_flags(&bgi, cache->flags);
> +
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		btrfs_set_stack_block_group_v2_remap_bytes(&bgi,
> +							   cache->remap_bytes);
> +		btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
> +						cache->identity_remap_count);
> +		write_extent_buffer(leaf, &bgi, bi,
> +				    sizeof(struct btrfs_block_group_item_v2));
> +	} else {
> +		write_extent_buffer(leaf, &bgi, bi,
> +				    sizeof(struct btrfs_block_group_item));
> +	}
> +
>  fail:
>  	btrfs_release_path(path);
>  	/*
> @@ -3193,6 +3242,9 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  	if (ret < 0 && ret != -ENOENT) {
>  		spin_lock(&cache->lock);
>  		cache->commit_used = old_commit_used;
> +		cache->commit_remap_bytes = old_commit_remap_bytes;
> +		cache->commit_identity_remap_count =
> +			old_commit_identity_remap_count;
>  		spin_unlock(&cache->lock);
>  	}
>  	return ret;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 9172104a5889..af23fdb3cf4d 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -129,6 +129,8 @@ struct btrfs_block_group {
>  	u64 flags;
>  	u64 cache_generation;
>  	u64 global_root_id;
> +	u64 remap_bytes;
> +	u32 identity_remap_count;
>  
>  	/*
>  	 * The last committed used bytes of this block group, if the above @used
> @@ -136,6 +138,15 @@ struct btrfs_block_group {
>  	 * group item of this block group.
>  	 */
>  	u64 commit_used;
> +	/*
> +	 * The last committed remap_bytes value of this block group.
> +	 */
> +	u64 commit_remap_bytes;
> +	/*
> +	 * The last commited identity_remap_count value of this block group.
> +	 */
> +	u32 commit_identity_remap_count;
> +
>  	/*
>  	 * If the free space extent count exceeds this number, convert the block
>  	 * group to bitmaps.
> @@ -282,7 +293,8 @@ static inline bool btrfs_is_block_group_used(const struct btrfs_block_group *bg)
>  {
>  	lockdep_assert_held(&bg->lock);
>  
> -	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0);
> +	return (bg->used > 0 || bg->reserved > 0 || bg->pinned > 0 ||
> +		bg->remap_bytes > 0);
>  }
>  
>  static inline bool btrfs_is_block_group_data_only(const struct btrfs_block_group *block_group)
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 89fe85778115..ee5f5b2788e1 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -373,7 +373,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
>  		return;
>  
> -	if (block_group->used == 0)
> +	if (block_group->used == 0 && block_group->remap_bytes == 0)
>  		add_to_discard_unused_list(discard_ctl, block_group);
>  	else
>  		add_to_discard_list(discard_ctl, block_group);
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index b6827c2a7815..08b1bcfc7db7 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -688,6 +688,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
>  	u64 chunk_objectid;
>  	u64 flags;
>  	u64 type;
> +	size_t exp_size;
>  
>  	/*
>  	 * Here we don't really care about alignment since extent allocator can
> @@ -699,10 +700,15 @@ static int check_block_group_item(struct extent_buffer *leaf,
>  		return -EUCLEAN;
>  	}
>  
> -	if (unlikely(item_size != sizeof(bgi))) {
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		exp_size = sizeof(struct btrfs_block_group_item_v2);
> +	else
> +		exp_size = sizeof(struct btrfs_block_group_item);
> +
> +	if (unlikely(item_size != exp_size)) {
>  		block_group_err(leaf, slot,
>  			"invalid item size, have %u expect %zu",
> -				item_size, sizeof(bgi));
> +				item_size, exp_size);
>  		return -EUCLEAN;
>  	}
>  
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 9a36f0206d90..500e3a7df90b 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1229,6 +1229,14 @@ struct btrfs_block_group_item {
>  	__le64 flags;
>  } __attribute__ ((__packed__));
>  
> +struct btrfs_block_group_item_v2 {
> +	__le64 used;
> +	__le64 chunk_objectid;
> +	__le64 flags;
> +	__le64 remap_bytes;
> +	__le32 identity_remap_count;
> +} __attribute__ ((__packed__));
> +
>  struct btrfs_free_space_info {
>  	__le32 extent_count;
>  	__le32 flags;
> -- 
> 2.49.1
> 

