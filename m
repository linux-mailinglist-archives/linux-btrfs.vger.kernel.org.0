Return-Path: <linux-btrfs+bounces-5887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0B912C95
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E621F25F73
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010371684AC;
	Fri, 21 Jun 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KVygj/3u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muXdg4EO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D038BFD
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991891; cv=none; b=qx57zEpFH12DKUTbsFsz7Qt8MZmevT8NEcthE3s6ZnWeqBLXjjKBO5/81wDTLdOOiI6qGfIlUizcQN+AAdQV0fo+J7axwzPXbSokohpGva4aZj87Fu3TnoqwQ96lF9DM2iTcLUeLcsyg2HY0Dg+GtgC4KpNN8jFFt24ZrV8Q4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991891; c=relaxed/simple;
	bh=yIK5p54R9nmDa94C+jR5A9K6ztTO56LqbY9OnnssMng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPMmzMRQTL1OJAgpNCDShGtPeDnAaG39fDNm3eW7QWEP8biDyC3Lw0WmOU4gdFg5MC0Vszh3MlAxBAl549lYvb0RoqHi6HKWk29t8ds2E69+Nw+ZmcFfT/IKy14jxogPhFGfTu/k9Gz0WvPUuROCAMwXtM7FZC/5Dza8XSjrrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KVygj/3u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muXdg4EO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 340D411400DD;
	Fri, 21 Jun 2024 13:44:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 21 Jun 2024 13:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718991888; x=1719078288; bh=8nS1QDOf1K
	JBX1KooERZh9yvgYZ3PGFUN4ctoVUmeRg=; b=KVygj/3ul9hm0QXkO0suBtCgZC
	UlQNqfluYTeVxrLx+1YT0pBxlvnxcQjgzWYEsyENCDdaBt+RcoI46Z0NGvhs0u5u
	49U9eS4juaftoshGURl5NTRkMdA+O7jDNZrpeQvV/R08ePilvDaRH3DFKdbuEp0/
	uXdCPCZBq75GI4I34NdsVtMQZigiYtcQJ55aVEyg+AQjP2aUqRebGwrlaSkcS1AI
	tzfTFF2lsqV3T6VFWgZMJVlo0S6fd2ZK/ZySzgM48zdnMzR1XpWo0bY2Z0yk86NT
	1Txl2ws6vntiZ8Bne6p7LDT2+9QBbutzky+CqaKUWoAu4Kb1meshqmuvhxXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718991888; x=1719078288; bh=8nS1QDOf1KJBX1KooERZh9yvgYZ3
	PGFUN4ctoVUmeRg=; b=muXdg4EO7y4ZOSD5O3Zz1QQaj8xA0fHW2nxygB8afKA5
	Yo/gLggxV4dhstRBJ3RyLoZSGrHojD+8JoX2cuJTS7wF4qkXe1E71WtiuQx4fbmn
	xOklRjVrckfBePbOK9ZjKU6SjT+o1srl8flhUi8sAJlQuLwd6Ctdo1KOoamgUOCW
	55vUL9Pe4qPVEX+smhKun8LM7JLGdj3FqymumrrtsqosOhT5+UGRP06mrW9Fg5mh
	YVG8bb2BYleFMrgzFS9tMYjCHJL/uWUnhuqo28iRX2+QXkauO/IZPDkvzUeEJEHb
	ekOwmdz6bn2W4HrvW4520AnnPtkSPfTn/fJ+aeY7Qg==
X-ME-Sender: <xms:D7x1ZjlRknWBcMv4xf-6lwD4Qbl5Ua89S_sZ31RchgWMe9b1R5JQ6A>
    <xme:D7x1Zm3nxxr1u3Wh6SKY_YsdCpbfBQsqAUlvNpkfhZgEkOHse5_8Wm6TO_FXoCStf
    y24NyY2oIfDXyEfaQw>
X-ME-Received: <xmr:D7x1ZprP5dZ75OljmXBlIncJyaJMpjDX8wz9NvJiF1O4gTd_G67hJqeKkue9iuev5iPeUVteB_WzQqYLTdbF4G1ZTSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ELx1ZrksOSuXalFKm7y3JWD-x1CWgytF_DfWH-6eZIi1fzvj33Zv6Q>
    <xmx:ELx1Zh0FVqoSJo9CYA5IeMiy042XyxXzrbYQ17KGza79Mvc55AB8zQ>
    <xmx:ELx1ZqvX2iwmpGTxEW9-46eJCQrLmwUEhWwXQMr5yLJ5Meg2ZdPcFw>
    <xmx:ELx1ZlUHM0ULNZq5hkz5w6xaC7UsUyAM8VoZLHYXCKtyHX8gZfehBQ>
    <xmx:ELx1ZvC4P99TFtPtcbgXglR0fnsQrNl4kay6k3K6GMRiF7A5ZhgpK8kH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 13:44:47 -0400 (EDT)
