Return-Path: <linux-btrfs+bounces-7413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CF95BE79
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 20:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5676628570B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D401D04B5;
	Thu, 22 Aug 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrqLxTe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161C13A3E6;
	Thu, 22 Aug 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352651; cv=none; b=s6FqLWerSQpe5HtLtZz3I1gpWkbkxS99tuCHOfO9jz1FCpPXhrBmp/x22IkyYuAOAACxuipHnE7MHB+lTyQYc4vsetsSbulsB5XzE8tnHV+u9pSSwFUqdRmfPSx6F8Ispw1pXwPI8EkKYJVkzy3lVu1ZyAVj5KZ352T3SzFGu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352651; c=relaxed/simple;
	bh=6Cm0bTloBm4V74x8cd769lfZ7ZMvXDhKYlxWwlXYBJ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev78Z83//M6xzMqY/6H+hPq/JHEIyrWEFj0JGrn2UqX1GVjNXibaF1qA7Z2WXZ2BYiGC/9jgsj5vpd3EJetQXmOctmEzROUrYReYxdfVh2kTL7L5NTYuGavgcvHFa7YBJrs38YLUHkzYk9MllZobEcIhFvNgH86Iy1MeTl6ULDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGrqLxTe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71439adca73so810891b3a.0;
        Thu, 22 Aug 2024 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724352648; x=1724957448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/giHwW8p/shdeeJgEhyqh9JwUPhW+QzITYF/aA9L2FI=;
        b=XGrqLxTeoTp+nNkeCTBCZ8J4mc1wAzsw8YIcWVzXXUCJDO2k8lA62ZbtAqxFQU2noe
         rS9oSXvGBJH4MrYPC/JWoDaHtGTUoeirczykKbjkrfcBDg30dHTagWAil0LIrPCwjSJT
         lOVgLIJgaFewpgcvLSJB69VYXCinyYfseSf/Qn63fZX/AFAOCTrrc7XHbsy2zMDI4qu+
         k2SAEf9+vhSf7l0o6S6nj5cAHEloKjvV5V8mX5b5LUT2oBA4YFEMznCRmXOES4ZawUos
         fKeLHFLWl58TCwhfBfr7fjVNgFvdFYwrTpa2YtjOKr/kapJn2fqsWy1pSgNQRObmItPM
         yEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724352648; x=1724957448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/giHwW8p/shdeeJgEhyqh9JwUPhW+QzITYF/aA9L2FI=;
        b=IKgVFVaHgFpIf9oHyvllU2zia5w7tHnMx2LJE6l8PuiWGHbsQ4EkLGuppJcivnyT0L
         VCpA8wov0NCeVpeRM+8+IQ29hPhm61MzgUZH+bPdAEi2pDQqYJaM/kXqxszq2JXqwO7W
         X0ClLO+luTetguHAu0/Lb0kJ8XBZzn867EP4uH/+DapsrW4JbPrO+A3zdtPEvd4wkBYi
         GCEPwhPqs3dwGEa/iaV6EYCsKxZj5BcBqwlIVkX+OVoNQdKSu5hiE3A9b+GmR0vowj4J
         HvK5+pfCpQS2GBZlZdbi/fTK8CDl1Br85wzEjbPd98gOHmFJamLQVJ2RJTVwJkBPdA5j
         y6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbuq8W6Jgk38r8Zrmblu7erxYjzEDFIPlaTy28aQc4fvoMPLFbB6bERCG9a3Dxkrh0o8ER6VzGuYOt@vger.kernel.org, AJvYcCWvK98AussgEqQkpDcreN2Cx9lH5BUB+vizsbKXZtLZFpuGccnBjal99YMwkm0ETJ59YZL6XLxe4W4Brg==@vger.kernel.org, AJvYcCX+N42xqgwU9SrQvxAUvm1lAbm2sgAeD1JLcUpITYhtPhraCmLHIRF45aAsqseRFqMsxs3d6YX4AHcYZSRD@vger.kernel.org, AJvYcCXiqVmec1kX5RAdfzh1+fJE5kIE8X9qk9/89yVyWQz4UW4Brs2o2lVxq2HSwJtROkIqhfASBUSfVUXg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/K0HYs3ciXXtvvccSiZdhOltGZXq0R3+Vul1KSuv8+7pQ5BYg
	4Nov6jiqPizP6TCay+9mXK10qoev8UQdJS8GiJYYZPmNdqP+MzA6ZuOyjA==
X-Google-Smtp-Source: AGHT+IGXbAgwOb//fb3sbe4twRBz+rgQ7/83yrF0Sp+dy7qo5f+zo0FMA7uKjgN8XJQZMA1MZ2oyaQ==
X-Received: by 2002:a05:6a20:9d91:b0:1c4:f209:f1ea with SMTP id adf61e73a8af0-1cad80f657emr8066482637.31.1724352648099;
        Thu, 22 Aug 2024 11:50:48 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:3cd4:f45f:79d:1096])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434230d1dsm1708507b3a.37.2024.08.22.11.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:50:47 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 22 Aug 2024 11:50:31 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 13/25] cxl/region: Add sparse DAX region support
Message-ID: <ZseId5TkH5F76xM0@fan>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-13-7c9b96cba6d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-dcd-type2-upstream-v3-13-7c9b96cba6d7@intel.com>

