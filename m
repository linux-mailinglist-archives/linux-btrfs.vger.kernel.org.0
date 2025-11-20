Return-Path: <linux-btrfs+bounces-19181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD84C71AC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF8A14E3145
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7C231830;
	Thu, 20 Nov 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OQhXlCZu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xIaJXYSk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7D1534EC
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601434; cv=none; b=KFR0tHc1Am7pTPBAXTpQaVRhuH1dm8199aRR3r9OpiBllV7/3m8b2uT3A1ac0bI6EH1PzNWW8MF44NFOybFZUN3Ye7u5IsZu8SewGtIkGshB6zYH34+IqFfiNdtT8462zSc439W6olBQIVS+i48AHxp27POLg7wANpuc+PeOfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601434; c=relaxed/simple;
	bh=446o3Io56vgm8fXL0InhEZK1xSwWgROAR6XiJ2dl/BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7N4skuSBqziFoa36wr8CaaLQFsK0UT9Ja9B2LoYEbbrCQPVJdOeUJ15zxaavoKVdi86d5vERRjOCiKqC5+wyAyHvASHl+2f/WKh5hdhMsATiFVcPk+HKP+rmEsR3VUTeTsLrhRlSjdy9mq9K7kW76myHSc698U5QklrXSmfVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OQhXlCZu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xIaJXYSk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B0AA140004D;
	Wed, 19 Nov 2025 20:17:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 20:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763601431; x=1763687831; bh=eYLwL1ZtIg
	LteWETfWWFKmkOeUbU4jmbrfEKKqhG+Po=; b=OQhXlCZuNltd/QLy7duXrNICwg
	3WJhkVqD7K6Z85mRAL384yOFpDBQ59JccpRJlAyeSjljmW/KaWYxvzo2nw+WoynB
	VwEXOJPJD4Du/+/+dYoI+rCySHqJoSvusadq5iPGWsPzmDk4C26bTUkHvqO3a6Q4
	/PttNdvgt/agmZYvFB0r1MO4teKtnuC7vX4y46TF3I3v/FdT7h5KvCkEbQt+014J
	imvFU06515gLLwoHhmgqB5WiZJLuntODNXBJCeq/Qam9hCWMQMhCs0EeKZd7O8WZ
	OWjFVPdTe8T6dRPPAgokWdayXD4l16XygCFdLKCVBtdrNjKhGomEmg1xBSVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763601431; x=1763687831; bh=eYLwL1ZtIgLteWETfWWFKmkOeUbU4jmbrfE
	KKqhG+Po=; b=xIaJXYSkjHz3dmZKrjBRtvbN8oI7iKW6kZtpXWcHIjekKsahFyJ
	5XXrR5VKoALA93k9gG4ukkFYfDJ8JAZkGVCGTSKdOKzhp+xzIP+a5rjgmTICJbyO
	XuuoMY0WYG0Bn7KDhsDm2MjE7V0Wd6eHDXwloQccWa+1onQplGgdiWkYENDFaFZd
	vGEY8gNXKLoLrlnLKprPbTpSFiw/V2rEqv5cG5UfbxjR0VPncC5EWd4A746brpD/
	jf8PgIPbw5nM7pojcmZdmf8j79c8y6mKh9w6jcrLGyuEHq9bMTRzOwR/KNeiwyHZ
	PFojxcw80ZUJi0Xfnlc0XnBFXKpXPYTdllA==
X-ME-Sender: <xms:F2weaaEjk-6AxHGggEm96mDuRHcR4eVuatAEG5Ij0rGV5lRY3Zi7Hw>
    <xme:F2weaRVxqBUBWj32LqBbrOCTt0F-S3OqfOa6Uba9yM5ih4bOpE7y0-KgrEuy7dUea
    NvqOSmoquXSyANu1quys35eHnXHvSs7tvxF7wugTPywr1IUWvwhU04>
