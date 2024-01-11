Return-Path: <linux-btrfs+bounces-1402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADC882B4D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 19:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E61F21C6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101353E06;
	Thu, 11 Jan 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUY92KO8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cuBXfEFx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OMtLjy+z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6VxlAiUA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E33C694
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC98E1F8B2;
	Thu, 11 Jan 2024 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704998442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldv3uxh6q0ac0ff/EEcbXSomEEodPlt/HIHzcyX4WGM=;
	b=yUY92KO8XzlipPOHeP8gK9qsDMFKXx1GRkweOJuynJLySbEwl+tLi+Q+j9f/z8UscIEtVC
	ldTVjJP1obXjtUc+qKDTSO2gIrof5wJvPY2LF3bFtcTknVC51C2tYnCkzGOJ7q7+8e2KhX
	dGILhRymxb35FfNEqmqP+iLmuo6qHyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704998442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldv3uxh6q0ac0ff/EEcbXSomEEodPlt/HIHzcyX4WGM=;
	b=cuBXfEFxemAftL/573IcU8cI+Y9uosbAXIeUC1PrFLPCn1QQRpJQiqVKSwitL8tnvrVRpZ
	kiPj6aMu3Z9xk+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704998441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldv3uxh6q0ac0ff/EEcbXSomEEodPlt/HIHzcyX4WGM=;
	b=OMtLjy+zPYobS309PYE5DhRDsdyITzUdDDAZQFx28dzW6dKRpOaUI1lIBdQvuSX1cmVHGG
	5dJKUalIfLgfH/pNifeT/BQJ/0HplHt6PKFAThT6cBajxjrE6dnmK6bz+aLkRB6oKmlHbI
	nXXcVgrajDZdT8pw8L1Fs4xcfwirM/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704998441;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ldv3uxh6q0ac0ff/EEcbXSomEEodPlt/HIHzcyX4WGM=;
	b=6VxlAiUAwkFSuq3Zp+WbXmFqXg6ApxW4cBBzLii5cKotiYdLO0qTpZJaUsATmAq+9TyrfF
	YmnILlvq24BczvCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9786A132FA;
	Thu, 11 Jan 2024 18:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QUyMJCk2oGVREwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 11 Jan 2024 18:40:41 +0000
Date: Thu, 11 Jan 2024 19:40:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: page to folio conversion in btrfs_truncate_block()
Message-ID: <20240111182516.GM31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cn7d3gijpqxtmlytcv4ztac3eb7ukd54co4csitaw6czn6bfxr@3wopycxp755q>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cn7d3gijpqxtmlytcv4ztac3eb7ukd54co4csitaw6czn6bfxr@3wopycxp755q>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OMtLjy+z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6VxlAiUA
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC98E1F8B2
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed, Jan 10, 2024 at 07:56:13PM -0600, Goldwyn Rodrigues wrote:
> Convert use of struct page to struct folio inside btrfs_truncate_block().
> The only page based function is set_page_extent_mapped(). All other
> functions have folio equivalents.
> 
> Had to use __filemap_get_folio() because filemap_grab_folio() does not
> allow passing allocation mask as a parameter.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

There are some overly long lines, I can fix that unless you'd like to
commit the patch yourself.

> ---
>  fs/btrfs/inode.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e285ddbcdee0..12c040328742 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4680,7 +4680,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  	u32 blocksize = fs_info->sectorsize;
>  	pgoff_t index = from >> PAGE_SHIFT;
>  	unsigned offset = from & (blocksize - 1);
> -	struct page *page;
> +	struct folio *folio;
>  	gfp_t mask = btrfs_alloc_write_mask(mapping);
>  	size_t write_bytes = blocksize;
>  	int ret = 0;
> @@ -4712,8 +4712,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  		goto out;
>  	}
>  again:
> -	page = find_or_create_page(mapping, index, mask);
> -	if (!page) {
> +	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);

This line is too long

> +	if (!folio) {
>  		btrfs_delalloc_release_space(inode, data_reserved, block_start,
>  					     blocksize, true);
>  		btrfs_delalloc_release_extents(inode, blocksize);
> @@ -4721,15 +4721,15 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  		goto out;
>  	}
>  
> -	if (!PageUptodate(page)) {
> -		ret = btrfs_read_folio(NULL, page_folio(page));
> -		lock_page(page);
> -		if (page->mapping != mapping) {
> -			unlock_page(page);
> -			put_page(page);
> +	if (!folio_test_uptodate(folio)) {
> +		ret = btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			goto again;
>  		}
> -		if (!PageUptodate(page)) {
> +		if (!folio_test_uptodate(folio)) {
>  			ret = -EIO;
>  			goto out_unlock;
>  		}
> @@ -4741,19 +4741,19 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  	 * folio private, but left the page in the mapping.  Set the page mapped
>  	 * here to make sure it's properly set for the subpage stuff.
>  	 */
> -	ret = set_page_extent_mapped(page);
> +	ret = set_page_extent_mapped(&folio->page);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	wait_on_page_writeback(page);
> +	folio_wait_writeback(folio);
>  
>  	lock_extent(io_tree, block_start, block_end, &cached_state);
>  
>  	ordered = btrfs_lookup_ordered_extent(inode, block_start);
>  	if (ordered) {
>  		unlock_extent(io_tree, block_start, block_end, &cached_state);
> -		unlock_page(page);
> -		put_page(page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		btrfs_start_ordered_extent(ordered);
>  		btrfs_put_ordered_extent(ordered);
>  		goto again;
> @@ -4774,15 +4774,13 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  		if (!len)
>  			len = blocksize - offset;
>  		if (front)
> -			memzero_page(page, (block_start - page_offset(page)),
> -				     offset);
> +			folio_zero_range(folio, block_start - folio_pos(folio), offset);

Here

>  		else
> -			memzero_page(page, (block_start - page_offset(page)) + offset,
> -				     len);
> +			folio_zero_range(folio, (block_start - folio_pos(folio)) + offset, len);

And here

>  	}
> -	btrfs_folio_clear_checked(fs_info, page_folio(page), block_start,
> +	btrfs_folio_clear_checked(fs_info, folio, block_start,
>  				  block_end + 1 - block_start);
> -	btrfs_folio_set_dirty(fs_info, page_folio(page), block_start,
> +	btrfs_folio_set_dirty(fs_info, folio, block_start,
>  			      block_end + 1 - block_start);
>  	unlock_extent(io_tree, block_start, block_end, &cached_state);
>  
> @@ -4799,8 +4797,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  					block_start, blocksize, true);
>  	}
>  	btrfs_delalloc_release_extents(inode, blocksize);
> -	unlock_page(page);
> -	put_page(page);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  out:
>  	if (only_release_metadata)
>  		btrfs_check_nocow_unlock(inode);
> -- 
> 2.43.0
> 
> 
> -- 
> Goldwyn

