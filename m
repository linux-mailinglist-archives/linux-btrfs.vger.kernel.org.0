Return-Path: <linux-btrfs+bounces-3962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A13899ECD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C71C21802
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB216D9CE;
	Fri,  5 Apr 2024 13:54:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A891C69E;
	Fri,  5 Apr 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325292; cv=none; b=H/fsShRAHh8Lcllb59V5eepO3955Z3F8exK6s0K+6YKDrAdR0+cgJ9z9d1nRJkFI6GZhwSpJha1yK9Il1QB9TKPIlJKCWThsMroxEHjSFeTEdKAqLiG0ZaSTad2qUYx+AA4oCvqMx9vF1SPdmNFnRHob8vZ9rp7oUYeLjvkUX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325292; c=relaxed/simple;
	bh=x3Tr40I4CXAi4Vr+74qZsOf8qqhl47JLAoq5lObopSY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCX+1l2SNkIcJe0RccUiZeqAyotrdtZanbHqm9u7q8n6SAfr/HlO5psEDpXkMVO63bl45l6AfBmzSCbwVx7ZtgxQY8U9JneZikFTz2S90z6cvaTca/VMzoei+ofJHarYAUkqb7xJXExVcVL7wvqWx72vrDGGbKzxrZ42Kx1APIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB0Lm5l3yz6JBFm;
	Fri,  5 Apr 2024 21:53:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E7BB114065C;
	Fri,  5 Apr 2024 21:54:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 14:54:45 +0100
