Return-Path: <linux-btrfs+bounces-8172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8397EE4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 17:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6462DB219C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6D19415E;
	Mon, 23 Sep 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oqjO3UPn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF098F6E
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105731; cv=none; b=Ma6Aku3DegqLeGY9T0n+J/DnyWx6lWhFIu9SKUVYnNSXhlxVgioaz1xldjny4/nejR8dNnF4PzNg9DrsEHOQ1oO3Eo/mE2t/q/gM5GAN8sM4qRQveD7Eh6ks3SuOvy3XqzZg3A7WiWrIK4mefNnH+GrtuT9Yn58c2K9XfInxihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105731; c=relaxed/simple;
	bh=CuX8plZrAsjJPZFuVo718HS91JHUPRkgdyb2aOOvnYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFMdeAZylUMd0gXFggONZkwMMH1W6MhPXUVJj7h2q3irCdf1+1orhYtZ8f4t1yuVuFa7CwIzOzRbG3d9MuY+b8AveR2ntFI9MhTWoRTtkGG+C79L0tlXAS4dywdkMos63WA3AnzFqimuMjdoYo/TRI6A7VrRyerRNmJHW1+tA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oqjO3UPn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e22531db3baso2508745276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727105729; x=1727710529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAtYhXfjzeyW4ugEIaLLdlY67SyPLOib8m1Uit/Y/cw=;
        b=oqjO3UPnnEMXcF47e0qtu1zds9DwHS74dFdH4qpmT9zbaRoiR3Q5oODhjZlCFDt2bH
         fqOEE/+XYrWRqzGFnQcl5ZK31LKPePHOEcJByGnDWVw05wUzbzqXM9D4zsIs6BRT2ULB
         P9BznIvCDYfiWHnq2/5W+P0Yelg0BAANGfxUFyvOWDmjE0BVbSm1FMFllVlWb6FiFnng
         9S/1hUdwLjOTEV9lsLVgzOrXleZSVlp3mn/KyZibvYaEKKR00wXwBaE6ZpBo2PNYI3dO
         eWpKTzsr39tac4OOnzc/Wlk8r0BSvvaOISoGzthcArq/Zr3pwhF8TQlBf0Ptnog+b8Dl
         rJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105729; x=1727710529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAtYhXfjzeyW4ugEIaLLdlY67SyPLOib8m1Uit/Y/cw=;
        b=jTc+S+E7N4Y0oiW/Ic5MeVEn/aH20hUDJQpMd07YVPi/UslTZZ55xOWzP+iMiIOJ35
         9ENgC0eqOPNb13ErFR8pizdTXSK4zCPV5uhLk/YffAT6wHBomjNkyE8pfJpGQNFrjRdP
         q/BTcGMHzCnQgIk6WFkck4jYCjZNsM3hNafhQToNyt0h/MFP5mBHyRPodBmlvg70VWAE
         Ms9xPUPj/VF1MVZrmkhTdRApJso66EsYUNYWq/KN8QMoItBjVR4p4ZjBVPmWeLMII5ep
         FOl03R99ICJ89ATaU+lc3pgIktxqBcdGfmxzDV2RT8xxppRDVSw9wzyV3IsW3i9N3mDD
         zHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUZrTw5svukaljiUzyONX+VLzT+tsS+AxcbKrHGU6bGqbEHrQCWo0+BGwOO8XjB1qLPdcgstp/av6/SRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyR5xdo+qC5sipOvMTH9QT0GdAszOtDGdKEZmMpBhVZOBn90n
	HD1XhpZVjYrUTPaSVhO4Of2L9XYg8tGghFhK9BUTJ9bzarNfhlnYSgXO4uIlwkI=
X-Google-Smtp-Source: AGHT+IEi4dVbenN9g8ccGGyWmlovmoPE4Jmp3BdrShWfA6qR/q6u+hoDHbrOg1OSEobdFdKoirYfSw==
X-Received: by 2002:a05:6902:2e0d:b0:e1a:8857:96dd with SMTP id 3f1490d57ef6-e2250c47473mr8868625276.31.1727105728763;
        Mon, 23 Sep 2024 08:35:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e202117105fsm2058423276.49.2024.09.23.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:35:28 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:35:27 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: stripe-tree: correctly truncate stripe extents
 on delete
Message-ID: <20240923153527.GC159452@perftesting>
References: <20240911095206.31060-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911095206.31060-1-jth@kernel.org>

On Wed, Sep 11, 2024 at 11:52:05AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> In our CI system, we're seeing the following ASSERT()ion to trigger when
> running RAID stripe-tree tests on non-zoned devices:
> 
>  assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64
> 
> This ASSERT()ion triggers, because for the initial design of RAID stripe-tree,
> I had the "one ordered-extent equals one bio" rule of zoned btrfs in mind.
> 
> But for a RAID stripe-tree based system, that is not hosted on a zoned
> storage device, but on a regular device this rule doesn't apply.
> 
> So in case the range we want to delete starts in the middle of the
> previous item, grab the item and "truncate" it's length. That is, subtract
> the deleted portion from the key's offset.
> 
> In case the range to delete ends in the middle of an item, we have to
> adjust both the item's key as well as the stripe extents.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> Changes to v1:
> - ASSERT() that slot > 0 before calling btrfs_previous_item()
> 
>  fs/btrfs/raid-stripe-tree.c | 52 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 4c859b550f6c..075fecd08d87 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -61,7 +61,57 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  		trace_btrfs_raid_extent_delete(fs_info, start, end,
>  					       found_start, found_end);
>  
> -		ASSERT(found_start >= start && found_end <= end);
> +		if (found_start < start) {
> +			struct btrfs_key prev;
> +			u64 diff = start - found_start;
> +
> +			ASSERT(slot > 0);
> +
> +			ret = btrfs_previous_item(stripe_root, path, start,
> +						  BTRFS_RAID_STRIPE_KEY);
> +			leaf = path->nodes[0];
> +			slot = path->slots[0];
> +			btrfs_item_key_to_cpu(leaf, &prev, slot);
> +			prev.offset -= diff;
> +
> +			btrfs_mark_buffer_dirty(trans, leaf);
> +
> +			start += diff;
> +			length -= diff;
> +
> +			btrfs_release_path(path);
> +			continue;
> +		}
> +
> +		if (end < found_end && found_end - end < key.offset) {
> +			struct btrfs_stripe_extent *stripe_extent;
> +			u64 diff = key.offset - length;
> +			int num_stripes;
> +
> +			num_stripes = btrfs_num_raid_stripes(
> +				btrfs_item_size(leaf, slot));
> +			stripe_extent = btrfs_item_ptr(
> +				leaf, slot, struct btrfs_stripe_extent);
> +
> +			for (int i = 0; i < num_stripes; i++) {
> +				struct btrfs_raid_stride *stride =
> +					&stripe_extent->strides[i];
> +				u64 physical = btrfs_raid_stride_physical(
> +					leaf, stride);
> +
> +				physical += diff;
> +				btrfs_set_raid_stride_physical(leaf, stride,
> +							       physical);
> +			}
> +
> +			key.objectid += diff;
> +			key.offset -= diff;

This part was confusing and isn't necessary, you can drop this bit and then add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

