Return-Path: <linux-btrfs+bounces-7560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7C960C03
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 15:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692CB288285
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5777C1C0DCE;
	Tue, 27 Aug 2024 13:26:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DB1BDA8B;
	Tue, 27 Aug 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765180; cv=none; b=spwHJVygn/GKuRMSLYvvnZlMzMWLsjCTVnpjHzxxCV0qiJ8uLIqx/LlhKb9sk/XlxM5hpehMmIwcpmaWHPTfG/vVQmpzBBsdHztC6rQH8ilkuSdZ9mNNfBt2c5LGuNbN+JoYtHRCnkNmfW85u355U5Cp+R+kXMQ751MYeXVv3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765180; c=relaxed/simple;
	bh=m2CmJ77UcG+8tkfrra5kg4E79NABuUeCBphF2gCmP10=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pw7YNo+T6aOQlSHDP72hKrRZZ+iR5SWEUAIaQS1ydV+5pAr3FzVtXLceI2YiH79rbGPXFKRayKRY6hYKI2POSx35LsUZdrUDXZ8fLdJ6sJJOyEBhzRNYU55EaQqzPZasjaP5LpPLB5WFoL41efxjXCPg2zY2E11WaxynkTlDyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtSrT0Kfvz6J7F9;
	Tue, 27 Aug 2024 21:22:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DCDA140A87;
	Tue, 27 Aug 2024 21:26:15 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 14:26:14 +0100
Date: Tue, 27 Aug 2024 14:26:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 20/25] dax/bus: Factor out dev dax resize logic
Message-ID: <20240827142613.00005c91@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-20-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-20-7c9b96cba6d7@intel.com>
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

On Fri, 16 Aug 2024 09:44:28 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Dynamic Capacity regions must limit dev dax resources to those areas
> which have extents backing real memory.  Such DAX regions are dubbed
> 'sparse' regions.  In order to manage where memory is available four
> alternatives were considered:
> 
> 1) Create a single region resource child on region creation which
>    reserves the entire region.  Then as extents are added punch holes in
>    this reservation.  This requires new resource manipulation to punch
>    the holes and still requires an additional iteration over the extent
>    areas which may already have existing dev dax resources used.
> 
> 2) Maintain an ordered xarray of extents which can be queried while
>    processing the resize logic.  The issue is that existing region->res
>    children may artificially limit the allocation size sent to
>    alloc_dev_dax_range().  IE the resource children can't be directly
>    used in the resize logic to find where space in the region is.  This
>    also poses a problem of managing the available size in 2 places.
> 
> 3) Maintain a separate resource tree with extents.  This option is the
>    same as 2) but with the different data structure.  Most ideally there
>    should be a unified representation of the resource tree not two places
>    to look for space.
> 
> 4) Create region resource children for each extent.  Manage the dax dev
>    resize logic in the same way as before but use a region child
>    (extent) resource as the parents to find space within each extent.
> 
> Option 4 can leverage the existing resize algorithm to find space within
> the extents.  It manages the available space in a singular resource tree
> which is less complicated for finding space.
> 
> In preparation for this change, factor out the dev_dax_resize logic.
> For static regions use dax_region->res as the parent to find space for
> the dax ranges.  Future patches will use the same algorithm with
> individual extent resources as the parent.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
I'm not 100% confident on this one, so will probably take another look
before giving a tag.
One trivial comment below.



> +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> +		struct dev_dax *dev_dax, resource_size_t size)
> +{
> +	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
> +	struct device *dev = &dev_dax->dev;
> +	resource_size_t alloc = 0;

No path in which this is not set before use.

> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	if (size == dev_size)
> +		return 0;
> +	if (size > dev_size && size - dev_size > avail)
> +		return -ENOSPC;
> +	if (size < dev_size)
> +		return dev_dax_shrink(dev_dax, size);
> +
> +	to_alloc = size - dev_size;
> +	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> +			"resize of %pa misaligned\n", &to_alloc))
> +		return -ENXIO;
> +
> +retry:
> +	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
> +	if (alloc <= 0)
> +		return alloc;
>  	to_alloc -= alloc;
>  	if (to_alloc)
>  		goto retry;



