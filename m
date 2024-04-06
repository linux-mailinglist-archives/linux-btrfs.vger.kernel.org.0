Return-Path: <linux-btrfs+bounces-3992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19A89A7C0
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 02:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4261C2101E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF09E1EA6E;
	Sat,  6 Apr 2024 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIeL2grW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49C32C92;
	Sat,  6 Apr 2024 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361695; cv=none; b=OMf/b7k61sm+BcoGn83uodVpMVY399pAuyawy+ek8dP3Q7sVZBcgt5veKUpYxPMEJf/aOtfA934WzQuQDHfbjcSpVwAUvmAO7uUkSlnnvU8xjVoT4HfSRZYV1PiSsfYKexmmeOYSvrMZH6LySxD+uH1A90AY/2Fl9jYdxp3l/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361695; c=relaxed/simple;
	bh=dnEl1bSn8VJ78TGNl6mm0353QJWGdbMkyEQ8vUlvqOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AunQDUcLsvubkGw4emxIwY97Z7D+xs9gu7OJY8HcHU0i1jsWmQFyVcGfm8m4uebkHoSJUKUSX34BR/VlQQkkEQ598wOoI0PSOA8IJmmQ71LT6d3n4hO6jXRqxklc4Yh1QTSkoouOR28opWKpQ4G5G+7bWn6l6QKSBn5FkMCYLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIeL2grW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361693; x=1743897693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dnEl1bSn8VJ78TGNl6mm0353QJWGdbMkyEQ8vUlvqOQ=;
  b=PIeL2grWeeeDXPV5Z8zZSWmXmF9vkKft1681h/bb/vDM5Tc767VqgDB5
   mBSaBmZGD4xrzJoB8fEdaFTG9aKZ+sm2ea9pqxsPYvb5V6hmvBtJWtoCt
   ZpfHFu175XrLjEhpEVuA/I/FoHKreFU1msFH1voOFgPd7lpM0+5j1r9jR
   2pTaAXx0rX5A6h30AjzQD8XZfBkO/c/PuDMnkG5Crc0ZyfD72IGhrI3UR
   551CcwIDq7GR1voaP7cZ2Ry55CjmmrC4RTODdTb5KstaUibrUJk68N9DA
   JmgnAbJWINmZWTN9GiS2C3mEtGyrl5ELWIkKPMhZYXERH/TEJ3CJs69Nq
   Q==;
X-CSE-ConnectionGUID: EraClYA9Rf2pFJmlCf37kQ==
X-CSE-MsgGUID: HqxLVUU+Q9y5scj/jWT3Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19071058"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19071058"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:01:32 -0700
X-CSE-ConnectionGUID: srenPdH2SkaNTFfAdLd4bA==
X-CSE-MsgGUID: zkq/j+qcQUKmUocue1es1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19379967"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.38.118]) ([10.212.38.118])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:01:33 -0700
Message-ID: <9593d672-8a01-437c-8a87-7217a38408c1@intel.com>
Date: Fri, 5 Apr 2024 17:01:31 -0700
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
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-4-b7b00d623625@intel.com>
 <1c7f63c5-1b7a-4f7b-9d48-4dd8b017d7de@intel.com>
 <661040ab52a14_e9f9f2943c@iweiny-mobl.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <661040ab52a14_e9f9f2943c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 11:19 AM, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
>> On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
>>> From: Navneet Singh <navneet.singh@intel.com>
>>>
>>> Region mode must reflect a general dynamic capacity type which is
>>> associated with a specific Dynamic Capacity (DC) partitions in each
>>> device decoder within the region.  DC partitions are also know as DC
>>> regions per CXL 3.1.
>>
>> This section reads somewhat awkward to me. Does this read any better?
>>
>> One or more Dynamic Capacity (DC) partitions (and decoders) form a CXL
>> software region. The region mode reflects composition of that entire software
>> region. Decoder mode reflects a specific DC partition. DC partitions are also
>> known as DC regions per CXL specification r3.1 but is not the same entity as
>> CXL software regions.
> 
> Yea that does sound better but I think this builds on your text and is even
> more clear.
> 
> <commit>
> cxl/region: Add dynamic capacity decoder and region modes
> 
> One or more decoders each pointing to a Dynamic Capacity (DC) partition form a
> CXL software region.  The region mode reflects composition of that entire
> software region.  Decoder mode reflects a specific DC partition.  DC partitions
> are also known as DC regions per CXL specification r3.1 but they are not the
> same entity as CXL software regions.
> 
> Define the new modes and helper functions required to make the association
> between these new modes.
> 
> </commit>
> 

LGTM
> 
> Ira

