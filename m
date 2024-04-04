Return-Path: <linux-btrfs+bounces-3924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52202898C40
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 18:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E75B282658
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE241C6BC;
	Thu,  4 Apr 2024 16:36:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFA1BC30;
	Thu,  4 Apr 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248596; cv=none; b=oXDVTTVx7YFVYya/zuV8LV1O0XFOI/fiAh4xC+rv95Xl8u2AMdZ/J1C7ETkNik2F05FS0HVWx4jvveQztm0dVXiXYeDlPvBlyXvGLWynLZarqTFZserrbARemkVN40SwZJCGTgZhVu2npNCGLkuQ3/lloOa1M5j9YHXx0ilYep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248596; c=relaxed/simple;
	bh=sBhr4OoTOXBwd5STx8zu2+HtM4Vou3RBmckRRs1jT3c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE3DrYlTEEsb9pZf66F0DRXi0830C8YwFKD0GpwoRM5XYq/k7dV/s5ZVdCXiQ3yZ6BU08Ht0ScjbZYbswKPDL5ReHHFOSndcDQ7FNVqzamHxLviCqjVl3WczYmGdaa323Xz2tbQC9M0sK1Kjaip+DXgm3a2blWTEyxXw0tEc53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9Rzw05hZz6K5XD;
	Fri,  5 Apr 2024 00:35:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 070CA141546;
	Fri,  5 Apr 2024 00:36:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 17:36:27 +0100
Date: Thu, 4 Apr 2024 17:36:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/26] dax/region: Create extent resources on DAX region
 driver load
Message-ID: <20240404173625.00005b32@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:20 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> DAX regions mapping dynamic capacity partitions introduce a requirement
> for the memory backing the region to come and go as required.  This
> results in a DAX region with sparse areas of memory backing.  To track
> the sparseness of the region, DAX extent objects need to track
> sub-resource information as a new layer between the DAX region resource
> and DAX device range resources.
> 
> Recall that DCD extents may be accepted when a region is first created.
> Extend this support on region driver load.  Scan existing extents and
> create DAX extent resources as a first step to DAX extent realization.
> 
> The lifetime of a DAX extent is tricky to manage because the extent life
> may end in one of two ways.  First, the device may request the extent be
> released.  Second, the region may release the extent when it is
> destroyed without hardware involvement.  Support extent release without
> hardware involvement first.  Subsequent patches will provide for
> hardware to request extent removal.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
LGTM though I'm far from an expert on DAX..

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for v1
> [iweiny: remove xarrays]
> [iweiny: remove as much of extra reference stuff as possible]
> [iweiny: Move extent resource handling to core DAX code]
> ---
>  drivers/dax/bus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/cxl.c         | 43 ++++++++++++++++++++++++++++++++++--
>  drivers/dax/dax-private.h | 12 +++++++++++
>  3 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 903566aff5eb..4d5ed7ab6537 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -186,6 +186,61 @@ static bool is_sparse(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
>  }
>  
> +static int dax_region_add_resource(struct dax_region *dax_region,
> +				   struct dax_extent *dax_ext,
> +				   resource_size_t start,
> +				   resource_size_t length)
> +{
> +	struct resource *ext_res;
> +
> +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> +	ext_res = __request_region(&dax_region->res, start, length, "extent", 0);
> +	if (!ext_res) {
> +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> +			&start, &length);
> +		return -ENOSPC;
> +	}
> +
> +	dax_ext->region = dax_region;
> +	dax_ext->res = ext_res;
> +	dev_dbg(dax_region->dev, "Extent add resource %pr\n", ext_res);
> +
> +	return 0;
> +}


