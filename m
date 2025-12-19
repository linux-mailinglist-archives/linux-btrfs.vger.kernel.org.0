Return-Path: <linux-btrfs+bounces-19879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FFCCE31E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61A24302105C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27326FA60;
	Fri, 19 Dec 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDeMbVaF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IY1fwu50";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GBlETgHA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4gGKXM2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357D22A7E9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109387; cv=none; b=gjwsJ6Yaxg19knew/lpIHrXVASgh56E3x2/B4jfEy+1W8sg5S/E31fG5FV3PPTAWcyB9htOoXaqLw0CR0uj1fJtqmy07yKuQvZb3XMuYvJvhvmSwJXASQUPwqF8r+ZMwKGU8EC3qOL4rOAg740yIkajK/ptdfJf0fQTbPxjH3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109387; c=relaxed/simple;
	bh=MrF6xikQzZQM4eLVZqG6Ra4Z1RWaC+OJcOh46sDMtro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECRZh+pd2vDWy6EaVKYopxcEVhU4jpoYn+cFlUlH23de7W6QDlPS6UYHkSIFDnnm1049svszfHG3wvP5+qct8ZgfROHJlmOWb9o8+/6kAkq+iDtwHutk1zmRXKcyhPn8RQcPKdvxspmNQLtJPDZEqkERXdyC33VakH3pyd/ueag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDeMbVaF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IY1fwu50; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GBlETgHA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4gGKXM2C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA945BD05;
	Fri, 19 Dec 2025 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766109382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHkpepqk0SjWZfULH9QUdO/kCYM9syLNcLaoTLL+ILo=;
	b=GDeMbVaFFaSBg/FrV5DRQwn7Jjj2eYlzaXQ6gexnGjKn7qeGvGsOHJYY75ODCSOY5xiS2P
	CnOLCZtq8xzlaAbgf0Sn2RwlIdXdjMevzXNXcNRK3SWE5LEfPQSgCXKobrpRdcVS/9FJfc
	rU9VmBjpp7bTX+2KfWbPo8r/3xaDRrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766109382;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHkpepqk0SjWZfULH9QUdO/kCYM9syLNcLaoTLL+ILo=;
	b=IY1fwu50wMzZNnXxe0N5hczuVaT1+gB0zuXkaXWtPAZf5mV6MqIsofR6frSv7ja8Bl6s1Z
	bqMuXN1mR68/iMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766109381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHkpepqk0SjWZfULH9QUdO/kCYM9syLNcLaoTLL+ILo=;
	b=GBlETgHAD9zJlOm8ELk9Pp/io8+bPQXKNe3Mn6ZL2z4Pa7rMBDPhhvrtmYmSV7No3K2dDl
	HJQ9Sb0oQejJxLaZqN96K0ThNAceRFrjIOS2JMjQ+iOfjaQIRis1+G7hoZYpYDL1BGjYYt
	fKuxEJA15GK+zQ6nXl6+FKv1+kXgPyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766109381;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pHkpepqk0SjWZfULH9QUdO/kCYM9syLNcLaoTLL+ILo=;
	b=4gGKXM2C3JRecVuOgr/r4EVHS88QaI9ZxXQwxPvpIk0/678OLk/er1ubUiu05so6oNUSza
	HN10OqlCbBvNIMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45F123EA63;
	Fri, 19 Dec 2025 01:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7VatEMWwRGkyOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 01:56:21 +0000
Date: Fri, 19 Dec 2025 02:56:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v7 10/16] btrfs: handle setting up relocation of block
 group with remap-tree
