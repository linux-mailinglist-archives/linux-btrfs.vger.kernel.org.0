Return-Path: <linux-btrfs+bounces-7474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA395DEDB
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B561C20E92
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B42AF15;
	Sat, 24 Aug 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qCvP2Z0/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tt+t+5wX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qCvP2Z0/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tt+t+5wX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6722F11
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724515443; cv=none; b=tXM9k3rzRiH4l2FqELKzqgn5+wy31MSItZRKyFWkflgMWC07S1VKJ3patg4eTk9l1S4D+NmKRHJTIdLtm0lyZXksIOPc1ASInEjIlkQuEm5CbQ2XwyOIgBxha0Safqk5/KxfM/4pmOQa1st7IAG+IIOjt5H9+O2wdujRtOC8/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724515443; c=relaxed/simple;
	bh=msVBDEFJi5WvNbdyuTsQg+C/0tCRiFxoFYOJYf+KyLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnqaCnqJmIQoRXf7XNsZWKzeOGpqm5N0gkl2TJk40KwGlRM09wU92Sbv/fv7InI/5G1QcNFrTqvULBJY6VfqEn5fRZp3emHVd5VUAMqxqm3TzXjHlcbjeBOJEMfPe++OdfxEoNxYXxdZD0wfzxyK/JgUEHXzo+AUCjeJE527j70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qCvP2Z0/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tt+t+5wX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qCvP2Z0/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tt+t+5wX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 641EC1F44E;
	Sat, 24 Aug 2024 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724515430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QBebKLMAYd8Zcc4spodBjUDeVrEfNLPMYj/FqYuIc8=;
	b=qCvP2Z0/WcSDr67Lu5ZtNdH4ZW95e073tBBAA8J7qb/3LUG3Rr5fxJK6xL9QuwRSUagzVn
	8WmNXKLZN3W5V7MzJGcRykajzXjxdEy5lVlMYfbzT2IC44oCBgnXEy+H6DXKk2cido1YdD
	NMSzPoWwbfm8Ks3FimY0sTw4lB7/2X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724515430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QBebKLMAYd8Zcc4spodBjUDeVrEfNLPMYj/FqYuIc8=;
	b=Tt+t+5wXac7XRq+LJw0ZRujF3x8ZV2XDZ6kiV1jkEitTcDWBEKTnB0V20+SU7fVbZdjK4K
	/zL21OY7N82lgcDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qCvP2Z0/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tt+t+5wX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724515430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QBebKLMAYd8Zcc4spodBjUDeVrEfNLPMYj/FqYuIc8=;
	b=qCvP2Z0/WcSDr67Lu5ZtNdH4ZW95e073tBBAA8J7qb/3LUG3Rr5fxJK6xL9QuwRSUagzVn
	8WmNXKLZN3W5V7MzJGcRykajzXjxdEy5lVlMYfbzT2IC44oCBgnXEy+H6DXKk2cido1YdD
	NMSzPoWwbfm8Ks3FimY0sTw4lB7/2X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724515430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QBebKLMAYd8Zcc4spodBjUDeVrEfNLPMYj/FqYuIc8=;
	b=Tt+t+5wXac7XRq+LJw0ZRujF3x8ZV2XDZ6kiV1jkEitTcDWBEKTnB0V20+SU7fVbZdjK4K
	/zL21OY7N82lgcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB09913A66;
	Sat, 24 Aug 2024 16:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tsK3IWUEymZJfgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Sat, 24 Aug 2024 16:03:49 +0000
Date: Sat, 24 Aug 2024 12:03:47 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: do not hold the extent lock for entire read
Message-ID: <tu2lxd7s3obnk6my6jcypnid44ndz2hpdmarxyrrowvkrpftqb@7dluyzmfc2is>
References: <cover.1724255475.git.josef@toxicpanda.com>
 <174b23dd8cf1a03d54f5ca3dc03c3f5011988d8a.1724255475.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174b23dd8cf1a03d54f5ca3dc03c3f5011988d8a.1724255475.git.josef@toxicpanda.com>
