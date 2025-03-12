Return-Path: <linux-btrfs+bounces-12214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946FA5D41C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 02:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860AC7A2FCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F313C816;
	Wed, 12 Mar 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5IGq6aF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63871A31;
	Wed, 12 Mar 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743588; cv=none; b=TTBo3CF0erAPBZyUQ6LqiVjSavo5L1nshCwW/73oPKLJRWrryIJpuS1NuUxAWCBkxI4HUn8VWee7TCZSLcA12+3y8nAS0q0koc6Llb8P/ngKN9Mn368UvVbui4ymiLDX30V4zvN+25hW9IR+1yX76Yz8wvcclhY1nsAfkJ3Fs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743588; c=relaxed/simple;
	bh=by8JKjIxnoQJiog3CV/peupJDQCR+8+cEKNT1kztQqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWGMy+uu0Edgl35lD1yL2PN/9UVKUSy59VhfFMYAbwa1rUwvrPlK+isl6yahE2VOGQXasg6n2QhOkP4hlT8SzfUmjYKYJd/Aj/pPEcv8EwssSYXaOe2IJOBUOuSLn5G8VZhlOTAAbDjewa4GUXPWjPneQoz2CBetBP5mKaeF55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5IGq6aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D1C4CEE9;
	Wed, 12 Mar 2025 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741743587;
	bh=by8JKjIxnoQJiog3CV/peupJDQCR+8+cEKNT1kztQqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u5IGq6aFDy/uwSOKxTWTGGz/7dCGk/hNUeYoZ5dhP1cr5dccm2+Qpn3UHP0RMDiCB
	 9WAN5b4kB1bSsPKASq8sVp0eRZ+SonRyqNObImjKvCCc/SMv7cMVakf3S7nt3UjhVa
	 /0enT0wQbUigDE+VD2XpV7AE+CAUxtNsFjSzgmciKeFfg2DleaOVu9gSHkp18xsLmR
	 KHKTSOg3fbcQvvbt/bh+I/w9n6O5E32eHLtlu4YJsa4wTaXCZsF8dkHP0TmHHvLRzV
	 ww2e3q/WpahtWrKj8W2CFmYXgjbQHFnMq9Y2BDI1g7Brv0jjFp7ZSO+do/WqI2zedj
	 nFDo0wBWPDOxg==
Message-ID: <da0d31a0-f2af-4aa8-ba9b-ce73bc010325@kernel.org>
Date: Wed, 12 Mar 2025 10:39:46 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: introduce zone capacity helper
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <335b0d7cd8c0e7492332273a330807a8130e213e.1741596325.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 10:31, Naohiro Aota wrote:
> {bdev,disk}_zone_capacity() takes block_device or gendisk and sector position
> and returns the zone capacity of the corresponding zone.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  include/linux/blkdev.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d37751789bf5..3c860a0cf339 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -826,6 +826,27 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
>  		(sb->s_blocksize_bits - SECTOR_SHIFT);
>  }
>  
> +#ifdef CONFIG_BLK_DEV_ZONED

There is already an "#ifdef CONFIG_BLK_DEV_ZONED" in blkdev.h, see
disk_nr_zones(). Please add this new helper under that ifdef to avoid adding a
new one.

> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)
> +{
> +	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
> +
> +	if (pos + zone_sectors >= get_capacity(disk))
> +		return disk->last_zone_capacity;
> +	return disk->zone_capacity;
> +}
> +#else /* CONFIG_BLK_DEV_ZONED */
> +static inline unsigned int disk_zone_capacity(struct gendisk *disk, sector_t pos)

Is this ever called for a non zoned drive ? It should not be... So do we really
need this stub ?

> +{
> +	return 0;
> +}
> +#endif /* CONFIG_BLK_DEV_ZONED */
> +
> +static inline unsigned int bdev_zone_capacity(struct block_device *bdev, sector_t pos)
> +{
> +	return disk_zone_capacity(bdev->bd_disk, pos);
> +}
> +
>  int bdev_disk_changed(struct gendisk *disk, bool invalidate);
>  
>  void put_disk(struct gendisk *disk);


-- 
Damien Le Moal
Western Digital Research

