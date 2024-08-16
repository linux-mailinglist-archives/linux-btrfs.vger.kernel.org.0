Return-Path: <linux-btrfs+bounces-7297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B239553DE
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8D21C22524
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565C14830D;
	Fri, 16 Aug 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb0wQJ4W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90914145FEE;
	Fri, 16 Aug 2024 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723851790; cv=none; b=kALuSCQYpY0VkoHubdichpiUdck7f1G1e409/l7BBOQQv9JjQvjjBKjyemp8ISvuLETVyWd5MYhloFiwcJpm6mpDzzvBgJCjVdgaWJW7+dkIFp21/p2he8ac9yTlNRCsWfj3tSXaE+9A3eQwSUX77l6/pWzsatZSa/ueDk9ptZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723851790; c=relaxed/simple;
	bh=beYeNlxIPK9w8xuSxdQ/6Grv4kIGkfjA0BnlbGC+1r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqNd2hNJwLtIgDO0TF70LX0HCu0XE+Fm2M91ffCH4KF4xWAQ9JRNR95Awp7z7RDAHcxVzGWtXF39XCJzAT8LYU+2cZ1FwrxthuIcWjTmF0yGKypGBfXXExM9IvpUDzPl7fInSjATtiPKkYg9zNCBfVAV7izDYnICvNWepxu80JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb0wQJ4W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723851789; x=1755387789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=beYeNlxIPK9w8xuSxdQ/6Grv4kIGkfjA0BnlbGC+1r8=;
  b=nb0wQJ4W/gQOouvGmRTZxAyUYuRPvxi+dcnpDBM3tFcqfCXm9GzBqVVk
   bAT28JpJkBTC1S/EkEOEP7NhJpc1QXZ9/QaJX/DP9mh7UjGZ3aWHuutWD
   FYdb66AkqYIstLDiJ/vmXWAedVvOd7tbZmMlsI5FBnABYGG3M2Rlvac/W
   jGGOOALuSqfceQlFaAS3yqb2rSKIlQkG2DH3UhGNJSESXw8LcsE4n4TbF
   VmJqTHFtLmdKB0JbhT8N5nVvWWk+StEOnZDU6Rg3mMfmRaapO86cp29Q0
   0GD5nPh3GcadlDvTU6vCE8fLGYd03kUXDcFJr868881r9qiQrlLClkKDV
   w==;
X-CSE-ConnectionGUID: v1Ms/Qh4SUmX/M8wNlrEUw==
X-CSE-MsgGUID: x5SqDUECToGK44IWS1MaJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="13063657"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="13063657"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:43:08 -0700
X-CSE-ConnectionGUID: vq/orHWdTz2gVCT3RIU/Tg==
X-CSE-MsgGUID: TCalvPG1SyOQwnnUMzHcFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59842897"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:43:06 -0700
Message-ID: <fcfbae13-9c6b-460d-ab10-e739caf86a06@intel.com>
Date: Fri, 16 Aug 2024 16:43:05 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/25] cxl/region: Refactor common create region code
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
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
 <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, Ira Weiny wrote:
> create_pmem_region_store() and create_ram_region_store() are identical
> with the exception of the region mode.  With the addition of DC region
> mode this would end up being 3 copies of the same code.
> 
> Refactor create_pmem_region_store() and create_ram_region_store() to use
> a single common function to be used in subsequent DC code.
> 
> Suggested-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 650fe33f2ed4..f85b26b39b2f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2553,9 +2553,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>  }
>  
> -static ssize_t create_pmem_region_store(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t len)
> +static ssize_t create_region_store(struct device *dev, const char *buf,
> +				   size_t len, enum cxl_region_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_region *cxlr;
> @@ -2565,31 +2564,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
> +	cxlr = __create_region(cxlrd, mode, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
>  	return len;
>  }
> +
> +static ssize_t create_pmem_region_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	return create_region_store(dev, buf, len, CXL_REGION_PMEM);
> +}
>  DEVICE_ATTR_RW(create_pmem_region);
>  
>  static ssize_t create_ram_region_store(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_region *cxlr;
> -	int rc, id;
> -
> -	rc = sscanf(buf, "region%d\n", &id);
> -	if (rc != 1)
> -		return -EINVAL;
> -
> -	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
> -	if (IS_ERR(cxlr))
> -		return PTR_ERR(cxlr);
> -
> -	return len;
> +	return create_region_store(dev, buf, len, CXL_REGION_RAM);
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> 

