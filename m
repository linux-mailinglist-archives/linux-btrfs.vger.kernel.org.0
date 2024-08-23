Return-Path: <linux-btrfs+bounces-7439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9595D07C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D41C21C45
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9E18891E;
	Fri, 23 Aug 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQ/y7QTe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D71C680;
	Fri, 23 Aug 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425101; cv=none; b=NRshCV6hDiSfMh4AVfuV9S/b/WCoemuJHUcHPUGhmTgZr4c+/x42Bo9R41BycQkINqwExf3/sy+xdoBmfSdJ4pfVgEEThTavgNVkJAfia7rfAgGw7wvdKfrM1nSUA7KvXV0sAi01vOqKT1/Ec6tEnQfpdhC5qi1Xr5RZesurWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425101; c=relaxed/simple;
	bh=RIJ5IMLUqYoUq4w2rKXmJ74g66XrLOMkScgxzSKyVKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgdDyUn6Dia7QCHtF2e1l8tP4gj4AxjGIGnN54/W65sjmg78ZEDJz40mrOEkLt7E6ttTgXLBfU4yyM9TRIEnA+XNifdRmAaRTNl549F0MmuDl8PMKZkTfqCJ9VWnnCJQnXIMZ/eOUFY+Y66ScSmlCIBltnfP1xns8p4zLGj1qB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQ/y7QTe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724425100; x=1755961100;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RIJ5IMLUqYoUq4w2rKXmJ74g66XrLOMkScgxzSKyVKg=;
  b=lQ/y7QTeRM2aZo7/WzqgjR9igD9SajGlBZNL9ZhHSYDqTayVSdWa9hDy
   Ouhhjoc3eTLsJg7GmIut29fAQlbYYBhuMmYqqqfgo7NA/hunlr54BPRNO
   ohZFs5gOVQz8Pp6NkIn6zPQe7qeKMHxlVsEj7l4iABUsGV8WXZgMR4WVs
   tzF3CtJ28l0zC9w6Bkr0foRStqXUkDyrb26aOmyktiGwv7mYIbqLTbKvy
   FlwaOf0155ebX2YY62g14WEPNFByIOuk/zNx4EJ0QZ0J3NlcoEfo/csSb
   bFPsFxVkZb23cz2ImIHfHPYw64txQtmsrBof8n+PRbzgtd28B+7d7JsGr
   g==;
X-CSE-ConnectionGUID: ZIgzag8TTk2iMCqDpLM41A==
X-CSE-MsgGUID: lz/StwamS9CheYP8CtXVsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22862811"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="22862811"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:58:19 -0700
X-CSE-ConnectionGUID: bNjA9O0OSZmslLXYetSkMA==
X-CSE-MsgGUID: rBapzcb8TcuJ5Q1s3IeObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61839719"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:58:16 -0700
Message-ID: <9f5b072c-59eb-40c0-a121-1ac06f9c38d7@intel.com>
Date: Fri, 23 Aug 2024 07:58:15 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/25] cxl/mem: Expose DCD partition capabilities in
 sysfs
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
 <20240816-dcd-type2-upstream-v3-11-7c9b96cba6d7@intel.com>
 <8649e30c-a43a-4096-a32f-e31bf3e71d90@intel.com>
 <66c7f3d977851_1719d29424@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <66c7f3d977851_1719d29424@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/24 7:28 PM, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
>>> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
>>> user space will need to know the details of the DC partitions available.
>>>
>>> Expose dynamic capacity capabilities through sysfs.
>>>
>>> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
>>> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>>
>>> ---
>>> Changes:
>>> [iweiny: remove review tags]
>>> [Davidlohr/Fan/Jonathan: omit 'dc' attribute directory if device is not DC]
>>> [Jonathan: update documentation for dc visibility]
>>> [Jonathan: Add a comment to DC region X attributes to ensure visibility checks work]
>>> [iweiny: push sysfs version to 6.12]
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++
>>>  drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++++++++++
>>>  2 files changed, 109 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>>> index 957717264709..6227ae0ab3fc 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>>> @@ -54,6 +54,18 @@ Description:
>>>  		identically named field in the Identify Memory Device Output
>>>  		Payload in the CXL-2.0 specification.
>>>  
>>> +What:		/sys/bus/cxl/devices/memX/dc/region_count
>>> +		/sys/bus/cxl/devices/memX/dc/regionY_size
>>
>> Just make it into 2 separate entries?
> 
> Do you mean in the docs?

Yes. Here you are combining all the sysfs entries into 1. I'm suggesting unique block per each sysfs entry with their own description. 
> 
> Ira
> 
>>
>> DJ
>>> +Date:		August, 2024
>>> +KernelVersion:	v6.12
>>> +Contact:	linux-cxl@vger.kernel.org
>>> +Description:
>>> +		(RO) Dynamic Capacity (DC) region information.  The dc
>>> +		directory is only visible on devices which support Dynamic
>>> +		Capacity.
>>> +		The region_count is the number of Dynamic Capacity (DC)
>>> +		partitions (regions) supported on the device.
>>> +		regionY_size is the size of each of those partitions.
>>>  
>>>  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
>>>  Date:		May, 2023
> 
> [snip]

