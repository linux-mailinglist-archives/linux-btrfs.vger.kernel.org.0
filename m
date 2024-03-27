Return-Path: <linux-btrfs+bounces-3674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47588ECD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27BC1F2C5B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF914E2CE;
	Wed, 27 Mar 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aycjg/sz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E812E1F0;
	Wed, 27 Mar 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561280; cv=none; b=FwfM+2xE4MC7W3ROgMRHlMSAS8RZ8OBVirGIeS1RXjaEZNUpR2I9I9ineIZo3QCzazmbau/rOVUA5GeRpCsXoXTej5tvoPqwr5t4i/1MRAFPA8BU51O12ZVG7loZN2mI6LKOzemfRKkpw/5Q6m4Cxh82buNJgnBQ0qWGQ+Es9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561280; c=relaxed/simple;
	bh=CgrYWenITCZVs5rgxOkYDcWumcyCEq1xPoUasY+8V8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE3ttxVbnjoItEkCKsGKSBokQ3aDPW++O0WvtLl1NcR5GwyYuCEOWyg6U23fiE8V34ubL5GOdehVCyyGRP2Gyb7j2JjCNij0PxCM53ho9oWRwAERTdButB/33JGv2JH2iNdvhRcIJMIIVlC+nroA8/j3XGFqEPRsYBqAClLl6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aycjg/sz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711561279; x=1743097279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgrYWenITCZVs5rgxOkYDcWumcyCEq1xPoUasY+8V8Q=;
  b=aycjg/szt+05QwBPrT3JrrdbwtjnTCs1Y80eygq7DsVjuBi2KprJr64O
   3KY3CfqDdur7L541bSmQZpWw0l5u7MrG8RsgTEzU/L+qu0GeZkPcNslFd
   w+JGlxYvYcqc8EdpdTtDUsJP8Njm/tbe6QmqnZXP8t/WFShq7mRZYmD9T
   DEflWyDvEC2hMxB7uKrpPP9xv5ZcdSRTEnxiIKX4DnM7ZQ2v1s7KA/TMV
   BDuclb0rT+erni0nt5E42/dCS7UDwnNnIeeHK8vy2LF/ofm2vYV1Un8r6
   hR7QOujIyqq0i1+7pyDnj/+yFG+4FRRygt6SYhVqgq3wbVEu3heHCp9wH
   A==;
X-CSE-ConnectionGUID: z3f/mZQMR1yMB6t7zZwYhw==
X-CSE-MsgGUID: BE1/EEVfRiCxDJe2Wkc0DQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17824937"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="17824937"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16998217"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:41:07 -0700
Message-ID: <4e24a03c-f557-4323-a836-ed01f72a3055@intel.com>
Date: Wed, 27 Mar 2024 10:41:05 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/26] cxl/pci: Factor out interrupt policy check
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-12-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-12-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
> Dynamic capacity devices (DCD) require interrupts to notify the host of
> events in the DCD log.  The interrupts for DCD may be supported despite
> FW control of memory event logs.
> 
> Prepare to support DCD event interrupts separate from other event
> interrupts by factoring out the check for event interrupt settings.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for V3:
> [iweiny: new patch]
> ---
>  drivers/cxl/pci.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccaf4ad26a4f..12cd5d399230 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -738,6 +738,21 @@ static bool cxl_event_int_is_fw(u8 setting)
>  	return mode == CXL_INT_FW;
>  }
>  
> +static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
> +					  struct cxl_event_interrupt_policy *policy)
> +{
> +	if (cxl_event_int_is_fw(policy->info_settings) ||
> +	    cxl_event_int_is_fw(policy->warn_settings) ||
> +	    cxl_event_int_is_fw(policy->failure_settings) ||
> +	    cxl_event_int_is_fw(policy->fatal_settings)) {
> +		dev_err(mds->cxlds.dev,
> +			"FW still in control of Event Logs despite _OSC settings\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> @@ -760,14 +775,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_int_is_fw(policy.info_settings) ||
> -	    cxl_event_int_is_fw(policy.warn_settings) ||
> -	    cxl_event_int_is_fw(policy.failure_settings) ||
> -	    cxl_event_int_is_fw(policy.fatal_settings)) {
> -		dev_err(mds->cxlds.dev,
> -			"FW still in control of Event Logs despite _OSC settings\n");
> +	if (!cxl_event_validate_mem_policy(mds, &policy))
>  		return -EBUSY;
> -	}
>  
>  	rc = cxl_event_config_msgnums(mds, &policy);
>  	if (rc)
> 

