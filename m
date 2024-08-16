Return-Path: <linux-btrfs+bounces-7299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A349553F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 01:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42FFB21FC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A163114830F;
	Fri, 16 Aug 2024 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg+L73E7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6AB661;
	Fri, 16 Aug 2024 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723852637; cv=none; b=gmOdWQqK1Yp9Skhi4QnU/H2eFBkhlHwQVCnE/GxoB0nEictuJiS1jZxzJ/LEncENuYxAyAI17PcJnL7xtRbK8cVS07byIVsTKha1B+RflsFSJ47+9PGyY7h79MOZKVJMY/IqLhP7PNelERSxwj3FAhCbM7mid+kemWrTpKV4cDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723852637; c=relaxed/simple;
	bh=UHlzo5S6DdvUcdhWPCY3lGHMj3T/in1RAfErRbmFYWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jni2KPrNjx0IBLUaaNABVtmY4Rpt2U5zaWCJ7SWnYzA1BWcNr06vI6cxdC8+YO0S/+s+NNnJs9MMK8fLCthzcAKiqkPbc8UMPeTRS0FdY0/j/NX8+UDKP3o4j/2Fm2OmCMcs5dWrY490tIrTcf59e/21fVE0zr9FQoBpIwcC7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg+L73E7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723852635; x=1755388635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UHlzo5S6DdvUcdhWPCY3lGHMj3T/in1RAfErRbmFYWI=;
  b=lg+L73E7ArGLymrNYcIdt6+EAcHwL/u4UJPdboX4n2ixI91Ru39sfn1s
   4rhaXF0DFftt5x4LUDD4lCMj1/lENs75bmPVmyWzVsNVPk3xHNxwzYG81
   zitnuqV20L7FLncn2wEwELXud1fSHuMqlaN2pJjh4CEliazeBXvWloiyX
   Ea97i86iNXjnq0qU74IONRHdqtnge6jHrembgnwutstdJh95BiODTv0pb
   XjMjwqYTNcCD928OgWSF1otp9AeYw0/3h+wiTtS7XiIYJOfcKHFYCoTLS
   8CYeX7UXu08YFNbZcMzKiRPg7q049ojXaqEnRE2ZGngTZXKLD3LPbmr3J
   g==;
X-CSE-ConnectionGUID: z88lSqDYSxKX74KUJBby0Q==
X-CSE-MsgGUID: rbF4DYpQRnuK1L4Wbkt+Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32735549"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="32735549"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:57:15 -0700
X-CSE-ConnectionGUID: CnvhQkBcRbqHhNIr/FlI5A==
X-CSE-MsgGUID: MTXli2OBREurMyd4AIS65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59973236"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 16:57:14 -0700
Message-ID: <9a15afbe-409d-4432-8b06-d1f7046c0f7a@intel.com>
Date: Fri, 16 Aug 2024 16:57:11 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] cxl/events: Split event msgnum configuration
 from irq setup
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
 <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-14-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/24 7:44 AM, Ira Weiny wrote:
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f7f03599bc83..17bea49bbf4d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -698,35 +698,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	return cxl_event_get_int_policy(mds, policy);
>  }
>  
> -static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
> +static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> +			      struct cxl_event_interrupt_policy *policy)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> -	struct cxl_event_interrupt_policy policy;
>  	int rc;
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->info_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
>  		return rc;
>  	}
>  
> -	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> +	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
>  		return rc;
> @@ -745,7 +741,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
>  	int rc;
>  
>  	/*
> @@ -773,11 +769,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  		return -EBUSY;
>  	}
>  
> +	rc = cxl_event_config_msgnums(mds, &policy);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds);
> +	rc = cxl_event_irqsetup(mds, &policy);
>  	if (rc)
>  		return rc;
>  
> 

