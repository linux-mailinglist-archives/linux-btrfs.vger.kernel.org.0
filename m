Return-Path: <linux-btrfs+bounces-14818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250CBAE1B4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A7F7A9C43
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580228BAA6;
	Fri, 20 Jun 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwyX0df8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVysyb1a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfS7ZhsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ual1WZqK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDD28B4FB
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424275; cv=none; b=M86g4D9WJBJ7AKUaVq4HTLFZDK2MAUNVEMq5i1qwhiRt1aeP7yhsQkPJ/MjHS+tePiZbYSP3eqwUHasMsVm3iif5/XkMH9SiQhV8AzzR0mn50ZDz6YEQCcaudurCssw+3jJDqWrGpjB/eASHr9W451ZOvWwI+u64g/TmzBhSGXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424275; c=relaxed/simple;
	bh=QlEprds3Zybg0FowxuXO8i2smkbJaZCX8P4B+brlGhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwdtZGWcMwjYETCF3rX19jc+PFOpVsvGBP4WI/xYA2EhLCtc7gZ2JN6vHZLaqVy384docvw+G5cNQHZzAz09LWcb1lkNvCHbSk653O9VRUcncGqsWcjwGrA+WJaItJhUUPN4c4bTMY4e6rIYz82HGiLG/gwyvpfvti0exyR+kIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwyX0df8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVysyb1a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfS7ZhsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ual1WZqK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D7081F82B;
	Fri, 20 Jun 2025 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750424271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96llgKQkpMP5/Q1GRcNpKSRfzo6zptpaBirZ/WzEBC4=;
	b=TwyX0df8ZNKIsDzgybk2NJmwnxXRy4xOENAGbTpnCNpOi4BCRzaikRx0HDRUJUUGFPwarR
	jPOcOiI4lv7KGgnVHZzzMaPi6MfWdGL7IxLt6z/yv0hw16qebLBH60duC57hrnK9AEqgfp
	tzva3OCIORcXs/mqcguG8JKl0T1xWDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750424271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96llgKQkpMP5/Q1GRcNpKSRfzo6zptpaBirZ/WzEBC4=;
	b=NVysyb1adbyrTijaaCwULk0nmGx4rmZzyXsU6r9TXypGAcQsH5B1GegOUq2llyrTuMKlzR
	2yQBRLiNa8/XPvDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750424270;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96llgKQkpMP5/Q1GRcNpKSRfzo6zptpaBirZ/WzEBC4=;
	b=dfS7ZhsK/E4hPjHm7lu7QXGdeOsUgUnowtpfCVYq4ApL0SbLyM2+icolKjQlFftKo85YJY
	5WiQBHjwi6tP7E/HBsr4ptqoQqgnHEphOfjXUMaolPGrVzcYexw8m3cNiCbGaPe3dhkZ3J
	m64z7XNE8z28Lz+JXgznPRsB6O9nME8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750424270;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96llgKQkpMP5/Q1GRcNpKSRfzo6zptpaBirZ/WzEBC4=;
	b=Ual1WZqK/66pKfc/z1EbvB924eCz08tLtKzADMSEO6vh1UH2/hI5kKGrxwwp+FLzQ4tdCk
	KVBLrju4TJAGG2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27D5A136BA;
	Fri, 20 Jun 2025 12:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Z2ACc5aVWisMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 12:57:50 +0000
Date: Fri, 20 Jun 2025 14:57:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: index buffer_tree using node size
Message-ID: <20250620125744.GT4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250612084724.3149616-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612084724.3149616-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 12, 2025 at 10:47:23AM +0200, Daniel Vacek wrote:
> So far we are deriving the buffer tree index using the sector size. But each
> extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> 
> For example the typical and quite common configuration uses sector size of 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using up to
> the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> slots are wasted as never used.
> 
> We can score significant memory savings on the required tree nodes by indexing
> the tree using the node size instead. As a result far less slots are wasted
> and the tree can now use up to all 100% of it's slots this way.
> 
> Note: This works even with unaligned tree blocks as we can still get unique
>       index by doing eb->start >> nodesize_shift.

Can we have at least some numbers? As we've talked about it and you
showed me the number of radix nodes or other internal xarray structures
before/after.

