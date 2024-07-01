Return-Path: <linux-btrfs+bounces-6114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C501591E9AF
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7A81C2306E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDFC17164C;
	Mon,  1 Jul 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iU17PC+y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3616DEAD
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866256; cv=none; b=t31/Va9euWN8Y798fLblnN1lAfi9H8DbXpf5vXdwEJGyp7sL6rvVmJi935Xf1xfQfhNeJhNC/QoWrMjuWByA8HubBHduI8GW2wbTpprFaADV4yDeNjhy4ZXHF3Wr2tpGTeJtj1dkltTkpk99Gc+IfiiKaP7Ympc/gyG57djJr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866256; c=relaxed/simple;
	bh=GDXQqQl49imr9gId7LhYIe5sv/DBl9egH625p/1ONLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCLIMB2SeHN+gVN/EyA95UH+H59cnF80sDt/AaBk7nxjARTeVy1i5ga/+aJWkIcSjnGqKJs6SxuAzYvaxx3B96sIzR0N0Hll4F8gmOeokzYTyNuRb+gU5JqXaH5pi4x7P/WLHUJk45lvl7QOFUC5dugXfttJzaA0NRmouR71tFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iU17PC+y; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70211abf4cbso1103732a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719866254; x=1720471054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDKV6Lk3k3cbXDKwxmMPoqdaJonjZZSGWKnYU0oW01M=;
        b=iU17PC+yy7H1pxq20Mrs2iLJyDX7fi/ZazV5+E6wXEiJbUguFIc2VvAtcEXYJcIvIe
         T06abxMjnqiNKNZE1FCffEtHz7iX3GbpDQjArqESQxjv7tGYADOcXn3Iz4oIK4RB9RJE
         AhAw05ZmPt2GSGTGT3iZg4wZoiSWE2+YOR3K6ZgXJbHdBqB4ezYiiUTnhNRhE92NFrIh
         dM/Jlhl8PUE0BBO+DpmEaK+5kK936L/NYp2TrYyugKKajAe99Cnb5icwBDBbFN9I3vWT
         Pp+NlstZqOVCIvzVXlenP+vnOQyJfdMhNIkBjFp7dXcqDwV3WMTM6zZibRl1JEz6CI8T
         ZBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866254; x=1720471054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDKV6Lk3k3cbXDKwxmMPoqdaJonjZZSGWKnYU0oW01M=;
        b=kv2mbL7TdXdZq8CkNOc4Gnjee+t6mI2qZ3zz8nGbFDjTGDwgc+glCo+7o2UlymSHJN
         oL6yk/5XzgtKD6qGu/hIOaFgSyWUedDPbg+7jfx+vjJIIuXmxc+bPM1uLZNNVHZREHmV
         nLflWH3yCg8gK1d9dLiBUiQUsZZYrBncQ+D63D61Z46JxjZkUFRniZsKRzJsq4Oge/O5
         dcSTkm7ho7wBVSk+RBiIbrPz+zB2awc0nwICKJZQ8R4eJJaN9TLtRD9gGQHbMGE3XK5E
         61WvYS9eRzXl/ep+7Yj9VIovpZB2s8dn8fWFHqcZYD2NpoeqzOKupZy9sGDAVNlQfOiZ
         mmtg==
X-Forwarded-Encrypted: i=1; AJvYcCVLiYZncFAONLHIM2oUO2qEiqbz5Cm5Po85l/aHXxF0pNPAo36f5VXgtacqa7Ma/KkyPu2sGhDE7JzSqTaZUO89oCxdCNJs+CGgJ1o=
X-Gm-Message-State: AOJu0YzricqsKEvyYC5FJy3M8UJhgdZGCh0NfNgICdnpdVeM3ccP5VKJ
	9mwGVLLcUr32qx2IcVgdv7TCJpbfnOCLFUheJo0ve9VOIwEA7CGgELxUocc0U/g=
X-Google-Smtp-Source: AGHT+IHA2fLEb6qaWdB+JmKOUVVoS4TPjbdpXIqXHuLmzi8+vn0Nwhlo8DLIsvzdPddTKnE6J7Aopw==
X-Received: by 2002:a05:6830:2b1e:b0:701:f8d0:eb44 with SMTP id 46e09a7af769-702076a4747mr10637764a34.34.1719866253734;
        Mon, 01 Jul 2024 13:37:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308b24sm382103785a.123.2024.07.01.13.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:37:33 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:37:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Message-ID: <20240701203732.GC510298@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:15PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> If we can't insert a stripe extent in the RAID stripe tree, because
> the key that points to the specific position in the stripe tree is
> already existing, we have to remove the item and then replace it by a
> new item.
> 
> This can happen for example on device replace operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..3020820dd6e2 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  	return ret;
>  }
>  
> +static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
> +				    struct btrfs_key *key,
> +				    struct btrfs_stripe_extent *stripe_extent,
> +				    const size_t item_size)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
> +	if (ret)
> +		goto err;
> +
> +	ret = btrfs_del_item(trans, stripe_root, path);
> +	if (ret)
> +		goto err;
> +
> +	btrfs_free_path(path);
> +
> +	return btrfs_insert_item(trans, stripe_root, key, stripe_extent,
> +				 item_size);
> + err:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>  static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
>  					struct btrfs_io_context *bioc)
>  {
> @@ -112,6 +143,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
>  
>  	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
>  				item_size);
> +	if (ret == -EEXIST)
> +		ret = replace_raid_extent_item(trans, &stripe_key,
> +					       stripe_extent, item_size);

I had another thought, how often is this particular thing happening?  Bec ause
we're doing 3 path allocations here in the worst case.  If it happens more than
say 10% of the time then we need to allocate a path once in
btrfs_insert_one_raid_extent(), do the insert, and if it fails re-use that path
to do the delete and insert the new one.  Thanks,

Josef

