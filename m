Return-Path: <linux-btrfs+bounces-16287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB782B318D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED151899BB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531962FD7DB;
	Fri, 22 Aug 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L5LESLCL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yyiuSdy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L5LESLCL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0yyiuSdy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E72E6114
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867696; cv=none; b=Q6lO7Waf2qBGDjPgQcp3NxaJMy8LXM5iLs6GHtgHnDrOLp51wBhrIscytJlYnRJcz6pQwjtOSZSXkua5BG+hkxH3b32Q8eyiZ6SO+c2gX4agl0TJe8NzX5q/wuRnUUQJIvD2VLPt/qMeFoosJoO4LRU8MRZ4xHeoReJh/rCc2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867696; c=relaxed/simple;
	bh=scu/zmQ/f6ny54sV6YH4v6ySmdb9umT6vKnv+BNRors=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZN3gyRbStOeG3gFnkjErljnXtq7upB/ZtWLTvdVo0klD78jUcNu1xxUm4YN0Zc+4z3LqS2JNQtZ69XRq0rxUuRV7YM8TNqqRhygE2VVqEnFVxOMzEwZF44R0IIYq+cC0qFM4X/1J7/32elvPbByzuwGqnd8cbKVMhMqf1rTaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L5LESLCL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yyiuSdy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L5LESLCL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0yyiuSdy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CA201F38E;
	Fri, 22 Aug 2025 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755867693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qy1wBHbqipDLjNkCz8kZCfV7Kri3YcZD0PoaBfbfOao=;
	b=L5LESLCLsM5IsfGOZVo/ptpLtT3pt1gjm0vq+Qqn9d+pmiKOoWS5nAxF500oF/AUg1QTqQ
	1EHoBpIIOpUYv6KV5SQn1YHW//0i6grhbnH67WI7dCqBSSTKRtNI45QApNglVZ4kzLf0Nf
	PHbQS3xtrul0vx1CeCh2iEQ8cL68dz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755867693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qy1wBHbqipDLjNkCz8kZCfV7Kri3YcZD0PoaBfbfOao=;
	b=0yyiuSdyPkl7eCfO0MB+/n0SEbQYYagtIRLewP7HMX+7w44cv59GgUqmvNolkBaAFTBN/o
	ppoVHJzujuz+teAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755867693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qy1wBHbqipDLjNkCz8kZCfV7Kri3YcZD0PoaBfbfOao=;
	b=L5LESLCLsM5IsfGOZVo/ptpLtT3pt1gjm0vq+Qqn9d+pmiKOoWS5nAxF500oF/AUg1QTqQ
	1EHoBpIIOpUYv6KV5SQn1YHW//0i6grhbnH67WI7dCqBSSTKRtNI45QApNglVZ4kzLf0Nf
	PHbQS3xtrul0vx1CeCh2iEQ8cL68dz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755867693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qy1wBHbqipDLjNkCz8kZCfV7Kri3YcZD0PoaBfbfOao=;
	b=0yyiuSdyPkl7eCfO0MB+/n0SEbQYYagtIRLewP7HMX+7w44cv59GgUqmvNolkBaAFTBN/o
	ppoVHJzujuz+teAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF0F13931;
	Fri, 22 Aug 2025 13:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TW46Ay1qqGg8bwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Aug 2025 13:01:33 +0000
Date: Fri, 22 Aug 2025 15:01:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250822130123.GV22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250821131557.5185-1-sunk67188@gmail.com>
 <20250821131557.5185-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131557.5185-3-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 21, 2025 at 09:12:24PM +0800, Sun YangKai wrote:
> Trival pattern for the auto freeing with goto -> return convertions
> if possible. No other function cleanup.