Date: Fri, 21 Jun 2024 10:44:24 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid allocating and running pointless delayed
 extent operations
Message-ID: <20240621174424.GA2757239@zen.localdomain>
References: <87618653fb07d2f6307babd128b626da36dd33e8.1718964587.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87618653fb07d2f6307babd128b626da36dd33e8.1718964587.git.fdmanana@suse.com>

On Fri, Jun 21, 2024 at 11:16:29AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We always allocate a delayed extent op structure when allocating a tree
> block (except for log trees), but most of the time we don't need it as
> we only need to set the BTRFS_BLOCK_FLAG_FULL_BACKREF if we're dealing
> with a relocation tree and we only need to set the key of a tree block
> in a btrfs_tree_block_info structure if we are not using skinny metadata
> (feature enabled by default since btrfs-progs 3.18 and available as of
> kernel 3.10).
> 
> In these cases, where we don't need neither to update flags nor to set
> the key, we only use the delayed extent op structure to set the tree
> block's level. This is a waste of memory and besides that, the memory
> allocation can fail and can add additional latency.
> 
> Instead of using a delayed extent op structure to store the level of
> the tree block, use the delayed ref head to store it. This doesn't
> change the size of neither structure and helps us avoid allocating
> delayed extent ops structures when using the skinny metadata feature
> and there's no relocation going on. This also gets rid of a BUG_ON().
> 
> For example, for a fs_mark run, with 5 iterations, 8 threads and 100K
> files per iteration, before this patch there were 118109 allocations
> of delayed extent op structures and after it there were none.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/delayed-ref.c |  9 +++++-
>  fs/btrfs/delayed-ref.h |  6 ++--
>  fs/btrfs/extent-tree.c | 63 ++++++++++++++++++------------------------
>  3 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6b4296ab651f..2ac9296edccb 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -819,6 +819,12 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
>  	spin_lock_init(&head_ref->lock);
>  	mutex_init(&head_ref->mutex);
>  
> +	/* If not metadata set an impossible level to help debugging. */
> +	if (generic_ref->type == BTRFS_REF_METADATA)
> +		head_ref->level = generic_ref->tree_ref.level;
> +	else
> +		head_ref->level = U8_MAX;
> +
>  	if (qrecord) {
>  		if (generic_ref->ref_root && reserved) {
>  			qrecord->data_rsv = reserved;
> @@ -1072,7 +1078,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  }
>  
>  int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
> -				u64 bytenr, u64 num_bytes,
> +				u64 bytenr, u64 num_bytes, u8 level,
>  				struct btrfs_delayed_extent_op *extent_op)
>  {
>  	struct btrfs_delayed_ref_head *head_ref;
> @@ -1082,6 +1088,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
>  		.action = BTRFS_UPDATE_DELAYED_HEAD,
>  		.bytenr = bytenr,
>  		.num_bytes = num_bytes,
> +		.tree_ref.level = level,
>  	};
>  
>  	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 405be46c420f..ef15e998be03 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -108,7 +108,6 @@ struct btrfs_delayed_ref_node {
>  
>  struct btrfs_delayed_extent_op {
>  	struct btrfs_disk_key key;
> -	u8 level;
>  	bool update_key;
>  	bool update_flags;
>  	u64 flags_to_set;
> @@ -172,6 +171,9 @@ struct btrfs_delayed_ref_head {
>  	 */
>  	u64 reserved_bytes;
>  
> +	/* Tree block level, for metadata only. */
> +	u8 level;
> +
>  	/*
>  	 * when a new extent is allocated, it is just reserved in memory
>  	 * The actual extent isn't inserted into the extent allocation tree
> @@ -355,7 +357,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  			       struct btrfs_ref *generic_ref,
>  			       u64 reserved);
>  int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
> -				u64 bytenr, u64 num_bytes,
> +				u64 bytenr, u64 num_bytes, u8 level,
>  				struct btrfs_delayed_extent_op *extent_op);
>  void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
>  			      struct btrfs_delayed_ref_root *delayed_refs,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 23a7cac108eb..250623f3b094 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -200,19 +200,8 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>  			goto search_again;
>  		}
>  		spin_lock(&head->lock);
> -		if (head->extent_op && head->extent_op->update_flags) {
> +		if (head->extent_op && head->extent_op->update_flags)
>  			extent_flags |= head->extent_op->flags_to_set;
> -		} else if (unlikely(num_refs == 0)) {
> -			spin_unlock(&head->lock);
> -			mutex_unlock(&head->mutex);
> -			spin_unlock(&delayed_refs->lock);
> -			ret = -EUCLEAN;
> -			btrfs_err(fs_info,
> -			  "unexpected zero reference count for extent %llu (%s)",
> -				  bytenr, metadata ? "metadata" : "data");
> -			btrfs_abort_transaction(trans, ret);
> -			goto out_free;
> -		}
>  
>  		num_refs += head->ref_mod;
>  		spin_unlock(&head->lock);
> @@ -1632,7 +1621,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
>  
>  	if (metadata) {
>  		key.type = BTRFS_METADATA_ITEM_KEY;
> -		key.offset = extent_op->level;
> +		key.offset = head->level;
>  	} else {
>  		key.type = BTRFS_EXTENT_ITEM_KEY;
>  		key.offset = head->num_bytes;
> @@ -1667,7 +1656,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
>  			ret = -EUCLEAN;
>  			btrfs_err(fs_info,
>  		  "missing extent item for extent %llu num_bytes %llu level %d",
> -				  head->bytenr, head->num_bytes, extent_op->level);
> +				  head->bytenr, head->num_bytes, head->level);
>  			goto out;
>  		}
>  	}
> @@ -1726,7 +1715,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  			.generation = trans->transid,
>  		};
>  
> -		BUG_ON(!extent_op || !extent_op->update_flags);
>  		ret = alloc_reserved_tree_block(trans, node, extent_op);
>  		if (!ret)
>  			btrfs_record_squota_delta(fs_info, &delta);
> @@ -2233,7 +2221,6 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
>  				struct extent_buffer *eb, u64 flags)
>  {
>  	struct btrfs_delayed_extent_op *extent_op;
> -	int level = btrfs_header_level(eb);
>  	int ret;
>  
>  	extent_op = btrfs_alloc_delayed_extent_op();
> @@ -2243,9 +2230,9 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
>  	extent_op->flags_to_set = flags;
>  	extent_op->update_flags = true;
>  	extent_op->update_key = false;
> -	extent_op->level = level;
>  
> -	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len, extent_op);
> +	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
> +					  btrfs_header_level(eb), extent_op);
>  	if (ret)
>  		btrfs_free_delayed_extent_op(extent_op);
>  	return ret;
> @@ -4866,7 +4853,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  	struct btrfs_path *path;
>  	struct extent_buffer *leaf;
>  	u32 size = sizeof(*extent_item) + sizeof(*iref);
> -	u64 flags = extent_op->flags_to_set;
> +	const u64 flags = (extent_op ? extent_op->flags_to_set : 0);
>  	/* The owner of a tree block is the level. */
>  	int level = btrfs_delayed_ref_owner(node);
>  	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
> @@ -5123,7 +5110,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  	struct btrfs_key ins;
>  	struct btrfs_block_rsv *block_rsv;
>  	struct extent_buffer *buf;
> -	struct btrfs_delayed_extent_op *extent_op;
>  	u64 flags = 0;
>  	int ret;
>  	u32 blocksize = fs_info->nodesize;
> @@ -5166,6 +5152,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  		BUG_ON(parent > 0);
>  
>  	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
> +		struct btrfs_delayed_extent_op *extent_op;
>  		struct btrfs_ref generic_ref = {
>  			.action = BTRFS_ADD_DELAYED_EXTENT,
>  			.bytenr = ins.objectid,
> @@ -5174,30 +5161,34 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>  			.owning_root = owning_root,
>  			.ref_root = root_objectid,
>  		};
> -		extent_op = btrfs_alloc_delayed_extent_op();
> -		if (!extent_op) {
> -			ret = -ENOMEM;
> -			goto out_free_buf;
> +
> +		if (!skinny_metadata || flags != 0) {
> +			extent_op = btrfs_alloc_delayed_extent_op();
> +			if (!extent_op) {
> +				ret = -ENOMEM;
> +				goto out_free_buf;
> +			}
> +			if (key)
> +				memcpy(&extent_op->key, key, sizeof(extent_op->key));
> +			else
> +				memset(&extent_op->key, 0, sizeof(extent_op->key));
> +			extent_op->flags_to_set = flags;
> +			extent_op->update_key = skinny_metadata ? false : true;
> +			extent_op->update_flags = (flags != 0);
> +		} else {
> +			extent_op = NULL;
>  		}
> -		if (key)
> -			memcpy(&extent_op->key, key, sizeof(extent_op->key));
> -		else
> -			memset(&extent_op->key, 0, sizeof(extent_op->key));
> -		extent_op->flags_to_set = flags;
> -		extent_op->update_key = skinny_metadata ? false : true;
> -		extent_op->update_flags = true;
> -		extent_op->level = level;
>  
>  		btrfs_init_tree_ref(&generic_ref, level, btrfs_root_id(root), false);
>  		btrfs_ref_tree_mod(fs_info, &generic_ref);
>  		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, extent_op);
> -		if (ret)
> -			goto out_free_delayed;
> +		if (ret) {
> +			btrfs_free_delayed_extent_op(extent_op);
> +			goto out_free_buf;
> +		}
>  	}
>  	return buf;
>  
> -out_free_delayed:
> -	btrfs_free_delayed_extent_op(extent_op);
>  out_free_buf:
>  	btrfs_tree_unlock(buf);
>  	free_extent_buffer(buf);
> -- 
> 2.43.0
> 