On Fri, Aug 16, 2024 at 09:44:21AM -0500, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic Capacity CXL regions must allow memory to be added or removed
> dynamically.  In addition to the quantity of memory available the
> location of the memory within a DC partition is dynamic based on the
> extents offered by a device.  CXL DAX regions must accommodate the
> sparseness of this memory in the management of DAX regions and devices.
> 
> Introduce the concept of a sparse DAX region.  Add a create_dc_region()
> sysfs entry to create such regions.  Special case DC capable regions to
> create a 0 sized seed DAX device to maintain compatibility which
> requires a default DAX device to hold a region reference.
> 
> Indicate 0 byte available capacity until such time that capacity is
> added.
> 
> Sparse regions complicate the range mapping of dax devices.  There is no
> known use case for range mapping on sparse regions.  Avoid the
> complication by preventing range mapping of dax devices on sparse
> regions.
> 
> Interleaving is deferred for now.  Add checks.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [Fan: use single function for dc region store]
> [djiang: avoid setting dev_size twice]
> [djbw: Check DCD support and interleave restriction on region creation]
> [iweiny: squash patch : dax/region: Prevent range mapping allocation on sparse regions]
> [iwieny: remove reviews]
> [iweiny: rebase to master]
> [iweiny: push sysfs version to 6.12]
> [iweiny: make cxled_to_mds inline]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++--------
>  drivers/cxl/core/core.h                 | 12 +++++++++
>  drivers/cxl/core/port.c                 |  1 +
>  drivers/cxl/core/region.c               | 46 +++++++++++++++++++++++++++++++--
>  drivers/dax/bus.c                       | 10 +++++++
>  drivers/dax/bus.h                       |  1 +
>  drivers/dax/cxl.c                       | 16 ++++++++++--
>  7 files changed, 93 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 6227ae0ab3fc..3a5ee88e551b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -406,20 +406,20 @@ Description:
>  		interleave_granularity).
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> -Date:		May, 2022, January, 2023
> -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
> +Date:		May, 2022, January, 2023, August 2024
> +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.12 (dc)
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
> index 72a506c9dbd0..15b6cf1c19ef 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -4,15 +4,27 @@
>  #ifndef __CXL_CORE_H__
>  #define __CXL_CORE_H__
>  
> +#include <cxlmem.h>
> +
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +static inline struct cxl_memdev_state *
> +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> +extern struct device_attribute dev_attr_create_dc_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 222aa0aeeef7..44e1e203173d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -320,6 +320,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_REGION_ATTR(create_dc_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f85b26b39b2f..35c4a1f4f9bd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -496,6 +496,11 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> +	if (cxlr->mode == CXL_REGION_DC && val != 1) {
> +		dev_err(dev, "Interleaving and DCD not supported\n");

Is there a typo here?
Maybe "Interleaving a DCD not supported"?

> +		return -EINVAL;
> +	}
> +
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -2174,6 +2179,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  	if (sysfs_streq(buf, "\n"))
>  		rc = detach_target(cxlr, pos);
>  	else {
> +		struct cxl_endpoint_decoder *cxled;
>  		struct device *dev;
>  
>  		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> @@ -2185,8 +2191,13 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  			goto out;
>  		}
>  
> -		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> -				   TASK_INTERRUPTIBLE);
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		if (cxlr->mode == CXL_REGION_DC &&
> +		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
> +			dev_dbg(dev, "DCD unsupported\n");
> +			return -EINVAL;
> +		}
> +		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
>  out:
>  		put_device(dev);
>  	}
> @@ -2534,6 +2545,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_REGION_RAM:
>  	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2587,6 +2599,20 @@ static ssize_t create_ram_region_store(struct device *dev,
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
> +	return create_region_store(dev, buf, len, CXL_REGION_DC);
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -3168,6 +3194,11 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
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
> @@ -3260,6 +3291,16 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EINVAL);
>  
>  	mode = cxl_decoder_to_region_mode(cxled->mode);
> +	if (mode == CXL_REGION_DC) {
> +		if (!cxl_dcd_supported(cxled_to_mds(cxled))) {
> +			dev_err(&cxled->cxld.dev, "DCD unsupported\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		if (cxled->cxld.interleave_ways != 1) {
> +			dev_err(&cxled->cxld.dev, "Interleaving and DCD not supported\n");
If it goes here, it means DCD is upported, but interleaving is not, so
the message here may also need change.

Fan
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
>  	do {
>  		cxlr = __create_region(cxlrd, mode,
>  				       atomic_read(&cxlrd->region_id));
> @@ -3467,6 +3508,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_REGION_RAM:
> +	case CXL_REGION_DC:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..d8cb5195a227 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -178,6 +178,11 @@ static bool is_static(struct dax_region *dax_region)
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
> @@ -301,6 +306,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>  
>  	lockdep_assert_held(&dax_region_rwsem);
>  
> +	if (is_sparse(dax_region))
> +		return 0;
> +
>  	for_each_dax_region_resource(dax_region, res)
>  		size -= resource_size(res);
>  	return size;
> @@ -1373,6 +1381,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  		return 0;
>  	if (a == &dev_attr_mapping.attr && is_static(dax_region))
>  		return 0;
> +	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
> +		return 0;
>  	if ((a == &dev_attr_align.attr ||
>  	     a == &dev_attr_size.attr) && is_static(dax_region))
>  		return 0444;
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
> index 9b29e732b39a..367e86b1c22a 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,31 @@ static int cxl_dax_region_probe(struct device *dev)
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
> +	if (cxlr->mode == CXL_REGION_DC)
> +		/* Add empty seed dax device */
> +		dev_size = 0;
> +	else
> +		dev_size = range_len(&cxlr_dax->hpa_range);
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
> 2.45.2
> 

