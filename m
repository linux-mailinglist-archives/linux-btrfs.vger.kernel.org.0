Return-Path: <linux-btrfs+bounces-15650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D5CB0FDD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 01:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758BD7B4E73
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 23:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFE2737E4;
	Wed, 23 Jul 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mshd8uDy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD97282F5
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315007; cv=none; b=rEuVZvrIPF8TSzv0vCfYvR+rQVErj/PZXtwR0lYs0gogZYJXUkNWHgybWxCjimj2nVv4ErvXJC0MvsaDFTuJ9OFrDj613dne+XEQuWMzVmb284oDA5aaI1Diqe6bsFCHn07TOotuv9ZKRHP12d8RqooNO76yKld5ThZXg2l6Wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315007; c=relaxed/simple;
	bh=o0GmTqqYfM01Bfcnm0gGuziSrgvtOhLMlZzr3BHaWeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ4pxoK74OjrHfY7KmDogqqKec6qqA5jI+XhdyVBCzecdpWuLpgXXej9Pt3YVgPSx0CncgmgcgWlXFEXSJLh8mYhUBj5DagVN1OrICzozeB437VAH8pbczNS8E0w3rsI34LqGJ2Q8fG7Xb19eMez6yB0DZINU6cGhoyM97N8Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mshd8uDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDE8C4CEE7;
	Wed, 23 Jul 2025 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315007;
	bh=o0GmTqqYfM01Bfcnm0gGuziSrgvtOhLMlZzr3BHaWeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mshd8uDyAZ6WZ7vfCWD4iY9/xRyLuOhBBJTtMrWY4h4thWU8khmRmBULSI6X5J0GF
	 EMehKwcvNzmgsst3Y1FIQ5cRc4WKjWhv/iLLyAq6FeNxyKdvo/mDwtcIzco2zMYShE
	 EN6+CAX59Tj/PAZuy2tH/6B39RMLLa2m6iM7mPqV1ALhpj2YWmFwBOdS1u2J41mIBm
	 5sG5Or8cZlp5UBDLKNn+ga5X+3Nj+Ll4H/R3ci6ZtwcPzsvbHMsucbyF189j+u5Fi4
	 805/yGYa1V0TTFs4X28mEudru8qjclkk5CjE1f/4Xs/p/GpxKOr+87QOZp/FUMBFlR
	 80atYIlK7PCmw==
Message-ID: <3786245c-60d5-4567-a505-3c05ba8610f6@kernel.org>
Date: Thu, 24 Jul 2025 08:56:43 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250723133810.48179-1-jth@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250723133810.48179-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 22:38, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't call ZONE FINISH for conventional zones as this will result in I/O
> errors. Instead check if the zone that needs finishing is a conventional
> zone and if yes skip it.
> 
> Also factor out the actual handling of finishing a single zone into a
> helper function, as do_zone_finish() is growing ever bigger and the
> indentations levels are getting higher.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> This is a preparation patch for Naohiro's patch titled:
> "btrfs: zoned: limit active zones to max_open_zones"
> which can be found at:
> https://lore.kernel.org/linux-btrfs/47f7423f53492e0ee1cd40f204db8354efb8d6b1.1752652539.git.naohiro.aota@wdc.com
> ---
>  fs/btrfs/zoned.c | 55 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index eeb049994cfe..ddacdb75d45c 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2257,6 +2257,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
>  	rcu_read_unlock();
>  }
>  
> +static int call_zone_finish(struct btrfs_block_group *block_group,
> +			    struct btrfs_io_stripe *stripe)
> +{
> +	struct btrfs_device *device = stripe->dev;
> +	const u64 physical = stripe->physical;
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	int ret;
> +
> +	if (!device->bdev)
> +		return 0;
> +
> +	if (zinfo->max_active_zones == 0)
> +		return 0;

Should these 2 returns be replaced with a "goto out;"...

> +
> +	if (btrfs_dev_is_sequential(device, physical)) {
> +		unsigned int nofs_flags;
> +
> +		nofs_flags = memalloc_nofs_save();
> +		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> +				       physical >> SECTOR_SHIFT,
> +				       zinfo->zone_size >> SECTOR_SHIFT);
> +		memalloc_nofs_restore(nofs_flags);
> +
> +		if (ret)
> +			return ret;
> +	}
> +

With "out:" label here ?

That was not done before, but I wonder if that is needed.

> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> +		zinfo->reserved_active_zones++;
> +	btrfs_dev_clear_active_zone(device, physical);
> +
> +	return 0;
> +}
> +
>  static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
>  {
>  	struct btrfs_fs_info *fs_info = block_group->fs_info;
> @@ -2341,31 +2375,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
>  	down_read(&dev_replace->rwsem);
>  	map = block_group->physical_map;
>  	for (i = 0; i < map->num_stripes; i++) {
> -		struct btrfs_device *device = map->stripes[i].dev;
> -		const u64 physical = map->stripes[i].physical;
> -		struct btrfs_zoned_device_info *zinfo = device->zone_info;
> -		unsigned int nofs_flags;
> -
> -		if (!device->bdev)
> -			continue;
> -
> -		if (zinfo->max_active_zones == 0)
> -			continue;
> -
> -		nofs_flags = memalloc_nofs_save();
> -		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
> -				       physical >> SECTOR_SHIFT,
> -				       zinfo->zone_size >> SECTOR_SHIFT);
> -		memalloc_nofs_restore(nofs_flags);
>  
> +		ret = call_zone_finish(block_group, &map->stripes[i]);
>  		if (ret) {
>  			up_read(&dev_replace->rwsem);
>  			return ret;
>  		}
> -
> -		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
> -			zinfo->reserved_active_zones++;
> -		btrfs_dev_clear_active_zone(device, physical);
>  	}
>  	up_read(&dev_replace->rwsem);
>  


-- 
Damien Le Moal
Western Digital Research

