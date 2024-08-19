Return-Path: <linux-btrfs+bounces-7326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D571957787
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 00:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27091C21ED6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 22:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3601DF661;
	Mon, 19 Aug 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYe2AgZ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56615DBC1;
	Mon, 19 Aug 2024 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106965; cv=none; b=YX8sKIAH95E+cGOEyrcyfm4r3zoyFHpCJre4STeiDYAzRH+bMUOAh8QUkpft9Kqdocp4EL07/TWsHdg2h1u3ePORiPwnkiiLqU5XnVp4i+623l8oWj7ChUx0nrP9cBwx/yOBL5KcY+zx77c+xY0UZ5e7EMOCo0Cvm+T/AGQXjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106965; c=relaxed/simple;
	bh=sP1bPuE1jv4uIvLThNvKf7gaSiahP6wPMyH4M/kLKpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxz6gBzPsxRaRO2Ii/sEiFSzSLNRxeeLAK/lA5uwBHTgv1ZKX+Sww3R595VsXG53M9Othul2FbKPo3pm0rWrVxRPqlnCb0MuICPr8waNWHfNbZE8SduFReuT/sIe2efzR/iWHRcXMlPbEDTCGnaPn/pWAv3rkDa3DjG+3niWeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYe2AgZ7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106964; x=1755642964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sP1bPuE1jv4uIvLThNvKf7gaSiahP6wPMyH4M/kLKpM=;
  b=EYe2AgZ729nOPFifSz1IOumhFeGHrIiXhE96TTqhIZq5w9MCxRrVSxw8
   AJ50yDbbI0vF4eE7Jsm4WoAXFq3y715pst8leTo3kwmMENpYy2G/xNQWN
   pNgUJr1K69T8Lx1UMSQysvbj4WyMT8V+v8NvQnjVuk1w4G+9AusrxoLie
   cmz0I7Ejsc948CiiEoi57GlB3HisACZ+TuG5ofYtVhLclODvsOWIGV3Pg
   hT/X1DvSm26VGM9d/WWsEA+Ll8ydSsmeTp5LTMalsElEpSB2RXqO1UuWy
   Q3+vTI4cqip8aTWJuq5vJUL7//ptyIAb9RMZh3zvqtt+cZXGYmLnbCCGr
   Q==;
