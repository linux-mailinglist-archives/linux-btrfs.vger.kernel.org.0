Return-Path: <linux-btrfs+bounces-3619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D488CB69
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5EB2216E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721985293;
	Tue, 26 Mar 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0ReI+rw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361E6F07B;
	Tue, 26 Mar 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475909; cv=none; b=i7VZwFH19jRsUKZVLJYqdAGLqurEOJHJjdZDOCNHdGOu7eB11MjpI6cegaPu8lWS6ut9HRvtE/thPnt59lGvMAgQaNcm1b72jLmPtvoFvesXiY2bhCJDuOxAr3fSta4fr1eCaeTn3dSuPyYN+mY9McmxzrzHw66HDKw8FmJx2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475909; c=relaxed/simple;
	bh=+0f2wjx5PoGT9oU7SA9Y1LHXUjBgVOpupO+S6BJi8lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw6FbQDH/sfLtz8kPkyd7j/t9JYinPQQR1mEUmW73C0lDSLWWaDVIzF7RNZ8i5RgCLQuyaVovwi4C5dz6PKrYH1iRz8P51dINM4IeF81QYBhYy0yWr+6s4jmEOVx+3hGRxlddYkeKFonDq4XPMJrh1z4Mv8TP7h+Nm/doXKPI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0ReI+rw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475907; x=1743011907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0f2wjx5PoGT9oU7SA9Y1LHXUjBgVOpupO+S6BJi8lw=;
  b=a0ReI+rwtsDmOfY/Y0oocISTmonIi1YYOMNgEhBQBe3JKFLr3yt6T1Yb
   g9F/R4hsvJ6G6fZiMwlCI2PBOgbPpwe28qwlVSbkcfTPHAqkuvW/zTwFs
   4BdI1ipQ5HuNCvRHqsM+ldvpd0g+czJaEFGkm9Dqz4bhzOtSXWO4E0mhJ
   ljpi6w8RVKoVcCWyF295TfHTkuodSTF6Bt6tdglnDwMMzgpU7Dmk1W+1b
   fyjtlRcW7CFybmtleMXg8KRW4rkvXi2hGZbQYNzFqv7ZLOcAs0EgV/yDL
   +ou90bdTP/kqvhML9r2RRbItNcBuApepW/da9GY/KEhEePS3LISls4ada
   Q==;
X-CSE-ConnectionGUID: qClSmqHsRGmT1vOiKq94yQ==
X-CSE-MsgGUID: KkgAdeTySGmIuj6TJdhOUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6400934"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6400934"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16426044"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.112.247]) ([10.212.112.247])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:58:25 -0700
Message-ID: <891efc78-4f4b-494b-8c51-4f15db68ef23@intel.com>
Date: Tue, 26 Mar 2024 10:58:24 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Content-Language: en-US
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
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

I second what Fan said about readability here if you do (mode > CXL_DECODER_DC7) for upper bound check instead.

> +		return -EINVAL;
> +
> +	return mode - CXL_DECODER_DC0;
> +}
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

I think maybe create a static string table that correlates cxl_decoder_mode to string. Then you can simplify cxl_decoder_mode_name() and as well as here. And here I think you can just do a for loop and go through the entire static table. 

>  	else
>  		return -EINVAL;
>  
> 

