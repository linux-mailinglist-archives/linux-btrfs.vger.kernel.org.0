Return-Path: <linux-btrfs+bounces-9264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DAD9B7F6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4531DB220B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025891BDAA5;
	Thu, 31 Oct 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRcYbMDw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD01A287E;
	Thu, 31 Oct 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390109; cv=none; b=gFfqP/SJoPkVesAY46Mxya+GEtjvQBgvFJ27gsQwU2xlhnuL6HdFfig9badYkRP25nOSxEHRAhPjFBoQKglftOE0Ele+NzAlY0CCiNWnqvlepDzw56KPyOJGbebjBPq0A3RAufTmijxNZs/KSs21KFgDki7N9f5i3CxCzvGvnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390109; c=relaxed/simple;
	bh=wlV3Rx5aKG704hWG8gNKyyb0F+JFaerl7qBcn2lQewo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXcRsOZshkOVAVs1wqmvPMg6cK4Ij3VFGj4DPFJfMDtKG0//wKh6cc1VU1IbMA4NqwOIk6O7euzVh8eKdlhIsHxp9239oAVdOxjnP6IER2Vwev9eFcvL8ZYzGsbE2KniV+qLuFKWZsGytCnlbz9xKobrk1vosxFanQahyGglHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRcYbMDw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730390107; x=1761926107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wlV3Rx5aKG704hWG8gNKyyb0F+JFaerl7qBcn2lQewo=;
  b=nRcYbMDwUR7Qbx+yF4Lbw2VGRNVejdqKMYgmD8z4tj29yGH75A7KKsyQ
   BbazPfyLqRwheHd1T32Bwv6w+kxpFeBsRGDEbgNhm+wB1Z4stXFy2nX0Q
   mFfpJNzH0TIm1xKbySfRHsPYi2i0Nyb/9WnBk7NcYTYfAxFxOJ0d4Dfss
   Gmi7kH9fWtgLgyRVohftGGPzLNJG68Nv57QfUnUqYpGXYahgTDa/6fQrE
   roXCHv8shxpH1TeVGsQrJ3A3U1FPPGSrA3MbeI2kQlZbhengbAWkutza9
   PoBG6jJ2qIm6F2l2HZMXlu9+yN0EaTqxk4KjypZEE7PYPRmawMULP5Jqi
   g==;
X-CSE-ConnectionGUID: tp3ALZ9mQPSbIyrUhKf+oA==
X-CSE-MsgGUID: Li5EgCUfR2Kr4iefjQCbXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41507963"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="41507963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:55:06 -0700
X-CSE-ConnectionGUID: rSnazU4oRDish+4AbsdK9A==
X-CSE-MsgGUID: xHNWbduNRwO9xzz1Nz+KAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82571183"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 08:55:04 -0700
Message-ID: <880d28c7-7284-41b2-88dc-12498b473a86@intel.com>
Date: Thu, 31 Oct 2024 08:55:03 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/27] DCD: Add support for Dynamic Capacity Devices
 (DCD)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Robert Moore <robert.moore@intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, Li Ming <ming4.li@intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
 <20241030144841.00006746@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241030144841.00006746@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 7:48 AM, Jonathan Cameron wrote:
> On Tue, 29 Oct 2024 15:34:35 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
>> A git tree of this series can be found here:
>>
>> 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-10-29
>>
>> Series info
>> ===========
>>
>> This series has 4 parts:
>>
>> Patch 1: Add core range_overlaps() function
>> Patch 2-6: CXL clean up/prelim patches
>> Patch 7-25: Core DCD support
>> Patch 26-27: cxl_test support
> 
> Other than a few trivial comments and that one build bot reported
> issue all looks good to me. Nice work Ira, Navneet etc.
> 
> Maybe optimistic to hit 6.13, but I'd love it if it did.
> If not, Dave, how about shaving a few off the front so at least
> there is less to remember for v6 onwards :)

I'd like to take it for 6.13. Just seeing if Dan has any last minute complaints :) We should be able to take 1-6 at least.

> 
> Jonathan


