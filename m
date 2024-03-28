Return-Path: <linux-btrfs+bounces-3744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3A2890E3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 00:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DED01C29028
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82A05A11C;
	Thu, 28 Mar 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLztQ9+a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B784F894;
	Thu, 28 Mar 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667194; cv=none; b=Zj52Kf4TpRyplos8aw7anOBoGoVb3jx4RL+2VdQEut87kF6ROsy9QOD1HTvqmARmo7IK6gVIFrPDUcmQEKo9ice0mP6A/WsZHr2IIkhjbnED6SidcIT+wSUOw9C6LSEjhc1LzaZi3RaFGDLIfzFk/OBwvc3c60uad42iy1vVcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667194; c=relaxed/simple;
	bh=nd5x1ybpixe+3ggSR5AVPu2UVKBuDSJyT9R7JTnPC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWVk6DnjjLZ52oKX1qeu6YilGic/1YUM72RAexb8JwT/V8TA9eTcq3oEjAn58P4NUR8dTKZBnvhodbQfcHvZUx3sttB1ExJHP4PoCysuwOEXTeJs/v+++56hSggJ5DXpNjJtV7GtVwDwuBtXcAZoJ2DOrBrkfOes1tYMRVoZQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLztQ9+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A08C433C7;
	Thu, 28 Mar 2024 23:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667194;
	bh=nd5x1ybpixe+3ggSR5AVPu2UVKBuDSJyT9R7JTnPC5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PLztQ9+aVXZ5alE/iE5HTzU/Y9ICIozNm/mAZBO0V/+Qlk1+kmASBMxUDZdDLRiue
	 fIZv9ohF1u1bPAt2DP5+XaZoxu3+faFidqTHs9UAHKHgoCI60+1QE+e4nbReC3UXmY
	 Si6f0wrzOluvM6AYGqACTxnACH7ugUbac839EvfOcBWwRu9uGMdDmWOjJP0WiHVqP4
	 KKHnOd8N0nQaeHgPpFeQUA7rSI+hAfzQq007jy/uuEIdALo6jpDc7KNEzP+P8ftJ+s
	 2VbCH/UhM7HaNfxk6su5d8UmGtT00X4XCooOv9Tjldb9Y8cnW+6fZtCE3hK0TApbiU
	 7HxKeczIDrSSg==
Message-ID: <032b0938-88fe-4129-8e49-6d4634ea1844@kernel.org>
Date: Fri, 29 Mar 2024 08:06:31 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC PATCH 3/3] btrfs: zoned: kick cleaner kthread if low
 on space
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 hch@lst.de, Boris Burkov <boris@bur.io>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-3-4cd558959407@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328-hans-v1-3-4cd558959407@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 22:56, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Kick the cleaner kthread on chunk allocation if we're slowly running out
> of usable space on a zoned filesystem.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fb8707f4cab5..25c1a17873db 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1040,6 +1040,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>  u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  				 u64 hole_end, u64 num_bytes)
>  {
> +	struct btrfs_fs_info *fs_info = device->fs_info;
>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>  	const u8 shift = zinfo->zone_size_shift;
>  	u64 nzones = num_bytes >> shift;
> @@ -1051,6 +1052,11 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
>  	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
>  
> +	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags) &&
> +	    btrfs_zoned_should_reclaim(fs_info)) {
> +		wake_up_process(fs_info->cleaner_kthread);
> +	}

Nit: no need for the curly brackets.

> +
>  	while (pos < hole_end) {
>  		begin = pos >> shift;
>  		end = begin + nzones;
> 

-- 
Damien Le Moal
Western Digital Research


