Return-Path: <linux-btrfs+bounces-11771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E5A44003
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 14:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6015E422644
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3122686BC;
	Tue, 25 Feb 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RddZ8m9N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zs2+3o0Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfECgU3M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MyCY9ubK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8117268C6C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488425; cv=none; b=q0JlD+aFX0KakRL6aWQWX9/nznixV+PC5Zg4EDAGRJ+wDgD64PCv/NJTzA0e0oDupr3S5RV7GqpCqB5DRZ1Qw8PXolXP4g8p7+Ec3NTFyC0bjcbHPHgBxzugH+cEkyO/IFgDXIjqDP2+6K1WO4zsEAJqgXxLHbnrTKNUKvevZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488425; c=relaxed/simple;
	bh=B5hwZmvPPt53kvgfCYRVKNuZepH839gsLvR4TuThNuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gITeWpzi/SU/UzMBd8d7OwRh+roBspq7jVROhU6hEy+mOwAWlzOjSR9I8KGYrB4W4TUSlQrDmxl8bL45jK4AdwiiYrZPX0yGE5URRTLR9Dn7tMYnXlbx58PlARinRDV7m9mYkgto7Fboco6ycLSrdtf67f7Tyn4K9eu6iSRh9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RddZ8m9N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zs2+3o0Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfECgU3M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MyCY9ubK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6C022118E;
	Tue, 25 Feb 2025 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488421;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i38+5s3oSfaHuiGWyHdO+WeTyb6D8SbsAixe/bMblI4=;
	b=RddZ8m9N3GiJCBTvJT2idqwsgUfZc7vgKJ/1+gzfe1J4kvHzd2395UpLlIpI7x6R+faMzJ
	r44CdJ7FL1CHiaiUjMQ49bS3O1JlrsTMF+Y+00zaajgEKYGNu0JQjdryk7wEVKAfyDdJjh
	Wc9ZVd9VWdJDp1TpsaUnvTweHmXZeHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488421;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i38+5s3oSfaHuiGWyHdO+WeTyb6D8SbsAixe/bMblI4=;
	b=Zs2+3o0YMhJjvEDvnCI9Pax6S2udcjt2lTdz6PYe3iG3JgfKifoxtdVHLoT9I7DBRbPNcs
	kLPt3ye3TS6R4kAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i38+5s3oSfaHuiGWyHdO+WeTyb6D8SbsAixe/bMblI4=;
	b=BfECgU3Mge7BbCQZNnrkcLVoSiRlaXI/cwRynpzjgx4UAtzOYefkcfxZptZp2jWqKehRSW
	dJFMD4UGFtSusiUhCOI9wygBQ1tRjDab2CPPcZ+ytrHlJBBFG8R7YBLRwEnHP5LKJ+7kvj
	AGfpSHXiKPv2brSXHdZ/Vq6LuWrK8JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i38+5s3oSfaHuiGWyHdO+WeTyb6D8SbsAixe/bMblI4=;
	b=MyCY9ubKgBprEKn9yIPVgBItIJIXIPVDokvU98SHptKVyVE6C6U7nneFxg3bFkZQJ5j82U
	tpOAOhGcJ3mCSLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A069213888;
	Tue, 25 Feb 2025 13:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 603xJuO+vWdAWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Feb 2025 13:00:19 +0000
Date: Tue, 25 Feb 2025 14:00:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: introduce a read path dedicated extent
 lock helper
Message-ID: <20250225130018.GO5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739328504.git.wqu@suse.com>
 <1b6921a745547f352f5b7e266ef28e864f2ce056.1739328504.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6921a745547f352f5b7e266ef28e864f2ce056.1739328504.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 01:22:45PM +1030, Qu Wenruo wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I have style comments that you can fix either at commit time or if you
have another iteration.

> ---
>  fs/btrfs/defrag.c       |   2 +-
>  fs/btrfs/direct-io.c    |   2 +-
>  fs/btrfs/extent_io.c    | 183 +++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/file.c         |   4 +-
>  fs/btrfs/inode.c        |   4 +-
>  fs/btrfs/ordered-data.c |  29 +++++--
>  fs/btrfs/ordered-data.h |   3 +-
>  7 files changed, 210 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 968dae953948..d1330c138054 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -902,7 +902,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
>  			break;
>  
>  		folio_unlock(folio);
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);

