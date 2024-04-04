Return-Path: <linux-btrfs+bounces-3921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31C898BCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2171C2196C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679812B145;
	Thu,  4 Apr 2024 16:06:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702312AACB;
	Thu,  4 Apr 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246816; cv=none; b=oDH0gtD4ADmwmvAuegDbeJp9kf5lps15sYtrD7RM9FIetxjKrryc2Bah7imGQpMy97dweIv6lRc97rTePPFOm2xLEsD2r+kooPHCje5/cVQQDWbiHQnYnnQiY3EN7mFFVJ1l8tNxt6WggsIFMjCexr9QyfV6smUksog+pqHC1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246816; c=relaxed/simple;
	bh=bFdC5cp6PSfWrEoupk04gWdS9M4Y0/x6VuDfdYcJZ/k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayhZBwlWxzxRaevrsZLf/325jCHqTxrZCA1xlheAtpu0dXfpm2v+JTlWFvJbnkCSDeHTAbEjD8EvKcwdWXnO6MaCZgehT77RdCiJFoLO5RMpRJh1css7Bx1Sa/t+TiRSOWyhVCqJSuHEZ9OlMhX9ieBkoiYwNO2c/RMIoy1hQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9RFt4wTXz67kr9;
	Fri,  5 Apr 2024 00:02:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 15076141546;
	Fri,  5 Apr 2024 00:06:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 17:06:49 +0100
Date: Thu, 4 Apr 2024 17:06:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 15/26] range: Add range_overlaps()
Message-ID: <20240404170648.00002dbe@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-15-b7b00d623625@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:18 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

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
FWIW given it's well review already.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


