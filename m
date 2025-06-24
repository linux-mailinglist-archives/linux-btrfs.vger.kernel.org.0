Return-Path: <linux-btrfs+bounces-14894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C785AE5949
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 03:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860D91B6477D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0E19DF4A;
	Tue, 24 Jun 2025 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7cZFjOd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC33FE7
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728957; cv=none; b=PTgCa9vsxAuisdj9wAw7Hbk9mpCubkrJxN5Gx817G/Kdq62qBmYwlgQo4sce6ejPa+M4wOFXLdiBHpudSBpyuSoeKeC7bun2DYHshFgL2h58fSBuV5o/6FTd+GTlExlvZx3sccNhxg1hrLEQ9v0ECV3fhqR8bOXEoGBKTpKTiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728957; c=relaxed/simple;
	bh=jDoJ8NiOLKyfEL2oFhy8I2Jrk/zzKXHa4XaVuhtHMjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJHr43HZkYxHVH7dxjyiMbmOJ4+pS0vnqLqUaVRl9FjsjTJajTdzDQIf+YFnh2BNEyIzw/D997H6LilZwx3+yQ5Uwo3Tapgh2E86wjf0V/kvp7ZvS8Bc/YYrg3HYuh3viP+iaxtBoyA9z80eCPGqGV92BSnOe1tlws7iIEhakWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7cZFjOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A8C4CEEA;
	Tue, 24 Jun 2025 01:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750728956;
	bh=jDoJ8NiOLKyfEL2oFhy8I2Jrk/zzKXHa4XaVuhtHMjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R7cZFjOdkFLcPYjjzxiddsnc0c01yacm8VqZli+kacxcGKA2tZXWWHeq7I23WWqxZ
	 NHZrC7VD2G9rXkq+ZDjfh6diJtogYZDBS9NfkYIkhae8utYtbGKVtdSm/R/nUXkJsD
	 gnKyo4wYjmOAmEcXtPzOyy0But1ta0UoXbbwGvMpYaeitVAHpgIuOn6kyX/E2Oe5RL
	 oFS5s21cy1Mb9z40jOmnDVmofF3VLebjxZ7uLdGuf6lkuUomY4IDQLOctlj0Bdyr1Y
	 jvZQROxYySd2J145SMUXVFoS9ZlEYnRCnHiL55TG6eegv0dnb351AlEsc87NQ2RbsD
	 Wp1gtOf20piKQ==
Message-ID: <bd2825ee-6210-4fce-9b1c-16fed908f3a1@kernel.org>
Date: Tue, 24 Jun 2025 10:33:52 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: zoned: get rid of treelog_bg_lock
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250623165629.316213-1-jth@kernel.org>
 <20250623165629.316213-3-jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250623165629.316213-3-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 1:56 AM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Lockstat analysis of benchmark workloads shows a very high contention of
