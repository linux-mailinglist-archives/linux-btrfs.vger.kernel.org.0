Return-Path: <linux-btrfs+bounces-3738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E002C890AA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB9294DEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D38139CED;
	Thu, 28 Mar 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DK3GyJGw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E936AF5;
	Thu, 28 Mar 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656583; cv=none; b=Mt4o4+yOIoDknN3Y8CbNXL9yjGubvtgD9ZdMRU5QcUkBiVOC/IdldrQYzBBMNSLAKkCaQIjJ8gU1ur5fVYKoArdLvL9tcY23IkYn5AyvgKTN11X8P6ows0JMZynBPZwcdqOaItntkR5vYaHS+NyHJ3Objm6ItI+dmSfb5WMs1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656583; c=relaxed/simple;
	bh=ik1M7ZZzzI5ShyQ5+NHuLBaVWwdADLPhh4sSQSATlG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzLVKpqRg7PxHqVXB6j+uIqxY86k6G1yFpAKcYtLS76bq78wBLKMLbKXmVPUfg1ucbeb/XfL4Vmuhd3jQgsHMMjUkbJeaXG5oqIFDK4UiTyU2/1oAy17YXShOCyZpustPJqYUJ9DNm4mXEJC9UYRtVjQflKQMg3jMjSOxAd8acA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DK3GyJGw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711656581; x=1743192581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ik1M7ZZzzI5ShyQ5+NHuLBaVWwdADLPhh4sSQSATlG0=;
  b=DK3GyJGwqJDup74IHeBqr1nbWFA9/etvFtlMpEMoKkx/P83qfwuJWhg5
   kfUm3Lnas0fqZGvQM6O/wAXbCcYCOLzDpd95v+BME4iNR7wU1ETNRQflD
   Nu6jKeqHwDzXwmLmVMUG0meyfh4a8iOOfMLbHUrmW63O+u+XbyW/KRDjP
   +1FdPuBm7oMvC/AWIYRKpujbbYnEsqyMTy+hlY1aDTiohEtgWzKZSrETB
   5jtu8SVP2mhRoBLUjlbLas1Ra8KD3x0/ta0ly+hB034wGt199dhsYZrKN
   gV0hGSTg4VUhHI7ay/Q3NeaZ+Hq+pWeyWh/351oF7o8udP3NrALBzfjFY
   w==;
X-CSE-ConnectionGUID: rODD7rb2ROq4/cdy5q6fhw==
X-CSE-MsgGUID: 1DdWMnSDQ6un+x/Y1rqV6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24326307"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24326307"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16633822"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.81.17]) ([10.212.81.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:09:39 -0700
Message-ID: <b6ff085c-8cdc-4867-83fd-9566d59d5946@intel.com>
Date: Thu, 28 Mar 2024 13:09:38 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
 <yd6mynddwk755ypomyspzxfsqwm7j5g47yfmbw2yfwoadpnnqy@7g3ktxrwkeau>
 <6604fe9e18eeb_20890294a1@iweiny-mobl.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6604fe9e18eeb_20890294a1@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/24 10:22 PM, Ira Weiny wrote:
> Davidlohr Bueso wrote:
>> On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:
>>
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
>>> Until now region modes and decoder modes were equivalent in that they
>>> were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
>>> regions (which will represent an array of device regions [better named
>>> partitions] the index of which could be different on different
>>> interleaved devices), the mode of an endpoint decoder and a region will
>>> no longer be equivalent.
>>>
>>> Define a new region mode enumeration and adjust the code for it.
>>
>> Could this could also be picked up regardless of dcd?
> 
> It could but there is no need for it without DCD.
> 
> I will work on re-ordering the cleanups if Dave will agree to take them
> early.

There's no reason for the change unless it comes with DCD right? And probably no urgent need to taking it ahead then?
> 
> Ira

