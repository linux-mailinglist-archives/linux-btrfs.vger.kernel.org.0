Return-Path: <linux-btrfs+bounces-14893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D648AE5940
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 03:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFCA3AF378
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9319CC3D;
	Tue, 24 Jun 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU/Piz/R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC03FB1B
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728707; cv=none; b=OOJSC2qv5JVkVspEGMOtyYwTMjRRxHNNrJ9Tn0ZyMxztQErMWoxLZmVpD5GmijKOdE6j7NXQfdMSiPvroaApox7mZwSCPxJvW2VlOOJbZcHNc/MfrFN6rEcRwCLl3oF6zWWC4RDYNzAdFGknMlFptDKfQnhgVbuvD/Jx8oKVFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728707; c=relaxed/simple;
	bh=A5zpTIF6KddSf9fza6DpnhU3vvnzKSNqRCwVEyAU4pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk0wEVnaR7BQbW/vdPR3RRTpQJLedVyJUqy9HjeS9OU8SdXlIIgk6V/QAPHNMG3mvOSNIVfePknxNW7j6VHevKPqD9FXUsqGF/kOpRD8fTZ8QtchsaJNkRvRfr9XbAn4UqLrGrDHHF3U9i5xSU3y5mhA9AJKaiXAscBm8wvmAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU/Piz/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477C6C4CEEA;
	Tue, 24 Jun 2025 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750728706;
	bh=A5zpTIF6KddSf9fza6DpnhU3vvnzKSNqRCwVEyAU4pM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TU/Piz/RVz2C/LMSl9lTV/0tsQ7MY1cjFuaWkfzmLa5FBVrakxcWUq4yd5OwelVIB
	 SHKBoHi50CgjPcPyP2tYBkzq2A2q7svB+WvCyP9LRNdqKKVcMJiMqVkFZS9y28mZ4B
	 yblgDzGQZCNsZ9HeNAoz1ZjJHUCADBQijTCSdV5HP9xqeIJazHV9HFLbfz+OR9gugd
	 fb6Op4ATAWM9KVjV+n0N1IaISmO4bqYgNE9hfBaX72u+rPk1YDC/sr25EGtgUlbYWH
	 3e/Aweh1joEVKZoHJdBQjhESSWKC5DbL0mLDgeou/kE8NkpiH6DBI9KQPIw8TtpwGh
	 eCrtyuJTUdr/w==
Message-ID: <0522f42f-636d-4985-883b-3583c899d339@kernel.org>
Date: Tue, 24 Jun 2025 10:29:42 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: zoned: get rid of relocation_bg_lock
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250623165629.316213-1-jth@kernel.org>
 <20250623165629.316213-2-jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250623165629.316213-2-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 1:56 AM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Lockstat analysis of benchmark workloads shows a very high contention of
> the relocation_bg_lock. But the relocation_bg_lock only protects a single

s/of the/on
s/But the/But or s/But the/But the lock

> field in 'struct btrfs_fs_info', namely 'u64 data_reloc_bg'.
> 
> Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::data_reloc_bg'.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[...]

> @@ -3908,8 +3903,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	       block_group->start == fs_info->treelog_bg ||
>  	       fs_info->treelog_bg == 0);
>  	ASSERT(!ffe_ctl->for_data_reloc ||
> -	       block_group->start == fs_info->data_reloc_bg ||
> -	       fs_info->data_reloc_bg == 0);
> +	       block_group->start == data_reloc_bytenr ||
> +	       data_reloc_bytenr == 0);

Shouldn't all these use of data_reloc_bytenr be replaced with
READ_ONCE(fs_info->data_reloc_bg) ? That is, if data_reloc_bg can change while
this function is running.

> @@ -3957,8 +3952,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  		fs_info->treelog_bg = block_group->start;
>  
>  	if (ffe_ctl->for_data_reloc) {
> -		if (!fs_info->data_reloc_bg)
> -			fs_info->data_reloc_bg = block_group->start;
> +		if (READ_ONCE(fs_info->data_reloc_bg) == 0)
> +			WRITE_ONCE(fs_info->data_reloc_bg, block_group->start);

See ! You did it here :)

> @@ -4304,10 +4298,10 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
>  			ffe_ctl->hint_byte = fs_info->treelog_bg;
>  		spin_unlock(&fs_info->treelog_bg_lock);
>  	} else if (ffe_ctl->for_data_reloc) {
> -		spin_lock(&fs_info->relocation_bg_lock);
> -		if (fs_info->data_reloc_bg)
> -			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
> -		spin_unlock(&fs_info->relocation_bg_lock);
> +		u64 data_reloc_bg = READ_ONCE(fs_info->data_reloc_bg);
> +
> +		if (data_reloc_bg)
> +			ffe_ctl->hint_byte = data_reloc_bg;

Why not drop the data_reloc_bg variable and use
READ_ONCE(fs_info->data_reloc_bg) directly ?

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index a4a309050b67..f58bd85ddf5a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2495,11 +2495,10 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
>  void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
>  {
>  	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	u64 data_reloc_bg = READ_ONCE(fs_info->data_reloc_bg);
>  
> -	spin_lock(&fs_info->relocation_bg_lock);
> -	if (fs_info->data_reloc_bg == bg->start)
> -		fs_info->data_reloc_bg = 0;
> -	spin_unlock(&fs_info->relocation_bg_lock);
> +	if (data_reloc_bg == bg->start)
> +		WRITE_ONCE(fs_info->data_reloc_bg, 0);

data_reloc_bg variable is not needed.


-- 
Damien Le Moal
Western Digital Research

