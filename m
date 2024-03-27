Return-Path: <linux-btrfs+bounces-3671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED1F88ECBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E622A37CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBC714E2FB;
	Wed, 27 Mar 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+qoq7Lz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D814D6EB;
	Wed, 27 Mar 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560987; cv=none; b=RQ2SvmzB8cqtDEQAZ2HhlQ7Y/sWXUAmCMk3BJBjO6gglBXk162Vf5Ks4VCo7crFg21FVbryZ4g/j44e1MWRY0A8UfiVx9pqAEGpFX9OeCvNkHhEgl1z/CEGXQzl+iFKM5lscSG2NmGNSzlwtB80XpcwjeTzmfTOrr/cCNFJj1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560987; c=relaxed/simple;
	bh=cWaCG28zJkm98H31xyHfUQpcHOiqdwVVgqTNYJ9YJgI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgWCo16fPd7Qshc7hSlktadvYN7j9CXDnukvGzTwEIVDZzHpP0w4hgQQf2Ay0YhJnJZnwZgFtdR67SFG7tjaVYmsuHxcIslIITEHHEfmJo1EVJij/xafGrm9vHbVz9Q3jZgJU+bnuKuS9QyC18Ja4cCsAOZ7U6K7DKIso7EZM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+qoq7Lz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so863728a12.1;
        Wed, 27 Mar 2024 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711560985; x=1712165785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHCOAlgP+RIdoP4a7OKKrPxNyvaC9b/HjUd6I9+eo/w=;
        b=b+qoq7LzEMyNyBVLaV8ftuvgxhcl7xzn6kmHqO6ohfyI9tUeYTKDJ4yaFmRmyghf0v
         MmZxfwuCMW1ESvZ1i0WgGfBxYuyKMBfjZ078FS+XkNi3v/1L459yoV93LUQ1AunCfc5w
         W+hwixY8Lzi6dLt8TtcvVr6K1BYTJa0VgATRl0OF8yvUlLh2+WbtqqZv76afZCsHfK+j
         c1JrfGJaqQRY8zZkaAjvBehBWnuGPSukNQ8uaCj9XlaE0XWPQf44D4BVeL5LPiwXvMAg
         sSqRIc7va53ST44xr1DpX8SrHhCdn/5RnLI3SKCqsHMW1BrE4XlB559UphXVCNQ7f2h8
         Oojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711560985; x=1712165785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHCOAlgP+RIdoP4a7OKKrPxNyvaC9b/HjUd6I9+eo/w=;
        b=Qx0xV5fYNYyoKd3SU4jnHLGMfB4TNa9yZLrA2Y6KHpln9tkmjhIFKYCe3a+oxE9lKw
         MfM1ds2kv9npsBxLvRZ5vDEp7YHvFFjusaINKxLr5YdOxDbjXbXLlAm5WxSx3d0SSD3H
         b+aiCHBJNtrVvrxo26e1c1dppazJQnvITqeYwquEMmOJ91T+NPHATeC5nisCw2DTwHuS
         KgQwaGQsGR2zkU4M/85XY32XKdIQH2vK2ooGNRvVd7X3bMawk1w1L5xsdWAamBdW0dZJ
         xsWuuFO/K6+1ZbAVel9cBI2cFKeB/SM3xNVm8jpFqDlUn6nBQwtAcl50uLD1kotFN/nR
         2COw==
X-Forwarded-Encrypted: i=1; AJvYcCUpz/qJmuuLtNzCsYzA0UOujz4nDh5kCG09RsfjLqulLepnll6oGsAqobCKyYW0arZp6GrQO0p0bVU5ep3RG/SwuzsionKSlMSUCRTLorky9SRYQfIAnqQYNtY1N/EjnLo78RNJXeZHnXNqddfzM0BFI2SgwLzdAagoFGoCrkao3Mob7zc=
X-Gm-Message-State: AOJu0Yy3+1hpWTsM2tOxOjHtZ0kRp+mkKG4OPwU705oEC9/rruBOkUgn
	Hd3KsUSmqdvgvRPakbVx/Sj/CP5TMb5Bb9jD+GaNiZoCXwPHY+/c
X-Google-Smtp-Source: AGHT+IG/AWAK7KwS4lSF3LbvG9OVcciFVrPD8IZ1b9bJpDPw13vvsS/XGcrI/P46dXxEHF5sMgm8+w==
X-Received: by 2002:a17:90b:2d0b:b0:2a0:967e:2ac with SMTP id sy11-20020a17090b2d0b00b002a0967e02acmr387091pjb.3.1711560984960;
        Wed, 27 Mar 2024 10:36:24 -0700 (PDT)
Received: from debian ([2601:641:300:14de:303a:e988:70bc:e778])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090abb0e00b0029c49ed3974sm1982913pjr.37.2024.03.27.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:36:24 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 27 Mar 2024 10:36:10 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Message-ID: <ZgRZCrxMkAtdT9Ta@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:18PM -0700, Ira Weiny wrote:
> Code to support CXL Dynamic Capacity devices will have extent ranges
> which need to be compared for intersection not a subset as is being
> checked in range_contains().
> 
> range_overlaps() is defined in btrfs with a different meaning from what
> is required in the standard range code.  Dan Williams pointed this out
> in [1].  Adjust the btrfs call according to his suggestion there.
> 
> Then add a generic range_overlaps().
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> [1] https://lore.kernel.org/all/65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch/
> ---
>  fs/btrfs/ordered-data.c | 10 +++++-----
>  include/linux/range.h   |  7 +++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 59850dc17b22..032d30a49edc 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -111,8 +111,8 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
>  	return NULL;
>  }
>  
> -static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
> -			  u64 len)
> +static int btrfs_range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
> +				u64 len)
>  {
>  	if (file_offset + len <= entry->file_offset ||
>  	    entry->file_offset + entry->num_bytes <= file_offset)
> @@ -914,7 +914,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>  
>  	while (1) {
>  		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			break;
>  
>  		if (entry->file_offset >= file_offset + len) {
> @@ -1043,12 +1043,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
>  	}
>  	if (prev) {
>  		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			goto out;
>  	}
>  	if (next) {
>  		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
> -		if (range_overlaps(entry, file_offset, len))
> +		if (btrfs_range_overlaps(entry, file_offset, len))
>  			goto out;
>  	}
>  	/* No ordered extent in the range */
> diff --git a/include/linux/range.h b/include/linux/range.h
> index 6ad0b73cb7ad..9a46f3212965 100644
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> @@ -13,11 +13,18 @@ static inline u64 range_len(const struct range *range)
>  	return range->end - range->start + 1;
>  }
>  
> +/* True if r1 completely contains r2 */
>  static inline bool range_contains(struct range *r1, struct range *r2)
>  {
>  	return r1->start <= r2->start && r1->end >= r2->end;
>  }
>  
> +/* True if any part of r1 overlaps r2 */
> +static inline bool range_overlaps(struct range *r1, struct range *r2)
> +{
> +	return r1->start <= r2->end && r1->end >= r2->start;
> +}
> +
>  int add_range(struct range *range, int az, int nr_range,
>  		u64 start, u64 end);
>  
> 
> -- 
> 2.44.0
> 

