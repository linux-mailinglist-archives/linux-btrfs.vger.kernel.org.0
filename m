Return-Path: <linux-btrfs+bounces-7295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 922619553BC
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 01:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C11F22C70
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B51148826;
	Fri, 16 Aug 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/mTFMZG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B61474D9;
	Fri, 16 Aug 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850226; cv=none; b=dNSHGBPNM7RR71XyLl5O2ma2lwNSMtHEJBKnXPj43bSCHZF0jEnW+sxRcdxSSkLKyxLWxi6MTVB0DxyfcR4arF+3wDiFAyyi1dZ3a2PpnNbbhPpfh3kbhv1IhFVmOsF3ei1B1kXT3OjhVMzTZlHRoMrtXMRsFCJ8Z83OvpoT9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850226; c=relaxed/simple;
	bh=BjhcSPzeBEf/CdWo/sx979xbojPHN02o91ghPixBfqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5810m0oDJdC8JTyd20hFpTkQrVAjl766XThw2Dk9s7Mb6gZ91M65rf38Dn24FLrP4GwI+KzfkoTKgVd/voG/W9rFwaOlkdrChtwH3uB5C7Z/lL1pl5xel0tOPkDGE7yhxZCK/yiddwDmNwjBgDBiOV0VzeoibC+aieqSE1JuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/mTFMZG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723850224; x=1755386224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BjhcSPzeBEf/CdWo/sx979xbojPHN02o91ghPixBfqQ=;
  b=j/mTFMZGM+pbj6nqBhA9yLFF3qx30kWwc81uUS2psGQDHYFWWCtwqKJs
   V+02gbNQOli/Q2F3NDhLX5yif3caqdL5LwNN5hFBOLHNB6ka/78ORY+ma
   scLIGBf7o1TZzef+mAXoHb0cTvfL7rnLPP7apo7fB43ZNNp57PVMNFItc
   Axf/lSDUvxLd2OZuUCC1dJPR+NHbVX3+a/IAuNISl9H+8+IIqC2p5oDWi
   lTJdk04fdPKQF+qKNqTRHIq1IZ6MGPPWwOPsRL6qn7vaQ/Qxs86360HQC
   /DaXZDOcty9uYYsuwYJoNrLmUnep+WmwmkYvxRQnquTFxkTZ6l/SQQeeh
   Q==;
X-CSE-ConnectionGUID: FcT7sex9SxWI7BPE86Zsvw==
X-CSE-MsgGUID: mryEbVuYQO+A0M12ccoYXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22130305"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22130305"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:17:03 -0700
X-CSE-ConnectionGUID: 8Z81hDAeQjuXBZiyQbk+Xw==
X-CSE-MsgGUID: H7rNfao5SK6kxxSd+9uuVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59447719"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:17:02 -0700
Message-ID: <07f637e3-5539-4bbd-bc0f-e2b1d131640d@intel.com>
Date: Fri, 16 Aug 2024 16:17:00 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/25] cxl/port: Add endpoint decoder DC mode support
 to sysfs
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
 <20240816-dcd-type2-upstream-v3-10-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-10-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Endpoint decoder mode is used to represent the partition the decoder
> points to such as ram or pmem.
> 
> Expand the mode to allow a decoder to point to a specific DC partition
> (Region).
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes:
> [Fan: change mode range logic]
> [Fan: use !resource_size()]
> [djiang: use the static mode name string array in mode_store()]
> [Jonathan: remove rc check from mode to region index]
> [Jonathan: clarify decoder mode 'mixed']
> [djbw: drop cleanup patch and just follow the convention in cxl_dpa_set_mode()]
> [fan: make dcd resource size check similar to other partitions]
> [djbw, jonathan, fan: remove mode range check from dc_mode_to_region_index]
> [iweiny: push sysfs versions to 6.12]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 ++++++++++----------
>  drivers/cxl/core/hdm.c                  | 10 ++++++++++
>  drivers/cxl/core/port.c                 | 10 +++++-----
>  drivers/cxl/cxl.h                       | 35 ++++++++++++++++++---------------
>  4 files changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a..957717264709 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -316,23 +316,24 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, October 2024
> +KernelVersion:	v6.0, v6.12 (dcY)
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
> +		decoder straddles partition boundaries, and 'none' indicates
> +		the decoder is not actively decoding, or no DPA allocation
> +		policy has been set.
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
> index b4a517c6d283..ceca0b3d3e5c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -551,6 +551,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -578,6 +579,15 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		goto out;
>  	}
>  
> +	if (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7) {
> +		rc = dc_mode_to_region_index(mode);
> +		if (!resource_size(&cxlds->dc_res[rc])) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			rc = -ENXIO;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode = mode;
>  	rc = 0;
>  out:
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8054cbaac9f6..222aa0aeeef7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -205,11 +205,11 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  	enum cxl_decoder_mode mode;
>  	ssize_t rc;
>  
> -	if (sysfs_streq(buf, "pmem"))
> -		mode = CXL_DECODER_PMEM;
> -	else if (sysfs_streq(buf, "ram"))
> -		mode = CXL_DECODER_RAM;
> -	else
> +	for (mode = CXL_DECODER_RAM; mode < CXL_DECODER_MIXED; mode++)
> +		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
> +			break;
> +
> +	if (mode >= CXL_DECODER_MIXED)
>  		return -EINVAL;
>  
>  	rc = cxl_dpa_set_mode(cxled, mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 53b666ef4097..16861c867537 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -365,6 +365,9 @@ struct cxl_decoder {
>  /*
>   * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
>   * while cxld_unregister() is running
> + *
> + * NOTE: CXL_DECODER_RAM must be second and CXL_DECODER_MIXED must be last.
> + *	 See mode_store()
>   */
>  enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
> @@ -382,25 +385,25 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_DEAD,
>  };
>  
> +static const char * const cxl_decoder_mode_names[] = {
> +	[CXL_DECODER_NONE] = "none",
> +	[CXL_DECODER_RAM] = "ram",
> +	[CXL_DECODER_PMEM] = "pmem",
> +	[CXL_DECODER_DC0] = "dc0",
> +	[CXL_DECODER_DC1] = "dc1",
> +	[CXL_DECODER_DC2] = "dc2",
> +	[CXL_DECODER_DC3] = "dc3",
> +	[CXL_DECODER_DC4] = "dc4",
> +	[CXL_DECODER_DC5] = "dc5",
> +	[CXL_DECODER_DC6] = "dc6",
> +	[CXL_DECODER_DC7] = "dc7",
> +	[CXL_DECODER_MIXED] = "mixed",
> +};
> +
>  static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  {
> -	static const char * const names[] = {
> -		[CXL_DECODER_NONE] = "none",
> -		[CXL_DECODER_RAM] = "ram",
> -		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_DC0] = "dc0",
> -		[CXL_DECODER_DC1] = "dc1",
> -		[CXL_DECODER_DC2] = "dc2",
> -		[CXL_DECODER_DC3] = "dc3",
> -		[CXL_DECODER_DC4] = "dc4",
> -		[CXL_DECODER_DC5] = "dc5",
> -		[CXL_DECODER_DC6] = "dc6",
> -		[CXL_DECODER_DC7] = "dc7",
> -		[CXL_DECODER_MIXED] = "mixed",
> -	};
> -
>  	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> -		return names[mode];
> +		return cxl_decoder_mode_names[mode];
>  	return "mixed";
>  }
>  
> 

