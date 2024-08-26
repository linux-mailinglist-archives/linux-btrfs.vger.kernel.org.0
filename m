Return-Path: <linux-btrfs+bounces-7504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906E95F45C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2295A282F29
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1D18E051;
	Mon, 26 Aug 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SFXfonh6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8518755F
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683792; cv=none; b=oftKp88aLzFFmHDqW2dJ90iJtHBCsg4ILA60f9MhXmKc4VHVfurzRTSEve16sHMOYrzo7vb7RUr24o1l8RVt0Q5qu2Rn9NbOJvaDwN7bUX5c7uJ3f43B7YLNBReVUg3GEbj472oxSN9+Vhvm6RYLN4pASyQHeQ/9So8LhCepBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683792; c=relaxed/simple;
	bh=Xr+cw//Uhr7B46vQyK/ho7Ff738pS52+HyfM8ZUJP6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaNVpChGzLE/gO2JjAbkc+uL926XxRicaILcwdeQ5jUL0nDXqqBvv0XY/Bkx/wYL/dw26P9SijHif4HqNIvwBzhL9UeDlnl1lzYt0t3w//dYGvzmyIJFuqN99Os5hzN4uG7rDAm6KOX+P8Xy6ihbP9N4on8GHjitO4SzKp7vBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SFXfonh6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1dd2004e1so298233085a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724683789; x=1725288589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcpcZ/ZoAkdTw2x0sl/WNy1SqcZeX1HC28pG2oEIg38=;
        b=SFXfonh63D3JKS6BdePy3foSgB1M7Pb81pwJDdt2BSEcm2bGTsty5JjuTFS2X2aOuJ
         IMpsQqRmC0yEPUwObVCp0R3ZoicS9NfltQSPN1khtGnj+sLFChiTyA8o939cD3J8iKwU
         114f8omcCH6fMQkR4KTCMoWxgSy15UBWVxq7oDCGXlfT9xe8aBdeIs3mTxbXJ/ZsYGZx
         hOb6MUpPWBl5RLfHsGseHEIh2+ipx6K+KSyi3XOOgWvIUmogxWy3afN7wW834D/K8cfy
         Vj5pKTDXKq8irNqP9UfmmFxnydrU6wNXkV+w7VlfNtn85b1UVI0GsUZjl807T0p4J/ay
         yuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683789; x=1725288589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcpcZ/ZoAkdTw2x0sl/WNy1SqcZeX1HC28pG2oEIg38=;
        b=QlcfMFnFC12fFJleMi4UmT6zaUuHqYOxgprUEDdXHGwqj/Et4IrGS1whuUXA9YJiCW
         Qx40Bgc6o12doOIhi380VBj0b3eIo3b0DiEBQWTwLOxRTz7Lf5SkNoh2VYO+FL7pvRps
         nqVz04M05Vp/9TrGARMJr7QhgRJErDXbk0i2frGG/mKbmQrRJVmqTSOe7MT4r7l7uS2/
         vYGSmvmKw/GY9oFf5A34Hf8flSktTlaglSQzhi/jH2WTK9zNR8QH4vaLNT/QzDC116Ka
         m0QqtsehJUD31rp4feBsUqtgqvzNVRu1UtijCor95u6iA32xVNLAkQyycv1hk45oEx+l
         1Ebw==
X-Gm-Message-State: AOJu0YzBF0OtSJkCgvZ2S+9PGcWcAHz5Cg0CkZ3G+ashmv1gFlh2xc8j
	eYlIfMD2VhCW/nNq68z87pTwqaTcr+DPCrWwZml9FSffnxhdm9UiY5PGO9cPvY7athH3LRhG88J
	P
X-Google-Smtp-Source: AGHT+IGhGjt05TalWyccZHDlgmfW7e2eAVZdPR8xJVSQQG+JnC5YP9dWDx3R4IkKYhvYcH/BhJpqkg==
X-Received: by 2002:a05:620a:46ab:b0:7a3:78ac:827c with SMTP id af79cd13be357-7a6896e3a0bmr1147399385a.10.1724683788790;
        Mon, 26 Aug 2024 07:49:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3471aasm462365185a.39.2024.08.26.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:49:48 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:49:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: do not hold the extent lock for entire read
