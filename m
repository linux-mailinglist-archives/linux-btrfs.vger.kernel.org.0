Return-Path: <linux-btrfs+bounces-13131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BC1A91C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059995A69F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DC24113D;
	Thu, 17 Apr 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vTzIIgmI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343824500A
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893535; cv=none; b=PLllc1rsBUCXEv2Rrs2n8Ka+0ZbxzQxW7Ym4YNEDoPbtnWWPwSHcE+mzFDJotyj9p86GzQWoplFaOBVJ4O9pBJlKbaqd+iXTCTf2UcNcOAWfcRyEekz86thfm2EionQ4F5BNrkPAhSot/451MXauEhaWJ7XvS9u17gJFxlAHKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893535; c=relaxed/simple;
	bh=YMHKRdlsLfBmAnrmerEHCVWjkaW9nTSDOu/63Jf/apM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUEOXV+PfxfA/NBHdLWoglLL+TgLOgXUJ3x0gqwfDxqu2zELY1KtWKGxLUBkLQIKx7JZtx5Jp/jlLx62ziR+HFqjBCQVKjtAA5CqLtW2aC+EPVB/sJiaAbmVYessODbtfak/oPBk20HYJQyYlGulfpIVP+eFiQgg0ikHotxSJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vTzIIgmI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso590537276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744893532; x=1745498332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84L7J/T6V0bl5MBOdTPVpTxGTheH1LyjYJRD63uSBMY=;
        b=vTzIIgmIodh5zh4ssVTdW+zFDRX4Kq6S1TMUsht9pZjWVd7JzjOPy2rNIdHGEr8FRf
         TSmYY3Lha7INgOuZnxqpvP5WvTdq1eFx5COgcdrntHdceWJb8hfD3t/sGUZfoFf4Q/kR
         SmM2CFJIZQTKeEvaeF9SA2V+psUbyI7AFCQzOZ/edii/7IXbHFpd7tbajl37mroJw9pe
         V0POQOxpSKFaY8ppR8t+cCYPDaR6pOQPbP4Mk333uaEU0+YMOqewrbhNfvI2PtiyP6mD
         eEhxQxOTSs+H0RdorUC6WFYHeOUuQ2EN46WxwyDeNVEGbSbDYyOiX3utGcebN8hQ0e+U
         DZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893532; x=1745498332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84L7J/T6V0bl5MBOdTPVpTxGTheH1LyjYJRD63uSBMY=;
        b=Itxw5GodcJ+tWlezbtGWGuJah4OsksWf17nxJKLI+ota2VHsm5K9K+q5Os232pROs8
         mZUo3K9gHhy99mJr2V0PpP4G1MSruIALKR5ZiqG+1yxfp7zLTEZWZpDRFw/w3h6/WXwY
         MSqxa2bOEGCFj0c3M8JVvnTfjSWuWxPtFoZkskKarxocDa3CSqxd2xST+z35K3SJZZDG
         dxDhSY18xhwKSeHIP+3jgARtcqZcDQOgbaKAxEakcedfSoSjiK1K5iIuCWMX3/a0Id1a
         yTYY3A4tvHLqdBe591dOgpgWtXLg96+oyHZX7uZuEp9Bk42fMLDQkdPniBekGT4YT+1L
         rlMQ==
X-Gm-Message-State: AOJu0YxT+rVM4f8Wn+2n1kMFs9B/Bm0qxkercCmfFcT+i62JkwMeHjvV
	ZPXS72vtGtWjhYp0ubz5CH7wqWH03vKUS5GVkLzOHH2n0zovBW12YF0+uGbLdwM=
X-Gm-Gg: ASbGncu8/xdi9u0NflOkcjN0CApXlgA6wDDc41ABOE+krW6gQ+qKb9pWX5VtCt1Ierd
	cPic4Nd0H7Cqim4UgERob+3hOzt6tguoClUt83b5BbqJFoh0ANrkSq+Cp+fKX+cP3V7eSMnN3gi
	nbLAJOp7UqoC6jv8+sELFJPh/Ovr5mKSH6s5NaS0eqiC88Z/Q3bptdqz/IkPS3VXg68POiWSkFv
	JZW6/rBLhYE83kOnDjJyC7SCwP0o/dcRLnXYvD/O0WfH57LuLb0ygq5gKYfuC4qC9BGa1YB8T0O
	pPeiGAm5LiMDmV1kutZMT14zagIH8NDJc8Wa8UM1ZKjKE5z5e0A9Y/z3UaOVtSMlWbiX1uV+jL4
	myA==
