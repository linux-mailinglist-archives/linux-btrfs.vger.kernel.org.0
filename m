Return-Path: <linux-btrfs+bounces-3670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D688EC9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E022A39DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F214D44E;
	Wed, 27 Mar 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTBl3vHx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197E12FB3E;
	Wed, 27 Mar 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560466; cv=none; b=b4AvYmV5NUcvsylrZSosdbtxol+ku+VAeQVsgsnjaupt7SL8ZSCBb1W08aGWnvycLEyGG/emnqV90PDVv34R0GaQ2Zijegn3yRzeDXz08byObPlPdODDW4AmSxzXT/lYWrn1ayAZSpH8o100DwLaUn6Q7RnBINr8RugPhElp2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560466; c=relaxed/simple;
	bh=xq4tevDffl124Rs0SAZHCv/vVKGMDoRQlDy6HZvW3zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVBAQquHCYnVtn0iBjUvkwAVEsDWsGhfzH88wIVjnZgAajlQ+NbW/7hSqbGPncIiGky9JJ/jUdmHnPeYq8Qq5oJvCEdU0jCT+FaE4grG4H9HYcuW7uKW0w3xQdgXITjZ9GqdT/lF0i656MSTH3g5CrgUdPjaPvkOhE2YfqODGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTBl3vHx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711560465; x=1743096465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xq4tevDffl124Rs0SAZHCv/vVKGMDoRQlDy6HZvW3zk=;
  b=aTBl3vHxEhYtt+5IgZ8tQDyZq4SZlFZqlphwAYmHjfl2PVWN1fbkIlD0
   HFYH07iJiKqn9nvp6W7Hb5vKQXBs+UYuBwEqfOA4PkAv1PJK5NLQsOrvN
   LCgLN5VolMSzjbnXEJGrT3XWsvm7hBVxdTfi+J1KImNq6YkNGUARLCCu/
   555kn/Sy3IxnA6sePIjxeokbNeBy7ihVo7n5mpG/M4aP0HOZfUBotZH54
   Al7Xv0HhLiXLHhdtRBxGIrISoWjeLNb8WEq1K1Z1BiiR+6SuvE3H3OSAC
   RUC2VSeKxHf2XGjK3fJEwEPgN9/Mv1j5BT2IDp6iTa630/2DYlWSFRusq
   A==;
X-CSE-ConnectionGUID: wpXd1wosRnG4cypRbuUULw==
X-CSE-MsgGUID: S+Tg85n7SqiNIfhGmfJIDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9640692"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="9640692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16287061"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 10:27:43 -0700
Message-ID: <dde02c34-fcf3-4adc-8920-7fd7fe202d54@intel.com>
Date: Wed, 27 Mar 2024 10:27:42 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Content-Language: en-US
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL devices optionally support dynamic capacity.  CXL Regions must be
> configured correctly to access this capacity.  Similar to ram and pmem
> partitions, DC Regions, as they are called in CXL 3.1, represent
> different partitions of the DPA space.
> 
> Introduce the concept of a sparse DAX region.  Add the create_dc_region
> sysfs entry to create sparse DC DAX regions.  Special case DC capable
> regions to create a 0 sized seed DAX device to maintain backwards
> compatibility with older software which needs a default DAX device to
> hold the region reference.
> 
> Flag sparse DAX regions to indicate 0 capacity available until such time
> as DC capacity is added.
> 
> Interleaving is deferred in this series.  Add an early check.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [djiang: mark sysfs entries to be in 6.10 kernel including date]
> [djbw: change dax region typing to be 'sparse' rather than 'dynamic']
> [iweiny: rebase changes to master instead of type2 patches]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 22 +++++++++++-----------
>  drivers/cxl/core/core.h                 |  1 +
>  drivers/cxl/core/port.c                 |  1 +
>  drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++++++++++
>  drivers/dax/bus.c                       |  8 ++++++++
>  drivers/dax/bus.h                       |  1 +
>  drivers/dax/cxl.c                       | 15 +++++++++++++--
>  7 files changed, 68 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 8a4f572c8498..f0cf52fff9fa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -411,20 +411,20 @@ Description:
>  		interleave_granularity).
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> -Date:		May, 2022, January, 2023
> -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
> +Date:		May, 2022, January, 2023, June 2024
> +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.10 (dc)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> -		of defining a new persistent, or volatile memory region
> -		(interleave-set) within the decode range bounded by root decoder
> -		'decoderX.Y'. The value written must match the current value
> -		returned from reading this attribute. An atomic compare exchange
> -		operation is done on write to assign the requested id to a
> -		region and allocate the region-id for the next creation attempt.
> -		EBUSY is returned if the region name written does not match the
> -		current cached value.
> +		of defining a new persistent, volatile, or Dynamic Capacity
> +		(DC) memory region (interleave-set) within the decode range
> +		bounded by root decoder 'decoderX.Y'. The value written must
> +		match the current value returned from reading this attribute.
> +		An atomic compare exchange operation is done on write to assign
> +		the requested id to a region and allocate the region-id for the
> +		next creation attempt.  EBUSY is returned if the region name

