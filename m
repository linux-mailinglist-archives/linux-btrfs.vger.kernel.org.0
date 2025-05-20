Return-Path: <linux-btrfs+bounces-14132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D4ABD36D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 11:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A258A18876E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB79262FC4;
	Tue, 20 May 2025 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVbmhqM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219E21C9EE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733510; cv=none; b=YwJyhPH4ytQt8ii+mcUZyTRVsubIrjWiG5D8t0cDzMGKD77uktHL709gaP/ubFjWnJoLx8F7uGNTuau7Wcpkie1tSSn8+Mrinb88fLJn/gUHEIxkQelyec2ykDGFq/uUXrAJPzn7n8Fad1Tdx5KTGH4tcI6wtjt+hxaLzMa+4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733510; c=relaxed/simple;
	bh=rgVVxOXMzX1I5VvDV+3tLB0kr08f1l86YXdX9unnC00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUnmcydkGkTHQfVQK5eCaC2s483NZwjEbNDjmVERabdjvfhacwJXp/SGzcjG+F3qPBE1xRVpewM2kJoNTF694oL7pslf9FKseHpOV1xyIfm1U9izx19HZcfLDtNO1DGsH2tZDdYPD/Lr5lWb7fYn2bjOVh4+6glSg3yZtt4jqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVbmhqM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F7C4CEE9;
	Tue, 20 May 2025 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733509;
	bh=rgVVxOXMzX1I5VvDV+3tLB0kr08f1l86YXdX9unnC00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KVbmhqM+lWp1yG32bcbXPbuQVOwq9yEnhgyud3WFN7uAdtijIBw6bGJWO8ypPdbNX
	 OftahqYb7K/We7+uOHaJS/3lV1O6r2b04Je+u/kWuzRGye4Bpzge+w6mv7lRU2kY80
	 c0esae5ZDrm7/kcXU88RNQc16c4sKZmm+Cxr2s9zgA5zUV+47QTFbViamwtvhXt1Ry
	 nF7uKi1it+Ugs55ra1mL0zh3PJ69FjIWpoQRdHkTTuJ6S+mC6xPoUHe7rP9Jnmo1BM
	 d7wsbV8IinM/QH+T4FP8p+OE2JYfkqKHiKE9xhWP7kk95vhI+L7rOtwCMR+pA+n2j3
	 Eqm8NWK/5Ge/w==
Message-ID: <be9fb855-29f1-41b9-a6ec-7e458ea38608@kernel.org>
Date: Tue, 20 May 2025 11:31:46 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: use filesystem size not disk size for
 reclaim decision
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <ce29d9ec1af7412e3e3e481e2fc3fb23842dca23.1747725440.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ce29d9ec1af7412e3e3e481e2fc3fb23842dca23.1747725440.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/05/20 9:20, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When deciding if a zoned filesystem is reaching the threshold to reclaim
> data block-groups, look at the size of the filesystem not to potentially
> total available size  of all drives in the filesystem.
> 
> Especially if a filesystem was create with mkfs' -b option, constraining
> it to only a portion of the block device, the numbers won't match and
> potentially garbage collection is kicking in too late.
> 
> Fixes: 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>


> ---
>  fs/btrfs/zoned.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b5b0156d5b95..19710634d63f 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2465,8 +2465,8 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	struct btrfs_device *device;
> +	u64 total = btrfs_super_total_bytes(fs_info->super_copy);
>  	u64 used = 0;
> -	u64 total = 0;
>  	u64 factor;
>  
>  	ASSERT(btrfs_is_zoned(fs_info));
> @@ -2479,7 +2479,6 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
>  		if (!device->bdev)
>  			continue;
>  
> -		total += device->disk_total_bytes;
>  		used += device->bytes_used;
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);


-- 
Damien Le Moal
Western Digital Research

