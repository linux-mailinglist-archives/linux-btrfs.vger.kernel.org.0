Return-Path: <linux-btrfs+bounces-3907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82589837C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6F51F23814
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D773509;
	Thu,  4 Apr 2024 08:51:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040A4597A;
	Thu,  4 Apr 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220707; cv=none; b=GuMCkfUuErE0TA/f8cmGRpVWXKPwlzjuwYJPcI88Sd/s9Dbt6DuL/1tcxhMkrHKfWIQe4eQ6c/L5JA34SM9u2b+EEnkYw4ommEqgKLLOl/i5dJOPq05WY/eSNMIjKtrdUFLWU8jvTV3t0YISqr/udy0Nvydrbj1+4AG5uXI3G68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220707; c=relaxed/simple;
	bh=XfmsCBkDJ/6d+QejA2BzcnkkJvQKAbigpPnYoVfbLio=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X74TW1EMxgEjgzOOBab6D50YYLrE+TsjtvVNoUwFddBRLUvJ6wTm8JETU2XoGPYiP8sMq8EFi1wx2908ZQ4B/9Fg5IvYUfsLvAfRpK95LRQw4XmpkIxwe5Zfatzx2f20eh8S7fwt7VcTiht7xjvHQYGxFhsZUz4XjOHQgXPYCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9FgY6sP7z67hPh;
	Thu,  4 Apr 2024 16:50:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A4843140B35;
	Thu,  4 Apr 2024 16:51:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 09:51:39 +0100
Date: Thu, 4 Apr 2024 09:51:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/26] cxl/mem: Expose device dynamic capacity
 capabilities
Message-ID: <20240404095138.00004c7d@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:11 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> user space will need to know the details of the DC Regions available on
> a device.
> 
> Expose driver dynamic capacity capabilities through sysfs
> attributes.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Trivial comments inline.
Whilst I'd like the directory hidden as per the other suggestions,
I don't mind that much.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> ---
> Changes for v1:
> [iweiny: remove review tags]
> [iweiny: mark sysfs for 6.10 kernel]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
>  drivers/cxl/core/memdev.c               | 76 +++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8b3efaf6563c..8a4f572c8498 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -54,6 +54,23 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/dc/region_count
> +Date:		June, 2024
> +KernelVersion:	v6.10
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> +		device.  May be 0 if the device does not support Dynamic
> +		Capacity.

That will change if you go ahead and hide the directory as per suggestions.

> +
> +What:		/sys/bus/cxl/devices/memX/dc/regionY_size
> +Date:		June, 2024
> +KernelVersion:	v6.10
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Size of the Dynamic Capacity (DC) region Y.  Only

Units always good to have in docs even if somewhat obvious.

> +		available on devices which support DC and only for those
> +		region indexes supported by the device.
>  
>  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
>  Date:		May, 2023
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d4e259f3a7e9..a7b880e33a7e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -101,6 +101,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,

...

> +static struct attribute *cxl_memdev_dc_attributes[] = {
> +	&dev_attr_region0_size.attr,
> +	&dev_attr_region1_size.attr,
> +	&dev_attr_region2_size.attr,
> +	&dev_attr_region3_size.attr,
> +	&dev_attr_region4_size.attr,
> +	&dev_attr_region5_size.attr,
> +	&dev_attr_region6_size.attr,
> +	&dev_attr_region7_size.attr,
> +	&dev_attr_region_count.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	/* Not a memory device */
> +	if (!mds)
> +		return 0;
> +
> +	if (a == &dev_attr_region_count.attr)
> +		return a->mode;
> +
> +	/* Show only the regions supported */
> +	if (n < mds->nr_dc_region)
> +		return a->mode;

This feels a bit fragile if anyone adds new attrs in future and for whatever reason
does it before these.

Maybe add a comment at top of cxl_memdev_dc_attributes()?  Say they must be first.

> +
> +	return 0;
> +}
> +

> 


