Return-Path: <linux-btrfs+bounces-2310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CEF850CCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 02:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00674B21408
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 01:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352661C16;
	Mon, 12 Feb 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJGNEpkS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368417D2
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707703161; cv=none; b=e3HoMdljj674nTer621fvoUDZcqE40LCzDFhTTK9pJZleh/gZ26AOIKVixUltYQSKGtgfktxt2XpGAnBr83khbBn9pKdGAQyVfR92MsGJ300bU/KjUnCXJOURPhE5JuOVpdBQRvem7uI67CipEPr9w+Pe70LDwz+8x7PX4eGQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707703161; c=relaxed/simple;
	bh=k30RgUftOEtjZ4ilUgy8F6q7Tdo873bh/HDTyQxTzEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bX+5MKbU6l70IYWcYfmKqMX5oVx3CmK862pr3IItTemLfGricDpavu7n6JnNMFr8NFNIJq3JCxjcHqey5vy8ibutU1/xkar5VNYPbFOsxMONoHUFgh90LWMqh/uPXTCk+3fpzlhNdKRQPWWcRzZ3dPoQ9zM6A4xlZsxwM0Zh80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJGNEpkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA1C433C7;
	Mon, 12 Feb 2024 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707703160;
	bh=k30RgUftOEtjZ4ilUgy8F6q7Tdo873bh/HDTyQxTzEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AJGNEpkSU4R2osrl1Y7r2ZbR2AzRBw6KYB2stSe4uf/oV81PmlxmEvflv6lMqGICX
	 I/mYBJEKjpJWIYjasy0MhJWuYjxLt9023EglDsnaBr13ZJWOCDp4y1cOjeMdhHh+DI
	 KI6kBtXzWceUlkZJJCDCPFoZmctcTCKkXYODAJfmUUiSnFesueu04xZAEtNNjIpRIy
	 +6UZbPbL7W1X8K0gdpzjO2e5OPqYIQ1LXqVNKClEpYf2eJJkDAy8vUsHAI1gaKqWH5
	 gfO3nmBIOcrEdVoo+GL4JRUUlYH95HOgKUDj3UnL8MW/rS87RgQY4Kn9CcGVIFK4Dg
	 DPFckuvywjg4Q==
Message-ID: <c34e93ef-8bc1-4e53-b009-0d8fc150e635@kernel.org>
Date: Mon, 12 Feb 2024 10:59:18 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
References: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/24 19:46, Johannes Thumshirn wrote:
> On a zoned filesystem with conventional zones, we're skipping the block
> group profile checks for the conventional zones.
> 
> This allows converting a zoned filesystem's data block groups to RAID when
> all of the zones backing the chunk are on conventional zones.  But this
> will lead to problems, once we're trying to allocate chunks backed by
> sequential zones.
> 
> So also check for conventional zones when loading a block group's profile
> on them.
> 
> Reported-by: 韩于惟 <hrx@bupt.moe>

Let's keep using the roman alphabet for names please...

Yuwei,

Not all kernel developers can read Chinese, so please sign your emails with your
name written in roman alphabet.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d9716456bce0..5beb6b936e61 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1369,8 +1369,10 @@ static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
>  		return -EIO;
>  	}
>  
> -	bg->alloc_offset = info->alloc_offset;
> -	bg->zone_capacity = info->capacity;
> +	if (info->alloc_offset != WP_CONVENTIONAL) {
> +		bg->alloc_offset = info->alloc_offset;
> +		bg->zone_capacity = info->capacity;
> +	}
>  	if (test_bit(0, active))
>  		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
>  	return 0;
> @@ -1406,6 +1408,16 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
>  		return -EIO;
>  	}
>  
> +	if (zone_info[0].alloc_offset == WP_CONVENTIONAL) {
> +		zone_info[0].alloc_offset = bg->alloc_offset;
> +		zone_info[0].capacity = bg->length;
> +	}
> +
> +	if (zone_info[1].alloc_offset == WP_CONVENTIONAL) {
> +		zone_info[1].alloc_offset = bg->alloc_offset;
> +		zone_info[1].capacity = bg->length;
> +	}
> +
>  	if (test_bit(0, active) != test_bit(1, active)) {
>  		if (!btrfs_zone_activate(bg))
>  			return -EIO;
> @@ -1458,6 +1470,9 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
>  						 zone_info[1].capacity);
>  	}
>  
> +	if (zone_info[0].alloc_offset == WP_CONVENTIONAL)
> +		zone_info[0].alloc_offset = bg->alloc_offset;
> +
>  	if (zone_info[0].alloc_offset != WP_MISSING_DEV)
>  		bg->alloc_offset = zone_info[0].alloc_offset;
>  	else
> @@ -1479,6 +1494,11 @@ static int btrfs_load_block_group_raid0(struct btrfs_block_group *bg,
>  		return -EINVAL;
>  	}
>  
> +	for (int i = 0; i < map->num_stripes; i++) {
> +		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
> +			zone_info[i].alloc_offset = bg->alloc_offset;
> +	}
> +
>  	for (int i = 0; i < map->num_stripes; i++) {
>  		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
>  		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
> @@ -1511,6 +1531,11 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
>  		return -EINVAL;
>  	}
>  
> +	for (int i = 0; i < map->num_stripes; i++) {
> +		if (zone_info[i].alloc_offset == WP_CONVENTIONAL)
> +			zone_info[i].alloc_offset = bg->alloc_offset;
> +	}
> +
>  	for (int i = 0; i < map->num_stripes; i++) {
>  		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
>  		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
> @@ -1605,7 +1630,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  		} else if (map->num_stripes == num_conventional) {
>  			cache->alloc_offset = last_alloc;
>  			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
> -			goto out;
>  		}
>  	}
>  

-- 
Damien Le Moal
Western Digital Research


