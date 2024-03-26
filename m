Return-Path: <linux-btrfs+bounces-3641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DEE88D102
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F981F2358E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004F13DDB8;
	Tue, 26 Mar 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXmCsoNv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176882D92;
	Tue, 26 Mar 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492323; cv=none; b=S4SImKiT/HhrBW7HE5CjJuNNwoHR29kgFrG5Veeh/UQiICCDYM/G8weiTxo3sM68AHb3ZxxoCzUJ3+NZjLXe1X2VeH6btOGaEQ1Yow3pgJ3lE1hZVc53AW6wj7/EiIe2aGnwkKrmjVRM2seLMO8k0cu65+blvBmAMxs4peBIR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492323; c=relaxed/simple;
	bh=jtsHLz1SCd7Ws82LpDVW1C4HDAeKj584/x/idhMkP8k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4eWjdOpONFMyqvAudYq2sBnRvpvr9pFIbNM9Snk/2INTG6qhwH49JQCvx81wtXL65+NJzG0iqAupaNQLsEUbiiROoVYjmtJRogUF5shDVuCxKFpgj91A86x0APpemoxj9CsS/MN9l9mhQIcgPfw9eSQeijwJx6hqUW6UanLTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXmCsoNv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so5177036b3a.1;
        Tue, 26 Mar 2024 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492320; x=1712097120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp7K9sSN8QNmCEoz5wv20o/pVKHqDwaf+8vL2htONYI=;
        b=KXmCsoNvAZizvE4BUh4zN5dNg0Lo9YKkuu0jwgiXJ0nGwNVDypSH9iE7LHZYnFw3Ix
         QotMUsG9xFhQRGgiyrjqgtts+9UMhrYmrlFmKGV7oZlfvMuw05bEHy4+BMFxP0JGCoM2
         F5bJWvU+NtsbtftV4mCZjrht4Shtj3aWGxL+FOVk4/DPPxFEpgoCC+RkBbvA0efzULJo
         BuAccpbuo+z8DFR2FLkmWo/yDmlRoGADn8kD9mBUl/GOWKj3xo3GsEFQbSR2kswRGFad
         1p2LK8YLOdxJRMBQdro1MW57zXiKAx//Fix0UW9Ya1nlNuhMFDgyWuvmrYNJy4J1G7uy
         okZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492320; x=1712097120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp7K9sSN8QNmCEoz5wv20o/pVKHqDwaf+8vL2htONYI=;
        b=JNJzL/CE8YxXIjMEUTt8FY3FU7g5f8DZXThlehIHxt7eb9L/AACPpBdQUCq/Y/Jz52
         /PQVoXGpu87n/CgEQ47SYbeeiwtA0ihcECU7tJlHAIOLEZ2J0wpxP6adwECgMrnO5hM5
         55trIyNOqxeECInQ77t+ngtBydIgPvjI64wMqydqqMczSeIKuwljaFfTjYAK605HKoff
         KGOVWuLK7rWwYs0pVN2mEfveB06g4n14T5U3wAhHGXzN4zPM9CuK2cr+Ilg+X5mlIiLR
         t+oN76WemkiwLuMRa09qJHvl+gQnePaJERz33VEpwnuS4WZDa/EFO+0UNx9a/n8cP66h
         cK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxhjzP2vZcxsybLFC8YnvwpoPKLPMPx5Luiywyh9zA2FoLUgWcmIl4aWxYS77fYDW9iK5e5jaEqkk7pj2lzrliNHZ9Wa4jU23Oohse9nkXn6Y1B1vD4AjtX900tOykFVlPDrG+Y1GB4fRuMG21vfC1IF1bXRSw1P7kezZMOmM3VtZetpw=
X-Gm-Message-State: AOJu0YxSRpqAs4RvhG9H0bwB6lRg0VywQm5nop9OKpoDHPT0FnX2SQx5
	xfNiF3GdqaJWEQ1GQf+HzIhXgc78tuAt6kPidW0Dxci8yb4qfq9j
X-Google-Smtp-Source: AGHT+IHo+MHxu4swdAKlWOVtLklFHI7ntmmEqC1ckEqkTqOi/mTD97R0ZvRX2bThaAWH3+TPBsReEQ==
X-Received: by 2002:a05:6a20:7d85:b0:1a3:a0cc:de91 with SMTP id v5-20020a056a207d8500b001a3a0ccde91mr1189702pzj.57.1711492319722;
        Tue, 26 Mar 2024 15:31:59 -0700 (PDT)
Received: from debian ([2601:641:300:14de:dab1:15ff:5381:7f21])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b006e535bf8da4sm6462655pfp.57.2024.03.26.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:31:59 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 26 Mar 2024 15:31:43 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/26] cxl/region: Add Dynamic Capacity CXL region support
Message-ID: <ZgNMz9doYO0KlgKU@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-9-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:12PM -0700, ira.weiny@intel.com wrote:
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

create_ram_region_store, create_pmem_region_store and
create_dc_region_store have mostly duplicate code, should we consider
extracting out as a helper function and pass region type for ram/pmem/dc region
store?

Fan 

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
> -- 
> 2.44.0
> 