X-CSE-ConnectionGUID: bBOoGqZER9aF9Bgw0wNRWw==
X-CSE-MsgGUID: pc/O8WtXT5i660darBlhNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33762515"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33762515"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:36:04 -0700
X-CSE-ConnectionGUID: jpTSJApcRXiXDj6wel+P3A==
X-CSE-MsgGUID: xDN1r87mRDaIattYsUAbEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60667139"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.111.235]) ([10.125.111.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:36:01 -0700
Message-ID: <9a2caf53-2ce5-41ef-ae43-95f097bbe193@intel.com>
Date: Mon, 19 Aug 2024 15:35:59 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/25] dax/bus: Factor out dev dax resize logic
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-20-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-20-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, Ira Weiny wrote:
> Dynamic Capacity regions must limit dev dax resources to those areas
> which have extents backing real memory.  Such DAX regions are dubbed
> 'sparse' regions.  In order to manage where memory is available four
> alternatives were considered:
> 
> 1) Create a single region resource child on region creation which
>    reserves the entire region.  Then as extents are added punch holes in
>    this reservation.  This requires new resource manipulation to punch
>    the holes and still requires an additional iteration over the extent
>    areas which may already have existing dev dax resources used.
> 
> 2) Maintain an ordered xarray of extents which can be queried while
>    processing the resize logic.  The issue is that existing region->res
>    children may artificially limit the allocation size sent to
>    alloc_dev_dax_range().  IE the resource children can't be directly
>    used in the resize logic to find where space in the region is.  This
>    also poses a problem of managing the available size in 2 places.
> 
> 3) Maintain a separate resource tree with extents.  This option is the
>    same as 2) but with the different data structure.  Most ideally there
>    should be a unified representation of the resource tree not two places
>    to look for space.
> 
> 4) Create region resource children for each extent.  Manage the dax dev
>    resize logic in the same way as before but use a region child
>    (extent) resource as the parents to find space within each extent.
> 
> Option 4 can leverage the existing resize algorithm to find space within
> the extents.  It manages the available space in a singular resource tree
> which is less complicated for finding space.
> 
> In preparation for this change, factor out the dev_dax_resize logic.
> For static regions use dax_region->res as the parent to find space for
> the dax ranges.  Future patches will use the same algorithm with
> individual extent resources as the parent.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes:
> [iweiny: Rebase on new DAX region locking]
> [iweiny: Reword commit message]
> [iweiny: Drop reviews]
> ---
>  drivers/dax/bus.c | 129 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index d8cb5195a227..975860371d9f 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -844,11 +844,9 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>  	return 0;
>  }
>  
> -static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> -		resource_size_t size)
> +static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
> +			       u64 start, resource_size_t size)
>  {
> -	struct dax_region *dax_region = dev_dax->region;
> -	struct resource *res = &dax_region->res;
>  	struct device *dev = &dev_dax->dev;
>  	struct dev_dax_range *ranges;
>  	unsigned long pgoff = 0;
> @@ -866,14 +864,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		return 0;
>  	}
>  
> -	alloc = __request_region(res, start, size, dev_name(dev), 0);
> +	alloc = __request_region(parent, start, size, dev_name(dev), 0);
>  	if (!alloc)
>  		return -ENOMEM;
>  
>  	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
>  			* (dev_dax->nr_range + 1), GFP_KERNEL);
>  	if (!ranges) {
> -		__release_region(res, alloc->start, resource_size(alloc));
> +		__release_region(parent, alloc->start, resource_size(alloc));
>  		return -ENOMEM;
>  	}
>  
> @@ -1026,50 +1024,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
>  	return true;
>  }
>  
> -static ssize_t dev_dax_resize(struct dax_region *dax_region,
> -		struct dev_dax *dev_dax, resource_size_t size)
> +/**
> + * dev_dax_resize_static - Expand the device into the unused portion of the
> + * region. This may involve adjusting the end of an existing resource, or
> + * allocating a new resource.
> + *
> + * @parent: parent resource to allocate this range in
> + * @dev_dax: DAX device to be expanded
> + * @to_alloc: amount of space to alloc; must be <= space available in @parent
> + *
> + * Return the amount of space allocated or -ERRNO on failure
> + */
> +static ssize_t dev_dax_resize_static(struct resource *parent,
> +				     struct dev_dax *dev_dax,
> +				     resource_size_t to_alloc)
>  {
> -	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> -	resource_size_t dev_size = dev_dax_size(dev_dax);
> -	struct resource *region_res = &dax_region->res;
> -	struct device *dev = &dev_dax->dev;
>  	struct resource *res, *first;
> -	resource_size_t alloc = 0;
>  	int rc;
>  
> -	if (dev->driver)
> -		return -EBUSY;
> -	if (size == dev_size)
> -		return 0;
> -	if (size > dev_size && size - dev_size > avail)
> -		return -ENOSPC;
> -	if (size < dev_size)
> -		return dev_dax_shrink(dev_dax, size);
> -
> -	to_alloc = size - dev_size;
> -	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> -			"resize of %pa misaligned\n", &to_alloc))
> -		return -ENXIO;
> -
> -	/*
> -	 * Expand the device into the unused portion of the region. This
> -	 * may involve adjusting the end of an existing resource, or
> -	 * allocating a new resource.
> -	 */
> -retry:
> -	first = region_res->child;
> -	if (!first)
> -		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
> +	first = parent->child;
> +	if (!first) {
> +		rc = alloc_dev_dax_range(parent, dev_dax,
> +					   parent->start, to_alloc);
> +		if (rc)
> +			return rc;
> +		return to_alloc;
> +	}
>  
> -	rc = -ENOSPC;
>  	for (res = first; res; res = res->sibling) {
>  		struct resource *next = res->sibling;
> +		resource_size_t alloc;
>  
>  		/* space at the beginning of the region */
> -		if (res == first && res->start > dax_region->res.start) {
> -			alloc = min(res->start - dax_region->res.start, to_alloc);
> -			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
> -			break;
> +		if (res == first && res->start > parent->start) {
> +			alloc = min(res->start - parent->start, to_alloc);
> +			rc = alloc_dev_dax_range(parent, dev_dax,
> +						 parent->start, alloc);
> +			if (rc)
> +				return rc;
> +			return alloc;
>  		}
>  
>  		alloc = 0;
> @@ -1078,21 +1071,55 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>  			alloc = min(next->start - (res->end + 1), to_alloc);
>  
>  		/* space at the end of the region */
> -		if (!alloc && !next && res->end < region_res->end)
> -			alloc = min(region_res->end - res->end, to_alloc);
> +		if (!alloc && !next && res->end < parent->end)
> +			alloc = min(parent->end - res->end, to_alloc);
>  
>  		if (!alloc)
>  			continue;
>  
>  		if (adjust_ok(dev_dax, res)) {
>  			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
> -			break;
> +			if (rc)
> +				return rc;
> +			return alloc;
>  		}
> -		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
> -		break;
> +		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
> +		if (rc)
> +			return rc;
> +		return alloc;
>  	}
> -	if (rc)
> -		return rc;
> +
> +	/* available was already calculated and should never be an issue */
> +	dev_WARN_ONCE(&dev_dax->dev, 1, "space not found?");
> +	return 0;
> +}
> +
> +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> +		struct dev_dax *dev_dax, resource_size_t size)
> +{
> +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
> +	struct device *dev = &dev_dax->dev;
> +	resource_size_t alloc = 0;
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	if (size == dev_size)
> +		return 0;
> +	if (size > dev_size && size - dev_size > avail)
> +		return -ENOSPC;
> +	if (size < dev_size)
> +		return dev_dax_shrink(dev_dax, size);
> +
> +	to_alloc = size - dev_size;
> +	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> +			"resize of %pa misaligned\n", &to_alloc))
> +		return -ENXIO;
> +
> +retry:
> +	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
> +	if (alloc <= 0)
> +		return alloc;
>  	to_alloc -= alloc;
>  	if (to_alloc)
>  		goto retry;
> @@ -1198,7 +1225,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  
>  	to_alloc = range_len(&r);
>  	if (alloc_is_aligned(dev_dax, to_alloc))
> -		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> +		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> +					 to_alloc);
>  	up_write(&dax_dev_rwsem);
>  	up_write(&dax_region_rwsem);
>  
> @@ -1466,7 +1494,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  	device_initialize(dev);
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>  
> -	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
> +	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> +				 data->size);
>  	if (rc)
>  		goto err_range;
>  
> 