X-ME-Received: <xmr:F2weaRz69Tf4PkXRTTPnH-5BeiJDUje-D9MHNZFHYz7BUz1nDfTr8eHcMPmhM-IG9UafZiXHBYVCfzgeOFBZuUIlRjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F2weafPuGtSUrY58jAylqAr42lGx960BRKZms5ubQLxQ0easpbdBsA>
    <xmx:F2weaS6N8G2IoD1AVg--M8jbMUauV--olaopOkeVPMSWCe_7IHDXsA>
    <xmx:F2weaQNcQ5Zne5XTwHSvHyK8Btcfu-ixhrRye_JU_xNCYT_3seYuxw>
    <xmx:F2weaQmSsccw6AS02pt3wYj51PbWRXbX-IoNgFirkOR6mHHq7FLz3Q>
    <xmx:F2weaQxr7mCqOZfTDfLKVLqv58iF-QRlLevSL_90mP5OB5IangarhO9r>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 20:17:10 -0500 (EST)
Date: Wed, 19 Nov 2025 17:16:26 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: reduce extent map lookup during writes
Message-ID: <20251120011626.GB2522273@zen.localdomain>
References: <cover.1763596717.git.wqu@suse.com>
 <a6869c2d5f3b8cdd3360375ea64d0449c97dfd6d.1763596717.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6869c2d5f3b8cdd3360375ea64d0449c97dfd6d.1763596717.git.wqu@suse.com>

On Thu, Nov 20, 2025 at 10:34:33AM +1030, Qu Wenruo wrote:
> With large data folios supports, even on x86_64 we can hit a folio that
> contains several fs blocks.
> 
> In that case, we still need to call btrfs_get_extent() for each block,
> as our submission path is still iterating each fs block and submit them
> one by one. This reduces the benefit of large folios.
> 
> Change the behavior to submit the whole range when possible, this is
> done by:
> 
> - Use for_each_set_bitrange() instead of for_each_set_bit()
>   Now we can get a contiguous range to submit instead of a single fs
>   block.
> 
> - Handle blocks beyond EOF in one go
>   This is pretty much the same as the old behavior, but for a range
>   crossing i_size, we finish the range beyond i_size first, then submit
>   the remaining.
> 
> - Submit the contiguous range in one go
>   Although we still need to consider the extent map boundary.
> 
> - Remove submit_one_sector()
>   As it's no longer utilized.
> 

This is very cool, quite excited about it. A couple questions inline but
the approach looks good to me overall.

Also, I was curious and looked at writepage_delalloc and that also uses
for_each_set_bit(...) though with simpler stuff in the loop
(btrfs_folio_set_lock) though I wonder if that can be simplified as well.

