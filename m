Return-Path: <linux-btrfs+bounces-3811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382B8943C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A371F26C2D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD14AEFA;
	Mon,  1 Apr 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjUZvz4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1847A64;
	Mon,  1 Apr 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991271; cv=none; b=c/oYOnLflWNdDRTmgEw7JLgCPIVrTqzpM1YvGsNGSfa6nIOT9G3rcYKW9jH98jN83hdqpZIDOzjf9dE/gazfy47d/qqHkM9rS4HAUxqs5SlcMgidocDe2jR4KS9Hti5tKv0FeZub3wKJIdcfjt3O7/b0Z/H0zkx8kOcU23BeL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991271; c=relaxed/simple;
	bh=fAORdwCJ6cWoA/Nlrq+Jlb00Y+L+FLHUMh9x9qNLohk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPe16mLvPXgLTbmdbm+DFC9lgfFMcVPE+AjPzD5Ru2Ikq/35PA9wWTRAQAVebBR+DTIDuN3dPtD+qJLWi3RgvjvZjAFw6xpw1sih8UGqVv4epTBURX6576aK6/jbZaIVk6ABwqJSaeq0E9Z4zxvAKMSO0GzApUuNKT0DARaZ7LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjUZvz4s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711991270; x=1743527270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fAORdwCJ6cWoA/Nlrq+Jlb00Y+L+FLHUMh9x9qNLohk=;
  b=RjUZvz4sH5PmKKx81UIg4Uq4aICyuwdOodB5s3ZHg6azDKKOMtVv504v
   LvGYPIBcvejnGQ21TzZGRIBt9UyWvVgRKk2EdR95hRwqlYYQj0pP1QqCM
   lVUL2VEMwDBry2E/5cG4wC6uq27zEFElgwS4kMc4MPzvcUARz9qsbPKcf
   k9aJB6/2fmoLdte6YSJVdqbSzIPfYSxUUHCz/GlAqgKNrq7+htVMxTeiH
   TwMQI+NElRO0HXT2CAF0wAPRkkrVS680N9j6bY2miA9u1d8uYfn5BKk13
   1y5zqyAvjZJycMXxUyfx5wJS94NNebi9oExScKDQowr51W4C86x29RBZ6
   Q==;
X-CSE-ConnectionGUID: 68MB2Cm4QFWLB7APJ3EAVQ==
X-CSE-MsgGUID: SgwJM+JhRYy6QEHsYMy7UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7317773"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="7317773"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22257093"
Received: from mthansen-mobl.amr.corp.intel.com (HELO [10.212.113.134]) ([10.212.113.134])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:07:48 -0700
Message-ID: <31b6d5c2-281c-4eee-ba8a-5344eda23041@intel.com>
Date: Mon, 1 Apr 2024 10:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/26] dax/region: Prevent range mapping allocation on
 sparse regions
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
 <20240324-dcd-type2-upstream-v1-21-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-21-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, Ira Weiny wrote:
> Sparse regions are not fully populated with memory and this complicates
> range mapping of dax devices on those regions.  There is no use case for
> range mapping on sparse regions.
> 
> Avoid the complication by prevent range mapping of dax devices on sparse
> regions.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

