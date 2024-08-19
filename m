Return-Path: <linux-btrfs+bounces-7319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2195707B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B921F242AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778B49652;
	Mon, 19 Aug 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+ZMsRNg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77251177982;
	Mon, 19 Aug 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085372; cv=none; b=cc8J6BmeG5UaBGHEmpMxhVTaI9sAdGoJfB2YBCh8GgDDLh1J8/nd4qVimDeJV6SHxbSZluAKs59zriMgf0mJjZCGdojEpE10syqdkw37txTBRksFHswS9qJ/9VKGTgKUrDr9wlzkfRIZYupPDGWVL1Wzpunus8yxnV8sg6G3Wzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085372; c=relaxed/simple;
	bh=Ij42qg4XwDB1sODuJcyZUx7sN09vuh1W4zuPaVmRGAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRhx4/9W5lwDiRECrQVpH9AjaKEIYcDwJi5W5iWtqB7ZRXKzPN39ivSxwXdoHZOrd56svE5cKDw+2Qi/oZ0/bkNCXI4eJOr6x6g1L5qj1A3SFhReAsfQIe1mYFBwnRAv8AcCCKrbXL4pHeF3tGHZDtEbLqRzTGAXo+3adyR+Owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+ZMsRNg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724085370; x=1755621370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ij42qg4XwDB1sODuJcyZUx7sN09vuh1W4zuPaVmRGAI=;
  b=A+ZMsRNgnRODGlPLdzke2AlkmGneaZLPdg72u23xiwWEBR4rmoBdCSfj
   5G5qsmPBriS8o04h8K77ekMb0yhLM48nww9IfX1QgFCKx6wSgzrjoHJWH
   YjERuX6766vnNaYO2EXASfoUxQIlyc6O2tWrEybsrAXDjBYC0QrOFMEzA
   cK4tslv88to+NZgxQb2j7pMPvDhzOyaKDzHZscbhwmRsPYLyIM6wMpz1G
   GlOjhUNRADh7EnhY69z5YIp6WLIZ+3PkDaOW4DRUkTPz/Ow4Ms0tx3Oft
   Zo9hTu6dCD8i/KDN/sTe7DC7RO8u3Cu+I7qHFSFON3U9Ubw7GZuoTGacv
   w==;
X-CSE-ConnectionGUID: nvSkGs9GTGKoQEvokLjaeA==
X-CSE-MsgGUID: GL/sByv2TCirSRFRlYI3Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33014580"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33014580"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 09:36:09 -0700
X-CSE-ConnectionGUID: ljhaOIarRHyIrsJxWNopMw==
X-CSE-MsgGUID: 6PLaEDX6RsWzXnrsWF2giw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60400622"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.111.235]) ([10.125.111.235])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 09:36:06 -0700
Message-ID: <47768d4a-1be2-4e4e-a84e-05e736f3966c@intel.com>
Date: Mon, 19 Aug 2024 09:35:49 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/25] cxl/core: Return endpoint decoder information
 from region search
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
 <20240816-dcd-type2-upstream-v3-17-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-17-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, Ira Weiny wrote:
> cxl_dpa_to_region() finds the region from a <DPA, device> tuple.
> The search involves finding the device endpoint decoder as well.
> 
> Dynamic capacity extent processing uses the endpoint decoder HPA
> information to calculate the HPA offset.  In addition, well behaved
> extents should be contained within an endpoint decoder.
> 
> Return the endpoint decoder found to be used in subsequent DCD code.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h   | 6 ++++--
>  drivers/cxl/core/mbox.c   | 2 +-
>  drivers/cxl/core/memdev.c | 4 ++--
>  drivers/cxl/core/region.c | 8 +++++++-
>  4 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15b6cf1c19ef..76c4153a9b2c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -39,7 +39,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  
> @@ -50,7 +51,8 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>  	return ULLONG_MAX;
>  }
>  static inline
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled)
>  {
>  	return NULL;
>  }
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 68c26c4be91a..01a447aaa1b1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -909,7 +909,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
>  		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
> -		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +		cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  		if (cxlr)
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7da1f0f5711a..12fb07fb89a6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -323,7 +323,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (rc)
>  		goto out;
>  
> -	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  	if (cxlr)
>  		dev_warn_once(mds->cxlds.dev,
>  			      "poison inject dpa:%#llx region: %s\n", dpa,
> @@ -387,7 +387,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (rc)
>  		goto out;
>  
> -	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa, NULL);
>  	if (cxlr)
>  		dev_warn_once(mds->cxlds.dev,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 35c4a1f4f9bd..8e0884b52f84 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2828,6 +2828,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  struct cxl_dpa_to_region_context {
>  	struct cxl_region *cxlr;
>  	u64 dpa;
> +	struct cxl_endpoint_decoder *cxled;
>  };
>  
>  static int __cxl_dpa_to_region(struct device *dev, void *arg)
> @@ -2861,11 +2862,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  			dev_name(dev));
>  
>  	ctx->cxlr = cxlr;
> +	ctx->cxled = cxled;
>  
>  	return 1;
>  }
>  
> -struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> +struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
> +				     struct cxl_endpoint_decoder **cxled)
>  {
>  	struct cxl_dpa_to_region_context ctx;
>  	struct cxl_port *port;
> @@ -2877,6 +2880,9 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
>  
> +	if (cxled)
> +		*cxled = ctx.cxled;
> +
>  	return ctx.cxlr;
>  }
>  
> 