There are many calls with the 0, 0 parameters, and only one instance
with other values. It would be good to add a static inline helper that
wraps these parameters.

>  		btrfs_put_ordered_extent(ordered);
>  		folio_lock(folio);
>  		/*
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index b5190a010205..c98db5058967 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -103,7 +103,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
>  			 */
>  			if (writing ||
>  			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
> -				btrfs_start_ordered_extent(ordered);
> +				btrfs_start_ordered_extent(ordered, 0, 0);
>  			else
>  				ret = nowait ? -EAGAIN : -ENOTBLK;
>  			btrfs_put_ordered_extent(ordered);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 91b20dccef73..819d51c3ed57 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1075,6 +1075,185 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  	return 0;
>  }
>  
> +/*
> + * Check if we can skip waiting the @ordered extent covering the block
> + * at file pos @cur.
> + *
> + * Return true if we can skip to @next_ret. The caller needs to check
> + * the @next_ret value to make sure if covers the full range, before
> + * skipping the OE.
> + *
> + * Return false if we must wait for the ordered extent.
> + *
> + * @cur:	The start file offset that we have locked folio for read.
> + * @next_ret:	If we return true, this indiciates the next check start
> + *		range.

The parameters should be after the first line description, the return
value description is last.

Also please reformat it to 80-ish line width, it seems the comments
below are also formatted to 70.

> + */
> +static bool can_skip_one_ordered_range(struct btrfs_inode *binode,

Please use 'inode' for btrfs_inodes, I have patches cleaning that up
everywhere.

> +				       struct btrfs_ordered_extent *ordered,
> +				       u64 cur, u64 *next_ret)
> +{
> +	const struct btrfs_fs_info *fs_info = binode->root->fs_info;
> +	struct folio *folio;
> +	const u32 blocksize = fs_info->sectorsize;
> +	u64 range_len;
> +	bool ret;
> +
> +	folio = filemap_get_folio(binode->vfs_inode.i_mapping,
> +				  cur >> PAGE_SHIFT);

Should this be folio_shift?

> +
> +	/*
> +	 * We should have locked the folio(s) for range [start, end], thus
> +	 * there must be a folio and it must be locked.
> +	 */
> +	ASSERT(!IS_ERR(folio));
> +	ASSERT(folio_test_locked(folio));
> +
> +	/*
> +	 * We several cases for the folio and OE combination:
> +	 *
> +	 * 0) Folio has no private flag
> +	 *    The OE has all its IO done but not yet finished, and folio got
> +	 *    invalidated. Or direct IO.
> +	 *
> +	 * Have to wait for the OE to finish, as it may contain the
> +	 * to-be-inserted data checksum.
> +	 * Without the data checksum inserted into csum tree, read
> +	 * will just fail with missing csum.
> +	 */
> +	if (!folio_test_private(folio)) {
> +		ret = false;
> +		goto out;
> +	}
> +	range_len = min(folio_pos(folio) + folio_size(folio),
> +			ordered->file_offset + ordered->num_bytes) - cur;
> +
> +	/*
> +	 * 1) The first block is DIRTY.
> +	 *
> +	 * This means the OE is created by some folio before us, but writeback
> +	 * has not started.
> +	 * We can and must skip the whole OE, because it will never start until
> +	 * we finished our folio read and unlocked the folio.
> +	 */
> +	if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
> +		ret = true;
> +		/*
> +		 * At least inside the folio, all the remaining blocks should
> +		 * also be dirty.
> +		 */
> +		ASSERT(btrfs_folio_test_dirty(fs_info, folio, cur, range_len));
> +		*next_ret = ordered->file_offset + ordered->num_bytes;
> +		goto out;
> +	}
> +
> +	/*
> +	 * 2) The first block is uptodate.
> +	 *
> +	 * At least the first block can be skipped, but we are still
> +	 * not full sure. E.g. if the OE has some other folios in
> +	 * the range that can not be skipped.
> +	 * So we return true and update @next_ret to the OE/folio boundary.
> +	 */
> +	if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +		u64 range_len = min(folio_pos(folio) + folio_size(folio),
> +				    ordered->file_offset + ordered->num_bytes) - cur;
> +
> +		/*
> +		 * The whole range to the OE end or folio boundary should also
> +		 * be uptodate.
> +		 */
> +		ASSERT(btrfs_folio_test_uptodate(fs_info, folio, cur, range_len));
> +		ret = true;
> +		*next_ret = cur + range_len;
> +		goto out;
> +	}
> +
> +	/*
> +	 * 3) The first block is not uptodate.
> +	 *
> +	 * This means the folio is invalidated after the OE finished, or direct IO.
> +	 * Very much the same as case 1), just with private flag set.
> +	 */
> +	ret = false;
> +out:
> +	folio_put(folio);
> +	return ret;
> +}
> +
> +static bool can_skip_ordered_extent(struct btrfs_inode *binode,
> +				    struct btrfs_ordered_extent *ordered,
> +				    u64 start, u64 end)
> +{
> +	u64 range_end = min(end, ordered->file_offset + ordered->num_bytes - 1);
> +	u64 range_start = max(start, ordered->file_offset);
> +	u64 cur = range_start;
> +
> +	while (cur < range_end) {
> +		bool can_skip;
> +		u64 next_start;
> +
> +		can_skip = can_skip_one_ordered_range(binode, ordered, cur,
> +						      &next_start);
> +		if (!can_skip)
> +			return false;
> +		cur = next_start;
> +	}
> +	return true;
> +}
> +
> +/*
> + * To make sure we get a stable view of extent maps for the involved range.
> + * This is for folio read paths (read and readahead), thus involved range
> + * should have all the folios locked.
> + */
> +static void lock_extents_for_read(struct btrfs_inode *binode, u64 start, u64 end,
> +				  struct extent_state **cached_state)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +	u64 cur_pos;
> +
> +	/* Caller must provide a valid @cached_state. */
> +	ASSERT(cached_state);
> +
> +	/*
> +	 * The range must at least be page aligned, as all read paths
> +	 * are folio based.
> +	 */
> +	ASSERT(IS_ALIGNED(start, PAGE_SIZE) && IS_ALIGNED(end + 1, PAGE_SIZE));
> +
> +again:
> +	lock_extent(&binode->io_tree, start, end, cached_state);
> +	cur_pos = start;
> +	while (cur_pos < end) {
> +		ordered = btrfs_lookup_ordered_range(binode, cur_pos,
> +						     end - cur_pos + 1);
> +		/*
> +		 * No ordered extents in the range, and we hold the
> +		 * extent lock, no one can modify the extent maps
> +		 * in the range, we're safe to return.
> +		 */
> +		if (!ordered)
> +			break;
> +
> +		/* Check if we can skip waiting for the whole OE. */
> +		if (can_skip_ordered_extent(binode, ordered, start, end)) {
> +			cur_pos = min(ordered->file_offset + ordered->num_bytes,
> +				      end + 1);
> +			btrfs_put_ordered_extent(ordered);
> +			continue;
> +		}
> +
> +		/* Now wait for the OE to finish. */
> +		unlock_extent(&binode->io_tree, start, end,
> +			      cached_state);
> +		btrfs_start_ordered_extent(ordered, start, end + 1 - start);
> +		btrfs_put_ordered_extent(ordered);
> +		/* We have unlocked the whole range, restart from the beginning. */
> +		goto again;

This is a bit wild, goto at the end of a while loop but I don't see a
cleaner way without making complicated in another way.

> +	}
> +}
> +
>  int btrfs_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct btrfs_inode *inode = folio_to_inode(folio);
> @@ -1085,7 +1264,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
>  	struct extent_map *em_cached = NULL;
>  	int ret;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
> +	lock_extents_for_read(inode, start, end, &cached_state);
>  	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
>  	unlock_extent(&inode->io_tree, start, end, &cached_state);
>  
> @@ -2375,7 +2554,7 @@ void btrfs_readahead(struct readahead_control *rac)
>  	struct extent_map *em_cached = NULL;
>  	u64 prev_em_start = (u64)-1;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
> +	lock_extents_for_read(inode, start, end, &cached_state);
>  
>  	while ((folio = readahead_folio(rac)) != NULL)
>  		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 579706fab9b4..81e6cb599585 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -942,7 +942,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
>  				      cached_state);
>  			folio_unlock(folio);
>  			folio_put(folio);
> -			btrfs_start_ordered_extent(ordered);
> +			btrfs_start_ordered_extent(ordered, 0, 0);
>  			btrfs_put_ordered_extent(ordered);
>  			return -EAGAIN;
>  		}
> @@ -1846,7 +1846,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  		unlock_extent(io_tree, page_start, page_end, &cached_state);
>  		folio_unlock(folio);
>  		up_read(&BTRFS_I(inode)->i_mmap_lock);
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);
>  		btrfs_put_ordered_extent(ordered);
>  		goto again;
>  	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 32895aabf0ff..eaf53408254d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2821,7 +2821,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
>  		unlock_extent(&inode->io_tree, page_start, page_end,
>  			      &cached_state);
>  		folio_unlock(folio);
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);
>  		btrfs_put_ordered_extent(ordered);
>  		goto again;
>  	}
> @@ -4876,7 +4876,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  		unlock_extent(io_tree, block_start, block_end, &cached_state);
>  		folio_unlock(folio);
>  		folio_put(folio);
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);
>  		btrfs_put_ordered_extent(ordered);
>  		goto again;
>  	}
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4aca7475fd82..6075a6fa4817 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -729,7 +729,7 @@ static void btrfs_run_ordered_extent_work(struct btrfs_work *work)
>  	struct btrfs_ordered_extent *ordered;
>  
>  	ordered = container_of(work, struct btrfs_ordered_extent, flush_work);
> -	btrfs_start_ordered_extent(ordered);
> +	btrfs_start_ordered_extent(ordered, 0, 0);
>  	complete(&ordered->completion);
>  }
>  
> @@ -842,10 +842,12 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
>  /*
>   * Start IO and wait for a given ordered extent to finish.
>   *
> - * Wait on page writeback for all the pages in the extent and the IO completion
> - * code to insert metadata into the btree corresponding to the extent.
> + * Wait on page writeback for all the pages in the extent but not in
> + * [@nowriteback_start, @nowriteback_start + @nowriteback_len) and the
> + * IO completion code to insert metadata into the btree corresponding to the extent.
>   */
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +				u64 nowriteback_start, u32 nowriteback_len)
>  {
>  	u64 start = entry->file_offset;
>  	u64 end = start + entry->num_bytes - 1;
> @@ -865,8 +867,19 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry)
>  	 * start IO on any dirty ones so the wait doesn't stall waiting
>  	 * for the flusher thread to find them
>  	 */
> -	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags))
> -		filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
> +	if (!test_bit(BTRFS_ORDERED_DIRECT, &entry->flags)) {
> +		if (!nowriteback_len) {
> +			filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start, end);
> +		} else {
> +			if (start < nowriteback_start)
> +				filemap_fdatawrite_range(inode->vfs_inode.i_mapping, start,
> +						nowriteback_start - 1);
> +			if (nowriteback_start + nowriteback_len < end)
> +				filemap_fdatawrite_range(inode->vfs_inode.i_mapping,
> +						nowriteback_start + nowriteback_len,
> +						end);
> +		}
> +	}
>  
>  	if (!freespace_inode)
>  		btrfs_might_wait_for_event(inode->root->fs_info, btrfs_ordered_extent);
> @@ -921,7 +934,7 @@ int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len)
>  			btrfs_put_ordered_extent(ordered);
>  			break;
>  		}
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);
>  		end = ordered->file_offset;
>  		/*
>  		 * If the ordered extent had an error save the error but don't
> @@ -1174,7 +1187,7 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
>  			break;
>  		}
>  		unlock_extent(&inode->io_tree, start, end, cachedp);
> -		btrfs_start_ordered_extent(ordered);
> +		btrfs_start_ordered_extent(ordered, 0, 0);
>  		btrfs_put_ordered_extent(ordered);
>  	}
>  }
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 4e152736d06c..d7cf69647434 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -191,7 +191,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>  			   struct btrfs_ordered_sum *sum);
>  struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
>  							 u64 file_offset);
> -void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry);
> +void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry,
> +				u64 nowriteback_start, u32 nowriteback_len);
>  int btrfs_wait_ordered_range(struct btrfs_inode *inode, u64 start, u64 len);
>  struct btrfs_ordered_extent *
>  btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
> -- 
> 2.48.1
> 

