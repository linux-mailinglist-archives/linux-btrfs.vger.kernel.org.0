Return-Path: <linux-btrfs+bounces-7293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9919553AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 01:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6B1C21ACC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BC1474BF;
	Fri, 16 Aug 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwEV8YrS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8E145A1B;
	Fri, 16 Aug 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849744; cv=none; b=XQbWihEIXkP5EaZgSxFGkgbRlYTCAHmu7JvrMXjBqhwEP1A5Xn73UkmtiNmx57W5BEONz8afVuQAo1fGrUenhQ/s/5aJQekvcASHvVChb7c5I+uBld4hzYriq/Jvpd6lIw4k2aV815OZ85f4fKeRvuCVI1enf3qlYQfCAyhpHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849744; c=relaxed/simple;
	bh=7sbb3BD2a5ZN5kvN3iJ0ML+womSFRTJZ5LUxX4IOoN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ss4XJW1fGPt89dq8RcRnIGaFKZri0ehSgt5STs4GEfxKXrDdehTqdT6bNEgd5m1MpkarD02mAX6DRLtsDCMWLMUJoi4AiwnTA9wedbiFVX1BnO1pF243KsMYUGSSsBh3BCdsCNQ/VyE/EoFqCNkrodwDOwhM+CzSjyu0jJxvv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwEV8YrS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723849742; x=1755385742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7sbb3BD2a5ZN5kvN3iJ0ML+womSFRTJZ5LUxX4IOoN4=;
  b=IwEV8YrSBawtBQ7Axf5oudpTx5fTGc5F5M8zesVvlADMZSNrEykN7hvb
   2ZEpL8lpSCReMLPTJ5laZJfBNHo9MEGjTUSwkns3wLiQp0Etrv6fC2sLL
   x6DOwMiF5nXMtDW1UJe3Mz+jYMnXlmoJMVqTNpwYjijzUJZawJYdvM2f/
   Yr5/ZzCNRK2NFgSixE0G64nXyqUK7pEx3zt1OJQBH7Ts23Y+T6zDSb9b6
   ig9xb6LY8vjRW9IIpNUnjyaA3nBPZIoC1et7L+sAKOR/+SENxLRgKgBz9
   C0D/DwE3DO4D7//fJXStgeW0iZwqkJMEm8BSu+YjiMDBuI9zUjaxfJj95
   Q==;
X-CSE-ConnectionGUID: /oYYZl7eRButbJ/kG0sm0Q==
X-CSE-MsgGUID: GDjUPkrESU2Ht654+kZBww==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="47561333"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="47561333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:09:01 -0700
X-CSE-ConnectionGUID: gGwuaqc5SFuAbKccEm2IXQ==
X-CSE-MsgGUID: koOiXlQUQFyMZHuajtrTRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="63984626"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:09:00 -0700
Message-ID: <8eefaa52-ba46-4e9b-8695-c086e08b0498@intel.com>
Date: Fri, 16 Aug 2024 16:08:58 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/25] cxl/hdm: Add dynamic capacity size support to
 endpoint decoders
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
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
 <20240816-dcd-type2-upstream-v3-9-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-9-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC partitions (regions).  In addition to assigning the size of the
> DC partition, the decoder must assign any skip value from the previous
> decoder.  This must be done within a contiguous DPA space.
> 
> Two complications arise with Dynamic Capacity regions which did not
> exist with Ram and PMEM partitions.  First, gaps in the DPA space can
> exist between and around the DC partitions.  Second, the Linux resource
> tree does not allow a resource to be marked across existing nodes within
> a tree.
> 
> For clarity, below is an example of an 60GB device with 10GB of RAM,
> 10GB of PMEM and 10GB for each of 2 DC partitions.  The desired CXL
> mapping is 5GB of RAM, 5GB of PMEM, and 5GB of DC1.
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
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
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
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
>        skip       skip  skip        skip      skip
> 
> Expand the calculation of DPA free space and enhance the logic to
> support this more complex skipping.  To track the potential of multiple
> skip resources an xarray is attached to the endpoint decoder.  The
> existing algorithm between RAM and PMEM is consolidated within the new
> one to streamline the code even though the result is the storage of a
> single skip resource in the xarray.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [Jonathan: Use an example only mapping 1/2 of DC1]
> [iweiny: Update cover letter]
> [iweiny: Fix 0day bugs
> 	https://lore.kernel.org/all/202408090138.RB41yBE8-lkp@intel.com/
> [djbw/Jonathan: allow more than 1 region per DC partition]
> ---
>  drivers/cxl/core/hdm.c  | 196 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/core/port.c |   2 +
>  drivers/cxl/cxl.h       |   2 +
>  3 files changed, 184 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..b4a517c6d283 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -223,6 +223,25 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
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
> @@ -233,15 +252,11 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
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
> @@ -268,6 +283,105 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	return mode - CXL_DECODER_DC0;
> +}
> +
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

