Return-Path: <linux-btrfs+bounces-10802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A5A06836
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821CF1617F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935ED20409A;
	Wed,  8 Jan 2025 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dY1/kJ9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiWjZ4VP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C2185B6D;
	Wed,  8 Jan 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375070; cv=none; b=iqZT4k31cosdTlFaXVMC3kZyzlx4dz9yxDUDJuaMrZxhglP1/RedR8LIc9SS+8OV8JQJ0D0SW5r1cTnnb1XJ0HIntXB6TglRWnzslZg/cgNItSjV230vG8rxLBvcN/hQ765fpB8a4cQBuajOvsVOYWRRXDAxQUGvvxbf9AH0fxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375070; c=relaxed/simple;
	bh=TGgr11J9CstRCOYVUqA2yctTqczUxPjiydd9bL5nq/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSvsBa62zRyOBRO5lpgjRxPp0IYn5mwziALfuZgdXRZAq6MrS+qvKAdyTchbRRX38D6kmpqgUvRar+15AjQPJMAmBW8QKBBCsLmr/zAT5kVKVgphnDdSSnZ8HOECmztOXOXCaFKQruHFCZu53AVORXIZEvX0ruFpmLCjBdGThgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dY1/kJ9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiWjZ4VP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68B4F25401E0;
	Wed,  8 Jan 2025 17:24:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 08 Jan 2025 17:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736375065; x=1736461465; bh=I2p08nY/mJ
	AlkvnGDxM4IBxFFgj5GcMkZDINNCSunsg=; b=dY1/kJ9V9yMaTvy64emqSm82hm
	SewvO+tYEOJVBfjxrjhbTAyVKRUtRtmmxyHdH7HavQJrt9Sc9bCN483z85DeIxfY
	kbMkGd/lYK+MG3Edp4RItx5fZ9iJ5e8bb+ExUtH+ozl5PDIf3zVuGnvgU0z9q/+y
	1lIsfWzKgI5V/z9i0WHPcEehWeBSqTqdElYSinxTgiIx4LElZKuf+jFYWz42makR
	JaHsjTtKghtzWNqK6rrs8Zm7spvRKZmr0C5r9fXV9uTmcNy98FCfWMia1gN5zwxQ
	ci0ig/r58OR2yz7r2jN5sU3LJv4PV/Chq32M81yS6MK8iW434Knu1zJOHPbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736375065; x=1736461465; bh=I2p08nY/mJAlkvnGDxM4IBxFFgj5GcMkZDI
	NNCSunsg=; b=AiWjZ4VPR92XkXAcCGmRZhZi6ELUa3Bwv1fgvn19esdYnp1iRle
	pBrMKSj6xqzwotVsH/gcYuKeOQEc3sUm1j2s/Va7/TDFqb070uOt+tosaHcsb//X
	Q5Ti1O9/KQjz7dO+H2ubUH9iIPoDNZ8ITgOK7GluVlximkQGyT2CIH79O/fnmmTN
	PhxpSv9xHfJkrZKBnLz5RjvsENXfraK7fntgBpdl6oVKjF8qHloJeiQm5iBbVPQT
	mUKbwPwJ5Tzy3abAAD3sqxuBif3OU21bVUIaJL/hkPBCKA1u42Zi1+vVcKacSWwE
	3q+dog4mJaX/6OjlYeugBJoiZxZE6os+5+A==
X-ME-Sender: <xms:Gft-Zw4QXTXvRnTNKPY3UfNGXXooDBOF08V0bT-gzkguDPM_YDg12w>
    <xme:Gft-Zx6G6o06lNjFEYPkVwf2gzcawYiLcgUkkzEgYnWQDwi4ERkb401-mOu_kFtpT
    VoIGo0AWaCOg1iV87U>
X-ME-Received: <xmr:Gft-Z_dmYsAw_1qUaFBDm3eRJhwPAJL0dMcjm1I5CTw8kBuDGor5tifiPvh_bTtKT3RmIc18ihQlCyvjZ8y4b14Qvzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gft-Z1It_7QqHemtk-byr6NvuYZnNEd3jySwqnoG8bteCoV5tt9jSg>
    <xmx:Gft-Z0K8OXP5gwTAfEBWenHVp_e84SbLJlFqW2vaABhq6zQIZLg39Q>
    <xmx:Gft-Z2wQdzi7TzCcft91qSxteOVZRLyfTX3uuO0NeJEfpl0_Lr0BSQ>
    <xmx:Gft-Z4KXoEHjU0X6DagUQfYu4Cf6pr2vJGCRFcWgy2TRGIkQcMFaIg>
    <xmx:Gft-Z42X0JNwr3HcmY6HJyq3lYGaU6zOon7n9-Jaa05vXJNHM0EwFDQI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:24:24 -0500 (EST)
Date: Wed, 8 Jan 2025 14:24:58 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/9] btrfs: fix double accounting race when
 extent_writepage_io() failed
