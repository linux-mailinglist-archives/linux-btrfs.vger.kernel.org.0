Return-Path: <linux-btrfs+bounces-7527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5380295FCD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D1284FFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997319D09C;
	Mon, 26 Aug 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZJt7+lD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAA19AA4E;
	Mon, 26 Aug 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711572; cv=none; b=ZDW2BfbSZXvHEZX8OGXWEkpkmDnb5eqqbONmximSPUiFg/o8lsb7VcAB8evcbHf5SzStyx63KwpWTDtzmoSnl/b6eHxmxOA0qpXvQb4Uq/4D8VJKw4dJWsuVfG3DFWBzHm1SwbS6lzyt0FjGZ0XvFF8qoV28b2HTBpm2btwCbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711572; c=relaxed/simple;
	bh=jwCZkZXF7jip/sriVYHS1Ts6Jp8GytCEr7FVxEzWWYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz9UDbzr5x9DWHg8B/R7hUka75ApD+0rpKdBP5r50KmYahkyBAZtrNB8T3F/B85q/519CTBGTqt3cRfCkLjjng7kxmZ3l8lMemaf4uUgrTCul90aJHVmbsyoJJvf+5wuomrulHgkHA3xu8/CgDMGFolcBbs0nk6Uxw7EDX4DQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZJt7+lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E2C8B7A0;
	Mon, 26 Aug 2024 22:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711572;
	bh=jwCZkZXF7jip/sriVYHS1Ts6Jp8GytCEr7FVxEzWWYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BZJt7+lDXoRNki7xYs28pktGnogKljnu7rcaN/h6iIsjPgq6dAyRIUhwnu1sFp1EZ
	 4MoOR96KjMvD+xh92IaiXpjmlZhQi1pZdfQTZ5W36zuf6KnguThMIBV0C/1WX9YxJz
	 0qLr2hIoMa5MCfCf+UX4KmsBAHgKZhzXBHdNg49DIP42AtCfQv5EszceSJra+20C9a
	 RuTjZ8IuvL577MWJ3kF5xchPH8ne4+fCQkacz/Q5AvVzi1fGXpVFAW1lOgwapfBWxb
	 5NCJ5yHDaObCyA87uja3nz4v1Scdk+VkQyVr1iFasoC2vSZNlY/MdnVk5oLJQnoGvh
	 Va2qLYZXwvtDg==
Message-ID: <40a53055-cb28-4211-bb72-b813bc983107@kernel.org>
Date: Tue, 27 Aug 2024 07:32:50 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block: properly handle REQ_OP_ZONE_APPEND in
 __bio_split_to_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826173820.1690925-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 02:37, Christoph Hellwig wrote:
> Currently REQ_OP_ZONE_APPEND is handled by the bio_split_rw case in
> __bio_split_to_limits.  This is harmful because REQ_OP_ZONE_APPEND
> bios do not adhere to the soft max_limits value but instead use their
> own capped version of max_hw_sectors, leading to incorrect splits that
> later blow up in bio_split.
> 
> We still need the bio_split_rw logic to count nr_segs for blk-mq code,
> so add a new wrapper that passes in the right limit, and turns any bio
> that would need a split into an error as an additional debugging aid.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 20 ++++++++++++++++++++
>  block/blk.h       |  4 ++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index c7222c4685e060..56769c4bcd799b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -378,6 +378,26 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  			get_max_io_size(bio, lim) << SECTOR_SHIFT));
>  }
>  
> +/*
> + * REQ_OP_ZONE_APPEND bios must never be split by the block layer.
> + *
> + * But we want the nr_segs calculation provided by bio_split_rw_at, and having
> + * a good sanity check that the submitter built the bio correctly is nice to
> + * have as well.
> + */
> +struct bio *bio_split_zone_append(struct bio *bio,
> +		const struct queue_limits *lim, unsigned *nr_segs)
> +{
> +	unsigned int max_sectors = queue_limits_max_zone_append_sectors(lim);
> +	int split_sectors;
> +
> +	split_sectors = bio_split_rw_at(bio, lim, nr_segs,
> +			max_sectors << SECTOR_SHIFT);
> +	if (WARN_ON_ONCE(split_sectors > 0))
> +		split_sectors = -EINVAL;

ah! OK, I see why you used an int for the sector count now.
Hmmm... This is subtle and I am not a huge fan. But I see how that saves some
cleanup code in patch 1. So OK.

Feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	return bio_submit_split(bio, split_sectors);
> +}
> +
>  /**
>   * bio_split_to_limits - split a bio to fit the queue limits
>   * @bio:     bio to be split
> diff --git a/block/blk.h b/block/blk.h
> index 0d8cd64c126064..61c2afa67daabb 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -337,6 +337,8 @@ struct bio *bio_split_write_zeroes(struct bio *bio,
>  		const struct queue_limits *lim, unsigned *nsegs);
>  struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
>  		unsigned *nr_segs);
> +struct bio *bio_split_zone_append(struct bio *bio,
> +		const struct queue_limits *lim, unsigned *nr_segs);
>  
>  /*
>   * All drivers must accept single-segments bios that are smaller than PAGE_SIZE.
> @@ -375,6 +377,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>  			return bio_split_rw(bio, lim, nr_segs);
>  		*nr_segs = 1;
>  		return bio;
> +	case REQ_OP_ZONE_APPEND:
> +		return bio_split_zone_append(bio, lim, nr_segs);
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  		return bio_split_discard(bio, lim, nr_segs);

-- 
Damien Le Moal
Western Digital Research


