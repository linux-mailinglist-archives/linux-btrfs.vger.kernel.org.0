Return-Path: <linux-btrfs+bounces-13132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF456A91C81
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241B918890FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F393242916;
	Thu, 17 Apr 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mxmlljzk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD422FACA
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893611; cv=none; b=LpILkDC73Qob9ZAiYhuKwWJKTEKuLa7JIhuDO5vpW2MeHajGQrOWDy34dcLSDuMBXKzIH1Qac8ecyXsPZSgwopFoZV9zf4J1uo2r/cneEGvtnyCLU0TFdtdHfdLpk5VEIT50sQqS0IJb1kz8K8xq+Ae42Rzy0md8uFzWvaRVKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893611; c=relaxed/simple;
	bh=+FZ54qN193Cbyc3iGpcZYtbV6YtQ1K4K1wH0qeRsQOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtwgguC6VS+mvCdXracVQO7Bx7yi0gz0Fxa6EY97t5xF/5E5baG2iWaeEF0TAlsAAgg2PQxSR7iYdSpaQVOBtQf2r2IeS22dh2QWb3qdqI7AyAS8DPVN/9Wjk9rEqZH3dgD8VyTph5pMBJTyckFR4jUVmgnGf75a+aVwj6gN2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mxmlljzk; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7054f0e933cso5874607b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744893608; x=1745498408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYdN1detB5LdQrhUepxYvUTDG1iK034YPiXZI59oEQc=;
        b=mxmlljzk1eSkrNCq7xlnazEvT7xz1M1+u7S08X2MeL7LY+ra34fj7CvSKsrZ1W2HVn
         DCTb20FwmVHHb/Uko8SIPq+K4DmazUhmgEex0yqw9wMibH4Au6UIlBsUTVe4MFzRqaWU
         WVB2F1BbbcSKP1uBF+/HDpTWePBmMP009HtslhyWFH/vB7aE0FLUm2fstoWSZRO0lTOQ
         dN09CTSG+K8/7G34w7S1IDOxnEGhc73S0zAVDyYChxC4zacTCnZrqXjLAfadL+bidUwv
         a9cp4RG3GDYzjpltZ5UeYPyuWmlM0shFrkUuIYu3Ks4F6e0iPef79T3UKctPdI2CwXL4
         bcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893608; x=1745498408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYdN1detB5LdQrhUepxYvUTDG1iK034YPiXZI59oEQc=;
        b=tFLxgN41TfQ2NdncaNyzrUSEXkI9y0qKDKBOZgL8SvQU7Ah8Hw4ilgvGkGdatk0uiA
         LqhgoHIJ2+6r1wn/iSeFkSHGAZ9AmRDtGMsLP7wS4b0NJSrjLmgNZyC4BPKX5oQ2Zwuz
         qEVaxpQ9djm8XZqy33sN4CWtzGwPLs0qsVbneUNbQyuWdt5S6RU/rDbOILv4BQnS5XfB
         n0aOZTxjRTpI9ReSCYRuI/ucXf+LOcMVSljKUnfYsTKZZtCMF4UEFK0rwwtrJBnOd16X
         +peSpNvvFVmVVN8pdP3v+oOq9Jt5IbCiULu9Ovz5zj+AANhv0a5qQ2HZ/vcYaLdIHEF8
         bHPg==
X-Gm-Message-State: AOJu0Yx2VhyWU+eK3lJ+gpNeHy1y3RCsFEO0hygUfZq8Gvi44fWdEzzp
	KoQpY8EriZZwRuLaTqyssC0l1K6EVBIZkbaJ7syBLuRCWAKHrmTYqpQGSY2RrB3t/vO3hHMG2A7
	A
X-Gm-Gg: ASbGncuC4k3q6iCQ5c4dG+ljslOQ+E7G8ZtMAo0m+GslGK+8A0P286Ffxn93eBSegot
	WHxN7V0HLYbmIYVtwgVTiEv8DTGiLlQCOVP+oY9u6hvAVZW88vJF721e+9TWBJgLZntLbTRl++C
	D303vY9dm4qP0r7YanfGmZHvmLFlruD4nerQgle9eRzGiZy3wkSfuuMhxXdppt3I2IfeEGAlRRc
	sDuehzc7KlcRiZjWlM0iwvxSja3N5DOoR171HaCLOO6ED+B/g+67LxDX+aqWSI5Q5GlW8qrprLU
	dgUsaraJJ2AojdoKhDxt3P1dbXaQDCoDC7d+ax1HgPqkjEcyGvWdhpJnSQnhc7HYeEtyBZJ6aqH
	6gQ==
X-Google-Smtp-Source: AGHT+IF/mgDUyML12SFuxl9x4XcOgQZdCc8fdWKy55znyzdLOPD8sqI/Aw/zktRoyj0QFFzPaMzxjw==
X-Received: by 2002:a05:690c:319:b0:6f9:7d7d:a725 with SMTP id 00721157ae682-706b3386f13mr75607927b3.33.1744893608170;
        Thu, 17 Apr 2025 05:40:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e137cbfsm46769067b3.50.2025.04.17.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:40:07 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:40:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 07/13] btrfs: pass space_info for block group creation