X-Google-Smtp-Source: AGHT+IG0FEohissnX7GHwHjDbG0MFYzaMeTAWvg56TPHQkkNC0C7s+N8A/CukxDM0ny+5E1mbyaHfw==
X-Received: by 2002:a05:6902:138c:b0:e6b:80e3:2cfb with SMTP id 3f1490d57ef6-e7275bc359dmr7520636276.28.1744893532186;
        Thu, 17 Apr 2025 05:38:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e70a67680ccsm1320472276.55.2025.04.17.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:38:51 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:38:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 06/13] btrfs: introduce space_info argument to
 btrfs_chunk_alloc
Message-ID: <20250417123849.GA3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <bf7314dc720dbeb1de64b95512cc796fdaba7ef3.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7314dc720dbeb1de64b95512cc796fdaba7ef3.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:11PM +0900, Naohiro Aota wrote:
> Take an optional btrfs_space_info argument in btrfs_chunk_alloc(). If
> specified, btrfs_chunk_alloc() works on the space_info. If not, the default
> space_info is used as the same as before.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For consistency sake I'd prefer if you'd just update the callers to lookup the
space_info and pass that in as appropriate.  In fact a lot of these callers
already have the block group or space_info available, so we could avoid the
extra overhead of doing a lookup

> ---
>  fs/btrfs/block-group.c | 19 ++++++++++++-------
>  fs/btrfs/block-group.h |  3 ++-
>  fs/btrfs/extent-tree.c |  2 +-
>  fs/btrfs/space-info.c  |  2 +-
>  fs/btrfs/transaction.c |  2 +-
>  5 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b700d80089d3..12cc9069d4bb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3018,7 +3018,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  		 */
>  		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
>  		if (alloc_flags != cache->flags) {
> -			ret = btrfs_chunk_alloc(trans, alloc_flags,
> +			ret = btrfs_chunk_alloc(trans, NULL, alloc_flags,
>  						CHUNK_ALLOC_FORCE);

Here we just do cache->space_info;

>  			/*
>  			 * ENOSPC is allowed here, we may have enough space
> @@ -3047,7 +3047,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  		goto unlock_out;
>  
>  	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
> -	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> +	ret = btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);

Same here.

>  	if (ret < 0)
>  		goto out;
>  	/*
> @@ -3899,7 +3899,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
>  {
>  	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
>  
> -	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
> +	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);

Here we'd have to lookup.

>  }
>  
>  static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
> @@ -4102,12 +4102,15 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
>   *    - return 0 if it doesn't need to allocate a new chunk,
>   *    - return 1 if it successfully allocates a chunk,
>   *    - return errors including -ENOSPC otherwise.
> + *
> + * @space_info can optionally be specified to make a new chunk belong to it. If
> + * it is NULL, it is set automatically.
>   */
> -int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
> +int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
> +		      struct btrfs_space_info *space_info, u64 flags,
>  		      enum btrfs_chunk_alloc_enum force)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_space_info *space_info;
>  	struct btrfs_block_group *ret_bg;
>  	bool wait_for_alloc = false;
>  	bool should_alloc = false;
> @@ -4146,8 +4149,10 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return -ENOSPC;
>  
> -	space_info = btrfs_find_space_info(fs_info, flags);
> -	ASSERT(space_info);
> +	if (!space_info) {
> +		space_info = btrfs_find_space_info(fs_info, flags);
> +		ASSERT(space_info);
> +	}
>  
>  	do {
>  		spin_lock(&space_info->lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 36937eeab9b8..c01f3af726a1 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -342,7 +342,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
>  			     bool force_wrong_size_class);
>  void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
>  			       u64 num_bytes, int delalloc);
> -int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
> +int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
> +		      struct btrfs_space_info *space_info, u64 flags,
>  		      enum btrfs_chunk_alloc_enum force);
>  int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
>  void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a68a8a07caff..1dad1a42c9c1 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4159,7 +4159,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  				return ret;
>  			}
>  
> -			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
> +			ret = btrfs_chunk_alloc(trans, NULL, ffe_ctl->flags,
>  						CHUNK_ALLOC_FORCE_FOR_EXTENT);

We'd have to look up here.

>  
>  			/* Do not bail out on ENOSPC since we can do more. */
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d6d33ab754ba..2489c2a16123 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -817,7 +817,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
>  			ret = PTR_ERR(trans);
>  			break;
>  		}
> -		ret = btrfs_chunk_alloc(trans,
> +		ret = btrfs_chunk_alloc(trans, space_info,
>  				btrfs_get_alloc_profile(fs_info, space_info->flags),
>  				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
>  					CHUNK_ALLOC_FORCE);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 39e48bf610a1..670e0527996c 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -763,7 +763,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	if (do_chunk_alloc && num_bytes) {
>  		u64 flags = h->block_rsv->space_info->flags;
>  
> -		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
> +		btrfs_chunk_alloc(h, NULL, btrfs_get_alloc_profile(fs_info, flags),
>  				  CHUNK_ALLOC_NO_FORCE);

Here we just do h->block_rsv->space_info.  Thanks,

Josef