Maybe rename skip_res to skip_xa, given most of the vars in CXL with _res are 'struct resource' to avoid confusion. See 'dpa_res' above.

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

Does 'skip_base == base' need to be checked here again before going to DCD?

DJ

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
> @@ -305,13 +419,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
> @@ -319,14 +432,20 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
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
> @@ -337,6 +456,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> +success:
> +	dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id, cxled->cxld.id,
> +		cxled->dpa_res, cxled->mode);
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
>  	return 0;
> @@ -466,8 +588,8 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	resource_size_t free_ram_start, free_pmem_start;
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> @@ -524,12 +646,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		else
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
> +	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
> +		int dc_index = dc_mode_to_region_index(cxled->mode);
> +
> +		for (p = cxlds->dc_res[dc_index].child, last = NULL; p; p = p->sibling)
> +			last = p;
> +
> +		if (last) {
> +			/*
> +			 * Some capacity in this DC partition is already allocated,
> +			 * that allocation already handled the skip.
> +			 */
> +			start = last->end + 1;
> +			skip = 0;
> +		} else {
> +			/* Calculate skip */
> +			resource_size_t skip_start, skip_end;
> +
> +			start = cxlds->dc_res[dc_index].start;
> +
> +			if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> +				skip_start = free_ram_start;
> +			else
> +				skip_start = free_pmem_start;
> +			/*
> +			 * If any dc region is already mapped, then that allocation
> +			 * already handled the RAM and PMEM skip.  Check for DC region
> +			 * skip.
> +			 */
> +			for (int i = dc_index - 1; i >= 0 ; i--) {
> +				if (cxlds->dc_res[i].child) {
> +					skip_start = cxlds->dc_res[i].child->end + 1;
> +					break;
> +				}
> +			}
> +
> +			skip_end = start - 1;
> +			skip = skip_end - skip_start + 1;
> +		}
> +		avail = cxlds->dc_res[dc_index].end - start + 1;
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
>  			cxl_decoder_mode_name(cxled->mode), &avail);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..8054cbaac9f6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -419,6 +419,7 @@ static void cxl_endpoint_decoder_release(struct device *dev)
>  	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
>  
>  	__cxl_decoder_release(&cxled->cxld);
> +	xa_destroy(&cxled->skip_res);
>  	kfree(cxled);
>  }
>  
> @@ -1899,6 +1900,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxled->pos = -1;
> +	xa_init(&cxled->skip_res);
>  	cxld = &cxled->cxld;
>  	rc = cxl_decoder_init(port, cxld);
>  	if (rc)	 {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d2674ab46f35..53b666ef4097 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -446,6 +446,7 @@ enum cxl_decoder_state {
>   * @cxld: base cxl_decoder_object
>   * @dpa_res: actively claimed DPA span of this decoder
>   * @skip: offset into @dpa_res where @cxld.hpa_range maps
> + * @skip_res: array of skipped resources from the previous decoder end
>   * @mode: which memory type / access-mode-partition this decoder targets
>   * @state: autodiscovery state
>   * @pos: interleave position in @cxld.region
> @@ -454,6 +455,7 @@ struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
>  	resource_size_t skip;
> +	struct xarray skip_res;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_state state;
>  	int pos;
> 