-EBUSY?

> +		written does not match the current cached value.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..91abeffbe985 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group;
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> +extern struct device_attribute dev_attr_create_dc_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 036b61cb3007..661177b575f7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -335,6 +335,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_REGION_ATTR(create_dc_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ec3b8c6948e9..0d7b09a49dcf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2205,6 +2205,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_REGION_RAM:
>  	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2314,6 +2315,32 @@ static ssize_t create_ram_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	struct cxl_region *cxlr;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	cxlr = __create_region(cxlrd, CXL_REGION_DC, id);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -2759,6 +2786,11 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	struct device *dev;
>  	int rc;
>  
> +	if (cxlr->mode == CXL_REGION_DC && cxlr->params.interleave_ways != 1) {
> +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
>  	cxlr_dax = cxl_dax_region_alloc(cxlr);
>  	if (IS_ERR(cxlr_dax))
>  		return PTR_ERR(cxlr_dax);
> @@ -3040,6 +3072,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_REGION_RAM:
> +	case CXL_REGION_DC:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index cb148f74ceda..903566aff5eb 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -181,6 +181,11 @@ static bool is_static(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
>  }
>  
> +static bool is_sparse(struct dax_region *dax_region)
> +{
> +	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
> +}
> +
>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> @@ -304,6 +309,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>  
>  	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
> +	if (is_sparse(dax_region))
> +		return 0;
> +
>  	for_each_dax_region_resource(dax_region, res)
>  		size -= resource_size(res);
>  	return size;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..783bfeef42cc 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -13,6 +13,7 @@ struct dax_region;
>  /* dax bus specific ioresource flags */
>  #define IORESOURCE_DAX_STATIC BIT(0)
>  #define IORESOURCE_DAX_KMEM BIT(1)
> +#define IORESOURCE_DAX_SPARSE_CAP BIT(2)
>  
>  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		struct range *range, int target_node, unsigned int align,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index c696837ab23c..415d03fbf9b6 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
> +	resource_size_t dev_size;
> +	unsigned long flags;
>  
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> +	flags = IORESOURCE_DAX_KMEM;
> +	if (cxlr->mode == CXL_REGION_DC)
> +		flags |= IORESOURCE_DAX_SPARSE_CAP;
> +
>  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> +				      PMD_SIZE, flags);
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	dev_size = range_len(&cxlr_dax->hpa_range);
> +	/* Add empty seed dax device */
> +	if (cxlr->mode == CXL_REGION_DC)
> +		dev_size = 0;

Nit. Just do if/else so dev_size isn't set twice if mode is DC.

> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
> -		.size = range_len(&cxlr_dax->hpa_range),
> +		.size = dev_size,
>  		.memmap_on_memory = true,
>  	};
>  
> 

