Return-Path: <linux-btrfs+bounces-2175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F20184BEFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9C2835AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BB1B941;
	Tue,  6 Feb 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gb/1d4ro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9eRdGzh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gb/1d4ro";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9eRdGzh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D41B815
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252920; cv=none; b=OL7Zxd6/8YaQ/6IdEl4igKVh3auxTMoWQho8up6VH1JCE6JxT9b3zoNGy2cVaaRcJ2AKvhgFnyN0fTyg/q+9X0GYxPKpWJF/VYkqeLbju+fNqP7bCFYOvHf/NgD0IwtlPJssqUnZcSXlyWyY1OlUykN00VkymKj7g7qb4yeRq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252920; c=relaxed/simple;
	bh=K9ay307hL3d90ZxeegCbyXCBSNQ5otI5otYVkj4CXFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnscaqnKUprEvmRNL4dDv+DIULOT2kbHwSJzBqjuXt4Y/vEPMGDGMBv2Qq6L2ETrREzAN+ObmGoMXRwc2jl24x8TUl4GvbN5jEA8kq114eEr1jS69KPAv+44u0aZlj2DVydq9fx88HbP9Kpcx0LccNCPOPsvsoC4LuLTY4hYLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gb/1d4ro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9eRdGzh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gb/1d4ro; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9eRdGzh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83B8C222D0;
	Tue,  6 Feb 2024 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707252915;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9BNqdpi+n2EHc9YJ5/SAK9ivLWcftHAPQqaCWY9MH0=;
	b=gb/1d4roBGUTiVMkR32b8hUTI8wtIfrpF/oegATDoiPqqBRWD8x55lYWB5VH/zHf6IhBI5
	F1ZdGjhrI9C6mZkMbLnqz4RDAP6xoG7QrEowQaXYBcqAXqN8pUH0KbbK6LY+1zFJz1EA6v
	PxI6p9avB8mw/pE/oOLByrynhzA0l9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707252915;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9BNqdpi+n2EHc9YJ5/SAK9ivLWcftHAPQqaCWY9MH0=;
	b=p9eRdGzh0sOZwrk5ufucZKNvNNhiTCVkIvRCdaInCBPiQDIipQ+GzCtn18/SGas2se61vh
	t3W/SaX0kiTc+7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707252915;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9BNqdpi+n2EHc9YJ5/SAK9ivLWcftHAPQqaCWY9MH0=;
	b=gb/1d4roBGUTiVMkR32b8hUTI8wtIfrpF/oegATDoiPqqBRWD8x55lYWB5VH/zHf6IhBI5
	F1ZdGjhrI9C6mZkMbLnqz4RDAP6xoG7QrEowQaXYBcqAXqN8pUH0KbbK6LY+1zFJz1EA6v
	PxI6p9avB8mw/pE/oOLByrynhzA0l9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707252915;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9BNqdpi+n2EHc9YJ5/SAK9ivLWcftHAPQqaCWY9MH0=;
	b=p9eRdGzh0sOZwrk5ufucZKNvNNhiTCVkIvRCdaInCBPiQDIipQ+GzCtn18/SGas2se61vh
	t3W/SaX0kiTc+7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F052139D8;
	Tue,  6 Feb 2024 20:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7gT6FrOcwmXCNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 20:55:15 +0000
