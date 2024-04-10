Return-Path: <linux-btrfs+bounces-4118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28388A0006
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381A11F2331F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44085171069;
	Wed, 10 Apr 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMMuFr7v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6018E0E;
	Wed, 10 Apr 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774957; cv=none; b=lFqTgxG/AIZtAQwNFGVi+SATbD/ghPkplm+g4mOEKIMOlWwp8Y4thGPHEjQWmD4BIPkJcNb5zjoXl10CT51cNJJgXhMhQfmZ5PF25Lh/w7apkGgG/uovTdTZXsteMoi0c44ZDH7te982ovpJBvUcD6VnMEiz5B4Zp6NNkmFkDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774957; c=relaxed/simple;
	bh=QM8Jb3Uz2AYesC7YWy8Mrr17tAqaCNoFBt/Sd7wQDX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za0gl5qFIihK659IBtXy891RgbnH2NTv0KvOwkZAfJW1O87BayP6H61G2LEm9R1qvG1HjcO8RAX2Bu6pAzwvTN3YRvWyefPfUuuqPVBR11wITT2EWh/HOcg8bg9sOm0IdJMrsoeSCJpY0/HHLOlbQhCjwZft0G5hKE07SFOZlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMMuFr7v; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712774955; x=1744310955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QM8Jb3Uz2AYesC7YWy8Mrr17tAqaCNoFBt/Sd7wQDX8=;
  b=XMMuFr7vMRCds3fyxeGhrkW+EzBTyPPgzGKtcTJiRLMWtg5qYyqNolsw
   qOYXXx3BEkXJb4M/EVXMEGk/UfcxnS2a6DbUzXYIi3hcS4st/0l2Q+Nz5
   Q1bPL8VmnOmdZ0vCe7bGRckRtx6/3TKiGFe5KsTvjx65ocfnkVl8GaVtd
   WagwZRaKrFcl7lULGGG5mNDWoLsYlc1YjxOdzUd7trmUmpPFxvdyiugZw
   lgXb0rplkhWGjHOal9RdVAwZilJyh+frVFT5U4RTz+6dX5RssgZHKtkru
   CfsNNHrs9pLOLDMiznDfqcsmWVIu5u8Vxc5OLxKHJOWuXdMs09e+xXgGq
   Q==;
X-CSE-ConnectionGUID: Hvp3hMutRP+0ytcBmjpS2A==
X-CSE-MsgGUID: DF+2kDYRT6CoSLf+GTacUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18719342"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18719342"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:49:14 -0700
X-CSE-ConnectionGUID: T4aZJgEBQ52sbbWuz+Wzyw==
X-CSE-MsgGUID: AA32th1QTB2ZpF7j19CTEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25280570"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:49:13 -0700
Date: Wed, 10 Apr 2024 11:49:11 -0700
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
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <ZhbfJ5HRCFAhUy2I@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:05PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Until now region modes and decoder modes were equivalent in that they
> were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> regions (which will represent an array of device regions [better named
> partitions] the index of which could be different on different
> interleaved devices), the mode of an endpoint decoder and a region will
> no longer be equivalent.
> 
> Define a new region mode enumeration and adjust the code for it.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> <none>
> ---
>  drivers/cxl/core/region.c | 77 +++++++++++++++++++++++++++++++++++------------
>  drivers/cxl/cxl.h         | 26 ++++++++++++++--
>  2 files changed, 81 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4c7fd2d5cccb..1723d17f121e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -40,7 +40,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>  	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (cxlr->mode != CXL_DECODER_PMEM)
> +	if (cxlr->mode != CXL_REGION_PMEM)
>  		rc = sysfs_emit(buf, "\n");
>  	else
>  		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -353,7 +353,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>  	 * Support tooling that expects to find a 'uuid' attribute for all
>  	 * regions regardless of mode.
>  	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_REGION_PMEM)
>  		return 0444;
>  	return a->mode;
>  }
> @@ -516,7 +516,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> @@ -542,7 +542,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  
>  	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>  	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode == CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
>  		return -ENXIO;
>  
>  	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
> @@ -1683,6 +1683,17 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static bool cxl_modes_compatible(enum cxl_region_mode rmode,
> +				 enum cxl_decoder_mode dmode)
> +{

Perhaps is_region_mode_compatible() ?  

Seems we have precedence for asking these questions that have
boolean responses. I picked 'region' because it is the region
we are trying to construct.


> +	if (rmode == CXL_REGION_RAM && dmode == CXL_DECODER_RAM)
> +		return true;
> +	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1693,9 +1704,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> -	if (cxled->mode != cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +	if (!cxl_modes_compatible(cxlr->mode, cxled->mode)) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %s mismatch decoder: %s\n",
> +			dev_name(&cxled->cxld.dev),
> +			cxl_region_mode_name(cxlr->mode),
> +			cxl_decoder_mode_name(cxled->mode));
>  		return -EINVAL;
>  	}

Does the above return bypass this next code segment (not in your diff):

       if (cxled->mode == CXL_DECODER_DEAD) {
                dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
                return -ENODEV;
        }

It seems we are changing the return value on DEAD.

More below where a new check for DEAD is added ...

snip

>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -2808,12 +2840,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> +	enum cxl_region_mode mode;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
>  	int rc;
>  
> +	if (cxled->mode == CXL_DECODER_DEAD)
> +		return ERR_PTR(-EINVAL);

I see this addition, but it is in a different place and with
a different return value. Help me understand that this is no
change in behavior.


> +
> +	mode = cxl_decoder_to_region_mode(cxled->mode);
>  	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, mode,
>  				       atomic_read(&cxlrd->region_id));
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  

snip

>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -511,7 +532,8 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Region mode which defines which endpoint decoder mode the region is
> + *        compatible with

Maybe...
@mode: Region mode used for decoder compatibility check

snip to end

--Alison

> 