Thanks,
Boris

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 208 +++++++++++++++++++++++--------------------
>  1 file changed, 112 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cbee93a929f3..152eed265a3c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1596,94 +1596,6 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  	return 0;
>  }
>  
> -/*
> - * Return 0 if we have submitted or queued the sector for submission.
> - * Return <0 for critical errors, and the involved sector will be cleaned up.
> - *
> - * Caller should make sure filepos < i_size and handle filepos >= i_size case.
> - */
> -static int submit_one_sector(struct btrfs_inode *inode,
> -			     struct folio *folio,
> -			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
> -			     loff_t i_size)
> -{
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct extent_map *em;
> -	u64 block_start;
> -	u64 disk_bytenr;
> -	u64 extent_offset;
> -	u64 em_end;
> -	const u32 sectorsize = fs_info->sectorsize;
> -
> -	ASSERT(IS_ALIGNED(filepos, sectorsize));
> -
> -	/* @filepos >= i_size case should be handled by the caller. */
> -	ASSERT(filepos < i_size);
> -
> -	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
> -	if (IS_ERR(em)) {
> -		/*
> -		 * bio_ctrl may contain a bio crossing several folios.
> -		 * Submit it immediately so that the bio has a chance
> -		 * to finish normally, other than marked as error.
> -		 */
> -		submit_one_bio(bio_ctrl);
> -
> -		/*
> -		 * When submission failed, we should still clear the folio dirty.
> -		 * Or the folio will be written back again but without any
> -		 * ordered extent.
> -		 */
> -		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
> -		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
> -		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
> -
> -		/*
> -		 * Since there is no bio submitted to finish the ordered
> -		 * extent, we have to manually finish this sector.
> -		 */
> -		btrfs_mark_ordered_io_finished(inode, folio, filepos,
> -					       fs_info->sectorsize, false);
> -		return PTR_ERR(em);
> -	}
> -
> -	extent_offset = filepos - em->start;
> -	em_end = btrfs_extent_map_end(em);
> -	ASSERT(filepos <= em_end);
> -	ASSERT(IS_ALIGNED(em->start, sectorsize));
> -	ASSERT(IS_ALIGNED(em->len, sectorsize));
> -
> -	block_start = btrfs_extent_map_block_start(em);
> -	disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
> -
> -	ASSERT(!btrfs_extent_map_is_compressed(em));
> -	ASSERT(block_start != EXTENT_MAP_HOLE);
> -	ASSERT(block_start != EXTENT_MAP_INLINE);
> -
> -	btrfs_free_extent_map(em);
> -	em = NULL;
> -
> -	/*
> -	 * Although the PageDirty bit is cleared before entering this
> -	 * function, subpage dirty bit is not cleared.
> -	 * So clear subpage dirty bit here so next time we won't submit
> -	 * a folio for a range already written to disk.
> -	 */
> -	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
> -	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
> -	/*
> -	 * Above call should set the whole folio with writeback flag, even
> -	 * just for a single subpage sector.
> -	 * As long as the folio is properly locked and the range is correct,
> -	 * we should always get the folio with writeback flag.
> -	 */
> -	ASSERT(folio_test_writeback(folio));
> -
> -	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
> -			    sectorsize, filepos - folio_pos(folio), 0);
> -	return 0;
> -}
> -
>  static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio,
>  				 u64 start, u32 len, loff_t i_size)
>  {
> @@ -1718,6 +1630,96 @@ static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio,
>  	btrfs_folio_clear_dirty(fs_info, folio, start, len);
>  }
>  
> +/*
> + * Return 0 if we have submitted or queued the range for submission.
> + * Return <0 for critical errors, and the involved blocks will be cleaned up.
> + *
> + * Caller should make sure the range doesn't go beyond the last block of the inode.
> + */
> +static int submit_range(struct btrfs_inode *inode, struct folio *folio,
> +			u64 start, u32 len, struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	const u32 sectorsize = fs_info->sectorsize;
> +	u64 cur = start;
> +
> +	ASSERT(IS_ALIGNED(start, sectorsize));
> +	ASSERT(IS_ALIGNED(len, sectorsize));
> +	ASSERT(start + len <= folio_end(folio));
> +
> +	while (cur < start + len) {
> +		struct extent_map *em;
> +		u64 block_start;
> +		u64 disk_bytenr;
> +		u64 extent_offset;
> +		u64 em_end;
> +		u32 cur_len = start + len - cur;
> +
> +		em = btrfs_get_extent(inode, NULL, cur, sectorsize);

why is sectorsize still relevant? Just a small size to grab an
overlapping em or something more meaningful?

> +		if (IS_ERR(em)) {
> +			/*
> +			 * bio_ctrl may contain a bio crossing several folios.
> +			 * Submit it immediately so that the bio has a chance
> +			 * to finish normally, other than marked as error.
> +			 */
> +			submit_one_bio(bio_ctrl);
> +
> +			/*
> +			 * When submission failed, we should still clear the folio dirty.
> +			 * Or the folio will be written back again but without any
> +			 * ordered extent.
> +			 */
> +			btrfs_folio_clear_dirty(fs_info, folio, cur, len);
> +			btrfs_folio_set_writeback(fs_info, folio, cur, len);
> +			btrfs_folio_clear_writeback(fs_info, folio, cur, len);

cur, cur_len? or start, len? cur, len feels wrong.

> +
> +			/*
> +			 * Since there is no bio submitted to finish the ordered
> +			 * extent, we have to manually finish this sector.
> +			 */
> +			btrfs_mark_ordered_io_finished(inode, folio, cur, len, false);

Same question about cur, len; also I don't know if the comment referring
to "this sector" still makes sense. Manually finish this ordered_extent
or something?

> +			return PTR_ERR(em);
> +		}
> +		extent_offset = cur - em->start;
> +		em_end = btrfs_extent_map_end(em);
> +		ASSERT(cur <= em_end);
> +		ASSERT(IS_ALIGNED(em->start, sectorsize));
> +		ASSERT(IS_ALIGNED(em->len, sectorsize));
> +
> +		block_start = btrfs_extent_map_block_start(em);
> +		disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
> +
> +		ASSERT(!btrfs_extent_map_is_compressed(em));
> +		ASSERT(block_start != EXTENT_MAP_HOLE);
> +		ASSERT(block_start != EXTENT_MAP_INLINE);
> +
> +		cur_len = min(cur_len, em_end - cur);
> +		btrfs_free_extent_map(em);
> +		em = NULL;
> +
> +		/*
> +		 * Although the PageDirty bit is cleared before entering this
> +		 * function, subpage dirty bit is not cleared.
> +		 * So clear subpage dirty bit here so next time we won't submit
> +		 * a folio for a range already written to disk.
> +		 */
> +		btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
> +		btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
> +		/*
> +		 * Above call should set the whole folio with writeback flag, even
> +		 * just for a single subpage block.
> +		 * As long as the folio is properly locked and the range is correct,
> +		 * we should always get the folio with writeback flag.
> +		 */
> +		ASSERT(folio_test_writeback(folio));
> +
> +		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
> +				    cur_len, cur - folio_pos(folio), 0);
> +		cur += cur_len;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Helper for extent_writepage().  This calls the writepage start hooks,
>   * and does the loop to map the page into extents and bios.
> @@ -1740,8 +1742,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  	const u64 folio_start = folio_pos(folio);
>  	const u64 folio_end = folio_start + folio_size(folio);
>  	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
> -	u64 cur;
> -	int bit;
> +	unsigned int start_bit;
> +	unsigned int end_bit;
> +	const u64 rounded_isize = round_up(i_size, fs_info->sectorsize);
>  	int ret = 0;
>  
>  	ASSERT(start >= folio_start, "start=%llu folio_start=%llu", start, folio_start);
> @@ -1769,14 +1772,27 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  
>  	bio_ctrl->end_io_func = end_bbio_data_write;
>  
> -	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
> -		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
> +	for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
> +		const u64 cur_start = folio_pos(folio) + (start_bit << fs_info->sectorsize_bits);
> +		u32 cur_len = (end_bit - start_bit) << fs_info->sectorsize_bits;
>  
> -		if (cur >= i_size) {
> -			finish_io_beyond_eof(inode, folio, cur, start + len - cur, i_size);
> -			break;
> +		if (cur_start > rounded_isize) {
> +			/*
> +			 * The whole range is byoned EOF.
sic: beyond
> +			 *
> +			 * Just finish the IO and skip to the next range.
> +			 */
> +			finish_io_beyond_eof(inode, folio, cur_start, cur_len, i_size);
> +			continue;
>  		}
> -		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
> +		if (cur_start + cur_len > rounded_isize) {
> +			/* The tailing part of the range is beyond EOF. */
> +			finish_io_beyond_eof(inode, folio, rounded_isize,
> +					     cur_start + cur_len - rounded_isize, i_size);
> +			/* Shrink the range inside the EOF. */
> +			cur_len = rounded_isize - cur_start;
> +		}
> +		ret = submit_range(inode, folio, cur_start, cur_len, bio_ctrl);
>  		if (unlikely(ret < 0)) {
>  			if (!found_error)
>  				found_error = ret;
> -- 
> 2.52.0
> 

