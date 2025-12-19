Return-Path: <linux-btrfs+bounces-19880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEDCCE3D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 03:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884DD3089E79
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8E528505E;
	Fri, 19 Dec 2025 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WDo4q19Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbYm/drn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZgnTbaP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSPeAQKy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3321E098
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766110071; cv=none; b=rYezBMt7lDldr07Zf8pq3vK+lxM/3CwxFZDgbIWKFqUmlDSwHTJqost2tCv795VNFPB/4fGujUmt1jOVV0WiM7Jmix/URhzquZTECtvapliqk71HyCBtf667QyI9ouo+ppyFKgXMR5IZNlkImWowDqFvVY1R3OXAK74xp7xjobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766110071; c=relaxed/simple;
	bh=wDPLCC6wrc7TSz3YIcIDoBA0/3gXlMGaFLhPKgf4tSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnKwCakafSIBjTgbUk0OoCTDI94l6v1+bMTMYQf4UC6yxZAgHvP/WTVBciYQxZGbNGj2tVYtaJwQ3LA+c3jxngu1BulO4v37RK4SO0FeDDpsOSBqS5/v17KAfp39VByoIi6m9UzOPeMo6MJZvgZRB8R9zbGi2fTyTX3ohzHk/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WDo4q19Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbYm/drn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZgnTbaP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSPeAQKy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75CB85BD05;
	Fri, 19 Dec 2025 02:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766110065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6e3GF0s+T4PxuXFmhKqb4xuXqwsvmGcDTSx1DaioPg=;
	b=WDo4q19ZXXTjSTRYQO1N8ijmC79NCLHpl9rsYLM7w+wx7F8p/0Jwc6Rd38zfJF/YJ+0fC2
	CYDV6hDFNNJkG0bPvC8hIhozuJHxzqBUSNFcYFQgNhqxFX8V3AVyJUkqUhGtE/8K1bSrIU
	YfuMgOkvMv/npHt70im0nTS93FQN8xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766110065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6e3GF0s+T4PxuXFmhKqb4xuXqwsvmGcDTSx1DaioPg=;
	b=rbYm/drnA3bF6OL7bOoJQvq/JUuyLvu7WZs/HDyrhax9mVCCI3aO5DHY9374FOpfyAxPLO
	V0qb8YakwKBdImCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OZgnTbaP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mSPeAQKy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766110063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6e3GF0s+T4PxuXFmhKqb4xuXqwsvmGcDTSx1DaioPg=;
	b=OZgnTbaPTPIMtvSYhA4cGOGpTq32tzxJ3oZwxCKkM/TE+0QYB8rPW4GUtpFaSUAgYk3/Uo
	EjMgrEONv66Wuv5nE7t/GeTwyYtDEm7IvqaAf84WqCkewG5nMu5YN+sm67UTwzFI6r5hzD
	h7pEJueZ26PcOCvwI1paU3aomxEwrb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766110063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6e3GF0s+T4PxuXFmhKqb4xuXqwsvmGcDTSx1DaioPg=;
	b=mSPeAQKy7DT64EhveHqWZs3/FymYFQzjn6jZZ0+YX1HkOeWaHyo2CFIsDkrk3HOcsPtlJ3
	D9v6W83ADDwS84Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38FFA3EA63;
	Fri, 19 Dec 2025 02:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFi2DW+zRGnpOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 02:07:43 +0000
Date: Fri, 19 Dec 2025 03:07:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v7 11/16] btrfs: move existing remaps before relocating
 block group
