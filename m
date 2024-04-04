Return-Path: <linux-btrfs+bounces-3927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814F898D16
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EA290687
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE05612D761;
	Thu,  4 Apr 2024 17:15:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6D12B82;
	Thu,  4 Apr 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250933; cv=none; b=rq0zOS+/6xCu1fKJLkKO+4WXp1shVxHgRxdnavThPEkGooVwCClWLBt+oSB6suLmaO0n6LtHff08IVvOnqJwjlRyRZT6640hKjOiZexWO5R12LKKGotY8+DvQ582NEX+c52dFfcalm/JXk98T+VhVrQLpLjGBQMGoGSQIhwMsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250933; c=relaxed/simple;
	bh=fs3CAOejMkP5hhLgQTUxZcc8HVmLkZEh2BWRUW/2kUE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjWxDmZUhSyy0vozNF6knM0jfTi8mSJpHTuWV365eD1S9vJUMQmbTlw4wpgjWkUtvyvqrrplK0/mB29AAeklm5xzxPLPUh+kb7shWt9Q01JgSJgG0IYBqT7A49IkrKadWxyZlMtA64hY8QaI81iRmHOJ+luYSgV3Q5eb8/WzSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Srp69W5z6J9h6;
	Fri,  5 Apr 2024 01:14:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 87530141546;
	Fri,  5 Apr 2024 01:15:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 18:15:24 +0100
Date: Thu, 4 Apr 2024 18:15:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/26] dax/bus: Factor out dev dax resize logic
Message-ID: <20240404181524.000007dc@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-19-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-19-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:22 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

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
Seems like a straight forward refactor to me. Some trivial comments inline.

However, maybe move this discussion to a different patch. It's a lot
to have here when code it really refers to is later (22 I think?)

> 
> ---
> Changes for V1
> [iweiny: Rebase on new DAX region locking]
> [iweiny: Reword commit message]
> [iweiny: Drop reviews]
> ---
>  drivers/dax/bus.c | 129 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 4d5ed7ab6537..bab19fc578d0 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c

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

Quirky indent I think.

...

> +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> +		struct dev_dax *dev_dax, resource_size_t size)
> +{
> +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
Trivial...
Whilst here nice to tidy up and move that to_alloc to it's own line as
not nice to mix declarations with assignments with those that aren't.


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
> @@ -1283,7 +1310,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  
>  	to_alloc = range_len(&r);
>  	if (alloc_is_aligned(dev_dax, to_alloc))
> -		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> +		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> +					 to_alloc);
>  	up_write(&dax_dev_rwsem);
>  	up_write(&dax_region_rwsem);
>  
> @@ -1506,7 +1534,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
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


