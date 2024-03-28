Return-Path: <linux-btrfs+bounces-3739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EE890AA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0471F28470
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A12139CF1;
	Thu, 28 Mar 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kr4kmRks"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99B135A4D;
	Thu, 28 Mar 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656603; cv=none; b=aPZZPD0ZxZu8esOU7PLuOb5z3/vVDCh9c+kPhvyPl8WX26PgLu4Mv07a5VXT6pAguORkSztIGbmp1oP5O7W//s79D0ZHdTslwOEVDgx8bIgvuyLF55WxDUELaKKrzhspvN/ROzvSBiEbENz3YfeAt20WqAHAfOkHqy7ZUHJsYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656603; c=relaxed/simple;
	bh=B0boc5nHCqXEMmaaCwtZm9t/Mtn0OCgA0SpVDAjwwB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAdMZiNkxJVn4amjD+akpbwZjOMwnZsEW7JKyAzEDAjp7p/pOsEBtmJybB4AxIwmBbamXPs3DVirBFqbrC04tRDB0CqbDiFyKM1vQFDaO7p6laqHTmZwzXaHWcgtO6UFGWL5uk3D+BqhU+diCrX3ZZriXIQgweLrR8/YJm7KBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kr4kmRks; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711656601; x=1743192601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B0boc5nHCqXEMmaaCwtZm9t/Mtn0OCgA0SpVDAjwwB0=;
  b=kr4kmRkscLEaxzJht2ojccT2z6JlyIgh5EqOzIsrSUc9XTJ4J6G31EAh
   8DvO/EjWlbhaRjq+xbwjPq1rXaVVCkiZZcb1V7ZU4V6Lq/ZzlpW5/u9Ef
   FhXE+v7YrG1Do+iLy3vOLkzfIdALmO6+QlUFLU9ISWXGpUNmf3PH0+Aol
   RZsHjrB82QO0f/gG6Wft6Mjih1f8jMXtJH0O54N4EZwU2GvvcgZdrzx3S
   z6fGdQHn1nreudEbJDOmUCdJEF/8lQljk01pOkin2XgYUHDGollWA/p4/
   VSSfJMeWNHH3aa0loKf1c1cr6P5aUf6LWd0gjpbm4mFPal6v1n+kQju9t
   g==;
X-CSE-ConnectionGUID: snKe/knISP6l9VsurJsrEg==
X-CSE-MsgGUID: a+oiXOLGQeGMvwDoL7FsHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24326334"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24326334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16633871"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.81.17]) ([10.212.81.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:09:59 -0700
Message-ID: <3cfc1dd4-e1a1-4d87-86f6-0f1833185172@intel.com>
Date: Thu, 28 Mar 2024 13:09:59 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

