Return-Path: <linux-btrfs+bounces-13133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA95A91C98
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C161769B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7C243953;
	Thu, 17 Apr 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yeoyN79z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E433770B
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893836; cv=none; b=PJtL3rrZ3HqCGTmVlXJ+MsUS+IttnB3E9/fC+BqdxrjBGUvmJ5ZAjvqMh++NY5M1yvbS5PND/IvXQFYttpqQg8z41NTJHDeoWYOM8AqBkDKL3ItDt/kOqJMP8OdgnRUVx+5GS+7LBC+xRhaovp9i2NjEU4yg+5XxvJOu2ybO6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893836; c=relaxed/simple;
	bh=2GzapIcDoz/MQgMcDwEnIJvddM7OHrFuzWabYW/QIHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnmE9ZfdiGz4cX8ORfoZFlgTZatkjzF3RHES6gCWitylL4Uz98HJ77M/oBYvKoAp9779JxI1iAtZ66T6Vu1MFcq3NZa2A4czNbdtZNGKC4hHUJh/7aHsc9+40vs9/XHOKDrcG7QoPK1XJCdMaDsdZG4wmGuh6dr6ITOdEhAmgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yeoyN79z; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6feab7c5f96so6329977b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744893834; x=1745498634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6D2O1Gdv/PtRYzebAtT+dNCMGWz9EfBb3p2o/a2qW5E=;
        b=yeoyN79zoDP4gvhlHePgApYER6nz3pl2YlfyYs2AiUwsRWzmGd9jGxHscmjWZj0qKX
         RxuEmah6FGnG0akYhmJhGqbjUyBO9qMVNUY0Lyd7hY+CigjCp5OhbxnAGBIBOMGk18Ux
         XTsu5b4AlX8lMVRBpHWkjiRy/aoVSruQV8tJTujumvUaZzr2O8AvvXoiYPWuh2/NwA9v
         V9di4P3ZGiRFtBvlXjEZ849fb81WHS/DY0C7ERioIUV+Ko20HANPW7fXaj/POOEfAHpd
         3Su8jiVVQKr10dNA1iPQZ/uWaQqFePiIreIJa1unJuco1PlgeGnbkDbmtPw/nUVDIz9C
         5Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893834; x=1745498634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D2O1Gdv/PtRYzebAtT+dNCMGWz9EfBb3p2o/a2qW5E=;
        b=fYxDbIIV+Q9mSD0F7g67iNfZfmafsN04OkWygqOHaLXzj3frrWSgIRH95hbzP5NwH0
         B18AHuh68eIULV0NXAhYSy95oVSAUnF2pFW35uN7j+5IRgz8KF71OMwHOlAj3jDhSpsZ
         3XXHz87tQNVg6/FcYFV1yaO6+fjbRgufu5GkdsNxvR9ibwpiIrIjpQLvLCVMwMg+g9Y6
         n2MK0e6iWaTBxw02tepDMWWKF2cokelsPIjcbFMpC8HsRIjd2Y9TddNoCA13Ya5qFC9R
         ztYVV5HKLhtUDkykpEkrabiKS5do8aVixOT3Ro82Nu7MddBTWlDHU2xF32IiJAR63shF
         fXLw==
X-Gm-Message-State: AOJu0Yy/KdzbgnsT8rwL3SBpsu/+FuGgw1RIaxodMH4Ll3zImBqekN+5
	OFqZ2oMjyIu+jRj61EPnCkE8U1YbZ/MEHsEpA4ZXfB36hZz0qbi/GZZ4oDJO4H1T2fLukgd2+3O
	x
X-Gm-Gg: ASbGncvd0f93d41cLQ96njML6PCJgVk89hFVSzaTZy9PA4GuiqY0KO12HhTCnhrZ9II
	RfvcCr2cxX855Flprzy6f9JJtnIrByKagdotjEj3mKTVK4/YMKkGqYXWXV2Ye83kVkniu2h/8Tn
	Jo6jb7PgT85ACoctxvoENxCWdxq0EM7YUGQDq4klharc5AYK3R46CzNZeSZJSiL8dNiYN2+khaV
	B249uDSOZ0w/ZeYpp0KWR9BPzoHqgVH9uFJKsyWTV/4grX5vXsel3nifxp6xJgkcmI+WnC/+yDK
	bIUn/eD9MLU4Y+B9q3mww+6XjoFeUcC1o0K81aiEu4q3Li8DAxqV3J0XL2DNXkcrQbtgIZvyT/O
	BSw==
X-Google-Smtp-Source: AGHT+IGdjuVNZ9h5NZOFecX56ohanXHVl+TkRL9Hg/e6z54aa10xoHK/XmmivT+7yqIpYZeFgwD9lw==
X-Received: by 2002:a05:690c:64c6:b0:6ef:761e:cfc with SMTP id 00721157ae682-706b336255fmr78784277b3.25.1744893833690;
        Thu, 17 Apr 2025 05:43:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706abaa589esm9819837b3.95.2025.04.17.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:43:52 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:43:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 08/13] btrfs: introduce btrfs_space_info sub-group