Message-ID: <20240826144947.GF2393039@perftesting>
References: <cover.1724255475.git.josef@toxicpanda.com>
 <174b23dd8cf1a03d54f5ca3dc03c3f5011988d8a.1724255475.git.josef@toxicpanda.com>
 <tu2lxd7s3obnk6my6jcypnid44ndz2hpdmarxyrrowvkrpftqb@7dluyzmfc2is>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tu2lxd7s3obnk6my6jcypnid44ndz2hpdmarxyrrowvkrpftqb@7dluyzmfc2is>

On Sat, Aug 24, 2024 at 12:03:47PM -0400, Goldwyn Rodrigues wrote:
> On 12:02 21/08, Josef Bacik wrote:
> > Historically we've held the extent lock throughout the entire read.
> > There's been a few reasons for this, but it's mostly just caused us
> > problems.  For example, this prevents us from allowing page faults
> > during direct io reads, because we could deadlock.  This has forced us
> > to only allow 4k reads at a time for io_uring NOWAIT requests because we
> > have no idea if we'll be forced to page fault and thus have to do a
> > whole lot of work.
> > 
> > On the buffered side we are protected by the page lock, as long as we're
> > reading things like buffered writes, punch hole, and even direct IO to a
> > certain degree will get hung up on the page lock while the page is in
> > flight.
> > 
> > On the direct side we have the dio extent lock, which acts much like the
> > way the extent lock worked previously to this patch, however just for
> > direct reads.  This protects direct reads from concurrent direct writes,
> > while we're protected from buffered writes via the inode lock.
> > 
> > Now that we're protected in all cases, narrow the extent lock to the
> > part where we're getting the extent map to submit the reads, no longer
> > holding the extent lock for the entire read operation.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/compression.c |  2 +-
> >  fs/btrfs/direct-io.c   | 51 ++++++++++++------------
> >  fs/btrfs/extent_io.c   | 88 +++---------------------------------------
> >  3 files changed, 31 insertions(+), 110 deletions(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 832ab8984c41..511f81f312af 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -521,6 +521,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
> >  		}
> >  		add_size = min(em->start + em->len, page_end + 1) - cur;
> >  		free_extent_map(em);
> > +		unlock_extent(tree, cur, page_end, NULL);
> >  
> >  		if (folio->index == end_index) {
> >  			size_t zero_offset = offset_in_folio(folio, isize);
> > @@ -534,7 +535,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
> >  
> >  		if (!bio_add_folio(orig_bio, folio, add_size,
> >  				   offset_in_folio(folio, cur))) {
> > -			unlock_extent(tree, cur, page_end, NULL);
> >  			folio_unlock(folio);
> >  			folio_put(folio);
> >  			break;
> > diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> > index 576f469cacee..66f1ce5fcfd2 100644
> > --- a/fs/btrfs/direct-io.c
> > +++ b/fs/btrfs/direct-io.c
> > @@ -366,7 +366,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  	int ret = 0;
> >  	u64 len = length;
> >  	const u64 data_alloc_len = length;
> > -	bool unlock_extents = false;
> > +	u32 unlock_bits = EXTENT_LOCKED;
> >  
> >  	/*
> >  	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> > @@ -527,7 +527,6 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  						    start, &len, flags);
> >  		if (ret < 0)
> >  			goto unlock_err;
> > -		unlock_extents = true;
> >  		/* Recalc len in case the new em is smaller than requested */
> >  		len = min(len, em->len - (start - em->start));
> >  		if (dio_data->data_space_reserved) {
> > @@ -548,23 +547,8 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  							       release_offset,
> >  							       release_len);
> >  		}
> > -	} else {
> > -		/*
> > -		 * We need to unlock only the end area that we aren't using.
> > -		 * The rest is going to be unlocked by the endio routine.
> > -		 */
> > -		lockstart = start + len;
> > -		if (lockstart < lockend)
> > -			unlock_extents = true;
> >  	}
> >  
> > -	if (unlock_extents)
> > -		clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> > -				 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> > -				 &cached_state);
> > -	else
> > -		free_extent_state(cached_state);
> > -
> >  	/*
> >  	 * Translate extent map information to iomap.
> >  	 * We trim the extents (and move the addr) even though iomap code does
> > @@ -583,6 +567,23 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> >  	iomap->length = len;
> >  	free_extent_map(em);
> >  
> > +	/*
> > +	 * Reads will hold the EXTENT_DIO_LOCKED bit until the io is completed,
> > +	 * writes only hold it for this part.  We hold the extent lock until
> > +	 * we're completely done with the extent map to make sure it remains
> > +	 * valid.
> > +	 */
> > +	if (write)
> > +		unlock_bits |= EXTENT_DIO_LOCKED;
> > +
> > +	clear_extent_bit(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> > +			 unlock_bits, &cached_state);
> > +
> > +	/* We didn't use everything, unlock the dio extent for the remainder. */
> > +	if (!write && (start + len) < lockend)
> > +		unlock_dio_extent(&BTRFS_I(inode)->io_tree, start + len,
> > +				  lockend, NULL);
> > +
> >  	return 0;
> >  
> >  unlock_err:
> > @@ -615,9 +616,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> >  
> >  	if (!write && (iomap->type == IOMAP_HOLE)) {
> >  		/* If reading from a hole, unlock and return */
> > -		clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> > -				  pos + length - 1,
> > -				  EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
> > +		unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> > +				  pos + length - 1, NULL);
> >  		return 0;
> >  	}
> >  
> > @@ -628,10 +628,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> >  			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> >  						    pos, length, false);
> >  		else
> > -			clear_extent_bit(&BTRFS_I(inode)->io_tree, pos,
> > -					 pos + length - 1,
> > -					 EXTENT_LOCKED | EXTENT_DIO_LOCKED,
> > -					 NULL);
> > +			unlock_dio_extent(&BTRFS_I(inode)->io_tree, pos,
> > +					  pos + length - 1, NULL);
> >  		ret = -ENOTBLK;
> >  	}
> >  	if (write) {
> > @@ -663,9 +661,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
> >  					    dip->file_offset, dip->bytes,
> >  					    !bio->bi_status);
> >  	} else {
> > -		clear_extent_bit(&inode->io_tree, dip->file_offset,
> > -				 dip->file_offset + dip->bytes - 1,
> > -				 EXTENT_LOCKED | EXTENT_DIO_LOCKED, NULL);
> > +		unlock_dio_extent(&inode->io_tree, dip->file_offset,
> > +				  dip->file_offset + dip->bytes - 1, NULL);
> >  	}
> >  
> >  	bbio->bio.bi_private = bbio->private;
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 822e2bf8bc99..3f3baec23717 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -480,75 +480,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
> >  	bio_put(bio);
> >  }
> >  
> > -/*
> > - * Record previously processed extent range
> > - *
> > - * For endio_readpage_release_extent() to handle a full extent range, reducing
> > - * the extent io operations.
> > - */
> > -struct processed_extent {
> > -	struct btrfs_inode *inode;
> > -	/* Start of the range in @inode */
> > -	u64 start;
> > -	/* End of the range in @inode */
> > -	u64 end;
> > -	bool uptodate;
> > -};
> > -
> > -/*
> > - * Try to release processed extent range
> > - *
> > - * May not release the extent range right now if the current range is
> > - * contiguous to processed extent.
> > - *
> > - * Will release processed extent when any of @inode, @uptodate, the range is
> > - * no longer contiguous to the processed range.
> > - *
> > - * Passing @inode == NULL will force processed extent to be released.
> > - */
> > -static void endio_readpage_release_extent(struct processed_extent *processed,
> > -			      struct btrfs_inode *inode, u64 start, u64 end,
> > -			      bool uptodate)
> > -{
> > -	struct extent_state *cached = NULL;
> > -	struct extent_io_tree *tree;
> > -
> > -	/* The first extent, initialize @processed */
> > -	if (!processed->inode)
> > -		goto update;
> > -
> > -	/*
> > -	 * Contiguous to processed extent, just uptodate the end.
> > -	 *
> > -	 * Several things to notice:
> > -	 *
> > -	 * - bio can be merged as long as on-disk bytenr is contiguous
> > -	 *   This means we can have page belonging to other inodes, thus need to
> > -	 *   check if the inode still matches.
> > -	 * - bvec can contain range beyond current page for multi-page bvec
> > -	 *   Thus we need to do processed->end + 1 >= start check
> > -	 */
> > -	if (processed->inode == inode && processed->uptodate == uptodate &&
> > -	    processed->end + 1 >= start && end >= processed->end) {
> > -		processed->end = end;
> > -		return;
> > -	}
> > -
> > -	tree = &processed->inode->io_tree;
> > -	/*
> > -	 * Now we don't have range contiguous to the processed range, release
> > -	 * the processed range now.
> > -	 */
> > -	unlock_extent(tree, processed->start, processed->end, &cached);
> > -
> > -update:
> > -	/* Update processed to current range */
> > -	processed->inode = inode;
> > -	processed->start = start;
> > -	processed->end = end;
> > -	processed->uptodate = uptodate;
> > -}
> > -
> >  static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
> >  {
> >  	ASSERT(folio_test_locked(folio));
> > @@ -575,7 +506,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >  {
> >  	struct btrfs_fs_info *fs_info = bbio->fs_info;
> >  	struct bio *bio = &bbio->bio;
> > -	struct processed_extent processed = { 0 };
> >  	struct folio_iter fi;
> >  	const u32 sectorsize = fs_info->sectorsize;
> >  
> > @@ -640,11 +570,7 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
> >  
> >  		/* Update page status and unlock. */
> >  		end_folio_read(folio, uptodate, start, len);
> > -		endio_readpage_release_extent(&processed, BTRFS_I(inode),
> > -					      start, end, uptodate);
> >  	}
> > -	/* Release the last extent */
> > -	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
> >  	bio_put(bio);
> >  }
> >  
> > @@ -1019,11 +945,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >  	size_t pg_offset = 0;
> >  	size_t iosize;
> >  	size_t blocksize = fs_info->sectorsize;
> > -	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> >  
> >  	ret = set_folio_extent_mapped(folio);
> >  	if (ret < 0) {
> > -		unlock_extent(tree, start, end, NULL);
> >  		folio_unlock(folio);
> >  		return ret;
> >  	}
> > @@ -1047,14 +971,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >  		if (cur >= last_byte) {
> >  			iosize = folio_size(folio) - pg_offset;
> >  			folio_zero_range(folio, pg_offset, iosize);
> > -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
> >  			end_folio_read(folio, true, cur, iosize);
> >  			break;
> >  		}
> >  		em = __get_extent_map(inode, folio, cur, end - cur + 1,
> >  				      em_cached);
> >  		if (IS_ERR(em)) {
> > -			unlock_extent(tree, cur, end, NULL);
> >  			end_folio_read(folio, false, cur, end + 1 - cur);
> >  			return PTR_ERR(em);
> >  		}
> > @@ -1123,7 +1045,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >  		if (block_start == EXTENT_MAP_HOLE) {
> >  			folio_zero_range(folio, pg_offset, iosize);
> >  
> > -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
> >  			end_folio_read(folio, true, cur, iosize);
> >  			cur = cur + iosize;
> >  			pg_offset += iosize;
> > @@ -1131,7 +1052,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
> >  		}
> >  		/* the get_extent function already copied into the folio */
> >  		if (block_start == EXTENT_MAP_INLINE) {
> > -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
> >  			end_folio_read(folio, true, cur, iosize);
> >  			cur = cur + iosize;
> >  			pg_offset += iosize;
> > @@ -1161,11 +1081,13 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
> >  	u64 end = start + folio_size(folio) - 1;
> >  	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
> >  	struct extent_map *em_cached = NULL;
> > +	struct extent_state *cached = NULL;
> >  	int ret;
> >  
> > -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> > +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);
> >  
> >  	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> > +	unlock_extent(&inode->io_tree, start, end, &cached);
> >  	free_extent_map(em_cached);
> >  
> >  	/*
> > @@ -2350,13 +2272,15 @@ void btrfs_readahead(struct readahead_control *rac)
> >  	u64 start = readahead_pos(rac);
> >  	u64 end = start + readahead_length(rac) - 1;
> >  	struct extent_map *em_cached = NULL;
> > +	struct extent_state *cached = NULL;
> >  	u64 prev_em_start = (u64)-1;
> >  
> > -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> > +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached);;
> >  
> >  	while ((folio = readahead_folio(rac)) != NULL)
> >  		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
> >  
> > +	unlock_extent(&inode->io_tree, start, end, &cached);
> >  	if (em_cached)
> >  		free_extent_map(em_cached);
> >  	submit_one_bio(&bio_ctrl);
> 
> I think you can combine the patch I have sent a couple of days back with
> this one. It will reduce the scope to extent locking-unlocking still
> further and limit it to fetching extent_map within
> __get_extent_map(). I have tested the following patch on top of this
> one, and it passes xfstests. If not, I can send it as a part of my next
> series.

Ok I'll integrate this and re-send.  Thanks!

Josef

