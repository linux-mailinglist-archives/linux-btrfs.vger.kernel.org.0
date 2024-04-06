Return-Path: <linux-btrfs+bounces-3993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50489A7CF
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 02:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9155A1C21035
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB611CA9;
	Sat,  6 Apr 2024 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG3TgztX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E965816;
	Sat,  6 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361786; cv=none; b=SbA3khasmjRZ1Vfg2Fhh06B7Sl2jLSJpvpUWh4Ivg3UEfDjLnE5G1aeeU9cvg+iObwHYzdTmBVYTIThBKwYXO6eqxvWiBlobDyQURhETfEqmZKDbNvROHNh+QADB+evsWFaW2OeBOxdwHsJbzegjOWzbu5fbNcy/NMnKHy6km/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361786; c=relaxed/simple;
	bh=5+ttekEZLHQpyaO1iP5vIUkSvn9+MlpWyDlBi1o2uC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTJGjBBh+/RNtlzn/F8/5j+fAwN29w6nPtwZ/R8iPIskrls1e5ZTNjWKZlUqnrZkpiJqm/6CTqShD6/yRtetMMCczSdu+L6CrzrueHcyPO95ih3top5LCEQo4oirfXKE7Gx10ESvO0nyumvivmROm1jdXUkWUNX7SHi6ZDMGGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG3TgztX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361785; x=1743897785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+ttekEZLHQpyaO1iP5vIUkSvn9+MlpWyDlBi1o2uC0=;
  b=CG3TgztXXawoWUj6a5VqKUbEOBezBAZE2x59mkjtyq87xc/FCFyskK48
   8ig1KhDTaQem3VX/Cdy96N3rinrzuw2AzOYp765H9IX5P9sRVxb6q32qi
   1M+L8DKtuDRv42W4oCP8+wRAv8HS/wNP3GBRTtrOpbWBsQZJxsHB0HqAL
   oTks+AqshnOeiFSnWaG2nuEUsga47aX/fQVd1jnd87gIJGbsXSZxieuvk
   oWaeyN2a7Y7rV6O4c4Gnx8uAX1ubMmRpL8fqmjCtUZrEgkd+/hV7quY4i
   vxWuY9Pdti3bnCW6xMzl62MYhXQcG7LZFKsZRgYpjl3eLOHOhnCVEsnJv
   A==;
X-CSE-ConnectionGUID: YmEtQnnIQE+FrD7+qVnrmw==
X-CSE-MsgGUID: T5bxxeTGQ+6PEkeY6Kabwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19071442"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19071442"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:02:30 -0700
X-CSE-ConnectionGUID: E/h9uEyaRkSgY+NJKEllqw==
X-CSE-MsgGUID: ewioc3H7R+CG3K+qX7ZKBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19381024"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.38.118]) ([10.212.38.118])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:02:25 -0700
Message-ID: <6f43f4be-f2da-4bc5-a70c-377599c9ec46@intel.com>
Date: Fri, 5 Apr 2024 17:02:23 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
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
 <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
 <922007a0-3f85-4a40-80e4-5c906e6dd2c8@intel.com>
 <66104f505de74_e9f9f294f5@iweiny-mobl.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <66104f505de74_e9f9f294f5@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 12:21 PM, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 3/24/24 4:18 PM, Ira Weiny wrote:
>>> cxl_dpa_set_mode() checks the mode for validity two times, once outside
>>> of the DPA RW semaphore and again within.  The function is not in a
>>> critical path.  Prior to Dynamic Capacity the extra check was not much
>>> of an issue.  The addition of DC modes increases the complexity of
>>> the check.
>>>
>>> Simplify the mode check before adding the more complex DC modes.
>>
>> I would augment this by saying simplify "by using scope-based resource menagement".
> 
> However, using the guard cleanup is not really the simplification here.  It is
> more about checking the mode a single time.
> 
> That said I will change this to:
> 
> Simplify the mode check and convert to use of a cleanup guard.

Ok

> 
> Ira

