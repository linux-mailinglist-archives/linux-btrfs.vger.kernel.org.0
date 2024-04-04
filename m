Return-Path: <linux-btrfs+bounces-3929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFB1898D52
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0B91F21F86
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF812E1D3;
	Thu,  4 Apr 2024 17:37:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10C1F94D;
	Thu,  4 Apr 2024 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252225; cv=none; b=tiRRzI5uCj0YUBwxnxpIEtRqoqLMD9As68L0laXfObgxy1FncNjbghwAH8Dm5kU2ES6Q6l6A0n6INEPAFBqnJh8a9soLbxn+6jO2mreF0SZQEfGeH+f0IriW3EKjgrh3MXMBqta+xV5+oxKH1+9jsVr6vTYVaBBMX0LqlygDH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252225; c=relaxed/simple;
	bh=RPBNudG7gpMpLVDgegigvpCHrmcZLuloK2mrc03VASc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzHYzHHbtf3VnZEIeSvm8uRGxNrkpTRVSown8HgWkuu8UV2kZHisIW8GkUmF93cPhWLW9upIgtQ6ipk7voKyFLRHRObAIx+gD29Qa+MyQZI6E4gXLU3HPIfRw5NER0i5cVv7pwysL2ylwrjhawP39a+3EDK6Jm/D3rjlTWVuUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9TKk0Zcnz6K5nC;
	Fri,  5 Apr 2024 01:35:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AC8F141546;
	Fri,  5 Apr 2024 01:36:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 18:36:57 +0100
Date: Thu, 4 Apr 2024 18:36:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/26] dax/region: Support DAX device creation on sparse
 DAX regions
Message-ID: <20240404183656.00005ac8@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-22-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-22-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:25 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Previous patches introduced a new sparse DAX region type.  This region
> type may have 0 or more bytes of backing memory.
> 
> DAX devices already have the ability to reference sparse ranges of a DAX
> region.  Leverage the range support of DAX devices to track memory
> across a sparse set of region extents.
> 
> Requests for extent removal can be received from the device at any time.
> But the host is not obliged to release that memory until it is finished
> with it.  Introduce a use count to track how many DAX devices are using
> an extent.  If that extent is in use reject the removal of the extent.
> 
> Leverage the region RW semaphore to protect the extent data as any
> changes to the use of the extent require DAX device, DAX region, and
> extent stability during those operations.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Comments are minor.  I'm not 100% confident on this yet, but
that's more a case of I need to look at the end result of the whole
series. Fairly happy though so...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for v3
> [iweiny: simplify the extent objects]
> [iweiny: refactor based on the new extent objects created]
> [iweiny: remove xarray]
> [iweiny: use lock/invalidate/cnt rather than kref]
> ---
>  drivers/cxl/core/extent.c |   8 ++
>  drivers/cxl/core/region.c |   6 +-
>  drivers/cxl/cxl.h         |   1 +
>  drivers/dax/bus.c         | 191 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/dax/bus.h         |   3 +-
>  drivers/dax/cxl.c         |  55 ++++++++++++-
>  drivers/dax/dax-private.h |  23 ++++++
>  drivers/dax/hmem/hmem.c   |   2 +-
>  drivers/dax/pmem.c        |   2 +-
>  9 files changed, 258 insertions(+), 33 deletions(-)
> 


> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 56dddaceeccb..70a559763e8c 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -236,11 +236,32 @@ int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(ext_dev, dax_region_release_extent,
> +	/* Assume the devm action will be configured without error */
> +	dev_set_drvdata(ext_dev, dax_ext);
> +	rc = devm_add_action_or_reset(ext_dev, dax_region_release_extent,
>  					no_free_ptr(dax_ext));

Indent needs tweaking.

> +	if (rc)
> +		dev_set_drvdata(ext_dev, NULL);
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(dax_region_add_extent);

> @@ -507,15 +553,26 @@ EXPORT_SYMBOL_GPL(kill_dev_dax);
>  static void trim_dev_dax_range(struct dev_dax *dev_dax)
>  {
>  	int i = dev_dax->nr_range - 1;
> -	struct range *range = &dev_dax->ranges[i].range;
> +	struct dev_dax_range *dev_range = &dev_dax->ranges[i];
> +	struct range *range = &dev_range->range;
>  	struct dax_region *dax_region = dev_dax->region;
> +	struct resource *res = &dax_region->res;

>  
>  	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
>  		(unsigned long long)range->start,
>  		(unsigned long long)range->end);
>  
> -	__release_region(&dax_region->res, range->start, range_len(range));
> +	if (dev_range->dax_ext) {
> +		res = dev_range->dax_ext->res;
> +		dev_dbg(&dev_dax->dev, "Trim sparse extent %pr\n", res);
> +	}
> +
> +	__release_region(res, range->start, range_len(range));
> +
> +	if (dev_range->dax_ext)

May be worth considering splitting this core bit into two
functions for dev_range->dax_ext and not. The overriding of res
is not giving nice readable code.


> +		dev_range->dax_ext->use_cnt--;
> +
>  	if (--dev_dax->nr_range == 0) {
>  		kfree(dev_dax->ranges);
>  		dev_dax->ranges = NULL;

>  
>  /**
> - * dev_dax_resize_static - Expand the device into the unused portion of the
> - * region. This may involve adjusting the end of an existing resource, or
> - * allocating a new resource.
> + * __dev_dax_resize - Expand the device into the unused portion of the region.
> + * This may involve adjusting the end of an existing resource, or allocating a
> + * new resource.
>   *
>   * @parent: parent resource to allocate this range in
>   * @dev_dax: DAX device to be expanded
>   * @to_alloc: amount of space to alloc; must be <= space available in @parent
> + * @dax_ext: if sparse; the extent containing parent

If not, what? NULL, but maybe docs should make that explicit.

>   *
>   * Return the amount of space allocated or -ERRNO on failure
>   */

> +static ssize_t dev_dax_resize_sparse(struct dax_region *dax_region,
> +				     struct dev_dax *dev_dax,
> +				     resource_size_t to_alloc)
> +{
> +	struct dax_extent *dax_ext;
> +	resource_size_t extent_max;
> +	struct device *ext_dev;
> +	ssize_t alloc;
> +
> +	ext_dev = dax_region->sparse_ops->find_ext(dax_region, &extent_max,
> +						   dax_ext_match_avail_size);
> +	if (!ext_dev)
> +		return -ENOSPC;
> +
> +	dax_ext = dev_get_drvdata(ext_dev);
> +	if (!dax_ext)
> +		return -ENOSPC;
> +
> +	to_alloc = min(extent_max, to_alloc);
> +	alloc = __dev_dax_resize(dax_ext->res, dev_dax, to_alloc, dax_ext);
> +	if (alloc < 0)
> +		dax_ext->use_cnt--;

Maybe define a put_dax_ext() / get_dax_ext() given this is operating somewhat like that
in that find_ext takes a reference and that is dropped on error.

> +	return alloc;
> +}

> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 83ee45aff69a..3cb95e5988ae 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c

> +/**
> + * find_ext - Match Extent callback
> + * @dax_region: region to search
> + * @size_avail: the available size if an extent is found
> + * @match_fn: match function
> + *
> + * Callback to itterate through the child devices of the DAX region calling

Spell check. Iterate

> + * match_fn only on those devices which are extents.
> + *
> + * If a match is found match_fn is responsible for locking or reference
> + * counting dax_ext as needed.
> + */
> +static struct device *find_ext(struct dax_region *dax_region,
> +			       resource_size_t *size_avail,
> +			       match_cb match_fn)
> +{
> +	struct match_data md = {
> +		.match_fn = match_fn,
> +		.size_avail = size_avail,
> +	};
> +	struct device *ext_dev;
> +
> +	ext_dev = device_find_child(dax_region->dev, &md, cxl_dax_match_ext);
> +

Trivial but I'd drop this blank line to closely group the check with the find.

> +	if (!ext_dev)
> +		return NULL;
> +
> +	/* caller must hold a count on extent data */
> +	put_device(ext_dev);
> +	return ext_dev;
> +}