Message-ID: <20250108222458.GB1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <51e0c5f464256c4a59a872077d560cb56b7509a2.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e0c5f464256c4a59a872077d560cb56b7509a2.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:43:56PM +1030, Qu Wenruo wrote:
> [BUG]
> If submit_one_sector() failed inside extent_writepage_io() for sector
> size < page size cases (e.g. 4K sector size and 64K page size), then
> we can hit double ordered extent accounting error.
> 
> This should be very rare, as submit_one_sector() only fails when we
> failed to grab the extent map, and such extent map should exist inside
> the memory and have been pinned.
> 
> [CAUSE]
> For example we have the following folio layout:
> 
>     0  4K          32K    48K   60K 64K
>     |//|           |//////|     |///|
> 
> Where |///| is the dirty range we need to writeback. The 3 different
> dirty ranges are submitted for regular COW.
> 
> Now we hit the following sequence:
> 
> - submit_one_sector() returned 0 for [0, 4K)
> 
> - submit_one_sector() returned 0 for [32K, 48K)
> 
> - submit_one_sector() returned error for [60K, 64K)
> 
> - btrfs_mark_ordered_io_finished() called for the whole folio
>   This will mark the following ranges as finished:
>   * [0, 4K)
>   * [32K, 48K)
>     Both ranges have their IO already submitted, this cleanup will
>     lead to double accounting.
> 
>   * [60K, 64K)
>     That's the correct cleanup.
> 
> The only good news is, this error is only theoretical, as the target
> extent map is always pinned, thus we should directly grab it from
> memory, other than reading it from the disk.
> 
> [FIX]
> Instead of calling btrfs_mark_ordered_io_finished() for the whole folio
> range, which can touch ranges we should not touch, instead
> move the error handling inside extent_writepage_io().
> 
> So that we can cleanup exact sectors that are ought to be submitted but
> failed.
> 
> This provide much more accurate cleanup, avoiding the double accounting.

Analysis and fix both make sense to me. However, this one feels a lot
more fragile than the other one.

It relies on submit_one_sector being the only error path in
extent_writepage_io. Any future error in the loop would have to create a
shared "per sector" error handling goto in the loop I guess?

Not a hard "no", in the sense that I think the code is correct for now
(aside from my submit_one_bio question) but curious if we can give this
some more principled structure.

Thanks,
Boris

> 
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 417c710c55ca..b6a4f1765b4c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1418,6 +1418,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	unsigned long range_bitmap = 0;
>  	bool submitted_io = false;
> +	bool error = false;
>  	const u64 folio_start = folio_pos(folio);
>  	u64 cur;
>  	int bit;
> @@ -1460,11 +1461,21 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  			break;
>  		}
>  		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
> -		if (ret < 0)
> -			goto out;
> +		if (unlikely(ret < 0)) {
> +			submit_one_bio(bio_ctrl);

This submit_one_bio is confusing to me. submit_one_sector failed and the
subsequent comment says "there is no bio submitted" yet right here we
call submit_one_bio.

What is the meaning of it?

> +			/*
> +			 * Failed to grab the extent map which should be very rare.
> +			 * Since there is no bio submitted to finish the ordered
> +			 * extent, we have to manually finish this sector.
> +			 */
> +			btrfs_mark_ordered_io_finished(inode, folio, cur,
> +					fs_info->sectorsize, false);
> +			error = true;
> +			continue;
> +		}
>  		submitted_io = true;
>  	}
> -out:
> +
>  	/*
>  	 * If we didn't submitted any sector (>= i_size), folio dirty get
>  	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
> @@ -1472,8 +1483,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  	 *
>  	 * Here we set writeback and clear for the range. If the full folio
>  	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
> +	 *
> +	 * If we hit any error, the corresponding sector will still be dirty
> +	 * thus no need to clear PAGECACHE_TAG_DIRTY.
>  	 */

submitted_io is only used for this bit of logic, so you could consider
changing this logic by keeping a single variable for whether or not we
should go into this logic (naming it seems kind of annoying) and then
setting it in both the error and submitted_io paths. I think that
reduces headache in thinking about boolean logic, slightly.

> -	if (!submitted_io) {
> +	if (!submitted_io && !error) {
>  		btrfs_folio_set_writeback(fs_info, folio, start, len);
>  		btrfs_folio_clear_writeback(fs_info, folio, start, len);
>  	}
> @@ -1493,7 +1507,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  {
>  	struct inode *inode = folio->mapping->host;
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> -	const u64 page_start = folio_pos(folio);
>  	int ret;
>  	size_t pg_offset;
>  	loff_t i_size = i_size_read(inode);
> @@ -1536,10 +1549,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  
>  	bio_ctrl->wbc->nr_to_write--;
>  
> -	if (ret)
> -		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> -					       page_start, PAGE_SIZE, !ret);
> -
>  done:
>  	if (ret < 0)
>  		mapping_set_error(folio->mapping, ret);
> @@ -2319,11 +2328,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  		if (ret == 1)
>  			goto next_page;
>  
> -		if (ret) {
> -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
> -						       cur, cur_len, !ret);
> +		if (ret)
>  			mapping_set_error(mapping, ret);
> -		}
>  		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
>  		if (ret < 0)
>  			found_error = true;
> -- 
> 2.47.1
> 