Message-ID: <20250417124351.GC3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <ad0d95fe1fec479076594e78dd8ff489ac0a1e83.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0d95fe1fec479076594e78dd8ff489ac0a1e83.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:13PM +0900, Naohiro Aota wrote:
> Current code assumes we have only one space_info for each block group type
> (DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
> manage special block groups.
> 
> One example is handling the data relocation block group for the zoned mode.
> That block group is dedicated for writing relocated data and we cannot
> allocate any regular extent from that block group, which is implemented in
> the zoned extent allocator. That block group still belongs to the normal
> data space_info. So, when all the normal data block groups are full and
> there are some free space in the dedicated block group, the space_info
> looks to have some free space, while it cannot allocate normal extent
> anymore. That results in a strange ENOSPC error. We need to have a
> space_info for the relocation data block group to represent the situation
> properly.
> 
> This commit adds a basic infrastructure for having a "sub-group" of a
> space_info: creation and removing. A sub-group space_info belongs to one of
> the primary space_infos and has the same flags as its parent.
> 
> This commit first introduces the relocation data sub-space_info, and the
> next commit will introduce tree-log sub-space_info. In the future, it could
> be useful to implement tiered storage for btrfs e.g, by implementing a
> sub-group space_info for block groups resides on a fast storage.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 11 +++++++++++
>  fs/btrfs/space-info.c  | 38 +++++++++++++++++++++++++++++++++++---
>  fs/btrfs/space-info.h  |  8 ++++++++
>  fs/btrfs/sysfs.c       | 16 +++++++++++++---
>  4 files changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 846c9737ff5a..475353b0b32c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4411,6 +4411,17 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
>  {
>  	struct btrfs_fs_info *info = space_info->fs_info;
>  
> +	if (space_info->subgroup_id == SUB_GROUP_PRIMARY) {
> +		/* This is a top space_info, proceeds its children first. */
> +		for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++) {
> +			if (space_info->sub_group[i]) {
> +				check_removing_space_info(space_info->sub_group[i]);
> +				kfree(space_info->sub_group[i]);
> +				space_info->sub_group[i] = NULL;
> +			}
> +		}
> +	}
> +
>  	/*
>  	 * Do not hide this behind enospc_debug, this is actually
>  	 * important and indicates a real bug if this happens.
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 2489c2a16123..37e55298c082 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -249,16 +249,38 @@ static void init_space_info(struct btrfs_fs_info *info,
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
>  	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
> +	space_info->subgroup_id = SUB_GROUP_PRIMARY;
>  
>  	if (btrfs_is_zoned(info))
>  		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
>  }
>  
> +static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flags,
> +				       enum btrfs_space_info_sub_group id)
> +{
> +	struct btrfs_fs_info *fs_info = parent->fs_info;
> +	struct btrfs_space_info *sub_space;
> +
> +	ASSERT(parent->subgroup_id == SUB_GROUP_PRIMARY);
> +	ASSERT(id != SUB_GROUP_PRIMARY);
> +
> +	sub_space = kzalloc(sizeof(*sub_space), GFP_NOFS);
> +	if (!sub_space)
> +		return -ENOMEM;
> +
> +	init_space_info(fs_info, sub_space, flags);
> +	parent->sub_group[id] = sub_space;
> +	sub_space->parent = parent;
> +	sub_space->subgroup_id = id;
> +
> +	return btrfs_sysfs_add_space_info_type(fs_info, sub_space);
> +}
> +
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
>  	struct btrfs_space_info *space_info;
> -	int ret;
> +	int ret = 0;
>  
>  	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
>  	if (!space_info)
> @@ -266,6 +288,15 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  
>  	init_space_info(info, space_info, flags);
>  
> +	if (btrfs_is_zoned(info)) {
> +		if (flags & BTRFS_BLOCK_GROUP_DATA)
> +			ret = create_space_info_sub_group(space_info, flags,
> +							  SUB_GROUP_DATA_RELOC);
> +		if (ret == -ENOMEM)
> +			return ret;
> +		ASSERT(!ret);
> +	}
> +
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)
>  		return ret;
> @@ -561,8 +592,9 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
>  	lockdep_assert_held(&info->lock);
>  
>  	/* The free space could be negative in case of overcommit */
> -	btrfs_info(fs_info, "space_info %s has %lld free, is %sfull",
> -		   flag_str,
> +	btrfs_info(fs_info,
> +		   "space_info %s (sub-group id %d) has %lld free, is %sfull",
> +		   flag_str, info->subgroup_id,
>  		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
>  		   info->full ? "" : "not ");
>  	btrfs_info(fs_info,
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 7459b4eb99cd..64641885babd 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -98,8 +98,16 @@ enum btrfs_flush_state {
>  	RESET_ZONES		= 12,
>  };
>  
> +enum btrfs_space_info_sub_group {
> +	SUB_GROUP_DATA_RELOC = 0,
> +	SUB_GROUP_PRIMARY = -1,
> +};
> +#define BTRFS_SPACE_INFO_SUB_GROUP_MAX 1

We want to avoid namespace pollution, so rename these to have a btrfs prefix,
and do something like

enum btrfs_space_info_sub_group {
	BTRFS_SUB_GROUP_DATA_RELOC = 0,
	BTRFS_SUB_GROUP_MAX,
	BTRFS_SUB_GROUP_PRIMARY = -1,
};

And then you can remove the define.  Thanks,

Josef

