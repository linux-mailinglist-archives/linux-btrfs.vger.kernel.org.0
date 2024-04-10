Return-Path: <linux-btrfs+bounces-4120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC838A03C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82EE28D32D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265622C695;
	Wed, 10 Apr 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wjb78jTL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7829CFA;
	Wed, 10 Apr 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789419; cv=none; b=aTNgxiAJya1D7ZRskG7uH+US2po4oUrgye6QiDGa4bWnk6VO4hjjxp4T9WRO0t930XSuZkBGxc8PsqQl0MJu48vE1XIictrWeK6OX8rzY+MXIXMuwqwD5KofFWSHctdan437Y7T5xp814IILmgZsq65hrVFZ2A8sTQw2xpCWQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789419; c=relaxed/simple;
	bh=i17jQ7cX9KXZKHC4ig8Hi9kgl1Ja1WBXCrpSBNckMUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtdKTWEJSwEyg8hnXVtQmibKy0kYUSjc9I9jnVnCUF7X5wMu4DTx+gY2rxoWUT1KOe3PViZ0a4whY2SaR9WAXoORYjg2kQEmB2JNtgxtAqtxLVLt9Kf+c/wYtEOfn2GtDMIOBL9+1jtjwkia7SmsZ2k+U3HaK3qMtIhBAJ9Ar78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wjb78jTL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712789417; x=1744325417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i17jQ7cX9KXZKHC4ig8Hi9kgl1Ja1WBXCrpSBNckMUI=;
  b=Wjb78jTLZ38LIvssDlbQ6nYAeli7qzCqU/obajWCkK4eZU8plus991As
   n2dKSkdbNScbrUOeyipSoHwvbEthTign9EBI+NWEOsCz99sBq7+cv2sIB
   3kKiHU3zabalD3bHAfo2JhieVtxqWDFmRH35mwAPwqjbzrIdjzN5Cd0GJ
   3d/dsm0Ql9rfvT5Q3sDiK2zdYPvf4rfSqzgx58FbtwVsij1JN3B4lOoQQ
   Sjshs6krXFXNgG/BQg7RN8Rdsipo987EhnX2rC7kSiuZ7PtZulnkZIVBO
   JmtK4qCqqgbDcP6w7VDGXfFxiyrgqrZ1IshmKCDklG77nW+8zMGfO8yoc
   g==;
X-CSE-ConnectionGUID: Cgf6N4/rRca3T2PZWcV72A==
X-CSE-MsgGUID: Wa3Abxz2Qa+1o/th//OTYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8287903"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8287903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:50:16 -0700
X-CSE-ConnectionGUID: 0pEcit44RRer0rRPGiFLig==
X-CSE-MsgGUID: RNydCwYaRa+8o1NTgWoG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="58133920"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:50:16 -0700
Date: Wed, 10 Apr 2024 15:50:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/26] cxl/port: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <ZhcXpi0oeg23G7EU@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-7-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:10PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC partitions (regions).  In addition to assigning the size of the
> DC partition, the decoder must assign any skip value from the previous
> decoder.  This must be done within a contiguous DPA space.
> 
> Two complications arise with Dynamic Capacity regions which did not
> exist with Ram and PMEM partitions.  First, gaps in the DPA space can

RAM

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

Nice art!


> Expand the calculation of DPA freespace and enhance the logic to support
> mapping/unmapping DC DPA space.  To track the potential of multiple skip
> resources an xarray is attached to the endpoint decoder.  The existing
> algorithm between RAM and PMEM is consolidated within the new one to
> streamline the code even though the result is the storage of a single
> skip resource in the xarray.

This passed the unit test cxl-poison.sh that relies on you not totally
breaking the cxled->skip here. Not exactly a tested by, but something!


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

Here and below it's probably needless to define dev. 
Just &port->dev in your single dev_dbg()
This is something to check for across the patchset.


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

again

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

From the "Limit each decoder" comment to here please explain.
I'm reading we cannot alloc dpa from this DC region because
is has a child?  And a child is a region?  Maybe I got it ;)


snip to end

--Alison

