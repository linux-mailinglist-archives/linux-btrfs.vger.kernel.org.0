Return-Path: <linux-btrfs+bounces-4115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6289FECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BFE1C22E34
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874217F37A;
	Wed, 10 Apr 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9KsUZZ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA231A60;
	Wed, 10 Apr 2024 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771048; cv=none; b=U9WFtDT7oXiI+E1FY4BgoGrSPshprsfLipzqUYn4qvSTNk/TqrVnqDvUWVOJHbWvUeDxQFTAvqONBEXWERf18R6GO8v7SzHv1cf7lt2nU9vHdDj9c9SmRO+7vGwFFOiIsxaq5Xd54oHdfHiKcadRihUNjpOOPds2+csu+6Iy+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771048; c=relaxed/simple;
	bh=mFAnz9GU98lP3BxM5VrgUDFGq/NcdcLR4hVTVHGEi+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEk47c1c+2XXa//GTBdbQKTz1w2Ven0NBd9FPbzhwHLEIiZx8j7xv9u9x4r1vvKgvVcI2J4OqID5mGbruDvnFkGs4qlrs3ZBsMRFli4FKOt+V9o2njzgBoMUKPn8iGNqt2VVbv4cQZZQbjOF0H0FrW2WBjhHZLocebG4hDOnc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9KsUZZ1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712771046; x=1744307046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFAnz9GU98lP3BxM5VrgUDFGq/NcdcLR4hVTVHGEi+s=;
  b=S9KsUZZ14Yw8pPawKcrykYK12/Kkv9cd5tGc6jP/09tW5fFlXovo8snk
   8m7d+9bj5phYhN9blit+RK3kpmCI9lCDgdylMn863PI0sKD2pXXOCLDgk
   WfSvHx33w1IRRhdW4QRrtZPLrjTsLmbibFYh79WRA+A7KVVn65poEkL1Z
   LuBuubLNSaUrUya+tFz9ptMK6b0xLx0nVcTV1zSp6b/oQbwg4Q6z2vt79
   3rNkHWmkdmqEsy8Bn+Gvnx5e3O4e8dYCeF2634Ln9EJP9vMPLHRRZGu2e
   V7ObUDgX48YHyBkSF+2EjpLfIEwkmE1Il3agJVInxKNUhatcRUKPN1RtU
   Q==;
X-CSE-ConnectionGUID: YlqNmV8OSsGdqvb7nhjqbw==
X-CSE-MsgGUID: Ad64L4WoSXyWZR3SEfkC2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19541750"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="19541750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:44:05 -0700
X-CSE-ConnectionGUID: 5lBF0UlbR/yN5YAg1QfU+w==
X-CSE-MsgGUID: 9qcLi33VSbSb+aRG0FBuWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20701283"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:44:05 -0700
Date: Wed, 10 Apr 2024 10:44:03 -0700
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
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <ZhbP4yMTxkLRiCSp@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:17PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case creation of a new
> region on top of the DC partition (region) is expected to expose those
> extents for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized read the device extent list.  For ease of review, this patch
> stops after reading the extent list and leaves realization of the region
> extents to a future patch.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: remove extent list xarray]
> [iweiny: Update spec references to 3.1]
> [iweiny: use struct range in extents]
> [iweiny: remove all reference tracking and let regions track extents
> 	 through the extent devices.]
> [djbw/Jonathan/Fan: move extent tracking to endpoint decoders]
> ---
>  drivers/cxl/core/core.h   |   9 +++
>  drivers/cxl/core/mbox.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |  29 +++++++
>  drivers/cxl/cxlmem.h      |  49 ++++++++++++
>  4 files changed, 279 insertions(+)

snip

> 
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_dc_extent *dc_extent)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	uint64_t start, len;
> +
> +	start = le64_to_cpu(dc_extent->start_dpa);
> +	len = le64_to_cpu(dc_extent->length);
> +
> +	/* Extents must not cross region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +

I think you already got range_contains suggestion

> +		if (dcr->base <= start &&
> +		    (start + len) <= (dcr->base + dcr->decode_len)) {
> +			dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> +				start, start + len - 1, i, start - dcr->base);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %#llx - %#llx is not in any DC region\n",
> +			    start, start + len - 1);

Need some clarification.
Isn't this checking that the extent is fully contained within a region?
And then, it dev_err's if not fully contained. There is not actually
a check and an error message about crossing region boundary's as the
comment suggests.  Maybe update the comment to reflect the work.. like:

/* Extent must be fully contained in a region */


> +	return -EINVAL;
> +}
> +
> +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> +				struct cxl_dc_extent *extent)
> +{
> +	uint64_t start = le64_to_cpu(extent->start_dpa);
> +	uint64_t length = le64_to_cpu(extent->length);

u64 here (and in other places too)


> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +	struct range ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};
> +
> +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent DPA:%#llx LEN:%#llx\n",
> +		cxled->dpa_res, start, length);
> +
> +	return range_contains(&ed_range, &ext_range);
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -973,6 +1020,15 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static struct cxl_memdev_state *
> +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}
> +

That's nice!


>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,

Perhaps drop the _dev_ from this (and other, like below) function names.

> +static int cxl_dev_get_dc_extents(struct cxl_endpoint_decoder *cxled,


snip

> +/**
> + * cxl_read_dc_extents() - Read any existing extents
> + * @cxled: Endpoint decoder which is part of a region
> + *
> + * Issue the Get Dynamic Capacity Extent List command to the device
> + * and add any existing extents found which belong to this decoder.
> + *
> + * Return: 0 if command was executed successfully, -ERRNO on error.
> + */
> +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	unsigned int extent_gen_num;
> +	int rc;
> +
> +	if (!cxl_dcd_supported(mds)) {
> +		dev_dbg(dev, "DCD unsupported\n");
> +		return 0;
> +	}
> +
> +	rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> +	dev_dbg(mds->cxlds.dev, "Extent count: %d Generation Num: %d\n",

Either use the *dev defined in both dev_dbg()'s or get rid of it use mds->cxlds.dev.

> +		rc, extent_gen_num);
> +	if (rc <= 0) /* 0 == no records found */
> +		return rc;
> +
> +	return cxl_dev_get_dc_extents(cxled, extent_gen_num, rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_read_dc_extents, CXL);
> +

snip

>  
> +static int cxl_region_read_extents(struct cxl_region *cxlr)
> +{

How about:
static int cxl_region_read_extents(struct cxl_region_params *p)


> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		int rc;
> +
> +		rc = cxl_read_dc_extents(p->targets[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}

snip to end

