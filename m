Return-Path: <linux-btrfs+bounces-3654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C4288E9A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF37F1F32C45
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868C12F597;
	Wed, 27 Mar 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSUJG0rs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361412EBD8;
	Wed, 27 Mar 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554207; cv=none; b=r0o1IneuLbF6RIxXlXC1mIOTJKlbIO/r38Xu+HIDn6StVh4R+pCATbiyX7us3QgFVSvAYzn8guJ0mOe11QjLLLjHjhJt0puDkz+6nOXAdXCxyB1i0lVVRKW9RfDLXhAyFr7lTl2ILM06Ma1R1UOO0dIBFO2xfHbHwo8HBCFvd/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554207; c=relaxed/simple;
	bh=l0AFTz7QNeuG4/Rna8jbSi7dILAGOV01dUFsJnzrOpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seOQISE7Tp/s8sjoHBI35yJyL4VblbUoE7bxhS15zICRsX3jb50btRYBq/qfx/vRLWFsbwycd1X/SWMig1pbp/RnknWNERqQYxquj3fKfs2i6mGGk9SmwKICfUsou2TNac6K0qYXIgMEhBz2LJk4DLZ/+DSS71Mnp3S/brOCvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSUJG0rs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711554205; x=1743090205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0AFTz7QNeuG4/Rna8jbSi7dILAGOV01dUFsJnzrOpM=;
  b=gSUJG0rsvmNkRiG0UYgXOw2wNNnPzCp+BxfMByHM6AUVRYVd066OucWt
   31zwf0H/mwQz9FdlPtyGtfjvm0L4/6UzOlWdZBMyLpGJvGPl3e/6wts/w
   U1qSRQmrA8kALThdgZ7HafFq/xKWczSIg3jFyjt98F4TGFpOZ/daPUCSq
   sy8feqe8oVrV18nRy6382wWtIamyjhsz9REmWLm//CDXB4HfVqc6nXF36
   gKGi43wOjaKCadgDmXyzN4Vz2n4hRzfvB73Y7EweR3SEywL3VZliTMqri
   4CODpeUn5TjIot+1Be50cORtTYtcnQaqItOa38JOCY4aBtS94WtQHNmgu
   Q==;
X-CSE-ConnectionGUID: WnjgG3x3Sqq2PyeQFk9xqw==
X-CSE-MsgGUID: pbruE37sTXeWWFuLfca/BQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="32109481"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="32109481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16386553"
Received: from aonyia-mobl.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:43:23 -0700
Message-ID: <1c7f63c5-1b7a-4f7b-9d48-4dd8b017d7de@intel.com>
Date: Wed, 27 Mar 2024 08:43:22 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/26] cxl/region: Add dynamic capacity decoder and region
 modes
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
 <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Region mode must reflect a general dynamic capacity type which is
> associated with a specific Dynamic Capacity (DC) partitions in each
> device decoder within the region.  DC partitions are also know as DC
> regions per CXL 3.1.

This section reads somewhat awkward to me. Does this read any better?

One or more Dynamic Capacity (DC) partitions (and decoders) form a CXL software region. The region mode reflects composition of that entire software region. Decoder mode reflects a specific DC partition. DC partitions are also known as DC regions per CXL specification r3.1 but is not the same entity as CXL software regions.

DJ

> 
> Decoder mode reflects a specific DC partition.
> 
> Define the new modes to use in subsequent patches and the helper
> functions required to make the association between these new modes.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes for v1
> [iweiny: split out from: Add dynamic capacity cxl region support.]
> ---
>  drivers/cxl/core/region.c |  4 ++++
>  drivers/cxl/cxl.h         | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1723d17f121e..ec3b8c6948e9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1690,6 +1690,8 @@ static bool cxl_modes_compatible(enum cxl_region_mode rmode,
>  		return true;
>  	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
>  		return true;
> +	if (rmode == CXL_REGION_DC && cxl_decoder_mode_is_dc(dmode))
> +		return true;
>  
>  	return false;
>  }
> @@ -2824,6 +2826,8 @@ cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
>  		return CXL_REGION_RAM;
>  	case CXL_DECODER_PMEM:
>  		return CXL_REGION_PMEM;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		return CXL_REGION_DC;
>  	case CXL_DECODER_MIXED:
>  	default:
>  		return CXL_REGION_MIXED;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9a0cce1e6fca..3b8935089c0c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -365,6 +365,14 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>  	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
> @@ -375,6 +383,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_DC0] = "dc0",
> +		[CXL_DECODER_DC1] = "dc1",
> +		[CXL_DECODER_DC2] = "dc2",
> +		[CXL_DECODER_DC3] = "dc3",
> +		[CXL_DECODER_DC4] = "dc4",
> +		[CXL_DECODER_DC5] = "dc5",
> +		[CXL_DECODER_DC6] = "dc6",
> +		[CXL_DECODER_DC7] = "dc7",
>  		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> @@ -383,10 +399,16 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +static inline bool cxl_decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> +}
> +
>  enum cxl_region_mode {
>  	CXL_REGION_NONE,
>  	CXL_REGION_RAM,
>  	CXL_REGION_PMEM,
> +	CXL_REGION_DC,
>  	CXL_REGION_MIXED,
>  };
>  
> @@ -396,6 +418,7 @@ static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
>  		[CXL_REGION_NONE] = "none",
>  		[CXL_REGION_RAM] = "ram",
>  		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_DC] = "dc",
>  		[CXL_REGION_MIXED] = "mixed",
>  	};
>  
> 