> the treelog_bg_lock. But the treelog_bg_lock only protects a single
> field in 'struct btrfs_fs_info', namely 'u64 treelog_bg'.
> 
> Use READ_ONCE()/WRITE_ONCE() to access 'btrfs_fs_info::treelog_bg'.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c     |  1 -
>  fs/btrfs/extent-tree.c | 45 +++++++++++-------------------------------
>  fs/btrfs/fs.h          |  1 -
>  fs/btrfs/zoned.c       |  2 +-
>  fs/btrfs/zoned.h       |  7 +++----
>  5 files changed, 15 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 24896322376d..a54218717cb4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2789,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	spin_lock_init(&fs_info->defrag_inodes_lock);
>  	spin_lock_init(&fs_info->super_lock);
>  	spin_lock_init(&fs_info->unused_bgs_lock);
> -	spin_lock_init(&fs_info->treelog_bg_lock);
>  	spin_lock_init(&fs_info->zone_active_bgs_lock);
>  	rwlock_init(&fs_info->tree_mod_log_lock);
>  	rwlock_init(&fs_info->global_root_lock);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a9bda68a1883..46358a555f78 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3809,22 +3809,6 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
>  	return find_free_extent_unclustered(block_group, ffe_ctl);
>  }
>  
> -/*
> - * Tree-log block group locking
> - * ============================
> - *
> - * fs_info::treelog_bg_lock protects the fs_info::treelog_bg which
> - * indicates the starting address of a block group, which is reserved only
> - * for tree-log metadata.
> - *
> - * Lock nesting
> - * ============
> - *
> - * space_info::lock
> - *   block_group::lock
> - *     fs_info::treelog_bg_lock
> - */
> -
>  /*
>   * Simple allocator for sequential-only block group. It only allows sequential
>   * allocation. No need to play with trees. This function also reserves the
> @@ -3844,7 +3828,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	u64 log_bytenr;
>  	u64 data_reloc_bytenr;
>  	int ret = 0;
> -	bool skip = false;
>  
>  	ASSERT(btrfs_is_zoned(block_group->fs_info));
>  
> @@ -3852,13 +3835,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	 * Do not allow non-tree-log blocks in the dedicated tree-log block
>  	 * group, and vice versa.
>  	 */
> -	spin_lock(&fs_info->treelog_bg_lock);
> -	log_bytenr = fs_info->treelog_bg;
> +	log_bytenr = READ_ONCE(fs_info->treelog_bg);
>  	if (log_bytenr && ((ffe_ctl->for_treelog && bytenr != log_bytenr) ||
>  			   (!ffe_ctl->for_treelog && bytenr == log_bytenr)))
> -		skip = true;
> -	spin_unlock(&fs_info->treelog_bg_lock);
> -	if (skip)
>  		return 1;
>  
>  	/*
> @@ -3894,14 +3873,13 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  
>  	spin_lock(&space_info->lock);
>  	spin_lock(&block_group->lock);
> -	spin_lock(&fs_info->treelog_bg_lock);
>  
>  	if (ret)
>  		goto out;
>  
>  	ASSERT(!ffe_ctl->for_treelog ||
> -	       block_group->start == fs_info->treelog_bg ||
> -	       fs_info->treelog_bg == 0);
> +	       block_group->start == log_bytenr ||
> +	       log_bytenr == 0);
>  	ASSERT(!ffe_ctl->for_data_reloc ||
>  	       block_group->start == data_reloc_bytenr ||
>  	       data_reloc_bytenr == 0);
> @@ -3917,7 +3895,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	 * Do not allow currently using block group to be tree-log dedicated
>  	 * block group.
>  	 */
> -	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
> +	if (ffe_ctl->for_treelog && log_bytenr == 0 &&

Similar comment as previous patch. It feels that all the log_bytenr uses should
really be replaced with READ_ONCE(fs_info->treelog_bg). But I am not sure about
the concurrency with that field changing...

>  	    (block_group->used || block_group->reserved)) {
>  		ret = 1;
>  		goto out;
> @@ -3948,8 +3926,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  		goto out;
>  	}
>  
> -	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
> -		fs_info->treelog_bg = block_group->start;
> +	if (ffe_ctl->for_treelog && READ_ONCE(fs_info->treelog_bg) == 0)
> +		WRITE_ONCE(fs_info->treelog_bg, block_group->start);
>  
>  	if (ffe_ctl->for_data_reloc) {
>  		if (READ_ONCE(fs_info->data_reloc_bg) == 0)

[...]

> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 6e11533b8e14..c1b3a5c3a799 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -383,14 +383,13 @@ static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
>  static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
>  {
>  	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	u64 treelog_bg = READ_ONCE(fs_info->treelog_bg);
>  
>  	if (!btrfs_is_zoned(fs_info))
>  		return;
>  
> -	spin_lock(&fs_info->treelog_bg_lock);
> -	if (fs_info->treelog_bg == bg->start)
> -		fs_info->treelog_bg = 0;
> -	spin_unlock(&fs_info->treelog_bg_lock);
> +	if (treelog_bg == bg->start)

Variable treelog_bg is not needed.

> +		WRITE_ONCE(fs_info->treelog_bg, 0);
>  }
>  
>  static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)


-- 
Damien Le Moal
Western Digital Research