Date: Tue, 6 Feb 2024 21:54:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix deadlock with fiemap and extent locking
Message-ID: <20240206205445.GR355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <47ac92a6c8be53a5e10add9315255460c062b52d.1706817512.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ac92a6c8be53a5e10add9315255460c062b52d.1706817512.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="gb/1d4ro";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p9eRdGzh
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,toxicpanda.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 83B8C222D0
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Feb 01, 2024 at 02:58:54PM -0500, Josef Bacik wrote:
> While working on the patchset to remove extent locking I got a lockdep
> splat with fiemap and pagefaulting with my new extent lock replacement
> lock.
> 
> This deadlock exists with our normal code, we just don't have lockdep
> annotations with the extent locking so we've never noticed it.
> 
> Since we're copying the fiemap extent to user space on every iteration
> we have the chance of pagefaulting.  Because we hold the extent lock for
> the entire range we could mkwrite into a range in the file that we have
> mmap'ed.  This would deadlock with the following stack trace
> 
> [<0>] lock_extent+0x28d/0x2f0
> [<0>] btrfs_page_mkwrite+0x273/0x8a0
> [<0>] do_page_mkwrite+0x50/0xb0
> [<0>] do_fault+0xc1/0x7b0
> [<0>] __handle_mm_fault+0x2fa/0x460
> [<0>] handle_mm_fault+0xa4/0x330
> [<0>] do_user_addr_fault+0x1f4/0x800
> [<0>] exc_page_fault+0x7c/0x1e0
> [<0>] asm_exc_page_fault+0x26/0x30
> [<0>] rep_movs_alternative+0x33/0x70
> [<0>] _copy_to_user+0x49/0x70
> [<0>] fiemap_fill_next_extent+0xc8/0x120
> [<0>] emit_fiemap_extent+0x4d/0xa0
> [<0>] extent_fiemap+0x7f8/0xad0
> [<0>] btrfs_fiemap+0x49/0x80
> [<0>] __x64_sys_ioctl+0x3e1/0xb50
> [<0>] do_syscall_64+0x94/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> I wrote an fstest to reproduce this deadlock without my replacement lock
> and verified that the deadlock exists with our existing locking.
> 
> To fix this simply don't take the extent lock for the entire duration of
> the fiemap.  This is safe in general because we keep track of where we
> are when we're searching the tree, so if an ordered extent updates in
> the middle of our fiemap call we'll still emit the correct extents
> because we know what offset we were on before.
> 
> The only place we maintain the lock is searching delalloc.  Since the
> delalloc stuff can change during writeback we want to lock the extent
> range so we have a consistent view of delalloc at the time we're
> checking to see if we need to set the delalloc flag.
> 
> With this patch applied we no longer deadlock with my testcase.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 49 +++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8648ea9b5fb5..f8b68249d958 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2683,16 +2683,25 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
>  	 * it beyond i_size.
>  	 */
>  	while (cur_offset < end && cur_offset < i_size) {
> +		struct extent_state *cached_state = NULL;
>  		u64 delalloc_start;
>  		u64 delalloc_end;
>  		u64 prealloc_start;
> +		u64 lockstart, lockend;
>  		u64 prealloc_len = 0;
>  		bool delalloc;
>  
> +		lockstart = round_down(cur_offset,
> +				       inode->root->fs_info->sectorsize);
> +		lockend = round_up(end, inode->root->fs_info->sectorsize);
> +
> +		lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);

This could use a comment why the locking is ok only for delalloc. This
is quite a step from 'the whole range'.

>  		delalloc = btrfs_find_delalloc_in_range(inode, cur_offset, end,
>  							delalloc_cached_state,
>  							&delalloc_start,
>  							&delalloc_end);