Message-ID: <20251219015605.GY3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-11-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-11-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.938];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,bur.io:email,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,batch.nr:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Nov 24, 2025 at 06:53:02PM +0000, Mark Harmstone wrote:
> Handle the preliminary work for relocating a block group in a filesystem
> with the remap-tree flag set.
> 
> If the block group is SYSTEM btrfs_relocate_block_group() proceeds as it
> does already, as bootstrapping issues mean that these block groups have
> to be processed the existing way. Similarly with REMAP blocks, which are
> dealt with in a later patch.
> 
> Otherwise we walk the free-space tree for the block group in question,
> recording any holes. These get converted into identity remaps and placed
> in the remap tree, and the block group's REMAPPED flag is set. From now
> on no new allocations are possible within this block group, and any I/O
> to it will be funnelled through btrfs_translate_remap(). We store the
> number of identity remaps in `identity_remap_count`, so that we know
> when we've removed the last one and the block group is fully remapped.
> 
> The change in btrfs_read_roots() is because data relocations no longer
> rely on the data reloc tree as a hidden subvolume in which to do
> snapshots.
> 
> (Thanks to Sun YangKai for his suggestions.)
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c     |   6 +-
>  fs/btrfs/block-group.h     |   4 +
>  fs/btrfs/free-space-tree.c |   4 +-
>  fs/btrfs/free-space-tree.h |   5 +-
>  fs/btrfs/relocation.c      | 516 +++++++++++++++++++++++++++++++++----
>  fs/btrfs/relocation.h      |  11 +
>  fs/btrfs/space-info.c      |   9 +-
>  fs/btrfs/volumes.c         |  91 ++++---
>  8 files changed, 553 insertions(+), 93 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 16a828d3d910..5fa6910e9813 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2413,6 +2413,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  	cache->used = btrfs_stack_block_group_v2_used(bgi);
>  	cache->commit_used = cache->used;
>  	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
> +	cache->commit_flags = cache->flags;
>  	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
>  	cache->space_info = btrfs_find_space_info(info, cache->flags);
>  	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
> @@ -2722,6 +2723,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>  	block_group->commit_remap_bytes = block_group->remap_bytes;
>  	block_group->commit_identity_remap_count =
>  		block_group->identity_remap_count;
> +	block_group->commit_flags = block_group->flags;
>  	key.objectid = block_group->start;
>  	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>  	key.offset = block_group->length;
> @@ -3210,13 +3212,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  	/* No change in values, can safely skip it. */
>  	if (cache->commit_used == used &&
>  	    cache->commit_remap_bytes == remap_bytes &&
> -	    cache->commit_identity_remap_count == identity_remap_count) {
> +	    cache->commit_identity_remap_count == identity_remap_count &&
> +	    cache->commit_flags == cache->flags) {
>  		spin_unlock(&cache->lock);
>  		return 0;
>  	}
>  	cache->commit_used = used;
>  	cache->commit_remap_bytes = remap_bytes;
>  	cache->commit_identity_remap_count = identity_remap_count;
> +	cache->commit_flags = cache->flags;
>  	spin_unlock(&cache->lock);
>  
>  	key.objectid = cache->start;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 45a512910666..fd28353b4511 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -146,6 +146,10 @@ struct btrfs_block_group {
>  	 * The last commited identity_remap_count value of this block group.
>  	 */
>  	u32 commit_identity_remap_count;
> +	/*
> +	 * The last committed flags value for this block group.
> +	 */
> +	u64 commit_flags;

This is a bit confusing as it's not clear it means the 'last' committed
flags, so I suggest to use "last_" prefix, also for other struct members
in block group.

>  
>  	/*
>  	 * If the free space extent count exceeds this number, convert the block
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 1ad2ad384b9e..ae2f39af9ba0 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -21,8 +21,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>  					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path);
>  
> -static struct btrfs_root *btrfs_free_space_root(
> -				struct btrfs_block_group *block_group)
> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_key key = {
>  		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
> @@ -93,7 +92,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
>  	return 0;
>  }
>  
> -EXPORT_FOR_TESTS
>  struct btrfs_free_space_info *btrfs_search_free_space_info(
>  		struct btrfs_trans_handle *trans,
>  		struct btrfs_block_group *block_group,
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 3d9a5d4477fc..89d2ff7e5c18 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,12 +35,13 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  				 u64 start, u64 size);
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  				      u64 start, u64 size);
> -
> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
>  btrfs_search_free_space_info(struct btrfs_trans_handle *trans,
>  			     struct btrfs_block_group *block_group,
>  			     struct btrfs_path *path, int cow);
> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group);
> +
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  				   struct btrfs_block_group *block_group,
>  				   struct btrfs_path *path, u64 start, u64 size);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 055cbddf962f..a73d2b69d0dd 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3617,7 +3617,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  		btrfs_btree_balance_dirty(fs_info);
>  	}
>  
> -	if (!err) {
> +	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>  		ret = relocate_file_extent_cluster(rc);
>  		if (ret < 0)
>  			err = ret;
> @@ -3861,6 +3861,90 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +static int add_remap_tree_entries(struct btrfs_trans_handle *trans,
> +				  struct btrfs_path *path,
> +				  struct btrfs_key *entries,
> +				  unsigned int num_entries)
> +{
> +	int ret;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_item_batch batch;
> +	u32 *data_sizes;
> +	u32 max_items;
> +
> +	max_items = BTRFS_LEAF_DATA_SIZE(trans->fs_info) / sizeof(struct btrfs_item);
> +
> +	data_sizes = kzalloc(sizeof(u32) * min_t(u32, num_entries, max_items),
> +			     GFP_NOFS);
> +	if (!data_sizes)
> +		return -ENOMEM;
> +
> +	while (true) {
> +		batch.keys = entries;
> +		batch.data_sizes = data_sizes;
> +		batch.total_data_size = 0;
> +		batch.nr = min_t(u32, num_entries, max_items);
> +
> +		ret = btrfs_insert_empty_items(trans, fs_info->remap_root, path,
> +					       &batch);
> +		btrfs_release_path(path);
> +
> +		if (num_entries <= max_items)
> +			break;
> +
> +		num_entries -= max_items;
> +		entries += max_items;
> +	}
> +
> +	kfree(data_sizes);
> +
> +	return ret;
> +}
> +
> +struct space_run {
> +	u64 start;
> +	u64 end;
> +};
> +
> +static void parse_bitmap(u64 block_size, const unsigned long *bitmap,
> +			 unsigned long size, u64 address,
> +			 struct space_run *space_runs,
> +			 unsigned int *num_space_runs)
> +{
> +	unsigned long pos, end;
> +	u64 run_start, run_length;
> +
> +	pos = find_first_bit(bitmap, size);
> +
> +	if (pos == size)
> +		return;
> +
> +	while (true) {
> +		end = find_next_zero_bit(bitmap, size, pos);
> +
> +		run_start = address + (pos * block_size);
> +		run_length = (end - pos) * block_size;
> +
> +		if (*num_space_runs != 0 &&
> +		    space_runs[*num_space_runs - 1].end == run_start) {
> +			space_runs[*num_space_runs - 1].end += run_length;
> +		} else {
> +			space_runs[*num_space_runs].start = run_start;
> +			space_runs[*num_space_runs].end = run_start + run_length;
> +
> +			(*num_space_runs)++;
> +		}
> +
> +		if (end == size)
> +			break;
> +
> +		pos = find_next_bit(bitmap, size, end + 1);
> +
> +		if (pos == size)
> +			break;
> +	}
> +}
> +
>  static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  					   struct btrfs_block_group *bg,
>  					   s64 diff)
> @@ -3893,6 +3977,188 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>  }
>  
> +static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
> +				     struct btrfs_path *path,
> +				     struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_free_space_info *fsi;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_root *space_root;
> +	u32 extent_count;
> +	struct space_run *space_runs = NULL;
> +	unsigned int num_space_runs = 0;
> +	struct btrfs_key *entries = NULL;
> +	unsigned int max_entries, num_entries;
> +	int ret;
> +
> +	mutex_lock(&bg->free_space_lock);
> +
> +	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
> +		mutex_unlock(&bg->free_space_lock);
> +
> +		ret = btrfs_add_block_group_free_space(trans, bg);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&bg->free_space_lock);
> +	}
> +
> +	fsi = btrfs_search_free_space_info(trans, bg, path, 0);
> +	if (IS_ERR(fsi)) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return PTR_ERR(fsi);
> +	}
> +
> +	extent_count = btrfs_free_space_extent_count(path->nodes[0], fsi);
> +
> +	btrfs_release_path(path);
> +
> +	space_runs = kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
> +	if (!space_runs) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return -ENOMEM;
> +	}
> +
> +	key.objectid = bg->start;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	space_root = btrfs_free_space_root(bg);
> +
> +	ret = btrfs_search_slot(trans, space_root, &key, path, 0, 0);
> +	if (ret < 0) {
> +		mutex_unlock(&bg->free_space_lock);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +	while (true) {
> +		leaf = path->nodes[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.objectid >= bg->start + bg->length)
> +			break;
> +
> +		if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
> +			if (num_space_runs != 0 &&
> +			    space_runs[num_space_runs - 1].end == found_key.objectid) {
> +				space_runs[num_space_runs - 1].end =
> +					found_key.objectid + found_key.offset;
> +			} else {
> +				BUG_ON(num_space_runs >= extent_count);
> +
> +				space_runs[num_space_runs].start = found_key.objectid;
> +				space_runs[num_space_runs].end =
> +					found_key.objectid + found_key.offset;
> +
> +				num_space_runs++;
> +			}
> +		} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
> +			void *bitmap;
> +			unsigned long offset;
> +			u32 data_size;
> +
> +			offset = btrfs_item_ptr_offset(leaf, path->slots[0]);
> +			data_size = btrfs_item_size(leaf, path->slots[0]);
> +
> +			if (data_size != 0) {
> +				bitmap = kmalloc(data_size, GFP_NOFS);
> +				if (!bitmap) {
> +					mutex_unlock(&bg->free_space_lock);
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +
> +				read_extent_buffer(leaf, bitmap, offset,
> +						   data_size);
> +
> +				parse_bitmap(fs_info->sectorsize, bitmap,
> +					     data_size * BITS_PER_BYTE,
> +					     found_key.objectid, space_runs,
> +					     &num_space_runs);
> +
> +				BUG_ON(num_space_runs > extent_count);

Please don't add new BUG_ON()s. Either it's an error that needs to be
handled or it's a development ASSERT.

> +
> +				kfree(bitmap);
> +			}
> +		}
> +
> +		path->slots[0]++;
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(space_root, path);
> +			if (ret != 0) {
> +				if (ret == 1)
> +					ret = 0;
> +				break;
> +			}
> +			leaf = path->nodes[0];
> +		}
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	mutex_unlock(&bg->free_space_lock);
> +
> +	max_entries = extent_count + 2;
> +	entries = kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
> +	if (!entries) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	num_entries = 0;
> +
> +	if (num_space_runs == 0) {
> +		entries[num_entries].objectid = bg->start;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset = bg->length;
> +		num_entries++;
> +	} else {
> +		if (space_runs[0].start > bg->start) {
> +			entries[num_entries].objectid = bg->start;
> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +			entries[num_entries].offset =
> +				space_runs[0].start - bg->start;
> +			num_entries++;
> +		}
> +
> +		for (unsigned int i = 1; i < num_space_runs; i++) {
> +			entries[num_entries].objectid = space_runs[i - 1].end;
> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +			entries[num_entries].offset =
> +				space_runs[i].start - space_runs[i - 1].end;
> +			num_entries++;
> +		}
> +
> +		if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
> +			entries[num_entries].objectid =
> +				space_runs[num_space_runs - 1].end;
> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +			entries[num_entries].offset =
> +				bg->start + bg->length - space_runs[num_space_runs - 1].end;
> +			num_entries++;
> +		}
> +
> +		if (num_entries == 0)
> +			goto out;
> +	}
> +
> +	bg->identity_remap_count = num_entries;
> +
> +	ret = add_remap_tree_entries(trans, path, entries, num_entries);
> +
> +out:
> +	kfree(entries);
> +	kfree(space_runs);
> +
> +	return ret;
> +}
> +
>  static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>  				struct btrfs_chunk_map *chunk,
>  				struct btrfs_path *path)
> @@ -4038,6 +4304,55 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>  		btrfs_mark_bg_fully_remapped(bg, trans);
>  }
>  
> +static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
> +			       struct btrfs_path *path, uint64_t start)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_chunk_map *chunk;
> +	struct btrfs_key key;
> +	u64 type;
> +	int ret;
> +	struct extent_buffer *leaf;
> +	struct btrfs_chunk *c;

                            chunk

> +
> +	read_lock(&fs_info->mapping_tree_lock);
> +
> +	chunk = btrfs_find_chunk_map_nolock(fs_info, start, 1);
> +	if (!chunk) {
> +		read_unlock(&fs_info->mapping_tree_lock);
> +		return -ENOENT;
> +	}
> +
> +	chunk->type |= BTRFS_BLOCK_GROUP_REMAPPED;
> +	type = chunk->type;
> +
> +	read_unlock(&fs_info->mapping_tree_lock);
> +
> +	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> +	key.type = BTRFS_CHUNK_ITEM_KEY;
> +	key.offset = start;
> +
> +	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
> +				0, 1);
> +	if (ret == 1) {
> +		ret = -ENOENT;
> +		goto end;
> +	} else if (ret < 0)
> +		goto end;
> +
> +	leaf = path->nodes[0];
> +
> +	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
> +	btrfs_set_chunk_type(leaf, c, type);
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	ret = 0;
> +end:
> +	btrfs_free_chunk_map(chunk);
> +	btrfs_release_path(path);
> +	return ret;
> +}
> +
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length)
>  {
> @@ -4092,6 +4407,136 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  	return 0;
>  }
>  
> +static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
> +				       struct btrfs_path *path,
> +				       struct btrfs_block_group *bg)
> +{
> +	struct btrfs_trans_handle *trans;
> +	bool bg_already_dirty = true;
> +	int ret, ret2;
> +
> +	ret = btrfs_cache_block_group(bg, true);
> +	if (ret)
> +		return ret;
> +
> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	/* We need to run delayed refs, to make sure FST is up to date. */
> +	ret = btrfs_run_delayed_refs(trans, U64_MAX);
> +	if (ret) {
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	ret = create_remap_tree_entries(trans, path, bg);
> +	if (ret) {

	if (unlikely...

> +		btrfs_abort_transaction(trans, ret);

Is the abort necessary? create_remap_tree_entries() does a lot of memory
allocations and can fail, but it seems that this is restartable.

> +		goto end;
> +	}
> +
> +	spin_lock(&bg->lock);
> +	bg->flags |= BTRFS_BLOCK_GROUP_REMAPPED;
> +	spin_unlock(&bg->lock);
> +
> +	spin_lock(&trans->transaction->dirty_bgs_lock);
> +	if (list_empty(&bg->dirty_list)) {
> +		list_add_tail(&bg->dirty_list,
> +			      &trans->transaction->dirty_bgs);
> +		bg_already_dirty = false;
> +		btrfs_get_block_group(bg);
> +	}
> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
> +
> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
> +	if (!bg_already_dirty)
> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
> +
> +	ret = mark_chunk_remapped(trans, path, bg->start);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto end;
> +	}
> +
> +	ret = btrfs_remove_block_group_free_space(trans, bg);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto end;
> +	}
> +
> +	btrfs_remove_free_space_cache(bg);
> +
> +end:
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	ret2 = btrfs_end_transaction(trans);
> +	if (!ret)
> +		ret = ret2;
> +
> +	return ret;
> +}
> +
> +static int do_nonremap_reloc(struct btrfs_fs_info *fs_info, bool verbose,
> +			     struct reloc_control *rc)
> +{
> +	int ret;
> +
> +	while (1) {
> +		enum reloc_stage finishes_stage;
> +
> +		mutex_lock(&fs_info->cleaner_mutex);
> +		ret = relocate_block_group(rc);
> +		mutex_unlock(&fs_info->cleaner_mutex);
> +
> +		finishes_stage = rc->stage;
> +		/*
> +		 * We may have gotten ENOSPC after we already dirtied some
> +		 * extents.  If writeout happens while we're relocating a
> +		 * different block group we could end up hitting the
> +		 * BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
> +		 * btrfs_reloc_cow_block.  Make sure we write everything out
> +		 * properly so we don't trip over this problem, and then break
> +		 * out of the loop if we hit an error.
> +		 */
> +		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
> +			int wb_ret;
> +
> +			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode),
> +								0, (u64)-1);
> +			if (wb_ret && ret == 0)
> +				ret = wb_ret;
> +			invalidate_mapping_pages(rc->data_inode->i_mapping,
> +							0, -1);
> +			rc->stage = UPDATE_DATA_PTRS;
> +		}
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if (rc->extents_found == 0)
> +			break;
> +
> +		if (verbose)
> +			btrfs_info(fs_info, "found %llu extents, stage: %s",
> +				   rc->extents_found,
> +				   stage_to_string(finishes_stage));
> +	}
> +
> +	WARN_ON(rc->block_group->pinned > 0);
> +	WARN_ON(rc->block_group->reserved > 0);
> +	WARN_ON(rc->block_group->used > 0);
> +
> +	return 0;
> +}
> +
>  /*
>   * function to relocate all extents in a block group.
>   */
> @@ -4102,7 +4547,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
>  	struct reloc_control *rc;
>  	struct inode *inode;
> -	struct btrfs_path *path;
> +	struct btrfs_path *path = NULL;
>  	int ret;
>  	bool bg_is_ro = false;
>  
> @@ -4164,7 +4609,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	}
>  
>  	inode = lookup_free_space_inode(rc->block_group, path);
> -	btrfs_free_path(path);
> +	btrfs_release_path(path);
>  
>  	if (!IS_ERR(inode))
>  		ret = delete_block_group_cache(rc->block_group, inode, 0);
> @@ -4174,11 +4619,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	if (ret && ret != -ENOENT)
>  		goto out;
>  
> -	rc->data_inode = create_reloc_inode(rc->block_group);
> -	if (IS_ERR(rc->data_inode)) {
> -		ret = PTR_ERR(rc->data_inode);
> -		rc->data_inode = NULL;
> -		goto out;
> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		rc->data_inode = create_reloc_inode(rc->block_group);
> +		if (IS_ERR(rc->data_inode)) {
> +			ret = PTR_ERR(rc->data_inode);
> +			rc->data_inode = NULL;
> +			goto out;
> +		}
>  	}
>  
>  	if (verbose)
> @@ -4191,54 +4638,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	ret = btrfs_zone_finish(rc->block_group);
>  	WARN_ON(ret && ret != -EAGAIN);
>  
> -	while (1) {
> -		enum reloc_stage finishes_stage;
> -
> -		mutex_lock(&fs_info->cleaner_mutex);
> -		ret = relocate_block_group(rc);
> -		mutex_unlock(&fs_info->cleaner_mutex);
> -
> -		finishes_stage = rc->stage;
> -		/*
> -		 * We may have gotten ENOSPC after we already dirtied some
> -		 * extents.  If writeout happens while we're relocating a
> -		 * different block group we could end up hitting the
> -		 * BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
> -		 * btrfs_reloc_cow_block.  Make sure we write everything out
> -		 * properly so we don't trip over this problem, and then break
> -		 * out of the loop if we hit an error.
> -		 */
> -		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
> -			int wb_ret;
> -
> -			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
> -							  (u64)-1);
> -			if (wb_ret && ret == 0)
> -				ret = wb_ret;
> -			invalidate_mapping_pages(rc->data_inode->i_mapping,
> -						 0, -1);
> -			rc->stage = UPDATE_DATA_PTRS;
> -		}
> -
> -		if (ret < 0)
> -			goto out;
> -
> -		if (rc->extents_found == 0)
> -			break;
> -
> -		if (verbose)
> -			btrfs_info(fs_info, "found %llu extents, stage: %s",
> -				   rc->extents_found,
> -				   stage_to_string(finishes_stage));
> +	if (should_relocate_using_remap_tree(bg)) {
> +		ret = start_block_group_remapping(fs_info, path, bg);
> +	} else {
> +		ret = do_nonremap_reloc(fs_info, verbose, rc);
>  	}
> -
> -	WARN_ON(rc->block_group->pinned > 0);
> -	WARN_ON(rc->block_group->reserved > 0);
> -	WARN_ON(rc->block_group->used > 0);
>  out:
>  	if (ret && bg_is_ro)
>  		btrfs_dec_block_group_ro(rc->block_group);
> -	iput(rc->data_inode);
> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		iput(rc->data_inode);
> +	btrfs_free_path(path);
>  	reloc_chunk_end(fs_info);
>  out_put_bg:
>  	btrfs_put_block_group(bg);
> @@ -4432,7 +4842,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  	btrfs_free_path(path);
>  
> -	if (ret == 0) {
> +	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>  		/* cleanup orphan inode in data relocation tree */
>  		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
>  		ASSERT(fs_root);
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index ffb497f27889..9f166b900d46 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -12,6 +12,17 @@ struct btrfs_trans_handle;
>  struct btrfs_ordered_extent;
>  struct btrfs_pending_snapshot;
>  
> +static inline bool should_relocate_using_remap_tree(struct btrfs_block_group *bg)
> +{
> +	if (!btrfs_fs_incompat(bg->fs_info, REMAP_TREE))
> +		return false;
> +
> +	if (bg->flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
> +		return false;
> +
> +	return true;
> +}
> +
>  int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  			       bool verbose);
>  int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 8e040dcea64a..9b9f7e38dbc9 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -376,8 +376,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>  	factor = btrfs_bg_type_to_factor(block_group->flags);
>  
>  	spin_lock(&space_info->lock);
> -	space_info->total_bytes += block_group->length;
> -	space_info->disk_total += block_group->length * factor;
> +
> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) ||
> +	    block_group->identity_remap_count != 0) {
> +		space_info->total_bytes += block_group->length;
> +		space_info->disk_total += block_group->length * factor;
> +	}
> +
>  	space_info->bytes_used += block_group->used;
>  	space_info->disk_used += block_group->used * factor;
>  	space_info->bytes_readonly += block_group->bytes_super;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 686e9abcf4cf..d676addf6ef4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3409,15 +3409,57 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  	return ret;
>  }
>  
> -int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
> -			 bool verbose)
> +static int btrfs_relocate_chunk_finish(struct btrfs_fs_info *fs_info,
> +				       struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_root *root = fs_info->chunk_root;
>  	struct btrfs_trans_handle *trans;
> -	struct btrfs_block_group *block_group;
>  	u64 length;
>  	int ret;
>  
> +	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +	length = block_group->length;
> +	btrfs_put_block_group(block_group);
> +
> +	/*
> +	 * On a zoned file system, discard the whole block group, this will
> +	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
> +	 * resetting the zone fails, don't treat it as a fatal problem from the
> +	 * filesystem's point of view.
> +	 */
> +	if (btrfs_is_zoned(fs_info)) {
> +		ret = btrfs_discard_extent(fs_info, block_group->start, length,
> +					   NULL);
> +		if (ret)
> +			btrfs_info(fs_info,
> +				   "failed to reset zone %llu after relocation",
> +				   block_group->start);
> +	}
> +
> +	trans = btrfs_start_trans_remove_block_group(root->fs_info,
> +						     block_group->start);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		btrfs_handle_fs_error(root->fs_info, ret, NULL);
> +		return ret;
> +	}
> +
> +	/*
> +	 * step two, delete the device extents and the
> +	 * chunk tree entries

If moving code please fix comments to the current style.

> +	 */
> +	ret = btrfs_remove_chunk(trans, block_group->start);
> +	btrfs_end_transaction(trans);
> +
> +	return ret;
> +}
> +
> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
> +			 bool verbose)
> +{
> +	struct btrfs_block_group *block_group;
> +	int ret;
> +
>  	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>  		btrfs_err(fs_info,
>  			  "relocate: not supported on extent tree v2 yet");
> @@ -3455,38 +3497,15 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
>  	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
>  	if (!block_group)
>  		return -ENOENT;
> -	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> -	length = block_group->length;
> -	btrfs_put_block_group(block_group);
> -
> -	/*
> -	 * On a zoned file system, discard the whole block group, this will
> -	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
> -	 * resetting the zone fails, don't treat it as a fatal problem from the
> -	 * filesystem's point of view.
> -	 */
> -	if (btrfs_is_zoned(fs_info)) {
> -		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
> -		if (ret)
> -			btrfs_info(fs_info,
> -				"failed to reset zone %llu after relocation",
> -				chunk_offset);
> -	}
>  
> -	trans = btrfs_start_trans_remove_block_group(root->fs_info,
> -						     chunk_offset);
> -	if (IS_ERR(trans)) {
> -		ret = PTR_ERR(trans);
> -		btrfs_handle_fs_error(root->fs_info, ret, NULL);
> -		return ret;
> +	if (should_relocate_using_remap_tree(block_group)) {
> +		/* If we're relocating using the remap tree we're now done. */
> +		btrfs_put_block_group(block_group);
> +		ret = 0;
> +	} else {
> +		ret = btrfs_relocate_chunk_finish(fs_info, block_group);
>  	}
>  
> -	/*
> -	 * step two, delete the device extents and the
> -	 * chunk tree entries
> -	 */
> -	ret = btrfs_remove_chunk(trans, chunk_offset);
> -	btrfs_end_transaction(trans);
>  	return ret;
>  }
>  
> @@ -4155,6 +4174,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
>  		chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> +		/* Check if chunk has already been fully relocated. */
> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAPPED &&
> +		    btrfs_chunk_num_stripes(leaf, chunk) == 0) {
> +			btrfs_release_path(path);
> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
> +			goto loop;
> +		}
> +
>  		if (!counting) {
>  			spin_lock(&fs_info->balance_lock);
>  			bctl->stat.considered++;
> -- 
> 2.51.0
> 

