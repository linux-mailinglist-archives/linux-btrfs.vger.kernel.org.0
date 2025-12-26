Return-Path: <linux-btrfs+bounces-20010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82ACDE512
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 05:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36E2300E035
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Dec 2025 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03564248F4D;
	Fri, 26 Dec 2025 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDhNKjjM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908653A1E6F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Dec 2025 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766722739; cv=none; b=TShRBy/B88vhGHiZZIQVQOIyYai8EN/CHHwjsb0qIjvZQ5DL7LX9Pf+dYuOzKMTDo2qbxtC4oXA+1nL4nBHKM5T+8KJofr4N3Zq8t1s+U7fIQrMe3mAgmr4EQPEIfc3eMpb4U4Fyx7ooaQMdxc5kyAOkO/2niLF38H5P6+YNTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766722739; c=relaxed/simple;
	bh=BMygIv0eNS9WMyhr9YpjSege1wuKqNpRl0Pcq2wgEtY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WMMLyt25NT+x2aLjOwz/XaeG2gSGR6kvF5R1ArkAZcNLErRxCMY3rx+8I/kDvqwr43OukLRuESLH34sNI0fiSJtjtw32jtN2V6w2Ded4TOWj6qMVcFtQTTDdjWK8hy6gg4DZXMSWoryylB0gfOgr0Ve73nTlpU36iGn2KM7AP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDhNKjjM; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34ab4ac9a34so1170231a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 20:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766722737; x=1767327537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MgCaR3wZubyCnFjg1/9XaZc6c146SOFIoMvUfKpBZZY=;
        b=eDhNKjjMGy+gQ3emJEHMg9FJ5hgessasFNcSH0LO2AZfOSkNpk1Eh8KCKZC/RjW2f0
         pONXk9WctPHGDonojo3nEh1dvVARuHbBPCfy4hDPM8Ip8vPjxLnjAXags6sZuEIaFcRS
         KIT6rCIBEBydCMnBSpuV6ljS+s4cPD1hsq8VZhlWHBJhW+dfHvOEHZi4sOC5vj0JsYV2
         bi4nY8VcRsaUli8UEzPDuFDmP7WJZjtPUZte4xAHEH7GnuKSmam/IRy8vAuGhtsOfTYv
         6jtz3jGOuk0TvcwvhXA/ihxWfnc2F4fq32ps5hYxKQWoO23UPB+33iVzY3s32/ODtPgz
         epTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766722737; x=1767327537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgCaR3wZubyCnFjg1/9XaZc6c146SOFIoMvUfKpBZZY=;
        b=wAekL5ZEXHwR7YY8jx4WjRulZKLlkgydZ3wjFsNy9LOtIW+769TFVFEkdFu3KRItiF
         RnOCo5EXR/l4VOCbbZTGTwbnPOrZuOF8SQ02IkNwLh1fQAliWDjOuIo+xfEp1milmAHT
         dC+if39pHlX8NUfN8Au2VQbA2S383X0Rw9iRe6e0b2SW3joQQUJoK2rKJzGzeQM1E/GP
         050ycAzZkKSkAwPMuk5T4Rlt5s7xKZ2E/+f7Iusjs5/7WSSXk6fLj9RV5DB0MjUqPWCe
         EwCOp/bgNrdH5/gbFMX7Wo6wdUySsO+/RKHMLR3KLCND8S6ZGgkCGr8MhYenxk44nW+0
         rJqw==
X-Forwarded-Encrypted: i=1; AJvYcCVuutG4HMEgIxDzWnaYJGVko1ZUaQlCEIRX+W/CJsMWhE244bG09njJqzjuuf68IKxnwU99WkYWuyiFLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/1nHAwSyFbSielvGSuwgzu0klfXL4Mytoa++cI5LO5a5xlgm
	J8MrFv0cciJgPS/oI6521jXt9D37oAT2zobOfymco2gd7EK3x8S53J8xmFtrNe6S6Nc=