> +		unlock_extent(&inode->io_tree, lockstart, lockend,
> +			      &cached_state);
>  		if (!delalloc)
>  			break;
>  
> @@ -2860,15 +2869,14 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  		  u64 start, u64 len)
>  {
>  	const u64 ino = btrfs_ino(inode);
> -	struct extent_state *cached_state = NULL;
>  	struct extent_state *delalloc_cached_state = NULL;
>  	struct btrfs_path *path;
>  	struct fiemap_cache cache = { 0 };
>  	struct btrfs_backref_share_check_ctx *backref_ctx;
>  	u64 last_extent_end;
>  	u64 prev_extent_end;
> -	u64 lockstart;
> -	u64 lockend;
> +	u64 align_start;
> +	u64 align_end;

This could be range_start and range_end, in the context where it appears
it's IMHO more clear.

>  	bool stopped = false;
>  	int ret;
>  
> @@ -2879,12 +2887,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  		goto out;
>  	}
>  
> -	lockstart = round_down(start, inode->root->fs_info->sectorsize);
> -	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
> -	prev_extent_end = lockstart;
> +	align_start = round_down(start, inode->root->fs_info->sectorsize);
> +	align_end = round_up(start + len, inode->root->fs_info->sectorsize);
> +	prev_extent_end = align_start;
>  
>  	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
> -	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>  
>  	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
>  	if (ret < 0)
> @@ -2892,7 +2899,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  	btrfs_release_path(path);
>  
>  	path->reada = READA_FORWARD;
> -	ret = fiemap_search_slot(inode, path, lockstart);
> +	ret = fiemap_search_slot(inode, path, align_start);
>  	if (ret < 0) {
>  		goto out_unlock;
>  	} else if (ret > 0) {
> @@ -2904,7 +2911,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  		goto check_eof_delalloc;
>  	}
>  
> -	while (prev_extent_end < lockend) {
> +	while (prev_extent_end < align_end) {
>  		struct extent_buffer *leaf = path->nodes[0];
>  		struct btrfs_file_extent_item *ei;
>  		struct btrfs_key key;
> @@ -2927,14 +2934,14 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  		 * The first iteration can leave us at an extent item that ends
>  		 * before our range's start. Move to the next item.
>  		 */
> -		if (extent_end <= lockstart)
> +		if (extent_end <= align_start)
>  			goto next_item;
>  
>  		backref_ctx->curr_leaf_bytenr = leaf->start;
>  
>  		/* We have in implicit hole (NO_HOLES feature enabled). */
>  		if (prev_extent_end < key.offset) {
> -			const u64 range_end = min(key.offset, lockend) - 1;
> +			const u64 range_end = min(key.offset, align_end) - 1;
>  
>  			ret = fiemap_process_hole(inode, fieinfo, &cache,
>  						  &delalloc_cached_state,
> @@ -2949,7 +2956,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  			}
>  
>  			/* We've reached the end of the fiemap range, stop. */
> -			if (key.offset >= lockend) {
> +			if (key.offset >= align_end) {
>  				stopped = true;
>  				break;
>  			}
> @@ -3043,29 +3050,40 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  	btrfs_free_path(path);
>  	path = NULL;
>  
> -	if (!stopped && prev_extent_end < lockend) {
> +	if (!stopped && prev_extent_end < align_end) {
>  		ret = fiemap_process_hole(inode, fieinfo, &cache,
>  					  &delalloc_cached_state, backref_ctx,
> -					  0, 0, 0, prev_extent_end, lockend - 1);
> +					  0, 0, 0, prev_extent_end, align_end - 1);
>  		if (ret < 0)
>  			goto out_unlock;
> -		prev_extent_end = lockend;
> +		prev_extent_end = align_end;
>  	}
>  
>  	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
>  		const u64 i_size = i_size_read(&inode->vfs_inode);
>  
>  		if (prev_extent_end < i_size) {
> +			struct extent_state *cached_state = NULL;
>  			u64 delalloc_start;
>  			u64 delalloc_end;
> +			u64 lockstart, lockend;
>  			bool delalloc;
>  
> +			lockstart = round_down(prev_extent_end,
> +					       inode->root->fs_info->sectorsize);
> +			lockend = round_up(i_size,
> +					   inode->root->fs_info->sectorsize);
> +
> +			lock_extent(&inode->io_tree, lockstart, lockend,
> +				    &cached_state);

And same comment about locking only delalloc range.

>  			delalloc = btrfs_find_delalloc_in_range(inode,
>  								prev_extent_end,
>  								i_size - 1,
>  								&delalloc_cached_state,
>  								&delalloc_start,
>  								&delalloc_end);
> +			unlock_extent(&inode->io_tree, lockstart, lockend,
> +				      &cached_state);
>  			if (!delalloc)
>  				cache.flags |= FIEMAP_EXTENT_LAST;
>  		} else {
> @@ -3076,7 +3094,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>  	ret = emit_last_fiemap_cache(fieinfo, &cache);
>  
>  out_unlock:
> -	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
>  	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>  out:
>  	free_extent_state(delalloc_cached_state);
> -- 
> 2.43.0
> 