Not all the changes match the trivial pattern described in the patches.

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/raid-stripe-tree.c |  16 +-
>  fs/btrfs/ref-verify.c       |   3 +-
>  fs/btrfs/reflink.c          |   3 +-
>  fs/btrfs/relocation.c       |  66 +++-----
>  fs/btrfs/root-tree.c        |  49 +++---
>  fs/btrfs/scrub.c            |  11 +-
>  fs/btrfs/send.c             | 307 +++++++++++++-----------------------
>  fs/btrfs/super.c            |   9 +-
>  fs/btrfs/tree-log.c         | 124 +++++----------
>  9 files changed, 204 insertions(+), 384 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index cab0b291088c..231107cafab2 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -67,7 +67,7 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_root *stripe_root = fs_info->stripe_root;
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct btrfs_key key;
>  	struct extent_buffer *leaf;
>  	u64 found_start;
> @@ -260,7 +260,6 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  		btrfs_release_path(path);
>  	}
>  
> -	btrfs_free_path(path);
>  	return ret;
>  }

As an example, this is the pattern, just declare, allocate and free at
the end.


> @@ -376,7 +374,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
>  	struct btrfs_stripe_extent *stripe_extent;
>  	struct btrfs_key stripe_key;
>  	struct btrfs_key found_key;
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct extent_buffer *leaf;
>  	const u64 end = logical + *length;
>  	int num_stripes;
> @@ -402,7 +400,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
>  
>  	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
>  	if (ret < 0)
> -		goto free_path;
> +		return ret;
>  	if (ret) {
>  		if (path->slots[0] != 0)
>  			path->slots[0]--;
> @@ -459,8 +457,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
>  		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
>  						   stripe->physical, devid);
>  
> -		ret = 0;
> -		goto free_path;
> +		return 0;
>  	}
>  
>  	/* If we're here, we haven't found the requested devid in the stripe. */
> @@ -474,8 +471,5 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
>  			  logical, logical + *length, stripe->dev->devid,
>  			  btrfs_bg_type_to_raid_name(map_type));
>  	}
> -free_path:
> -	btrfs_free_path(path);
> -
>  	return ret;
>  }

This is also still trivial with the goto/return conversion as long as
there's not additional logic around that.


> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7256f6748c8f..8b08d6e4cb2b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -409,7 +409,7 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
>  	struct btrfs_backref_iter *iter;
>  	struct btrfs_backref_cache *cache = &rc->backref_cache;
>  	/* For searching parent of TREE_BLOCK_REF */
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct btrfs_backref_node *cur;
>  	struct btrfs_backref_node *node = NULL;
>  	struct btrfs_backref_edge *edge;
> @@ -461,7 +461,6 @@ static noinline_for_stack struct btrfs_backref_node *build_backref_tree(
>  out:
>  	btrfs_free_path(iter->path);
>  	kfree(iter);
> -	btrfs_free_path(path);

In this case it depends, there are a few more statements after the
freeing which means the path is still allocated until the function ends.
If the statements are something quick, like in this case then it's still
OK and considered trivial.

>  	if (ret) {
>  		btrfs_backref_error_cleanup(cache, node);
>  		return ERR_PTR(ret);

> @@ -1661,8 +1651,6 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
>  	btrfs_tree_unlock(leaf);
>  	free_extent_buffer(leaf);
>  out:
> -	btrfs_free_path(path);

Similar to the previous one but is not trivial, due to calls to
insert_dirty_subvol(), btrfs_end_transaction_throttle(),
btrfs_btree_balance_dirty() and invalidate_extent_cache(). Please have a
look what the functions do.

> -
>  	if (ret == 0) {
>  		ret = insert_dirty_subvol(trans, rc, root);
>  		if (ret)

> @@ -4080,7 +4058,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  	struct btrfs_key key;
>  	struct btrfs_root *fs_root;
>  	struct btrfs_root *reloc_root;
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct extent_buffer *leaf;
>  	struct reloc_control *rc = NULL;
>  	struct btrfs_trans_handle *trans;
> @@ -4229,8 +4207,6 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  out:
>  	free_reloc_roots(&reloc_roots);
>  
> -	btrfs_free_path(path);

Same non-trivial case, there's btrfs_orphan_cleanup() after that.

> -
>  	if (ret == 0) {
>  		/* cleanup orphan inode in data relocation tree */
>  		fs_root = btrfs_grab_root(fs_info->data_reloc_root);

Please split the patch to parts that have the described trivial changes,
and then one patch per function in case it's not trivial and needs some
adjustments.

The freeing followed by other code can be still converted to auto
cleaning but there must be an explicit path = NULL after the free.

