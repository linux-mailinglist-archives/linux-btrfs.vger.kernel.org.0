Return-Path: <linux-btrfs+bounces-3743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD91890E3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5252945EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D613958C;
	Thu, 28 Mar 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz7Iyiv9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2C55C3C;
	Thu, 28 Mar 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667137; cv=none; b=KT/7Sc+W50tAq7HkPYSP7bbFwAmzM31YgYsYLNMqhldxtuQFfEJpeCCcY+Q/QIa+fhSv+BAoeDp7S+KnnnLK7xHgMf9+gFuKUPXQccaoimqRAoCXqIMeIUNglWlsh9m+bnSUX6vXWx2yWbKVyntyclZbxaAtfYbqdnTUFGDeqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667137; c=relaxed/simple;
	bh=tyeWRu/YgrK8oK56ulzEXfggC+JkpfleVOMjnPm+e/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IakXoDE0eFMmJjboW8xWnGa08r/caH8MOBi1vQPawqJY5ahoafg1g1wer9b3o78Zp4iWA/uTHtophZ4bvgqRA7AUFp2YC0lVSndD4K2Nqwy2lgKKqgQ9X4T0HGgKSW7yF8NFbLBJsrHw4v1h9YvXin/yB//1gikmV1BdO5q/OuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz7Iyiv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F507C43394;
	Thu, 28 Mar 2024 23:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667137;
	bh=tyeWRu/YgrK8oK56ulzEXfggC+JkpfleVOMjnPm+e/8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dz7Iyiv9/BHLTcCm670zmo4NAMUF4ldUjPhYYaovfI/dTBzd4laKaz4sb0sPtpQkJ
	 vmOTb39AtB6xOfh51DNL/4odODdW4KmlRp4ATou1vZ+Aa8lbosaoyzdElrJHf2vwIo
	 57vIzsXoQ8UkWe88Was+uAtiN5RQG01WqRFnsAWrmMz93WVEGYwFpicygtI+Atw9gm
	 DSJdxL2agawWJo6T82qWwMv0LVVgw2o/SCpi0llkP/pgbwlksYkItDVinzq9NtruzD
	 S9RTvJmeDZ1ad8hwwvm8zLWondc3felURi4YfmX+kFVcldZSIjS6gCJOa6vu8i5Xoi
	 R3LyUQEEcqIkg==
Message-ID: <e32027a2-6032-4937-a362-287897abdf11@kernel.org>
Date: Fri, 29 Mar 2024 08:05:34 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
 hch@lst.de, Boris Burkov <boris@bur.io>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-2-4cd558959407@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328-hans-v1-2-4cd558959407@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 22:56, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c |  2 ++
>  fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   |  3 +++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5a35c2c0bbc9..83b56f109d29 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	}
>  	btrfs_discard_resume(fs_info);
>  
> +	btrfs_reserve_relocation_zone(fs_info);
> +
>  	if (fs_info->uuid_root &&
>  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>  	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d51faf7f4162..fb8707f4cab5 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
>  
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
>  	}
>  	spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
> +{
> +	struct btrfs_block_group *bg;
> +
> +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +			if (bg->used == 0)
> +				return bg->start;
> +		}
> +	}
> +
> +	return 0;

The first block group does not start at offset 0 ? If it does, then this is not
correct. Maybe turn this function into returning a bool and add a pointer
argument to return the bg start value ?

> +}
> +
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *tree_root = fs_info->tree_root;
> +	struct btrfs_space_info *sinfo = fs_info->data_sinfo;
> +	struct btrfs_trans_handle *trans;
> +	u64 flags = btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +	u64 bytenr = 0;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +
> +	bytenr = find_empty_block_group(sinfo);
> +	if (!bytenr) {
> +		int ret;
> +
> +		trans = btrfs_join_transaction(tree_root);
> +		if (IS_ERR(trans))
> +			return;
> +
> +		ret = btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> +		btrfs_end_transaction(trans);
> +
> +		if (!ret)
> +			bytenr = find_empty_block_group(sinfo);

What if this fail again ?

> +	}
> +
> +	spin_lock(&fs_info->relocation_bg_lock);
> +	fs_info->data_reloc_bg = bytenr;
> +	spin_unlock(&fs_info->relocation_bg_lock);
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 77c4321e331f..048ffada4549 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
>  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>  				struct btrfs_space_info *space_info, bool do_finish);
>  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
>  
>  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
>  
> +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info) { }
> +
>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> 

-- 
Damien Le Moal
Western Digital Research


