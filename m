Return-Path: <linux-btrfs+bounces-9287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E59B8AAF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260C72810E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2914A4C6;
	Fri,  1 Nov 2024 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C52yBy85"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558228FC;
	Fri,  1 Nov 2024 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439452; cv=none; b=n86MTTtHVsd0mrURzZdPCtBr6efkj5/oPSTHEfXu8rLogXvoITf+VeSpKamt90VZqTnVXLdCu//imixlijO/n+dhb8UGNjfyZYX2rkicXQwWauHzbiUvQz3GheDq6FaFyUhdFQWbV7Ecn9itk7WHUY2x9ceIJ8P22kTv4K5JV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439452; c=relaxed/simple;
	bh=njLyUb9nfUKECfH1fzjo9qlzOs3JFHMTWiAj3ELMd+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY0MeK+6nvjvYh7cuv3bGce2HYdFMoBEWWXpTR+DyTkq0KqoEOprIzHUX6CAqrZIjiHYYIr0Fw6gKc/xNOwqnZjw7K7lqNPSLRnz4banKxbDPVlpAy0SEpSb0STfqO+6f0sw0azqUdwVBaq+yuIBUhd8gLtHKqJxxHZjSuVXniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C52yBy85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B28C4CECD;
	Fri,  1 Nov 2024 05:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730439451;
	bh=njLyUb9nfUKECfH1fzjo9qlzOs3JFHMTWiAj3ELMd+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C52yBy850frLlOn0ZmnTrU39ftCJOmWhorzPZ7fmjJzAPfHvF8vGp4LLl7t2eHRim
	 +12zaw0528zBteDTUN7LDDa2EkXwposLQm1dqmFDcRK+nQe2ce02gzTwbfEeCyCwVc
	 dZ/o12uR4df30IPfENGDk59sSNIVtb3uByAnh31R//IZRGZ82zahLSsjSEqXhKHx3V
	 SY3qgIlggB0z2CFtSKUmXWZPoDsQAvsuRNkkJU0usibrGgdy0zJQG6IW3v2Z7pfY7r
	 gWFcx9sq8f27rR1AZkUXYDN1XKeSnooEn6pBWk5SMWV/UpvCUGUWLhZLbCwU+YLHr3
	 SCNgMhAjnw3CQ==
Message-ID: <f376f179-0173-49b4-b4c6-0cabb8720dfd@kernel.org>
Date: Fri, 1 Nov 2024 14:37:29 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: lift bio_is_zone_append to bio.h
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241101052206.437530-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 14:21, Christoph Hellwig wrote:
> Make bio_is_zone_append globally available, because file systems need
> to use to check for a zone append bio in their end_io handlers to deal
> with the block layer emulation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good (one nit below).

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  block/blk.h         |  9 ---------
>  include/linux/bio.h | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 63d5df0dc29c..6060e1e180a3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -457,11 +457,6 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
>  {
>  	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
>  }
> -static inline bool bio_is_zone_append(struct bio *bio)
> -{
> -	return bio_op(bio) == REQ_OP_ZONE_APPEND ||
> -		bio_flagged(bio, BIO_EMULATES_ZONE_APPEND);
> -}
>  void blk_zone_write_plug_bio_merged(struct bio *bio);
>  void blk_zone_write_plug_init_request(struct request *rq);
>  static inline void blk_zone_update_request_bio(struct request *rq,
> @@ -510,10 +505,6 @@ static inline bool bio_zone_write_plugging(struct bio *bio)
>  {
>  	return false;
>  }
> -static inline bool bio_is_zone_append(struct bio *bio)
> -{
> -	return false;
> -}
>  static inline void blk_zone_write_plug_bio_merged(struct bio *bio)
>  {
>  }
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 4a1bf43ca53d..60830a6a5939 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -675,6 +675,23 @@ static inline void bio_clear_polled(struct bio *bio)
>  	bio->bi_opf &= ~REQ_POLLED;
>  }
>  
> +/**
> + * bio_is_zone_append - is this a zone append bio?
> + * @bio:	bio to check
> + *
> + * Check if @bio is a zone append operation.  Core block layer code and end_io
> + * handlers must use this instead of an open coded REQ_OP_ZONE_APPEND check
> + * because the block layer can rewrite REQ_OP_ZONE_APPEND to REQ_OP_WRITE if
> + * it is not natively supported.
> + */
> +static inline bool bio_is_zone_append(struct bio *bio)
> +{
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		return false;

Nit: this "if" is probably not needed. But it does not hurt either. Since we
should never be seeing this function being called for the
!IS_ENABLED(CONFIG_BLK_DEV_ZONED) case, should we add a WARN_ON_ONCE() ?

> +	return bio_op(bio) == REQ_OP_ZONE_APPEND ||
> +		bio_flagged(bio, BIO_EMULATES_ZONE_APPEND);
> +}
> +
>  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
>  		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp);
>  struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new);


-- 
Damien Le Moal
Western Digital Research

