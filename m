Return-Path: <linux-btrfs+bounces-7448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1595D30A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1CFB25740
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD918E02B;
	Fri, 23 Aug 2024 16:18:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB518BBAC;
	Fri, 23 Aug 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429881; cv=none; b=UzlKR2V3s8tb+ie4CNcfRBs8S154vzdudUhqEtLzhfM4WxbU1xBs16AWSiVMVBTIsT6iR8yHpb9v4FExzgJfayFszTo6ARs8lx/hSoTXP+9lvMUpfFFyPxTV1KLNoHAbDSQH77JZhpYD0IGRrd8be51qysE0svti2kczkH42axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429881; c=relaxed/simple;
	bh=czqBYsrZ9fnUopyb9/ZeopdlLvO4lAvI2lPQMbjb4XQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCpCnE1ftrgbFMwD9Mzwisnvq2g0Mryc4TYoNYyl6rF6sFWDpOo5flXJ3V3KaBWYjdKYj1VDC2NX62LXouj3BSP0A/zdIC9fpfKEiFmIizJ3fcIfVzbMDsnqvhFURogvMIFG0mwgl37EnBpKiaJp4N21dqX9z8943YBYvys8J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr4sS4Cpjz6K61C;
	Sat, 24 Aug 2024 00:14:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8357E140C98;
	Sat, 24 Aug 2024 00:17:57 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 17:17:56 +0100
Date: Fri, 23 Aug 2024 17:17:55 +0100
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
Subject: Re: [PATCH v3 12/25] cxl/region: Refactor common create region code
Message-ID: <20240823171755.00002ce6@Huawei.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
	<20240816-dcd-type2-upstream-v3-12-7c9b96cba6d7@intel.com>
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

On Fri, 16 Aug 2024 09:44:20 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> create_pmem_region_store() and create_ram_region_store() are identical
> with the exception of the region mode.  With the addition of DC region
> mode this would end up being 3 copies of the same code.
> 
> Refactor create_pmem_region_store() and create_ram_region_store() to use
> a single common function to be used in subsequent DC code.
> 
> Suggested-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Make sense

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/core/region.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 650fe33f2ed4..f85b26b39b2f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2553,9 +2553,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>  }
>  
> -static ssize_t create_pmem_region_store(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t len)
> +static ssize_t create_region_store(struct device *dev, const char *buf,
> +				   size_t len, enum cxl_region_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  	struct cxl_region *cxlr;
> @@ -2565,31 +2564,26 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_REGION_PMEM, id);
> +	cxlr = __create_region(cxlrd, mode, id);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
>  	return len;
>  }
> +
> +static ssize_t create_pmem_region_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	return create_region_store(dev, buf, len, CXL_REGION_PMEM);
> +}
>  DEVICE_ATTR_RW(create_pmem_region);
>  
>  static ssize_t create_ram_region_store(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> -	struct cxl_region *cxlr;
> -	int rc, id;
> -
> -	rc = sscanf(buf, "region%d\n", &id);
> -	if (rc != 1)
> -		return -EINVAL;
> -
> -	cxlr = __create_region(cxlrd, CXL_REGION_RAM, id);
> -	if (IS_ERR(cxlr))
> -		return PTR_ERR(cxlr);
> -
> -	return len;
> +	return create_region_store(dev, buf, len, CXL_REGION_RAM);
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> 