Message-ID: <20251219020737.GZ3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-12-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-12-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 75CB85BD05
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,bur.io:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon, Nov 24, 2025 at 06:53:03PM +0000, Mark Harmstone wrote:
> If when relocating a block group we find that `remap_bytes` > 0 in its
> block group item, that means that it has been the destination block
> group for another that has been remapped.
> 
> We need to seach the remap tree for any remap backrefs within this
> range, and move the data to a third block group. This is because
> otherwise btrfs_translate_remap() could end up following an unbounded
> chain of remaps, which would only get worse over time.
> 
> We only relocate one block group at a time, so `remap_bytes` will only
> ever go down while we are doing this. Once we're finished we set the
> REMAPPED flag on the block group, which will permanently prevent any
> other data from being moved to within it.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/bio.c         |   3 +-
>  fs/btrfs/bio.h         |   3 +
>  fs/btrfs/extent-tree.c |   6 +-
>  fs/btrfs/relocation.c  | 487 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 496 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 4a7bef895b97..085272fda99a 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -827,7 +827,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  		 */
>  		if (!(inode->flags & BTRFS_INODE_NODATASUM) &&
>  		    !test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
> -		    !btrfs_is_data_reloc_root(inode->root)) {
> +		    !btrfs_is_data_reloc_root(inode->root) &&
> +		    !bbio->is_remap) {
>  			if (should_async_write(bbio) &&
>  			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
>  				goto done;
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 56279b7f3b2a..fe96e66a39aa 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -89,6 +89,9 @@ struct btrfs_bio {
>  	 */
>  	bool is_scrub;
>  
> +	/* Whether the bio is coming from copy_remapped_data_io(). */
> +	bool is_remap;

The bool flags of bbio have been changed recently to bool bitfields.

> +
>  	/* Whether the csum generation for data write is async. */
>  	bool async_csum;
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 283485cb3f88..ef832acf3ff4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4555,7 +4555,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		    block_group->cached != BTRFS_CACHE_NO) {
>  			down_read(&space_info->groups_sem);
>  			if (list_empty(&block_group->list) ||
> -			    block_group->ro) {
> +			    block_group->ro ||
> +			    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
>  				/*
>  				 * someone is removing this block group,
>  				 * we can't jump into the have_block_group
> @@ -4589,7 +4590,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  
>  		ffe_ctl->hinted = false;
>  		/* If the block group is read-only, we can skip it entirely. */
> -		if (unlikely(block_group->ro)) {
> +		if (unlikely(block_group->ro) ||
> +		    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {

Should the whole condition be in unlikely()?

>  			if (ffe_ctl->for_treelog)
>  				btrfs_clear_treelog_bg(block_group);
>  			if (ffe_ctl->for_data_reloc)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a73d2b69d0dd..3c486894b6b4 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3977,6 +3977,487 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>  }
>  
> +struct reloc_io_private {

Please write a short description what's the purpose of this structure.

> +	struct completion done;
> +	refcount_t pending_refs;
> +	blk_status_t status;
> +};
> +
> +static void reloc_endio(struct btrfs_bio *bbio)
> +{
> +	struct reloc_io_private *priv = bbio->private;
> +
> +	if (bbio->bio.bi_status)
> +		WRITE_ONCE(priv->status, bbio->bio.bi_status);
> +
> +	if (refcount_dec_and_test(&priv->pending_refs))
> +		complete(&priv->done);
> +
> +	bio_put(&bbio->bio);
> +}
> +
> +static int copy_remapped_data_io(struct btrfs_fs_info *fs_info,
> +				 struct reloc_io_private *priv,
> +				 struct page **pages, u64 addr, u64 length,
> +				 bool do_write)
> +{
> +	struct btrfs_bio *bbio;
> +	unsigned long i = 0;

No need for long, this is an array index.

> +	blk_opf_t op = do_write ? REQ_OP_WRITE : REQ_OP_READ;

Simply pass the REQ_OP as parameter, this will be more descriptive than
just true/false.

> +
> +	init_completion(&priv->done);
> +	refcount_set(&priv->pending_refs, 1);
> +	priv->status = 0;
> +
> +	bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, BTRFS_I(fs_info->btree_inode),
> +			       addr, reloc_endio, priv);
> +	bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
> +	bbio->is_remap = true;
> +
> +	do {
> +		size_t bytes = min_t(u64, length, PAGE_SIZE);
> +
> +		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
> +			refcount_inc(&priv->pending_refs);
> +			btrfs_submit_bbio(bbio, 0);
> +
> +			bbio = btrfs_bio_alloc(BIO_MAX_VECS, op,
> +					       BTRFS_I(fs_info->btree_inode),
> +					       addr, reloc_endio, priv);
> +			bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
> +			bbio->is_remap = true;
> +			continue;
> +		}
> +
> +		i++;
> +		addr += bytes;
> +		length -= bytes;
> +	} while (length);
> +
> +	refcount_inc(&priv->pending_refs);
> +	btrfs_submit_bbio(bbio, 0);
> +
> +	if (!refcount_dec_and_test(&priv->pending_refs))
> +		wait_for_completion_io(&priv->done);
> +
> +	return blk_status_to_errno(READ_ONCE(priv->status));
> +}
> +
> +static int copy_remapped_data(struct btrfs_fs_info *fs_info, u64 old_addr,
> +			      u64 new_addr, u64 length)
> +{
> +	int ret;
> +	struct page **pages;
> +	unsigned int nr_pages;
> +	struct reloc_io_private priv;
> +
> +	nr_pages = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;

I think there's a macro for that

> +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> +	ret = btrfs_alloc_page_array(nr_pages, pages, 0);
> +	if (ret) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	ret = copy_remapped_data_io(fs_info, &priv, pages, old_addr, length,
> +				    false);
> +	if (ret)
> +		goto end;
> +
> +	ret = copy_remapped_data_io(fs_info, &priv, pages, new_addr, length,
> +				    true);
> +
> +end:
> +	for (unsigned int i = 0; i < nr_pages; i++) {
> +		if (pages[i])
> +			__free_page(pages[i]);
> +	}
> +	kfree(pages);
> +
> +	return ret;
> +}
> +
> +static int do_copy(struct btrfs_fs_info *fs_info, u64 old_addr, u64 new_addr,

Please use better name than 'do_copy'

> +		   u64 length)
> +{
> +	int ret;
> +
> +	/* Copy 1MB at a time, to avoid using too much memory. */

One bio at a time, no parallelism, won't this be slow?

> +
> +	do {
> +		u64 to_copy = min_t(u64, length, SZ_1M);
> +
> +		/* Limit to one bio. */
> +		to_copy = min_t(u64, to_copy, BIO_MAX_VECS << PAGE_SHIFT);
> +
> +		ret = copy_remapped_data(fs_info, old_addr, new_addr,
> +					 to_copy);

As this is looping many times the memory in copy_remapped_data()
is repeatedly allocated and freed. This should be lifted to the caller
which will provide buffer for the maximum expected length.

> +		if (ret)
> +			return ret;
> +
> +		if (to_copy == length)
> +			break;
> +
> +		old_addr += to_copy;
> +		new_addr += to_copy;
> +		length -= to_copy;
> +	} while (true);
> +
> +	return 0;
> +}
> +
> +static int add_remap_item(struct btrfs_trans_handle *trans,
> +			  struct btrfs_path *path, u64 new_addr, u64 length,
> +			  u64 old_addr)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_remap remap;

This should be initialized, and at other places too, this is not the
first occurence.

> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret;
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_REMAP_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root, path,
> +				      &key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	btrfs_set_stack_remap_address(&remap, new_addr);
> +
> +	write_extent_buffer(leaf, &remap,
> +			    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +			    sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
> +
> +	return 0;
> +}
> +
> +static int add_remap_backref_item(struct btrfs_trans_handle *trans,
> +				  struct btrfs_path *path, u64 new_addr,
> +				  u64 length, u64 old_addr)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_remap remap;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret;
> +
> +	key.objectid = new_addr;
> +	key.type = BTRFS_REMAP_BACKREF_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +				      path, &key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	btrfs_set_stack_remap_address(&remap, old_addr);
> +
> +	write_extent_buffer(leaf, &remap,
> +			    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +			    sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
> +
> +	return 0;
> +}
> +
> +static int move_existing_remap(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *bg, u64 new_addr,
> +			       u64 length, u64 old_addr)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap_ptr, remap;
> +	struct btrfs_key key, ins;
> +	u64 dest_addr, dest_length, min_size;
> +	struct btrfs_block_group *dest_bg;
> +	int ret;
> +	bool is_data = bg->flags & BTRFS_BLOCK_GROUP_DATA;

	const bool

> +	struct btrfs_space_info *sinfo = bg->space_info;
> +	bool mutex_taken = false, bg_needs_free_space;
> +
> +	spin_lock(&sinfo->lock);
> +	btrfs_space_info_update_bytes_may_use(sinfo, length);
> +	spin_unlock(&sinfo->lock);
> +
> +	if (is_data)
> +		min_size = fs_info->sectorsize;
> +	else
> +		min_size = fs_info->nodesize;
> +
> +	ret = btrfs_reserve_extent(fs_info->fs_root, length, length, min_size,
> +				   0, 0, &ins, is_data, false);
> +	if (ret) {
> +		spin_lock(&sinfo->lock);
> +		btrfs_space_info_update_bytes_may_use(sinfo, -length);
> +		spin_unlock(&sinfo->lock);
> +		return ret;
> +	}
> +
> +	dest_addr = ins.objectid;
> +	dest_length = ins.offset;
> +
> +	if (!is_data && !IS_ALIGNED(dest_length, fs_info->nodesize)) {
> +		u64 new_length = ALIGN_DOWN(dest_length, fs_info->nodesize);
> +
> +		btrfs_free_reserved_extent(fs_info, dest_addr + new_length,
> +					   dest_length - new_length, 0);
> +
> +		dest_length = new_length;
> +	}
> +
> +	trans = btrfs_join_transaction(fs_info->remap_root);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		trans = NULL;
> +		goto end;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +	mutex_taken = true;
> +
> +	/* Find old remap entry. */
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_REMAP_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
> +				path, 0, 1);
> +	if (ret == 1) {
> +		/*
> +		 * Not a problem if the remap entry wasn't found: that means
> +		 * that another transaction has deallocated the data.
> +		 * move_existing_remaps() loops until the BG contains no
> +		 * remaps, so we can just return 0 in this case.
> +		 */
> +		btrfs_release_path(path);
> +		ret = 0;
> +		goto end;
> +	} else if (ret) {
> +		goto end;
> +	}
> +
> +	ret = do_copy(fs_info, new_addr, dest_addr, dest_length);
> +	if (ret)
> +		goto end;
> +
> +	/* Change data of old remap entry. */
> +
> +	leaf = path->nodes[0];
> +
> +	remap_ptr = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> +	btrfs_set_remap_address(leaf, remap_ptr, dest_addr);
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	if (dest_length != length) {
> +		key.offset = dest_length;
> +		btrfs_set_item_key_safe(trans, path, &key);
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	if (dest_length != length) {
> +		/* Add remap item for remainder. */
> +
> +		ret = add_remap_item(trans, path, new_addr + dest_length,
> +				     length - dest_length,
> +				     old_addr + dest_length);
> +		if (ret)
> +			goto end;
> +	}
> +
> +	/* Change or remove old backref. */
> +
> +	key.objectid = new_addr;
> +	key.type = BTRFS_REMAP_BACKREF_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
> +				path, -1, 1);
> +	if (ret) {
> +		if (ret == 1) {
> +			btrfs_release_path(path);
> +			ret = -ENOENT;
> +		}
> +		goto end;
> +	}
> +
> +	leaf = path->nodes[0];
> +
> +	if (dest_length == length) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret) {
> +			btrfs_release_path(path);
> +			goto end;
> +		}
> +	} else {
> +		key.objectid += dest_length;
> +		key.offset -= dest_length;
> +		btrfs_set_item_key_safe(trans, path, &key);
> +
> +		btrfs_set_stack_remap_address(&remap, old_addr + dest_length);
> +
> +		write_extent_buffer(leaf, &remap,
> +				    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +				    sizeof(struct btrfs_remap));
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	/* Add new backref. */
> +
> +	ret = add_remap_backref_item(trans, path, dest_addr, dest_length,
> +				     old_addr);
> +	if (ret)
> +		goto end;
> +
> +	adjust_block_group_remap_bytes(trans, bg, -dest_length);
> +
> +	ret = btrfs_add_to_free_space_tree(trans, new_addr, dest_length);
> +	if (ret)
> +		goto end;
> +
> +	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
> +
> +	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +	btrfs_put_block_group(dest_bg);
> +
> +	if (bg_needs_free_space) {
> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
> +		if (ret)
> +			goto end;
> +	}
> +
> +	ret = btrfs_remove_from_free_space_tree(trans, dest_addr, dest_length);
> +	if (ret) {
> +		btrfs_remove_from_free_space_tree(trans, new_addr,
> +						  dest_length);
> +		goto end;
> +	}
> +
> +	ret = 0;
> +
> +end:
> +	if (mutex_taken)
> +		mutex_unlock(&fs_info->remap_mutex);
> +
> +	btrfs_dec_block_group_reservations(fs_info, dest_addr);
> +
> +	if (ret) {
> +		btrfs_free_reserved_extent(fs_info, dest_addr, dest_length, 0);
> +
> +		if (trans) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +		}
> +	} else {
> +		dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
> +		btrfs_free_reserved_bytes(dest_bg, dest_length, 0);
> +		btrfs_put_block_group(dest_bg);
> +
> +		ret = btrfs_commit_transaction(trans);
> +	}
> +
> +	return ret;
> +}
> +
> +static int move_existing_remaps(struct btrfs_fs_info *fs_info,
> +				struct btrfs_block_group *bg,
> +				struct btrfs_path *path)
> +{
> +	int ret;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap;
> +	u64 old_addr;
> +
> +	/* Look for backrefs in remap tree. */
> +
> +	while (bg->remap_bytes > 0) {
> +		key.objectid = bg->start;
> +		key.type = BTRFS_REMAP_BACKREF_KEY;
> +		key.offset = 0;
> +
> +		ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> +					0, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		leaf = path->nodes[0];
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(fs_info->remap_root, path);
> +			if (ret < 0) {
> +				btrfs_release_path(path);
> +				return ret;
> +			}
> +
> +			if (ret) {
> +				btrfs_release_path(path);
> +				break;
> +			}
> +
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +		if (key.type != BTRFS_REMAP_BACKREF_KEY) {
> +			path->slots[0]++;
> +
> +			if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +				ret = btrfs_next_leaf(fs_info->remap_root, path);
> +				if (ret < 0) {
> +					btrfs_release_path(path);
> +					return ret;
> +				}
> +
> +				if (ret) {
> +					btrfs_release_path(path);
> +					break;
> +				}
> +
> +				leaf = path->nodes[0];
> +			}
> +		}
> +
> +		remap = btrfs_item_ptr(leaf, path->slots[0],
> +				       struct btrfs_remap);
> +
> +		old_addr = btrfs_remap_address(leaf, remap);
> +
> +		btrfs_release_path(path);
> +
> +		ret = move_existing_remap(fs_info, path, bg, key.objectid,
> +					  key.offset, old_addr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	BUG_ON(bg->remap_bytes > 0);
> +
> +	return 0;
> +}
> +
>  static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>  				     struct btrfs_path *path,
>  				     struct btrfs_block_group *bg)
> @@ -4639,6 +5120,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	WARN_ON(ret && ret != -EAGAIN);
>  
>  	if (should_relocate_using_remap_tree(bg)) {
> +		if (bg->remap_bytes != 0) {
> +			ret = move_existing_remaps(fs_info, bg, path);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		ret = start_block_group_remapping(fs_info, path, bg);
>  	} else {
>  		ret = do_nonremap_reloc(fs_info, verbose, rc);
> -- 
> 2.51.0
> 

