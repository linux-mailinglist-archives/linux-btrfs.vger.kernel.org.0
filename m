Return-Path: <linux-btrfs+bounces-5919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A26915225
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F84B25B33
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FB19B58E;
	Mon, 24 Jun 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DBxBvaMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471019B595
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242586; cv=none; b=lBBqBuPVMJWgkOI64ZG/iubWI+C4aRyw9z0rXKUlavmIVa5xmhPB4FK2jR2I9dFeR/+3bnhmZpUQ4eStVKvJij1lld119cYt0EwtITv+n0CPo/5LSpgkDGHpw299+SnhZW1JUVHbrpxX1Iyd+MxJBEHPoMfDhSH0s9ysgn9JuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242586; c=relaxed/simple;
	bh=eS8U5EmXy/4EcmvqF2P52fJBoHvcoCbWf4VNJwqSR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3xwcROxE0wwdI43d3sOXQTTuTNhgDHhHoWCKXOBjcykW4OQ5+qZTJAuvC/yhQJ89Ei7LF6FEhXF58kiRW+l/tcd8c1yRxlEZfqwxqM3QiN0BB9DnCRiv/jfS6HVjr99cdTEZr29Ey1ipt9jnstwfQOyqi6fWc7KfuO2i3N9SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DBxBvaMF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44051a577easo21808071cf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719242582; x=1719847382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NXske5I93gKxWI2CgNUVluNUNyA4zjABVul07yp6ho=;
        b=DBxBvaMFPp3bSB3dcBGCQwYhQIis8uv0jIx9eIXMbICyNi95FdsLpnk13r9Ef3p7uL
         9AXSkWuKW+ho7SSeadUjiOyj9IPE0ek/1f5KRESib5v8mYJy86q1oI/q/+CQGH1a3VTM
         e+u8bPxfDqTvkvlNy4CxlhysbeXYjo5LWi0TWw+jGlNNhlmMUlK+5OAn4mLam42r3Hm5
         Rqz0NprNrxew5zdj+4Rfn18sbvX65d7lPm2ZSd+JOfr4Kw5/IDJ+LsOGlB4iOYiREQdM
         uxyiK/l3SpHEmhpjD1ixtBAbdePcuctsRpUeHkFuWV+cYl8yrSBRUM9n/hTTUy4nTj0B
         SIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242582; x=1719847382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NXske5I93gKxWI2CgNUVluNUNyA4zjABVul07yp6ho=;
        b=L/dNIkySsqf9uGELkgyuqmBSatQFfyui3bup6MAx3jhDBa+R7ZF4Rv2y3Ef4WaGBw/
         WHYRuMpJn1/dGw//Sl49yBfLavW+EYqjTaB+N+dTN8kZqk8W3HJPQtoq0s5LSbTPhZ+7
         iHFYNZ9TsVR7gVOHnt8QCie9Crsw3edv0B5iHbM89iUXhklL0uNNxSQSfCLSoA5LNANw
         +rOaLNjsMFG+eSDWi1AWu/dFzSNOFJlHoUdInnyVi6zymvzoqjqHkTcyMxy0TkpdfNyI
         EOQvdQcFHD9jhntqA/a7TifgTUBcDSL8emjK1yBAjeYONeQxQQTn7RuipPiU2E2SPGRf
         rqkw==
X-Gm-Message-State: AOJu0YwAfwE0Wodh0Y7RbUjATcQH4Oy0YwjgJdjnW+Ba8BBYBMlC6RvL
	c+lXZpzq8U/AbnLywr74WQvNAJQwzp7ky//S0e97S9fFefriG7gd7zTrae05GN8=
X-Google-Smtp-Source: AGHT+IF7shFK4RgsUKicgUcQlV2KuW8EzXyANAg4JT9CIbfrnWs6KTcrcMkmJ6FE/0GenQ5aEryXvA==
X-Received: by 2002:a05:622a:102:b0:43b:1472:1671 with SMTP id d75a77b69052e-444d9201673mr55095231cf.17.1719242582142;
        Mon, 24 Jun 2024 08:23:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444d180cf6esm27396301cf.24.2024.06.24.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:23:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:23:00 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 5/6] btrfs: prevent pathological periodic reclaim loops
Message-ID: <20240624152300.GA2513195@perftesting>
References: <cover.1718665689.git.boris@bur.io>
 <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>

