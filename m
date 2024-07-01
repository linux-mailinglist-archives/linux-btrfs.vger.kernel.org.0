Return-Path: <linux-btrfs+bounces-6099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F291E1DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D951C21B1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665B15FD15;
	Mon,  1 Jul 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pjX6dQrW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9515F41E
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842833; cv=none; b=g7qmoqEWaI4fG+k5femui9J/JUVPunCozYoCFdv6DJGTteSYUsnvzmw/K8ODdl/3nuDdsj2UGozcVHB4K7fiFJe/zjTDOWUzzGVsEbu9y8YEvmZl1NEsy/nvU9OlkRKQQMkKDlZcvTWJMucLtC3IXzeNSHCVx9drnp0nqRAb94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842833; c=relaxed/simple;
	bh=GWxUadjMd8EeQuyJnyGncMegFmbcFmckibO73fnPsrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYYXejwjflUclBFuUHLZQ12NlQsA+4HD63W4+PxgGOhHcE2uskkVGzj71a9jUyX1XtMor/PiTRO0yScB7zqnAXF1emjSek0GmlQOKpIjWYZ0PkhUC86ZLhYlgk9PKiwV9FTUl8/R7AtjoXQkjii4IvSLEcIFK5pl/QZLqvy3D08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pjX6dQrW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b553b1a159so14183116d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719842831; x=1720447631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++020ywjg0SsahrAB68jHUSpG5yq6AbUleeNEo1NTT0=;
        b=pjX6dQrWsgfNR4pRBpACk1RQJlSOG+b19vT+YpvHfYc98U0jsZfSJwBNIyAvIg6gIr
         6VWZzhamOhD4D7ATNz+wZqD2pxK8Pc4qacKbUTApliWCDl4LoZnRD/1eJQZLIWFvPO/X
         y53qZti37QdAJaOmv+TrmxNj7nHrxnQ5MnAy87wJRBUPDgfwj2CyqYpZyGjzubHXGv5B
         jNJrZdS2+x/6hY5yFK/Pdyb4Ez2GDnOierKWle6ZMd1GE/V76l+HQAHQJ0ELxgaOxKdW
         HgjUnVi0dE8qtRbHv2DOxUsiMYcmZAuECm28CQyOnyCxKJZbzYhBkEnSzNg56bZeKCTD
         iRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842831; x=1720447631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++020ywjg0SsahrAB68jHUSpG5yq6AbUleeNEo1NTT0=;
        b=O1KYbTzMeMtL2C8x6VfWqkA9CqQjI3MiFEI6z5HiC4JoWwfq11KtNzfGMs48ilTjNY
         86fGDcriK7L9t2IpX8BBN2RvwhdPHWfHX8ulfN2TL8cPa9xnHIeJ+TZmS/CAj2i7pOPB
         u+gaJjIkEB4m2hpoFk2B64KbmPrvbHGvG0sQJo7ZSwaz0accOZesSCLHOSgO67b4qFxI
         07tatMNpjQltMhK+T3YMILPAWEYFx4LEGhThj8o//cIHsw6ZIHO20NJS53XR6A0uQY7o
         oC/IBKRXPcIudLyVlplBp6Fo3YDp8WTT0CsT8GW7INkaMdO0xhivndm/qzE++IZnm0SL
         Ba4g==
X-Forwarded-Encrypted: i=1; AJvYcCXmv8Wv0gJMC7bSe3u+azVN5Y+B6hz6iWoOBP5NaEie9dLJqQm2uP+7aHdJkZ1cR+uDn3CUvm3NKbClkCXGy8WsN4gDdktsg9Js5ck=
X-Gm-Message-State: AOJu0Yyj0FJSCqMhFpm1OZdvfDDBWNrJPhFgDAWVKD0u47Hqv9Xjt04X
	o8vunSFFT5g76eTNDhJ8BG8dsWeeNJoygRooCzj+Sn3tyAgRyrPnWGFIIiu7c2o1OnxUXP0ZnJr
	O
X-Google-Smtp-Source: AGHT+IGGRUGVODA/CYNuU7Cfwb94JKUvEdzlRRo0OdesqLUupWgo2L3l3x6zC24/jpTdwjSNwgJ47g==
X-Received: by 2002:a05:6214:d61:b0:6b5:6331:4d4 with SMTP id 6a1803df08f44-6b5b71794f8mr71117376d6.51.1719842830498;
        Mon, 01 Jul 2024 07:07:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5ac3101fcsm27240546d6.125.2024.07.01.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:07:09 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:07:09 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 2/5] btrfs: split RAID stripes on deletion
