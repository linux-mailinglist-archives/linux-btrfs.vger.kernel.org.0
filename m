Return-Path: <linux-btrfs+bounces-4123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651958A03DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 01:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018891F28C2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 23:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6527471;
	Wed, 10 Apr 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLPWVthE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0260138E;
	Wed, 10 Apr 2024 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790175; cv=none; b=f1lSWfKekXhnD6RGjZ5eOH9sNzzToyaIJO02UxqrJOl6sTeOnYffLWkOQjqVMMMuRl/kaWEvW1GhgrZ+OPB6bWv6kOipTNPr1H+z86aRvey7l6bxoyNhc8PvLmAM05LSAY02+aYomUyHv2Cz2GeWqxY+2muzJOtaLfuNjOejBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790175; c=relaxed/simple;
	bh=sFhWM211YDpR7/XHJA9rb31Qejl1CNxXKFja7LXZLGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIw8Z6CO3yN6L+YxrR9bLlEpFNs6ZHcDX8xYxi4Msl1eM2ukhObGTIxz+1b7v1XAZfPYxOUd6aREfHc3DX+o4LbnC+iF5g/SzC/xPbvQ2ZDURhJ72GR08IKx7jfRx+52Vqf+mK8hPDN9Y0tbSiNfEOHjLlH2cMYlAq5vQ3Qt1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLPWVthE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712790174; x=1744326174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFhWM211YDpR7/XHJA9rb31Qejl1CNxXKFja7LXZLGo=;
  b=PLPWVthEHYCnFcTrzztlC0nvBjzIHDkPTl83zzqw1WDpy+qCfmzjLPDO
   EUkn5TbTFCGChUENGKU7ME+W70hnyqBbfNKh7i2/JHBUlqrQkx/FyiCln
   tFblrGbZNziHGT+S/Zp2bhPh1vzDbnBfPqMz0N5kCIwHd1g6gYlBz7yoB
   IXmB7Fhmvq68dbi3J6VEZXEQS9bD14esN2roJUlijBdmWTkDqACzvYOWf
   IohF0TM9FYBmMTBJbdhBmpylXhPw56WhVn8czvnoVlrUC+RhIA63GNlT8
   EBRG8YzjdM6FT6/xVxl60vOxfQdStApqTic2QB30pTNe7c/gwi/rH7LTX
   w==;
X-CSE-ConnectionGUID: oy9cikOvSs2uAsRQrhNEXw==
X-CSE-MsgGUID: 5kWZbGbKRwyxW9YY6OIf3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25636369"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25636369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:02:53 -0700
X-CSE-ConnectionGUID: XtnfMNwWR2+2gigAO3WCFA==
X-CSE-MsgGUID: WCXFSRYVSSCjJ3fW95mSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20774467"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:02:52 -0700
Date: Wed, 10 Apr 2024 16:02:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/26] dax/region: Prevent range mapping allocation on
 sparse regions
Message-ID: <ZhcamPGpT50GUdz6@aschofie-mobl2>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-21-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-21-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:24PM -0700, Ira Weiny wrote:

Perhaps lead w some words from prior patch to provide context:

"DAX regions mapping dynamic capacity partitions introduce a requirement
for the memory backing the region to come and go as required.  This
results in a DAX region with sparse areas of memory backing."

Or should this fold into: 
dax/region: Create extent resources on DAX region driver load

> Sparse regions are not fully populated with memory and this complicates
> range mapping of dax devices on those regions.  There is no use case for
> range mapping on sparse regions.
> 
> Avoid the complication by prevent range mapping of dax devices on sparse
> regions.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/dax/bus.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index bab19fc578d0..56dddaceeccb 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1452,6 +1452,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  		return 0;
>  	if (a == &dev_attr_mapping.attr && is_static(dax_region))
>  		return 0;
> +	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
> +		return 0;
>  	if ((a == &dev_attr_align.attr ||
>  	     a == &dev_attr_size.attr) && is_static(dax_region))
>  		return 0444;
> 
> -- 
> 2.44.0
> 