Date: Fri, 5 Apr 2024 14:54:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/26] cxl/port: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <20240405145444.0000437f@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:10 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC partitions (regions).  In addition to assigning the size of the
> DC partition, the decoder must assign any skip value from the previous
> decoder.  This must be done within a contiguous DPA space.
> 
> Two complications arise with Dynamic Capacity regions which did not
> exist with Ram and PMEM partitions.  First, gaps in the DPA space can
> exist between and around the DC Regions.  Second, the Linux resource
> tree does not allow a resource to be marked across existing nodes within
> a tree.
> 
> For clarity, below is an example of an 60GB device with 10GB of RAM,
> 10GB of PMEM and 10GB for each of 2 DC Regions.  The desired CXL mapping
> is 5GB of RAM, 5GB of PMEM, and all 10GB of DC1.
> 
>      DPA RANGE
>      (dpa_res)
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
> 
> RAM         PMEM                  DC0                   DC1
>  (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
> |----------|----------|   <gap>  |----------|   <gap>  |----------|
> 
>  RAM        PMEM                                        DC1
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
> 0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB


To add another corner to the example, maybe map only part of DC1?

> 
> The previous skip resource between RAM and PMEM was always a child of
> the RAM resource and fit nicely [see (S) below].  Because of this
> simplicity this skip resource reference was not stored in any CXL state.
> On release the skip range could be calculated based on the endpoint
> decoders stored values.
> 
> Now when DC1 is being mapped 4 skip resources must be created as
> children.  One for the PMEM resource (A), two of the parent DPA resource
> (B,D), and one more child of the DC0 resource (C).
> 
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
>                            |                     |
> |----------|----------|    |     |----------|    |     |----------|
>         |          |       |          |          |
>        (S)        (A)     (B)        (C)        (D)
> 	v          v       v          v          v
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXXXXXXX|
>        skip       skip  skip        skip      skip
> 
> Expand the calculation of DPA freespace and enhance the logic to support
> mapping/unmapping DC DPA space.  To track the potential of multiple skip
> resources an xarray is attached to the endpoint decoder.  The existing
> algorithm between RAM and PMEM is consolidated within the new one to
> streamline the code even though the result is the storage of a single
> skip resource in the xarray.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: Update cover letter]
> ---
>  drivers/cxl/core/hdm.c  | 192 +++++++++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/core/port.c |   2 +
>  drivers/cxl/cxl.h       |   2 +
>  3 files changed, 179 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e22b6f4f7145..da7d58184490 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -210,6 +210,25 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
>  
> +static void cxl_skip_release(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct device *dev = &port->dev;
> +	unsigned long index;
> +	void *entry;
> +
> +	xa_for_each(&cxled->skip_res, index, entry) {
> +		struct resource *res = entry;
> +
> +		dev_dbg(dev, "decoder%d.%d: releasing skipped space; %pr\n",
> +			port->id, cxled->cxld.id, res);
> +		__release_region(&cxlds->dpa_res, res->start,
> +				 resource_size(res));
> +		xa_erase(&cxled->skip_res, index);
> +	}
> +}
> +
>  /*
>   * Must be called in a context that synchronizes against this decoder's
>   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> @@ -220,15 +239,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct resource *res = cxled->dpa_res;
> -	resource_size_t skip_start;
>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
> -	/* save @skip_start, before @res is released */
> -	skip_start = res->start - cxled->skip;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +	cxl_skip_release(cxled);
>  	cxled->skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
> @@ -263,6 +278,100 @@ static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
>  	return mode - CXL_DECODER_DC0;
>  }
>  
> +static int cxl_request_skip(struct cxl_endpoint_decoder *cxled,
> +			    resource_size_t skip_base, resource_size_t skip_len)
> +{
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	const char *name = dev_name(&cxled->cxld.dev);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct resource *dpa_res = &cxlds->dpa_res;
> +	struct device *dev = &port->dev;
> +	struct resource *res;
> +	int rc;
> +
> +	res = __request_region(dpa_res, skip_base, skip_len, name, 0);
> +	if (!res)
> +		return -EBUSY;
> +
> +	rc = xa_insert(&cxled->skip_res, skip_base, res, GFP_KERNEL);
> +	if (rc) {
> +		__release_region(dpa_res, skip_base, skip_len);
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "decoder%d.%d: skipped space; %pr\n",
> +		port->id, cxled->cxld.id, res);
> +	return 0;
> +}
> +
> +static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
> +				resource_size_t base, resource_size_t skipped)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	resource_size_t skip_base = base - skipped;
> +	struct device *dev = &port->dev;
> +	resource_size_t skip_len = 0;
> +	int rc, index;
> +
> +	if (resource_size(&cxlds->ram_res) && skip_base <= cxlds->ram_res.end) {
> +		skip_len = cxlds->ram_res.end - skip_base + 1;
> +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> +		if (rc)
> +			return rc;
> +		skip_base += skip_len;
> +	}
> +
> +	if (skip_base == base) {
> +		dev_dbg(dev, "skip done ram!\n");
> +		return 0;
> +	}
> +
> +	if (resource_size(&cxlds->pmem_res) &&
> +	    skip_base <= cxlds->pmem_res.end) {
> +		skip_len = cxlds->pmem_res.end - skip_base + 1;
> +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> +		if (rc)
> +			return rc;
> +		skip_base += skip_len;
> +	}
> +
> +	index = dc_mode_to_region_index(cxled->mode);
> +	for (int i = 0; i <= index; i++) {
> +		struct resource *dcr = &cxlds->dc_res[i];
> +
> +		if (skip_base < dcr->start) {
> +			skip_len = dcr->start - skip_base;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +
> +		if (skip_base == base) {
> +			dev_dbg(dev, "skip done DC region %d!\n", i);
> +			break;
> +		}
> +
> +		if (resource_size(dcr) && skip_base <= dcr->end) {
> +			if (skip_base > base) {
> +				dev_err(dev, "Skip error DC region %d; skip_base %pa; base %pa\n",
> +					i, &skip_base, &base);
> +				return -ENXIO;
> +			}
> +
> +			skip_len = dcr->end - skip_base + 1;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -300,13 +409,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	}
>  
>  	if (skipped) {
> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> -				       dev_name(&cxled->cxld.dev), 0);
> -		if (!res) {
> -			dev_dbg(dev,
> -				"decoder%d.%d: failed to reserve skipped space\n",
> -				port->id, cxled->cxld.id);
> -			return -EBUSY;
> +		int rc = cxl_reserve_dpa_skip(cxled, base, skipped);
> +
> +		if (rc) {
> +			dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space; %pa - %pa\n",
> +				port->id, cxled->cxld.id, &base, &skipped);
> +			return rc;
>  		}
>  	}
>  	res = __request_region(&cxlds->dpa_res, base, len,
> @@ -314,14 +422,20 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
>  			port->id, cxled->cxld.id);
> -		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +		cxl_skip_release(cxled);
>  		return -EBUSY;
>  	}
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> +		int index = dc_mode_to_region_index(mode);
> +
> +		if (resource_contains(&cxlds->dc_res[index], res)) {
> +			cxled->mode = mode;
> +			goto success;
> +		}
> +	}
>  	if (resource_contains(&cxlds->pmem_res, res))
>  		cxled->mode = CXL_DECODER_PMEM;
>  	else if (resource_contains(&cxlds->ram_res, res))
> @@ -332,6 +446,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> +success:
> +	dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id, cxled->cxld.id,
> +		cxled->dpa_res, cxled->mode);
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
>  	return 0;
> @@ -463,14 +580,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  {
> +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> -	int rc;
> +	int rc, dc_index;
>  
>  	down_write(&cxl_dpa_rwsem);

Obviously not related to this patch as such, but maybe a good place
for scoped_guard() to avoid the dance around unlocking the rwsem
and allow some early returns on the error paths.


>  	if (cxled->cxld.region) {
> @@ -500,6 +617,21 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	else
>  		free_pmem_start = cxlds->pmem_res.start;
>  
> +	/*
> +	 * Limit each decoder to a single DC region to map memory with
> +	 * different DSMAS entry.
> +	 */
> +	dc_index = dc_mode_to_region_index(cxled->mode);
> +	if (dc_index >= 0) {
> +		if (cxlds->dc_res[dc_index].child) {
> +			dev_err(dev, "Cannot allocate DPA from DC Region: %d\n",
> +				dc_index);
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		free_dc_start = cxlds->dc_res[dc_index].start;
> +	}
> +
>  	if (cxled->mode == CXL_DECODER_RAM) {
>  		start = free_ram_start;
>  		avail = cxlds->ram_res.end - start + 1;
> @@ -521,12 +653,38 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		else
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
> +	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
> +		resource_size_t skip_start, skip_end;
> +
> +		start = free_dc_start;
> +		avail = cxlds->dc_res[dc_index].end - start + 1;
> +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> +			skip_start = free_ram_start;
> +		else
> +			skip_start = free_pmem_start;
> +		/*
> +		 * If any dc region is already mapped, then that allocation
> +		 * already handled the RAM and PMEM skip.  Check for DC region
> +		 * skip.
> +		 */
> +		for (int i = dc_index - 1; i >= 0 ; i--) {
> +			if (cxlds->dc_res[i].child) {
> +				skip_start = cxlds->dc_res[i].child->end + 1;
> +				break;
> +			}
> +		}
> +
> +		skip_end = start - 1;
> +		skip = skip_end - skip_start + 1;

I notice in the pmem equivalent there is a case for part of the region already mapped.
Can that not happen for a DC region as well?

>  	} else {
>  		dev_dbg(dev, "mode not set\n");
>  		rc = -EINVAL;
>  		goto out;
>  	}
>  
> +	dev_dbg(dev, "DPA Allocation start: %pa len: %#llx Skip: %pa\n",
> +		&start, size, &skip);
> +
>  	if (size > avail) {
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>  			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",