Message-ID: <20240701140709.GF504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-2-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-2-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:16PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> The current RAID stripe code assumes, that we will always remove a
> whole stripe entry.
> 
> But if we're only removing a part of a RAID stripe we're hitting the
> ASSERT()ion checking for this condition.
> 
> Instead of assuming the complete deletion of a RAID stripe, split the
> stripe if we need to.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.c            |   1 +
>  fs/btrfs/raid-stripe-tree.c | 100 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 77 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index e33f9f5a228d..16f9cf6360a4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
>  	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>  
>  	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
> +	       key.type != BTRFS_RAID_STRIPE_KEY &&
>  	       key.type != BTRFS_EXTENT_CSUM_KEY);
>  
>  	if (btrfs_leaf_free_space(leaf) >= ins_len)
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 3020820dd6e2..64e36b46cbab 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -33,42 +33,94 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  	if (!path)
>  		return -ENOMEM;
>  
> -	while (1) {
> -		key.objectid = start;
> -		key.type = BTRFS_RAID_STRIPE_KEY;
> -		key.offset = length;
> +again:
> +	key.objectid = start;
> +	key.type = BTRFS_RAID_STRIPE_KEY;
> +	key.offset = length;
>  
> -		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
> -		if (ret < 0)
> -			break;
> -		if (ret > 0) {
> -			ret = 0;
> -			if (path->slots[0] == 0)
> -				break;
> -			path->slots[0]--;
> -		}
> +	ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto out;
> +	if (ret > 0) {
> +		ret = 0;
> +		if (path->slots[0] == 0)
> +			goto out;
> +		path->slots[0]--;
> +	}
> +
> +	leaf = path->nodes[0];
> +	slot = path->slots[0];
> +	btrfs_item_key_to_cpu(leaf, &key, slot);
> +	found_start = key.objectid;
> +	found_end = found_start + key.offset;
> +
> +	/* That stripe ends before we start, we're done. */
> +	if (found_end <= start)
> +		goto out;
> +
> +	trace_btrfs_raid_extent_delete(fs_info, start, end,
> +				       found_start, found_end);
> +
> +	if (found_start < start) {
> +		u64 diff = start - found_start;
> +		struct btrfs_key new_key;
> +		int num_stripes;
> +		struct btrfs_stripe_extent *stripe_extent;
> +
> +		new_key.objectid = start;
> +		new_key.type = BTRFS_RAID_STRIPE_KEY;
> +		new_key.offset = length - diff;
> +
> +		ret = btrfs_duplicate_item(trans, stripe_root, path,
> +					   &new_key);
> +		if (ret)
> +			goto out;
>  
>  		leaf = path->nodes[0];
>  		slot = path->slots[0];
> -		btrfs_item_key_to_cpu(leaf, &key, slot);
> -		found_start = key.objectid;
> -		found_end = found_start + key.offset;
>  
> -		/* That stripe ends before we start, we're done. */
> -		if (found_end <= start)
> -			break;
> +		num_stripes =
> +			btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
> +		stripe_extent =
> +			btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
> +
> +		for (int i = 0; i < num_stripes; i++) {
> +			struct btrfs_raid_stride *raid_stride =
> +				&stripe_extent->strides[i];
> +			u64 physical =
> +				btrfs_raid_stride_physical(leaf, raid_stride);
> +
> +			btrfs_set_raid_stride_physical(leaf, raid_stride,
> +							     physical + diff);
> +		}
> +
> +		btrfs_mark_buffer_dirty(trans, leaf);
> +		btrfs_release_path(path);
> +		goto again;
> +	}
> +
> +	if (found_end > end) {
> +		u64 diff = found_end - end;
> +		struct btrfs_key new_key;
>  
> -		trace_btrfs_raid_extent_delete(fs_info, start, end,
> -					       found_start, found_end);
> +		new_key.objectid = found_start;
> +		new_key.type = BTRFS_RAID_STRIPE_KEY;
> +		new_key.offset = length - diff;
>  
> -		ASSERT(found_start >= start && found_end <= end);
> -		ret = btrfs_del_item(trans, stripe_root, path);
> +		ret = btrfs_duplicate_item(trans, stripe_root, path,
> +					   &new_key);

This seems incorrect to me.  If we have [0, 1MiB) and we're deleting [0,512KiB)
then the tree at this point is

[0, BTRFS_RAID_STRIPE_KEY, 512KiB]
[0, BTRFS_RAID_STRIPE_KEY, 1MiB]

which is valid as far as key ordering goes, but is a violation of the raid
stripe tree design correct?  And then you do goto again, and then you'll delete

[0, BTRFS_RAID_STRIPE_KEY, 512KiB]

but leave the old one in place, correct?  Thanks,

Josef