X-Gm-Gg: AY/fxX4TARaG8OHP6PtnXxOwkmgodl4NmYi2Ntmpc3MHJKEdNo17hfaumXwaqmGlg0G
	qXIxk5utiIkXBIQUEbKlT070DTDlaWLlsLEB6PJ6eVVTE9JrA4uqQfWGeOWWNetSlUN2Rq0CBX4
	XTYEJa2uOTMg/S2XQgVeTKzc41XDHzpJy5WkicSCypUVjs+C8YJLbW0YYEC0K3nEuHlpvRStEId
	fOzuDptnr5OX51+r89Sm4MA73CiSHeWFBLxYgPwKDmUualyOMQ1KsfkwFEHTKzY+2v6f1JWmg1I
	U9Hc35r+oeHFN8XaBpodhE8kseKtEewH7Pa6p8THvbkU8kcfVI17bA06n8xR6Zmnuq7g0w12NEo
	QrquEkRMXoMD9rw219n0f8cMLa04TfqlmdMFJm+lW7KqlNqvvVfCqj2C1irmRJJyqmgh2iZPbXW
	FrgYBpi5xaYcbtaguCvSzlCjgh
X-Google-Smtp-Source: AGHT+IFRZmGQO8wKDH1o7PEU28MnJgkWYHGt+4/TOwGMThKaV8yuRMHHIpiAgzVzRfDFRNJtA3HnCg==
X-Received: by 2002:a05:6a00:228f:b0:7b6:ebcb:63fa with SMTP id d2e1a72fcca58-7ff6198e350mr13979811b3a.0.1766722736811;
        Thu, 25 Dec 2025 20:18:56 -0800 (PST)
Received: from [192.168.1.13] ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e682870sm20635141b3a.57.2025.12.25.20.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 20:18:56 -0800 (PST)
Message-ID: <29f9e528-9dbe-48fb-9353-6ad7177be50f@gmail.com>
Date: Fri, 26 Dec 2025 12:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sun Yangkai <sunk67188@gmail.com>
Subject: Re: [PATCH v2 5/6] btrfs: prevent pathological periodic reclaim loops
To: boris@bur.io
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
Content-Language: en-US
In-Reply-To: <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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

I wonder why we're not clearing the reclaimble_bytes count here.

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

We're comparing s64 with u64 here, and it won't work as expected.

Even after fixing this by changing chunk_sz to s64, it will not work as expected
in the following case:

- We're filling the disk so reclaimable_bytes is always negative.
- There's less than 10G unallocated so dynamic_reclaim kicked in.
- periodic_reclaim will never work since reclaimable_bytes is always negetive.

> +		btrfs_set_periodic_reclaim_ready(space_info, true);
> +}
> +
> +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> +{
> +	assert_spin_locked(&space_info->lock);
> +	if (!READ_ONCE(space_info->periodic_reclaim))
> +		return;
> +	if (ready != space_info->periodic_reclaim_ready) {
> +		space_info->periodic_reclaim_ready = ready;
> +		if (!ready)
> +			space_info->reclaimable_bytes = 0;
> +	}
> +}
> +
> +bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> +{
> +	bool ret;
> +
> +	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		return false;
> +	if (!READ_ONCE(space_info->periodic_reclaim))
> +		return false;
> +
> +	spin_lock(&space_info->lock);
> +	ret = space_info->periodic_reclaim_ready;
> +	btrfs_set_periodic_reclaim_ready(space_info, false);
> +	spin_unlock(&space_info->lock);
> +
> +	return ret;
> +}
> +
>  int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
>  {
>  	int ret;
> @@ -1991,9 +2033,7 @@ int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
>  	struct btrfs_space_info *space_info;
>  
>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
> -		if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> -			continue;
> -		if (!READ_ONCE(space_info->periodic_reclaim))
> +		if (!btrfs_should_periodic_reclaim(space_info))
>  			continue;
>  		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
>  			ret = do_reclaim_sweep(fs_info, space_info, raid);
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index ae4a1f7d5856..4db8a0267c16 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -196,6 +196,17 @@ struct btrfs_space_info {
>  	 * threshold in the cleaner thread.
>  	 */
>  	bool periodic_reclaim;
> +
> +	/*
> +	 * Periodic reclaim should be a no-op if a space_info hasn't
> +	 * freed any space since the last time we tried.
> +	 */
> +	bool periodic_reclaim_ready;

Also, I wonder why we need this bool flag. I think we care more about if
reclaimable_bytes' value is more than 1G when calling
btrfs_should_periodic_reclaim() rather than if it has been more than 1G during
two calls of btrfs_should_periodic_reclaim().

Thanks,
Sun YangKai

> +
> +	/*
> +	 * Net bytes freed or allocated since the last reclaim pass.
> +	 */
> +	s64 reclaimable_bytes;
>  };
>  
>  struct reserve_ticket {
> @@ -278,6 +289,9 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
>  
> +void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
> +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
> +bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
>  int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
>  int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
>  
> -- 
> 2.45.2


