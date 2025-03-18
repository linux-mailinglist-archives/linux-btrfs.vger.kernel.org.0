Return-Path: <linux-btrfs+bounces-12352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C19A6691B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696873ABE86
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B413D1D90A5;
	Tue, 18 Mar 2025 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG0+WEYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E311C701E;
	Tue, 18 Mar 2025 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274901; cv=none; b=OTTeuLkxJjZryQOdt1btzmqQ4Wh0A3onCYwNG+wFpuQZkff0vcTy5eb/AJ46gTSHDMyhL2c1JQGLrx2CBeIu0a3OSAyIAe3qjTH8hjhMn4y1c+/BRG0mz3HixMeMZe8GyUaJwTxNvLx5Ll2qLWerFEUH0pGo+foytriZ+b2rTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274901; c=relaxed/simple;
	bh=5ceMNbFl7plji2NtlkqWSlEhVl7K/757geJ+59hocFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwBfshzFh9qJPUD+ssXqHDSphAFIbKuKle5TaOKGwI1SO7C0/qL+IDjhKTPxzR3S88ViUrk1G9UTo00SvF2ua+AjUuDdOg5y7SeK4F8fJVygea8cMymH9+pfTrLb0EcsKunsdzhWvD/TSNiU934Q9MQGBX7W3LYP3SbJMdyvS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG0+WEYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5FDC4CEDD;
	Tue, 18 Mar 2025 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742274900;
	bh=5ceMNbFl7plji2NtlkqWSlEhVl7K/757geJ+59hocFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FG0+WEYa5h9ogAhz6P7Vr8DbRhmV6u0NuxB0ZHdea49Z3+rk3hIinb6kTZ+j5LSLl
	 qxdyAezWVIYB+4K/jDXu331j+B6dIEeGyheu5imISU8q9re8/P0hOgwTjGzVIseG6y
	 4AtMZ4HrNJX7SXYUhDqa0dPVUgOPiGrbptp4KYj/2D8XVD0gVj2yhBYL8zI/9r/91d
	 sZjuRg0/icQvS7GHdOO3AZ/PaUn5T+zi5a9EqQjaaoBMe8oYT9CdacrRjbaVE8MOTU
	 64ak9UWfidpgPuTx3RcXIAMgC//2gXmNUiUFZm8nvGzwnjNi0j1WBgHQYqHcj/fx3Q
	 Xqs45BXpMy9xQ==
Message-ID: <2a641d02-1d59-4e0b-9dcc-defb64548d1b@kernel.org>
Date: Tue, 18 Mar 2025 14:14:29 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: introduce zone capacity helper
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 9:59 AM, Naohiro Aota wrote:
> {bdev,disk}_zone_capacity() takes block_device or gendisk and sector position
> and returns the zone capacity of the corresponding zone.
> 
> With that, move disk_nr_zones() and blk_zone_plug_bio() to consolidate them in
> the same #ifdef block.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  include/linux/blkdev.h | 67 ++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d37751789bf5..6f1bdec27ac7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -691,23 +691,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  		(q->limits.features & BLK_FEAT_ZONED);
>  }
>  
> -#ifdef CONFIG_BLK_DEV_ZONED
> -static inline unsigned int disk_nr_zones(struct gendisk *disk)
> -{
> -	return disk->nr_zones;
> -}
> -bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
> -#else /* CONFIG_BLK_DEV_ZONED */
> -static inline unsigned int disk_nr_zones(struct gendisk *disk)
> -{
> -	return 0;
> -}
> -static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_BLK_DEV_ZONED */
> -
>  static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  {
>  	if (!blk_queue_is_zoned(disk->queue))
> @@ -715,11 +698,6 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  	return sector >> ilog2(disk->queue->limits.chunk_sectors);
>  }
>  
> -static inline unsigned int bdev_nr_zones(struct block_device *bdev)
> -{
> -	return disk_nr_zones(bdev->bd_disk);
> -}
> -
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	return bdev->bd_disk->queue->limits.max_open_zones;
> @@ -826,6 +804,51 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
>  		(sb->s_blocksize_bits - SECTOR_SHIFT);
>  }
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static inline unsigned int disk_nr_zones(struct gendisk *disk)
> +{
> +	return disk->nr_zones;
> +}
> +bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
> +
> +/**
> + * disk_zone_capacity - returns the zone capacity of zone at @pos

@pos is not the start of the zone, so this should be:

 * disk_zone_capacity - returns the capacity of the zone containing @sect

And rename pos to sect.

With that, this looks good to me, so feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

