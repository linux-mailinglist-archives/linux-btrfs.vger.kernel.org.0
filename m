Return-Path: <linux-btrfs+bounces-7525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0895FCB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06FB283946
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47F19D889;
	Mon, 26 Aug 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFqS4BRu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DB19CD0B;
	Mon, 26 Aug 2024 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711202; cv=none; b=Em8yfB4Kw/KDapDntQrEqKHdtin8lZGazB1hqakjhOlF/hF/JBSIQGsZ60dEjWq+BVOVoWSmoUEJAIEXaBfAx5HOkHF4Bwg38PZUs6jxuepv8ns7NzIVwXRrLeMpPKXq9/G9sRZJwYoTffFLfHbLejNh2yHe7V/URqWw2RaKnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711202; c=relaxed/simple;
	bh=KwBCfyZaZuyDUkAcCoSKlhfLqiDJ5jWH6q2Uh9v9JFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCGpK//CcExlS4bpSyZL4hC126aStmxbVeVKOn209tnRe8tm0x9lQ4feVe5yca0xIGQpDz/oELDpI9DL2+J8rRDW6CbjU/al336W7rEdy2bbVXvZYVxDXxtk2fP00kaJe0oz98q3Q/Xt3jPvNS3BMAik5eAyewtkSDohUFEzdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFqS4BRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A9C8B7A7;
	Mon, 26 Aug 2024 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711202;
	bh=KwBCfyZaZuyDUkAcCoSKlhfLqiDJ5jWH6q2Uh9v9JFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fFqS4BRuqwdX7OAl41SNWBsrZfmUtUZqVUi82R+s+NZPR6i5Q+C+p0CTGhxAbGcTI
	 jGXzk73lAYs+Aee0v0rpZ8CQNaD3ceRyOGgKc4eBzIbrC1bikcfU9Fn6WQDfj665yV
	 f7cBn2UmKHSWtvgOiSbmIXnGWQ8Dy435MqcWCd2xERnr9y8tr2+JYgMVy6/r3tMO63
	 TC9B5a2qT/+06Z5GZ4u/cqr1cGYRhHv9HZXGyqVIwrA8/KKzStCxXxFwh4/oJZpkK5
	 NdJ107aqEQALTiWNXBwxN2iy2PLNtwKiRGGFntImYHcaoJXlWsX33t3Yh47vkYFUWL
	 U9VpYBaXQnOng==
Message-ID: <e59de073-c608-4206-8f98-9f46b1750931@kernel.org>
Date: Tue, 27 Aug 2024 07:26:40 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: rework bio splitting
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826173820.1690925-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 02:37, Christoph Hellwig wrote:
> The current setup with bio_may_exceed_limit and __bio_split_to_limits
> is a bit of a mess.
> 
> Change it so that __bio_split_to_limits does all the work and is just
> a variant of bio_split_to_limits that returns nr_segs.  This is done
> by inlining it and instead have the various bio_split_* helpers directly
> submit the potentially split bios.
> 
> To support btrfs, the rw version has a lower level helper split out
> that just returns the offset to split.  This turns out to nicely clean
> up the btrfs flow as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c   | 146 +++++++++++++++++---------------------------
>  block/blk-mq.c      |  11 ++--
>  block/blk.h         |  63 +++++++++++++------
>  fs/btrfs/bio.c      |  30 +++++----
>  include/linux/bio.h |   4 +-
>  5 files changed, 125 insertions(+), 129 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index de5281bcadc538..c7222c4685e060 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -105,9 +105,33 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
>  	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
>  }
>  
> -static struct bio *bio_split_discard(struct bio *bio,
> -				     const struct queue_limits *lim,
> -				     unsigned *nsegs, struct bio_set *bs)
> +static struct bio *bio_submit_split(struct bio *bio, int split_sectors)

Why not "unsigned int" for split_sectors ? That would avoid the need for the
first "if" of the function. Note that bio_split() also takes an int for the
sector count and also checks for < 0 count with a BUG_ON(). We can clean that up
too. BIOs sector count is unsigned int...

> +{
> +	if (unlikely(split_sectors < 0)) {
> +		bio->bi_status = errno_to_blk_status(split_sectors);
> +		bio_endio(bio);
> +		return NULL;
> +	}
> +
> +	if (split_sectors) {

May be the simple case should come first ? E.g.:

	if (!split_sectors)
		return bio;

But shouldn't this check be:

	if (split_sectors >= bio_sectors(bio))
		return bio;

?

[...]

> +/**
> + * __bio_split_to_limits - split a bio to fit the queue limits
> + * @bio:     bio to be split
> + * @lim:     queue limits to split based on
> + * @nr_segs: returns the number of segments in the returned bio
> + *
> + * Check if @bio needs splitting based on the queue limits, and if so split off
> + * a bio fitting the limits from the beginning of @bio and return it.  @bio is
> + * shortened to the remainder and re-submitted.
> + *
> + * The split bio is allocated from @q->bio_split, which is provided by the
> + * block layer.
> + */
> +static inline struct bio *__bio_split_to_limits(struct bio *bio,
> +		const struct queue_limits *lim, unsigned int *nr_segs)
>  {
>  	switch (bio_op(bio)) {
> +	default:
> +		if (bio_may_need_split(bio, lim))
> +			return bio_split_rw(bio, lim, nr_segs);
> +		*nr_segs = 1;
> +		return bio;

Wouldn't it be safer to move the if check inside bio_split_rw(), so that here we
can have:

		return bio_split_rw(bio, lim, nr_segs);

And at the top of bio_split_rw() add:

	if (!bio_may_need_split(bio, lim)) {
		*nr_segs = 1;
		return bio;
	}

so that bio_split_rw() always does the right thing ?

>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> +		return bio_split_discard(bio, lim, nr_segs);
>  	case REQ_OP_WRITE_ZEROES:
> -		return true; /* non-trivial splitting decisions */
> -	default:
> -		break;
> +		return bio_split_write_zeroes(bio, lim, nr_segs);
>  	}
> -
> -	/*
> -	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
> -	 * This is a quick and dirty check that relies on the fact that
> -	 * bi_io_vec[0] is always valid if a bio has data.  The check might
> -	 * lead to occasional false negatives when bios are cloned, but compared
> -	 * to the performance impact of cloned bios themselves the loop below
> -	 * doesn't matter anyway.
> -	 */
> -	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
>  }

-- 
Damien Le Moal
Western Digital Research


