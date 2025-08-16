Return-Path: <linux-btrfs+bounces-16102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB3B28913
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2833ADD9D
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5823DE;
	Sat, 16 Aug 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eDwID1Bd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjgZRDdc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B11FC8
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302862; cv=none; b=nLOOGsdt6IMFgLW/SJW4OanF7P/7f9rpiJYR4dYfVzJM9ZeC6i974eFU4BEZdwFX2Q7k/rNzoTdvl5FrKI5cIIB2fnF5sVBEuD5tOzq6yRyOJsFtqJYLgnHx8u+4H3GNOdK9RwYEhYeu9F0uNSCDqoOTwD7lj8OMyXzV73MG9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302862; c=relaxed/simple;
	bh=HchmN9qY7m1Lh39keTCNRxNXnPrThV1+DHg0i1cHCyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBfyYQunPsn8SBTJOS2DB4AUIwRVml+RtcKLzvHDCMUXgos2gqu7y2pleYIgKGybim6ma4DtPtBlWBOdYSFy1iQTEVWuPQLE69w2jgWf6OggAXnS/UZTp1FXJOgKAxZIWvPUWEuaBiRT7SQhGI1Gya37a0RoUb4A35TMbo1zkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eDwID1Bd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjgZRDdc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB0817A0258;
	Fri, 15 Aug 2025 20:07:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 20:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755302859; x=1755389259; bh=Ztga+1t3P4
	Cf65BVYV09KnwIQhhP8G8iGBDPrMu1HHQ=; b=eDwID1BdDyEGYpX7V8iOT1ZOM+
	QeG6iD71l+0c3mtjL7pfzi0bV+Yek2EiMVi5JolRCDwLeS5QrGV6+dBCBq5H7lTB
	m4QbeAlvuqEieaeN7fCBjoatSju2T11qLGwqULaBHu8+FDIpvc5bs6T5e1EpqPk3
	LD/Hp2rQc6LfKuaEyKGGsRyy8CuOezyNachXtHoQ3Xm0qq5/VFoVcqUxwOHJiX6Y
	XpVtsiIrBTSnhjLvZrdSHX5Hsl9Ykma+aOnU8YFupAz30gUWqLSr+vVUv3h/ofiw
	zog5hjTOUZcTdC0Ntj6Z7sWxv28xwZZx8LVydbc2cnhOBO16IyoKSw4oo7Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755302859; x=1755389259; bh=Ztga+1t3P4Cf65BVYV09KnwIQhhP8G8iGBD
	PrMu1HHQ=; b=HjgZRDdcZsDKVMbvWBNiJR0OtUPqN9a0pWpUxKyGnYlMs+5Hltr
	6ARnj+/BCb0RpJl05mmttNNfSNXbgLl0wG6/yPgYbslX64Y1JiC5HT4XIkAoXTaw
	LhdvwRaHNqQv4VN9xc90lNvFWbGMIlXDyecNOp+Kvpkq6ZGh/yH8QCRFo7FlvhMq
	mwhFzJqd+d7ZRWmkOarqUWRYmOY/9z8X5iswWpNbDOlac79H47r5uBA+iD3EEE9c
	cvTzDecPa8FvpC+T+8z6/oI/rTWTxjJZzrlB3jjsdXYRMccWW0VMROnHGetU+lUS
	z1fWJoO9Wc3l/HQtUVYG+Q/qdjuegqajBMw==
X-ME-Sender: <xms:y8ufaBP5MPy2EiR7sm7bCPp5A1TiwIpRv-8PgifyR0pqTJyLva7Swg>
    <xme:y8ufaEIVbqwsQg1-BR-ihnMxVDjmRayx9OgvALRq-NoeMY0lLtWrqZAGT5iwfoBTt
    yYfHKKp28Lm7x98Ofc>
X-ME-Received: <xmr:y8ufaCGiqk4dksGxecAg3srP1idyLAEEDaoHeFS_ZR5pdfgR_dQQE3KVVdSYgQ59gKECjV-8hqyltC_q9_jqc-pxZX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:y8ufaMQrg8pvVC2SnS03DI48uXDsh7lawIV_vPgsBStjBkmGJI49Wg>
    <xmx:y8ufaOGlcwHvJipNMagSI61P_jUouxHxVzqRnbueAXbjVtsFAoWfzA>
    <xmx:y8ufaI95RmpHnCdRA8sQh7df0QJ7oW0VY5kpik1DzJI8iQn35y8Jjw>
    <xmx:y8ufaIIz3lSerTZYlstIbGNmjtjBuixDgTDI9k9uNppo3L2fHPduaA>
    <xmx:y8ufaISKkwe13TdN-EQ62i7LWU-g5hbFgYZpIUYbc0zRej3DpF16H12j>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:07:38 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:08:20 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 06/16] btrfs: add extended version of struct
 block_group_item
Message-ID: <20250816000820.GD3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-7-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-7-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:48PM +0100, Mark Harmstone wrote:
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
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/accessors.h            |  20 +++++++
>  fs/btrfs/block-group.c          | 101 ++++++++++++++++++++++++--------
>  fs/btrfs/block-group.h          |  14 ++++-
>  fs/btrfs/discard.c              |   2 +-
>  fs/btrfs/tree-checker.c         |  10 +++-
>  include/uapi/linux/btrfs_tree.h |   8 +++
>  6 files changed, 127 insertions(+), 28 deletions(-)
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
> index 4d76d457da9b..bed9c58b6cbc 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2368,7 +2368,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>  }
>  
>  static int read_one_block_group(struct btrfs_fs_info *info,
> -				struct btrfs_block_group_item *bgi,
> +				struct btrfs_block_group_item_v2 *bgi,
>  				const struct btrfs_key *key,
>  				int need_clear)
>  {
> @@ -2383,11 +2383,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
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
> @@ -2452,7 +2457,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  	} else if (cache->length == cache->used) {
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		btrfs_free_excluded_extents(cache);
> -	} else if (cache->used == 0) {
> +	} else if (cache->used == 0 && cache->remap_bytes == 0) {
>  		cache->cached = BTRFS_CACHE_FINISHED;
>  		ret = btrfs_add_new_free_space(cache, cache->start,
>  					       cache->start + cache->length, NULL);
> @@ -2472,7 +2477,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  
>  	set_avail_alloc_bits(info, cache->flags);
>  	if (btrfs_chunk_writeable(info, cache->start)) {
> -		if (cache->used == 0) {
> +		if (cache->used == 0 && cache->identity_remap_count == 0 &&
> +		    cache->remap_bytes == 0) {
>  			ASSERT(list_empty(&cache->bg_list));
>  			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
>  			    !(cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
> @@ -2578,9 +2584,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
> @@ -2591,8 +2598,16 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
> @@ -2662,25 +2677,38 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
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
> @@ -3135,10 +3163,12 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
> @@ -3148,13 +3178,21 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
> @@ -3170,11 +3208,23 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
> @@ -3189,6 +3239,9 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
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
> index a8bb8429c966..ecc89701b2ea 100644
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
> index 1015a4d37fb2..2b7b1e440bc8 100644
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
> index 20bfe333ffdd..922f7afa024d 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -687,6 +687,7 @@ static int check_block_group_item(struct extent_buffer *leaf,
>  	u64 chunk_objectid;
>  	u64 flags;
>  	u64 type;
> +	size_t exp_size;
>  
>  	/*
>  	 * Here we don't really care about alignment since extent allocator can
> @@ -698,10 +699,15 @@ static int check_block_group_item(struct extent_buffer *leaf,
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