Message-ID: <20250417124006.GB3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <e9c33853d3095c61b982bfb23bd313d8641d6797.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c33853d3095c61b982bfb23bd313d8641d6797.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:12PM +0900, Naohiro Aota wrote:
> Add btrfs_space_info parameter to btrfs_make_block_group(), its related
> functions and related struct. Passed space_info will have a new block
> group. If NULL is passed, it uses the default space_info.
> 
> The parameter is used in a later commit and the behavior is unchanged now.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 18 ++++++++++--------
>  fs/btrfs/block-group.h |  4 ++--
>  fs/btrfs/volumes.c     | 22 +++++++++++++++++-----
>  fs/btrfs/volumes.h     |  3 ++-
>  4 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 12cc9069d4bb..846c9737ff5a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2866,8 +2866,8 @@ static u64 calculate_global_root_id(const struct btrfs_fs_info *fs_info, u64 off
>  }
>  
>  struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
> -						 u64 type,
> -						 u64 chunk_offset, u64 size)
> +						 struct btrfs_space_info *space_info,
> +						 u64 type, u64 chunk_offset, u64 size)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_block_group *cache;
> @@ -2921,7 +2921,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
>  	 * assigned to our block group. We want our bg to be added to the rbtree
>  	 * with its ->space_info set.
>  	 */
> -	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
> +	cache->space_info = space_info;
>  	ASSERT(cache->space_info);
>  
>  	ret = btrfs_add_block_group_cache(cache);
> @@ -3902,7 +3902,9 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
>  	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
>  }
>  
> -static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
> +static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans,
> +						struct btrfs_space_info *space_info,
> +						u64 flags)
>  {
>  	struct btrfs_block_group *bg;
>  	int ret;
> @@ -3915,7 +3917,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
>  	 */
>  	check_system_chunk(trans, flags);
>  
> -	bg = btrfs_create_chunk(trans, flags);
> +	bg = btrfs_create_chunk(trans, space_info, flags);
>  	if (IS_ERR(bg)) {
>  		ret = PTR_ERR(bg);
>  		goto out;
> @@ -3964,7 +3966,7 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
>  		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
>  		struct btrfs_block_group *sys_bg;
>  
> -		sys_bg = btrfs_create_chunk(trans, sys_flags);
> +		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
>  		if (IS_ERR(sys_bg)) {
>  			ret = PTR_ERR(sys_bg);
>  			btrfs_abort_transaction(trans, ret);
> @@ -4214,7 +4216,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
>  			force_metadata_allocation(fs_info);
>  	}
>  
> -	ret_bg = do_chunk_alloc(trans, flags);
> +	ret_bg = do_chunk_alloc(trans, space_info, flags);
>  	trans->allocating_chunk = false;
>  
>  	if (IS_ERR(ret_bg)) {
> @@ -4297,7 +4299,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
>  		 * the paths we visit in the chunk tree (they were already COWed
>  		 * or created in the current transaction for example).
>  		 */
> -		bg = btrfs_create_chunk(trans, flags);
> +		bg = btrfs_create_chunk(trans, NULL, flags);
>  		if (IS_ERR(bg)) {
>  			ret = PTR_ERR(bg);
>  		} else {
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index c01f3af726a1..35309b690d6f 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -326,8 +326,8 @@ void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
>  void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
>  int btrfs_read_block_groups(struct btrfs_fs_info *info);
>  struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
> -						 u64 type,
> -						 u64 chunk_offset, u64 size);
> +						 struct btrfs_space_info *space_info,
> +						 u64 type, u64 chunk_offset, u64 size);
>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
>  int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  			     bool do_chunk_alloc);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7509cbe3272c..5462c832ea19 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3420,7 +3420,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
>  		struct btrfs_block_group *sys_bg;
>  
> -		sys_bg = btrfs_create_chunk(trans, sys_flags);
> +		sys_bg = btrfs_create_chunk(trans, NULL, sys_flags);
>  		if (IS_ERR(sys_bg)) {
>  			ret = PTR_ERR(sys_bg);
>  			btrfs_abort_transaction(trans, ret);
> @@ -5216,6 +5216,8 @@ struct alloc_chunk_ctl {
>  	u64 stripe_size;
>  	u64 chunk_size;
>  	int ndevs;
> +	/* Space_info the block group is going to belong. */
> +	struct btrfs_space_info *space_info;
>  };
>  
>  static void init_alloc_chunk_ctl_policy_regular(
> @@ -5617,7 +5619,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
>  		return ERR_PTR(ret);
>  	}
>  
> -	block_group = btrfs_make_block_group(trans, type, start, ctl->chunk_size);
> +	block_group = btrfs_make_block_group(trans, ctl->space_info, type, start,
> +					     ctl->chunk_size);
>  	if (IS_ERR(block_group)) {
>  		btrfs_remove_chunk_map(info, map);
>  		return block_group;
> @@ -5643,7 +5646,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
>  }
>  
>  struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
> -					    u64 type)
> +					     struct btrfs_space_info *space_info,
> +					     u64 type)
>  {
>  	struct btrfs_fs_info *info = trans->fs_info;
>  	struct btrfs_fs_devices *fs_devices = info->fs_devices;
> @@ -5671,8 +5675,16 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (!space_info) {
> +		space_info = btrfs_find_space_info(info, type);
> +		if (!space_info) {
> +			ASSERT(0);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}

Same comment here, make everybody send down the space_info instead of it being
optional.  Thanks,

Josef

