Return-Path: <linux-btrfs+bounces-15278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277F9AFAA54
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 05:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220C17A2C90
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887725A2BF;
	Mon,  7 Jul 2025 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCmLPdUs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87B17D7
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859785; cv=none; b=grEmgU7NoiVuPtpqAO1UWmYIq8OL4kjKrRph2ouP08xnOCslSvmwJHTeV6xp9GnaUW0m5ioJ9q/168xxlixcsPbxlWjq8sPPsuZ9iSbvh5U88z4ZoaUv+f332+S1C1iXERjUVB3FPU40G2NZG8wqQ8UtbC6V2GX/v7UwDa42Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859785; c=relaxed/simple;
	bh=wdTqDLG1BgxS4BLFQuPK54piIxLNad6Fj6vEtMSisHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DsGI+D6Ar0bRSgyQiDEUPtyfXm8iX4nAhSTrjsmD2W86PtbYCCOXCcz2SyvFOnsyoL5dT7u2WoxqirPcO+K49fLvbHIWil6ir6XzA99HgHz6Tv5emTpQSPSswIrREEv69re6N0HQ/CuUVGEkV31nusgXxwkOMZ7ekWyeeDujLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCmLPdUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D022C4CEE3;
	Mon,  7 Jul 2025 03:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751859784;
	bh=wdTqDLG1BgxS4BLFQuPK54piIxLNad6Fj6vEtMSisHw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=MCmLPdUsraad3HKHb6FQatsR8MqoayQs7c9ccWXJS5tuPw1N21bgorlJR+3Fp87R9
	 neSQZae9jSwitRNibe/lZso1t5+zme2cCzsxGnFuud0aEil6z8BJ8eq7eNVQjNYs5W
	 3oLQWIFIjFtrhiRwfzrqV1tEmeGqFBpOREs3FmKiOXYAclbS/7VH754cU9ozRmUzhf
	 5WEcULQf30N3uayve6kCC4JF/aN91Wo51GC9dkMzYYftbdLCy9yM80VPGrN1z79AIk
	 wiMnQ4Bus87RLJUCvMzQQxKgNxIGriE1JtphmSlA0Pk3Ps3IjDUBJqCbiAqnnS7CmT
	 jIBdj4tE/ePWA==
Message-ID: <17bd900f-78a2-4c24-911a-6c29c6e9a520@kernel.org>
Date: Mon, 7 Jul 2025 12:40:55 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: zoned: limit active zones to max_open_zones
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <d2f36336c9eff5de35149223e9fd9b279028a804.1751611657.git.naohiro.aota@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <d2f36336c9eff5de35149223e9fd9b279028a804.1751611657.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 11:44 AM, Naohiro Aota wrote:
> When there is no active zone limit, we can technically write into any
> number of zones at the same time. However, exceeding the max open zones can
> degrade performance. To prevent this, set the max_active_zones to
> bdev_max_open_zones() if there is no active zone limit.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 9c354e84ab07..bdcfabcb35e7 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -418,6 +418,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  		zone_info->nr_zones++;
>  
>  	max_active_zones = bdev_max_active_zones(bdev);
> +	if (!max_active_zones)
> +		max_active_zones = bdev_max_open_zones(bdev);

	max_active_zones = min_not_zero(bdev_max_active_zones(bdev),
					bdev_max_open_zones(bdev));

And what if the device has no limits at all ? (e.g. no max active limit and no
max open limit). In this case, max_active_zones will be zero. Should we perhaps
set in that case a default max_active zones ?

For information, the block layer zone write plugging defaults to create a 128
zones pull of write plugs if the device has no limits
(BLK_ZONE_WPLUG_DEFAULT_POOL_SIZE in block/blk-zoned.c). I would recommend
using that limit here too. So something like this:

/* Default number of max active zones when the device has no limits. */
#define BTRFS_ZONE_DEFAULT_MAX_ACTIVE	128

	max_active_zones = min_not_zero(bdev_max_active_zones(bdev),
					bdev_max_open_zones(bdev));
	if (!max_active_zones &&
	    bdev_nr_zones(bdev) > BTRFS_ZONE_DEFAULT_MAX_ACTIVE)
		max_active_zones = BTRFS_ZONE_DEFAULT_MAX_ACTIVE;


>  	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
>  		btrfs_err(fs_info,
>  "zoned: %s: max active zones %u is too small, need at least %u active zones",


-- 
Damien Le Moal
Western Digital Research