On Mon, Jun 17, 2024 at 04:11:17PM -0700, Boris Burkov wrote:
> Periodic reclaim runs the risk of getting stuck in a state where it
> keeps reclaiming the same block group over and over. This can happen if
> 1. reclaiming that block_group fails
> 2. reclaiming that block_group fails to move any extents into existing
>    block_groups and just allocates a fresh chunk and moves everything.
> 
> Currently, 1. is a very tight loop inside the reclaim worker. That is
> critical for edge triggered reclaim or else we risk forgetting about a
> reclaimable group. On the other hand, with level triggered reclaim we
> can break out of that loop and get it later.
> 
> With that fixed, 2. applies to both failures and "successes" with no
> progress. If we have done a periodic reclaim on a space_info and nothing
> has changed in that space_info, there is not much point to trying again,
> so don't, until enough space gets free, which we capture with a
> heuristic of needing to net free 1 chunk.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 12 ++++++---
>  fs/btrfs/space-info.c  | 56 ++++++++++++++++++++++++++++++++++++------
>  fs/btrfs/space-info.h  | 14 +++++++++++
>  3 files changed, 71 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6bcf24f2ac79..ba9afb94e7ce 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1933,6 +1933,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  			reclaimed = 0;
>  			spin_lock(&space_info->lock);
>  			space_info->reclaim_errors++;
> +			if (READ_ONCE(space_info->periodic_reclaim))
> +				space_info->periodic_reclaim_ready = false;
>  			spin_unlock(&space_info->lock);
>  		}
>  		spin_lock(&space_info->lock);
> @@ -1941,7 +1943,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  		spin_unlock(&space_info->lock);
>  
>  next:
> -		if (ret) {
> +		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
>  			/* Refcount held by the reclaim_bgs list after splice. */
>  			btrfs_get_block_group(bg);
>  			list_add_tail(&bg->bg_list, &retry_list);
> @@ -3677,6 +3679,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		space_info->bytes_reserved -= num_bytes;
>  		space_info->bytes_used += num_bytes;
>  		space_info->disk_used += num_bytes * factor;
> +		if (READ_ONCE(space_info->periodic_reclaim))
> +			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
>  		spin_unlock(&cache->lock);
>  		spin_unlock(&space_info->lock);
>  	} else {
> @@ -3686,8 +3690,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		btrfs_space_info_update_bytes_pinned(info, space_info, num_bytes);
>  		space_info->bytes_used -= num_bytes;
>  		space_info->disk_used -= num_bytes * factor;
> -
> -		reclaim = should_reclaim_block_group(cache, num_bytes);
> +		if (READ_ONCE(space_info->periodic_reclaim))
> +			btrfs_space_info_update_reclaimable(space_info, num_bytes);
> +		else
> +			reclaim = should_reclaim_block_group(cache, num_bytes);
>  
>  		spin_unlock(&cache->lock);
>  		spin_unlock(&space_info->lock);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index ff92ad26ffa2..e7a2aa751f8f 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include "linux/spinlock.h"
>  #include <linux/minmax.h>
>  #include "misc.h"
>  #include "ctree.h"
> @@ -1899,7 +1900,9 @@ static u64 calc_pct_ratio(u64 x, u64 y)
>   */
>  static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
>  {
> -	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * calc_effective_data_chunk_size(fs_info);
> +	u64 chunk_sz = calc_effective_data_chunk_size(fs_info);
> +
> +	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * chunk_sz;
>  }
>  
>  /*
> @@ -1935,14 +1938,13 @@ static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
>  	u64 unused = alloc - used;
>  	u64 want = target > unalloc ? target - unalloc : 0;
>  	u64 data_chunk_size = calc_effective_data_chunk_size(fs_info);
> -	/* Cast to int is OK because want <= target */
> -	int ratio = calc_pct_ratio(want, target);
>  
> -	/* If we have no unused space, don't bother, it won't work anyway */
> +	/* If we have no unused space, don't bother, it won't work anyway. */
>  	if (unused < data_chunk_size)
>  		return 0;
>  
> -	return ratio;
> +	/* Cast to int is OK because want <= target. */
> +	return calc_pct_ratio(want, target);
>  }
>  
>  int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
> @@ -1984,6 +1986,46 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> +void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> +{
> +	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
> +
> +	assert_spin_locked(&space_info->lock);
> +	space_info->reclaimable_bytes += bytes;
> +
> +	if (space_info->reclaimable_bytes >= chunk_sz)
> +		btrfs_set_periodic_reclaim_ready(space_info, true);
> +}
> +
> +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> +{
> +	assert_spin_locked(&space_info->lock);

This is essentially

BUG_ON(!locked(spin_lock));

instead use

lockdep_assert_held()

which will just yell at us so we can fix it.  Thanks,

Josef