> Signed-off-by: Daniel Vacek <neelx@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> v2 changes:
>  * Note that this is still correct even with unaligned tree blocks.
>  * Rename node_bits to nodesize_bits to stay consistent.
>  * Move the nodesize_bits member next to nodesize and make it u32.
> 
> ---
>  fs/btrfs/disk-io.c   |  1 +
>  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
>  fs/btrfs/fs.h        |  3 ++-
>  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0d6ad7512f217..3d465258f15b7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3396,6 +3396,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
>  
>  	fs_info->nodesize = nodesize;
> +	fs_info->nodesize_bits = ilog2(nodesize);
>  	fs_info->sectorsize = sectorsize;
>  	fs_info->sectorsize_bits = ilog2(sectorsize);
>  	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e9ba80a56172d..a55c7c7eb8990 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
>  	 */
>  	spin_lock(&eb->refs_lock);
>  	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> -		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> +		XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>  		unsigned long flags;
>  
>  		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer *eb)
>  static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
>  {
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> +	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>  	unsigned long flags;
>  
>  	xas_lock_irqsave(&xas, flags);
> @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
>  static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_mark_t mark)
>  {
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
> -	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> +	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
>  	unsigned long flags;
>  
>  	xas_lock_irqsave(&xas, flags);
> @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
>  	rcu_read_lock();
>  	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
>  		if (!eb_batch_add(batch, eb)) {
> -			*start = ((eb->start + eb->len) >> fs_info->sectorsize_bits);
> +			*start = (eb->start + eb->len) >> fs_info->nodesize_bits;

In other places you drop the outer ( ) from the shifts, please keep it
if it's there (or add if it's missing).

>  			goto out;
>  		}
>  	}
> @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
>  		struct btrfs_fs_info *fs_info, u64 start)
>  {
>  	struct extent_buffer *eb;
> -	unsigned long index = (start >> fs_info->sectorsize_bits);
> +	unsigned long index = start >> fs_info->nodesize_bits;
>  
>  	rcu_read_lock();
>  	eb = xa_load(&fs_info->buffer_tree, index);
> @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
>  				      u64 end)
>  {
>  	struct eb_batch batch;
> -	unsigned long start_index = (start >> fs_info->sectorsize_bits);
> -	unsigned long end_index = (end >> fs_info->sectorsize_bits);
> +	unsigned long start_index = start >> fs_info->nodesize_bits;
> +	unsigned long end_index = end >> fs_info->nodesize_bits;
>  
>  	eb_batch_init(&batch);
>  	while (start_index <= end_index) {
> @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>  
>  	eb_batch_init(&batch);
>  	if (wbc->range_cyclic) {
> -		index = ((mapping->writeback_index << PAGE_SHIFT) >> fs_info->sectorsize_bits);
> +		index = (mapping->writeback_index << PAGE_SHIFT) >> fs_info->nodesize_bits;
>  		end = -1;
>  
>  		/*
> @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space *mapping,
>  		 */
>  		scanned = (index == 0);
>  	} else {
> -		index = (wbc->range_start >> fs_info->sectorsize_bits);
> -		end = (wbc->range_end >> fs_info->sectorsize_bits);
> +		index = wbc->range_start >> fs_info->nodesize_bits;
> +		end = wbc->range_end >> fs_info->nodesize_bits;
>  
>  		scanned = 1;
>  	}
> @@ -3038,7 +3038,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>  	eb->fs_info = fs_info;
>  again:
>  	xa_lock_irq(&fs_info->buffer_tree);
> -	exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->sectorsize_bits,
> +	exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->nodesize_bits,
>  			      NULL, eb, GFP_NOFS);
>  	if (xa_is_err(exists)) {
>  		ret = xa_err(exists);
> @@ -3355,7 +3355,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  again:
>  	xa_lock_irq(&fs_info->buffer_tree);
>  	existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
> -				   start >> fs_info->sectorsize_bits, NULL, eb,
> +				   start >> fs_info->nodesize_bits, NULL, eb,
>  				   GFP_NOFS);
>  	if (xa_is_err(existing_eb)) {
>  		ret = xa_err(existing_eb);
> @@ -3458,7 +3458,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
>  		 * in this case.
>  		 */
>  		xa_cmpxchg_irq(&fs_info->buffer_tree,
> -			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
> +			       eb->start >> fs_info->nodesize_bits, eb, NULL,
>  			       GFP_ATOMIC);
>  
>  		btrfs_leak_debug_del_eb(eb);
> @@ -4300,9 +4300,9 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  {
>  	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
>  	struct extent_buffer *eb;
> -	unsigned long start = (folio_pos(folio) >> fs_info->sectorsize_bits);
> +	unsigned long start = folio_pos(folio) >> fs_info->nodesize_bits;
>  	unsigned long index = start;
> -	unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
> +	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
>  	int ret;
>  
>  	xa_lock_irq(&fs_info->buffer_tree);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b239e4b8421cf..fd7cbbe3515d6 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -781,7 +781,7 @@ struct btrfs_fs_info {
>  
>  	struct btrfs_delayed_root *delayed_root;
>  
> -	/* Entries are eb->start / sectorsize */
> +	/* Entries are eb->start >> nodesize_bits */
>  	struct xarray buffer_tree;
>  
>  	/* Next backup root to be overwritten */
> @@ -813,6 +813,7 @@ struct btrfs_fs_info {
>  
>  	/* Cached block sizes */
>  	u32 nodesize;
> +	u32 nodesize_bits;
>  	u32 sectorsize;
>  	/* ilog2 of sectorsize, use to avoid 64bit division */
>  	u32 sectorsize_bits;
> -- 
> 2.47.2
> 

