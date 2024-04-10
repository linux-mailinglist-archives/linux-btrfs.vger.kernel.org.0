Return-Path: <linux-btrfs+bounces-4119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9518A0156
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 22:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1733C28BF3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3736181BB1;
	Wed, 10 Apr 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNFSn+G2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618876110;
	Wed, 10 Apr 2024 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781192; cv=none; b=BEmkxsU71+a+axIe+8fYkEK0nyvOp25u0Lp/DFBNkz9hKDVw3pGQ0mVoB3JYewTKn3NHTRAqewnRrXC9mWZ1Mtza8iTUx4y2q4w3M0TvW0gpIk20M44NN9Fu5JoTNIuLVUsuYIzS38QuFAzscqNfXSCDNegltFzeF/LPoe5BYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781192; c=relaxed/simple;
	bh=szcvBm58CmYgHwxREZtOC2xNrrznZ2iKhAcgS1jq92k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcSbOcIObP53MKjlVOAVvZQtSy4ZnO6n9Vl8ohesrmmsRDWALdxHDcWZUO+IJu5HQLzlH7VUmlms71d5ARftb43C8i/HYlIcxafT3Yt88+oAeW8JEaMhS4YTV6HnLi7dDFN0k+ebFKvI5kngIF8Sri5gdswLUYMoe806qtkJIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNFSn+G2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712781190; x=1744317190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=szcvBm58CmYgHwxREZtOC2xNrrznZ2iKhAcgS1jq92k=;
  b=cNFSn+G29Aef3J2WV0av+He7XiZdYQbW/KfOtJinQJhw89l/6ehhzzBY
   tLIbA+0J8byX2R+8LSh307LH3mR2EjFtPI/H6269Txl1RtQBwZdGXkuRz
   iBmxOgbST7hgwbXkmDfhz/PeD7NFPYJeIIqKuJs8cw+Jmi8CrygHcw/Pa
   oF0k9XZ97Pj0PgDc5yHmsqWbE66fNnBj25D8ePvC5b4gpGiIWff5iry3p
   7rlfS75OvN0HPL8Cn8R8IefvV1YpzxoQwRnyGIg+6s+5NR55el0b0GTGW
   czNC9ToytEMD4VdEf3zfLMQV9+B98GQKJn9OcdxP25T41JM1b2+h1GFEf
   Q==;
X-CSE-ConnectionGUID: d6jr2godQVGLYtetIbvStA==
X-CSE-MsgGUID: hYkVxLTLQ9WMFVdH3v2fKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8344983"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8344983"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:33:09 -0700
X-CSE-ConnectionGUID: E6kjO7a/RLK4AbXo5UyOXA==
X-CSE-MsgGUID: 69/XIloPQcmBhOsygt9vjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20647702"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:33:09 -0700
Date: Wed, 10 Apr 2024 13:33:07 -0700
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
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <Zhb3g+mji54OcIfs@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:09PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Endpoint decoders which are used to map Dynamic Capacity must be
> configured to point to the correct Dynamic Capacity (DC) Region.  The
> decoder mode currently represents the partition the decoder points to
> such as ram or pmem.
> 
> Expand the mode to include DC regions [partitions].
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: eliminate added gotos]
> [iweiny: Mark DC support for 6.10 kernel]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 +++++++++++----------
>  drivers/cxl/core/hdm.c                  | 19 +++++++++++++++++++
>  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..8b3efaf6563c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -316,23 +316,24 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, June 2024
> +KernelVersion:	v6.0, v6.10 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles the volatile/persistent partition boundary,
> +		and 'none' indicates the decoder is not actively decoding, or
> +		no DPA allocation policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 66b8419fd0c3..e22b6f4f7145 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -255,6 +255,14 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	if (mode < CXL_DECODER_DC0 || CXL_DECODER_DC7 < mode)
> +		return -EINVAL;
> +
> +	return mode - CXL_DECODER_DC0;
> +}

Curious why this works?


> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -411,6 +419,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> +	int rc;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> @@ -433,6 +442,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  			return -ENXIO;
>  		}
>  		break;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		rc = dc_mode_to_region_index(mode);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (resource_size(&cxlds->dc_res[rc]) == 0) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			return -ENXIO;
> +		}


return rc breaks the pattern in this function.

Feels like 'rc' can be named 'index' since we index into dc_res[].
Explicitly show the return -EINVAL here as other cases do.

like:
	index = dc_mode_to_region_index(mode);
	if (index < 0)
		return -EINVAL;

and then: 
	dc_mode_to_region_index() can just return -1 or still return
	-EINVAL.

> +		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..80c0651794eb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -208,6 +208,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>  
> 
> -- 
> 2.44.0
> 

