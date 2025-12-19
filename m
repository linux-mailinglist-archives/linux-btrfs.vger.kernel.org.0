Return-Path: <linux-btrfs+bounces-19881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21048CCE3EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 03:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F023028F6E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773922836C;
	Fri, 19 Dec 2025 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GAtDO4fe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJJK+6+e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1hIdrT40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZBAC+KJV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B288BEC
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110362; cv=none; b=YrNl6rrliISU0nOeGbk1zkLuL0hJsYMhw4o/4JiymQFt6nrMxMHda4vIUKDny9IouZhfX9kiuQCsgIK3BxhhPW7imVAUlx/+do5ekDDkA1fE4dT3jFikKD1Qm9tRb0m2Cf1zlND5kpeiPtcDDGVC+V2LbtEC5d+I1dHAwHbNLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110362; c=relaxed/simple;
	bh=WmEo3qHnSTeYmVbkRX+DD3HbvuhUsRbfEwGpY4cRdTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTG6RyCK7Rn3D3Jekx+TYE0siS0Ui9WWQG8smukRz2x75WdEaawUR/bWYf73fYsfVz4OqRyRsZIzszS0/oVyKe9zFY4O2ZSLhE/4HmMjYA/6Q4TJb2cSfY1PISf0dvO3Sexey/mkvSJQHD/dHfy2HNWbX2bpA5sp09pMur6s4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GAtDO4fe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJJK+6+e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1hIdrT40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZBAC+KJV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB378336F3;
	Fri, 19 Dec 2025 02:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766110359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOo8fE22nO1hLD/zjYJdwCxhClokE/MUBx+jqTz8wwM=;
	b=GAtDO4feB4DgCGh0180ohVX03cUwkvAnqhFux7ohJMcgbGQoqMJ/dbPL3p1y8Dp2hJ4C8f
	wpwFPb0CmlkrKqsfAAOVbaiK7Q1scMCfHAOaYKnZFlH/d4jkHGYW27DP+FTa0feMwNqAKo
	LCDcXx3nTVwchH1gYFn8hJPq06aWUiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766110359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOo8fE22nO1hLD/zjYJdwCxhClokE/MUBx+jqTz8wwM=;
	b=rJJK+6+e1jLVTklUkejCO8wYi4H1zgeZ2QfFnpLieRwvncidj5yCRpCZH3eN0KEJ8f1oAJ
	f8IBVQnKzhNYCbBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766110357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOo8fE22nO1hLD/zjYJdwCxhClokE/MUBx+jqTz8wwM=;
	b=1hIdrT40g2rFGF+4XCYy4qt5J3kR8Jr9yz5j32Y+JdpXlzJ3hHJFsQYDxfMKlECbKDcBpt
	L7db/bF2K8ccPFFSbrcz+pVAy6i5V3NUfe3fxZCBu4nWNZYSPNbqKIj+S+9LKdX1h2xMlb
	HqOu2ekiiViRQUbizu7SsBBwShMj23g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766110357;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOo8fE22nO1hLD/zjYJdwCxhClokE/MUBx+jqTz8wwM=;
	b=ZBAC+KJV5+BrJqKBlk/frAb2Uo6V0OOfuRrfzRulaijr7GZSnYuZjDqgnhDOsoxAnNzWai
	BAufyEKQqcgWC8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EB483EA63;
	Fri, 19 Dec 2025 02:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLmdIpW0RGm4PAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 02:12:37 +0000