X-Rspamd-Queue-Id: 641EC1F44E
X-Spam-Score: -6.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12:02 21/08, Josef Bacik wrote:
> Historically we've held the extent lock throughout the entire read.
> There's been a few reasons for this, but it's mostly just caused us
> problems.  For example, this prevents us from allowing page faults
> during direct io reads, because we could deadlock.  This has forced us
> to only allow 4k reads at a time for io_uring NOWAIT requests because we
> have no idea if we'll be forced to page fault and thus have to do a
> whole lot of work.
> 
> On the buffered side we are protected by the page lock, as long as we're
> reading things like buffered writes, punch hole, and even direct IO to a
> certain degree will get hung up on the page lock while the page is in
> flight.
> 
> On the direct side we have the dio extent lock, which acts much like the
> way the extent lock worked previously to this patch, however just for
> direct reads.  This protects direct reads from concurrent direct writes,
> while we're protected from buffered writes via the inode lock.
> 
> Now that we're protected in all cases, narrow the extent lock to the
> part where we're getting the extent map to submit the reads, no longer
> holding the extent lock for the entire read operation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/compression.c |  2 +-
>  fs/btrfs/direct-io.c   | 51 ++++++++++++------------
>  fs/btrfs/extent_io.c   | 88 +++---------------------------------------
>  3 files changed, 31 insertions(+), 110 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 832ab8984c41..511f81f312af 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -521,6 +521,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		}
>  		add_size = min(em->start + em->len, page_end + 1) - cur;
>  		free_extent_map(em);
> +		unlock_extent(tree, cur, page_end, NULL);
>  
>  		if (folio->index == end_index) {
>  			size_t zero_offset = offset_in_folio(folio, isize);
> @@ -534,7 +535,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  
>  		if (!bio_add_folio(orig_bio, folio, add_size,
>  				   offset_in_folio(folio, cur))) {
> -			unlock_extent(tree, cur, page_end, NULL);
>  			folio_unlock(folio);
>  			folio_put(folio);
>  			break;
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 576f469cacee..66f1ce5fcfd2 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -366,7 +366,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  	int ret = 0;
>  	u64 len = length;
>  	const u64 data_alloc_len = length;
> -	bool unlock_extents = false;
> +	u32 unlock_bits = EXTENT_LOCKED;
>  
>  	/*
>  	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> @@ -527,7 +527,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  						    start, &len, flags);
>  		if (ret < 0)
>  			goto unlock_err;
> -		unlock_extents = true;
>  		/* Recalc len in case the new em is smaller than requested */
>  		len = min(len, em->len - (start - em->start));
>  		if (dio_data->data_space_reserved) {
> @@ -548,23 +547,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  							       release_offset,
>  							       release_len);
>  		}
> -	} else {
> -		/*
> -		 * We need to unlock only the end area that we aren't using.
> -		 * The rest is going to be unlocked by the endio routine.
> -		 */
> -		lockstart = start + len;
> -		if (lockstart < lockend)
> -			unlock_extents = true;
>  	}
>  
> -	if (unlock_extents)
> -		clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> -				 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> -				 &cached_state);
> -	else
> -		free_extent_state(cached_state);
> -
>  	/*
>  	 * Translate extent map information to iomap.
>  	 * We trim the extents (and move the addr) even though iomap code does
> @@ -583,6 +567,23 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  	iomap->length = len;
>  	free_extent_map(em);
>  
> +	/*
> +	 * Reads will hold the EXTENT_DIO_LOCKED bit until the io is completed,
> +	 * writes only hold it for this part.  We hold the extent lock until
> +	 * we're completely done with the extent map to make sure it remains
> +	 * valid.
> +	 */
> +	if (write)
> +		unlock_bits |= EXTENT_DIO_LOCKED;
> +
> +	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> +			 unlock_bits, &cached_state);
> +
> +	/* We didn't use everything, unlock the dio extent for the remainder. */
> +	if (!write && (start + len) < lockend)
> +		unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
> +				  lockend, NULL);
> +
>  	return 0;
>  
>  unlock_err:
> @@ -615,9 +616,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (!write && (iomap->type == IOMAP_HOLE)) {
>  		/* If reading from a hole, unlock and return */
> -		clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> -				  pos + length - 1,
> -				  EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
> +		unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> +				  pos + length - 1, NULL);
>  		return 0;
>  	}
>  
> @@ -628,10 +628,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>  			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
>  						    pos, length, false);
>  		else
> -			clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> -					 pos + length - 1,
> -					 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> -					 NULL);
> +			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> +					  pos + length - 1, NULL);
>  		ret = -ENOTBLK;
>  	}
>  	if (write) {
> @@ -663,9 +661,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
>  					    dip->file_offset, dip->bytes,
>  					    !bio->bi_status);
>  	} else {
> -		clear_extent_bit(&inode->io_tree, dip->file_offset,
> -				 dip->file_offset + dip->bytes - 1,
> -				 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
> +		unlock_dio_extent(&inode->io_tree, dip->file_offset,
> +				  dip->file_offset + dip->bytes - 1, NULL);
>  	}
>  
>  	bbio->bio.bi_private = bbio->private;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 822e2bf8bc99..3f3baec23717 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
>  	bio_put(bio);
>  }
>  
> -/*
> - * Record previously processed extent range
> - *
> - * For endio_readpage_release_extent() to handle a full extent range, reducing
> - * the extent io operations.
> - */
> -struct processed_extent {
> -	struct btrfs_inode *inode;
> -	/* Start of the range in @inode */
> -	u64 start;
> -	/* End of the range in @inode */
> -	u64 end;
> -	bool uptodate;
> -};
> -
> -/*
> - * Try to release processed extent range
> - *
> - * May not release the extent range right now if the current range is
> - * contiguous to processed extent.
> - *
> - * Will release processed extent when any of @inode, @uptodate, the range is
> - * no longer contiguous to the processed range.
> - *
> - * Passing @inode == NULL will force processed extent to be released.
> - */
> -static void endio_readpage_release_extent(struct processed_extent *processed,
> -			      struct btrfs_inode *inode, u64 start, u64 end,
> -			      bool uptodate)
> -{
> -	struct extent_state *cached = NULL;
> -	struct extent_io_tree *tree;
> -
> -	/* The first extent, initialize @processed */
> -	if (!processed->inode)
> -		goto update;
> -
> -	/*
> -	 * Contiguous to processed extent, just uptodate the end.
> -	 *
> -	 * Several things to notice:
> -	 *
> -	 * - bio can be merged as long as on-disk bytenr is contiguous
> -	 *   This means we can have page belonging to other inodes, thus need to
> -	 *   check if the inode still matches.
> -	 * - bvec can contain range beyond current page for multi-page bvec
> -	 *   Thus we need to do processed->end + 1 >= start check
> -	 */
> -	if (processed->inode == inode && processed->uptodate == uptodate &&
> -	    processed->end + 1 >= start && end >= processed->end) {
> -		processed->end = end;
> -		return;
> -	}
> -
> -	tree = &processed->inode->io_tree;
> -	/*
> -	 * Now we don't have range contiguous to the processed range, release
> -	 * the processed range now.
> -	 */
> -	unlock_extent(tree, processed->start, processed->end, &cached);
> -
> -update:
> -	/* Update processed to current range */
> -	processed->inode = inode;
> -	processed->start = start;
> -	processed->end = end;
> -	processed->uptodate = uptodate;
> -}
> -
>  static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
>  {
>  	ASSERT(folio_test_locked(folio));
> @@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>  {
>  	struct btrfs_fs_info *fs_info = bbio->fs_info;
>  	struct bio *bio = &bbio->bio;
> -	struct processed_extent processed = { 0 };
>  	struct folio_iter fi;
>  	const u32 sectorsize = fs_info->sectorsize;
>  
> @@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>  
>  		/* Update page status and unlock. */
>  		end_folio_read(folio, uptodate, start, len);
> -		endio_readpage_release_extent(&processed, BTRFS_I(inode),
> -					      start, end, uptodate);
>  	}
> -	/* Release the last extent */
> -	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
>  	bio_put(bio);
>  }
>  
> @@ -1019,11 +945,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  	size_t pg_offset = 0;
>  	size_t iosize;
>  	size_t blocksize = fs_info->sectorsize;
> -	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  
>  	ret = set_folio_extent_mapped(folio);
>  	if (ret < 0) {
> -		unlock_extent(tree, start, end, NULL);
>  		folio_unlock(folio);
>  		return ret;
>  	}
> @@ -1047,14 +971,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  		if (cur >= last_byte) {
>  			iosize = folio_size(folio) - pg_offset;
>  			folio_zero_range(folio, pg_offset, iosize);
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_folio_read(folio, true, cur, iosize);
>  			break;
>  		}
>  		em = __get_extent_map(inode, folio, cur, end - cur + 1,
>  				      em_cached);
>  		if (IS_ERR(em)) {
> -			unlock_extent(tree, cur, end, NULL);
>  			end_folio_read(folio, false, cur, end + 1 - cur);
>  			return PTR_ERR(em);
>  		}
> @@ -1123,7 +1045,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  		if (block_start == EXTENT_MAP_HOLE) {
>  			folio_zero_range(folio, pg_offset, iosize);
>  
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_folio_read(folio, true, cur, iosize);
>  			cur = cur + iosize;
>  			pg_offset += iosize;
> @@ -1131,7 +1052,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  		}
>  		/* the get_extent function already copied into the folio */
>  		if (block_start == EXTENT_MAP_INLINE) {
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_folio_read(folio, true, cur, iosize);
>  			cur = cur + iosize;
>  			pg_offset += iosize;
> @@ -1161,11 +1081,13 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
>  	u64 end = start + folio_size(folio) - 1;
>  	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
>  	struct extent_map *em_cached = NULL;
> +	struct extent_state *cached = NULL;
>  	int ret;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);
>  
>  	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> +	unlock_extent(&inode->io_tree, start, end, &cached);
>  	free_extent_map(em_cached);
>  
>  	/*
> @@ -2350,13 +2272,15 @@ void btrfs_readahead(struct readahead_control *rac)
>  	u64 start = readahead_pos(rac);
>  	u64 end = start + readahead_length(rac) - 1;
>  	struct extent_map *em_cached = NULL;
> +	struct extent_state *cached = NULL;
>  	u64 prev_em_start = (u64)-1;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);;
>  
>  	while ((folio = readahead_folio(rac)) != NULL)
>  		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
>  
> +	unlock_extent(&inode->io_tree, start, end, &cached);
>  	if (em_cached)
>  		free_extent_map(em_cached);
>  	submit_one_bio(&bio_ctrl);

I think you can combine the patch I have sent a couple of days back with
this one. It will reduce the scope to extent locking-unlocking still
further and limit it to fetching extent_map within
__get_extent_map(). I have tested the following patch on top of this
one, and it passes xfstests. If not, I can send it as a part of my next
series.


commit 2dcd5f1e80ac5ce024239f8f3888dbe088ce7593
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Thu Aug 22 13:04:35 2024 -0400

    btrfs: reduce scope of extent locks while reading
    
    extent locks need not be taken for the entire duration of the
    do_readpage() but just while reading extents. The extent_map returned
    and cached (in em_cached) is refcounted so there is no fear of it
    dropping.

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3f3baec23717..67a93153ab1f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -899,6 +899,7 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 					   u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
 
 	ASSERT(em_cached);
 
@@ -914,12 +915,15 @@ static struct extent_map *__get_extent_map(struct inode *inode,
 		*em_cached = NULL;
 	}
 
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start, start + len - 1, &cached_state);
 	em = btrfs_get_extent(BTRFS_I(inode), folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
 	}
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, start + len - 1, &cached_state);
+
 	return em;
 }
 /*
@@ -1076,18 +1080,11 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct btrfs_inode *inode = folio_to_inode(folio);
-	u64 start = folio_pos(folio);
-	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
-	struct extent_state *cached = NULL;
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);
-
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
-	unlock_extent(&inode->io_tree, start, end, &cached);
 	free_extent_map(em_cached);
 
 	/*
@@ -2267,20 +2264,13 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
-	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
 	struct folio *folio;
-	u64 start = readahead_pos(rac);
-	u64 end = start + readahead_length(rac) - 1;
 	struct extent_map *em_cached = NULL;
-	struct extent_state *cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);;
-
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
-	unlock_extent(&inode->io_tree, start, end, &cached);
 	if (em_cached)
 		free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);



-- 
Goldwyn

