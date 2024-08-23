Return-Path: <linux-btrfs+bounces-7445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9495D27F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAE41F235F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74518A6C7;
	Fri, 23 Aug 2024 16:09:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408218593A;
	Fri, 23 Aug 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429372; cv=none; b=FRgaOc8l+KtQtbF0stmH3zW3tLNWPKc+4bT63aLhhlNPBg29jxGs2FMufppUo2slUkRtPCpWFj4y1ykj2Kc3q61vH8+0G3b9mEABS2Wl07a7wD6+RhKzyZzJV+khZkAoOvExoWxdfn+AoouOwTeePcqiH0zMywFJSDq+i9e8fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429372; c=relaxed/simple;
	bh=CbAQlyU8fku3VCWy5333UtRcY2DrWTawVuVsOfKJuII=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6uAuGQ6GoZnluLCpCoXV6Jv9afcnlaX30rn+iqqKvgWinS7nsdh2XIA9x2lLq3eAEuL3bJX2u7kvgM5jMiK8+EgpYe+TUOuUuUa0Rgc3ZhBMB/Gr/pn1rvccAv07jLSI/xIzAcjbvmUJheKJ3FukjIVgVx5fz4ZmEtCB1Ip6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr4gX4g02z6K97G;
	Sat, 24 Aug 2024 00:06:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B415B140C72;
	Sat, 24 Aug 2024 00:09:25 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 17:09:25 +0100
Date: Fri, 23 Aug 2024 17:09:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
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
Subject: Re: [PATCH v3 09/25] cxl/hdm: Add dynamic capacity size support to
 endpoint decoders
Message-ID: <20240823170924.00002456@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-9-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-9-7c9b96cba6d7@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:44:17 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To support Dynamic Capacity Devices (DCD) endpoint decoders will need to
> map DC partitions (regions).  In addition to assigning the size of the
> DC partition, the decoder must assign any skip value from the previous
> decoder.  This must be done within a contiguous DPA space.
> 
> Two complications arise with Dynamic Capacity regions which did not
> exist with Ram and PMEM partitions.  First, gaps in the DPA space can
> exist between and around the DC partitions.  Second, the Linux resource
> tree does not allow a resource to be marked across existing nodes within
> a tree.
> 
> For clarity, below is an example of an 60GB device with 10GB of RAM,
> 10GB of PMEM and 10GB for each of 2 DC partitions.  The desired CXL
> mapping is 5GB of RAM, 5GB of PMEM, and 5GB of DC1.
> 
>      DPA RANGE
>      (dpa_res)
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
> 
> RAM         PMEM                  DC0                   DC1
>  (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])
> |----------|----------|   <gap>  |----------|   <gap>  |----------|
> 
>  RAM        PMEM                                        DC1
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
> 0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB
> 
> The previous skip resource between RAM and PMEM was always a child of
> the RAM resource and fit nicely [see (S) below].  Because of this
> simplicity this skip resource reference was not stored in any CXL state.
> On release the skip range could be calculated based on the endpoint
> decoders stored values.
> 
> Now when DC1 is being mapped 4 skip resources must be created as
> children.  One for the PMEM resource (A), two of the parent DPA resource
> (B,D), and one more child of the DC0 resource (C).
> 
> 0GB        10GB       20GB       30GB       40GB       50GB       60GB
> |----------|----------|----------|----------|----------|----------|
>                            |                     |
> |----------|----------|    |     |----------|    |     |----------|
>         |          |       |          |          |
>        (S)        (A)     (B)        (C)        (D)
> 	v          v       v          v          v
> |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|
>        skip       skip  skip        skip      skip
> 
> Expand the calculation of DPA free space and enhance the logic to
> support this more complex skipping.  To track the potential of multiple
> skip resources an xarray is attached to the endpoint decoder.  The
> existing algorithm between RAM and PMEM is consolidated within the new
> one to streamline the code even though the result is the storage of a
> single skip resource in the xarray.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
One query below + request to add a comment on it for when I've
again completely forgotten how this works.

Also a grumpy reviewer comment.

> +static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
> +				resource_size_t base, resource_size_t skipped)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	resource_size_t skip_base = base - skipped;
> +	struct device *dev = &port->dev;
> +	resource_size_t skip_len = 0;
> +	int rc, index;
> +

> +	index = dc_mode_to_region_index(cxled->mode);
> +	for (int i = 0; i <= index; i++) {

I'm not sure why this is <= so maybe a comment?

> +		struct resource *dcr = &cxlds->dc_res[i];
> +
> +		if (skip_base < dcr->start) {
> +			skip_len = dcr->start - skip_base;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +
> +		if (skip_base == base) {
> +			dev_dbg(dev, "skip done DC region %d!\n", i);
> +			break;
> +		}
> +
> +		if (resource_size(dcr) && skip_base <= dcr->end) {
> +			if (skip_base > base) {
> +				dev_err(dev, "Skip error DC region %d; skip_base %pa; base %pa\n",
> +					i, &skip_base, &base);
> +				return -ENXIO;
> +			}
> +
> +			skip_len = dcr->end - skip_base + 1;
> +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> +			if (rc)
> +				return rc;
> +			skip_base += skip_len;
> +		}
> +	}
> +
> +	return 0;
> +}

> @@ -466,8 +588,8 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	resource_size_t free_ram_start, free_pmem_start;
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);

Patch noise.  Put it back where it was! (assuming I haven't failed to spot the difference)

>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;