Date: Fri, 19 Dec 2025 03:12:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v7 14/16] btrfs: allow balancing remap tree
Message-ID: <20251219021236.GA3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-15-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-15-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.95
X-Spam-Level: 
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.15)[-0.737];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,bur.io:email,imap1.dmz-prg2.suse.org:helo,harmstone.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Nov 24, 2025 at 06:53:06PM +0000, Mark Harmstone wrote:
> Balancing the REMAP chunk, i.e. the chunk in which the remap tree lives,
> is a special case.
> 
> We can't use the remap tree itself for this, as then we'd have no way to
> boostrap it on mount. And we can't use the pre-remap tree code for this
> as it relies on walking the extent tree, and we're not creating backrefs
> for REMAP chunks.
> 
> So instead, if a balance would relocate any REMAP block groups, mark
> those block groups as readonly and COW every leaf of the remap tree.
> 
> There's more sophisticated ways of doing this, such as only COWing nodes
> within a block group that's to be relocated, but they're fiddly and with
> lots of edge cases. Plus it's not anticipated that a) the number of
> REMAP chunks is going to be particularly large, or b) that users will
> want to only relocate some of these chunks - the main use case here is
> to unbreak RAID conversion and device removal.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/volumes.c | 159 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 58ea0ef9d9c4..48544833aa4c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4002,8 +4002,11 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	struct btrfs_balance_args *bargs = NULL;
>  	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> -	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
> -		return false;
> +	/* treat REMAP chunks as METADATA */
> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
> +		chunk_type &= ~BTRFS_BLOCK_GROUP_REMAP;
> +		chunk_type |= BTRFS_BLOCK_GROUP_METADATA;
> +	}
>  
>  	/* type filter */
>  	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
> @@ -4086,6 +4089,113 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	return true;
>  }
>  
> +struct remap_chunk_info {
> +	struct list_head list;
> +	u64 offset;
> +	struct btrfs_block_group *bg;
> +	bool made_ro;
> +};
> +
> +static int cow_remap_tree(struct btrfs_trans_handle *trans,
> +			  struct btrfs_path *path)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key = { 0 };
> +	int ret;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	while (true) {
> +		ret = btrfs_next_leaf(fs_info->remap_root, path);
> +		if (ret < 0) {
> +			return ret;
> +		} else if (ret > 0) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +		btrfs_release_path(path);
> +
> +		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
> +					0, 1);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int balance_remap_chunks(struct btrfs_fs_info *fs_info,
> +				struct btrfs_path *path,
> +				struct list_head *chunks)
> +{
> +	struct remap_chunk_info *rci, *tmp;
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	list_for_each_entry_safe(rci, tmp, chunks, list) {
> +		rci->bg = btrfs_lookup_block_group(fs_info, rci->offset);
> +		if (!rci->bg) {
> +			list_del(&rci->list);
> +			kfree(rci);
> +			continue;
> +		}
> +
> +		ret = btrfs_inc_block_group_ro(rci->bg, false);
> +		if (ret)
> +			goto end;
> +
> +		rci->made_ro = true;
> +	}
> +
> +	if (list_empty(chunks))
> +		return 0;
> +
> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		goto end;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	ret = cow_remap_tree(trans, path);
> +
> +	btrfs_release_path(path);
> +
> +	mutex_unlock(&fs_info->remap_mutex);

The release path would be beter placed outside of the lock as this makes
the critical section shorter.

> +
> +	btrfs_commit_transaction(trans);
> +
> +end:
> +	while (!list_empty(chunks)) {
> +		bool unused;

		bool is_unused

> +
> +		rci = list_first_entry(chunks, struct remap_chunk_info, list);
> +
> +		spin_lock(&rci->bg->lock);
> +		unused = !btrfs_is_block_group_used(rci->bg);
> +		spin_unlock(&rci->bg->lock);
> +
> +		if (unused)
> +			btrfs_mark_bg_unused(rci->bg);
> +
> +		if (rci->made_ro)
> +			btrfs_dec_block_group_ro(rci->bg);
> +
> +		btrfs_put_block_group(rci->bg);
> +
> +		list_del(&rci->list);
> +		kfree(rci);
> +	}
> +
> +	return ret;
> +}
> +
>  static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
> @@ -4108,6 +4218,9 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  	u32 count_meta = 0;
>  	u32 count_sys = 0;
>  	int chunk_reserved = 0;
> +	struct remap_chunk_info *rci;
> +	unsigned int num_remap_chunks = 0;
> +	LIST_HEAD(remap_chunks);
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> @@ -4206,7 +4319,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  				count_data++;
>  			else if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM)
>  				count_sys++;
> -			else if (chunk_type & BTRFS_BLOCK_GROUP_METADATA)
> +			else if (chunk_type & (BTRFS_BLOCK_GROUP_METADATA |
> +					       BTRFS_BLOCK_GROUP_REMAP))
>  				count_meta++;
>  
>  			goto loop;
> @@ -4226,6 +4340,30 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  			goto loop;
>  		}
>  
> +		/*
> +		 * Balancing REMAP chunks takes place separately - add the
> +		 * details to a list so it can be processed later.
> +		 */
> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +			rci = kmalloc(sizeof(struct remap_chunk_info),
> +				      GFP_NOFS);
> +			if (!rci) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
> +
> +			rci->offset = found_key.offset;
> +			rci->bg = NULL;
> +			rci->made_ro = false;
> +			list_add_tail(&rci->list, &remap_chunks);
> +
> +			num_remap_chunks++;
> +
> +			goto loop;
> +		}
> +
>  		if (!chunk_reserved) {
>  			/*
>  			 * We may be relocating the only data chunk we have,
> @@ -4265,11 +4403,24 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  		key.offset = found_key.offset - 1;
>  	}
>  
> +	btrfs_release_path(path);
> +
>  	if (counting) {
> -		btrfs_release_path(path);
>  		counting = false;
>  		goto again;
>  	}
> +
> +	if (!list_empty(&remap_chunks)) {
> +		ret = balance_remap_chunks(fs_info, path, &remap_chunks);
> +		if (ret == -ENOSPC)
> +			enospc_errors++;
> +
> +		if (!ret) {
> +			spin_lock(&fs_info->balance_lock);
> +			bctl->stat.completed += num_remap_chunks;
> +			spin_unlock(&fs_info->balance_lock);
> +		}
> +	}
>  error:
>  	if (enospc_errors) {
>  		btrfs_info(fs_info, "%d enospc errors during balance",
> -- 
> 2.51.0
> 

