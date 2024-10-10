Return-Path: <linux-btrfs+bounces-8819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBA4998E7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 19:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEF71C239E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667DD19D082;
	Thu, 10 Oct 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffrdUvGH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6F19ABCE;
	Thu, 10 Oct 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582084; cv=none; b=nBGMR5brvMwkgAWyOKkKbTLcLkqIMW+GHr3Mp7K5OznFe8SMaWI/D0Xlb/SnXInb8FmF6epqGGp3A7VkvRj23vX7oXJGDB2upgQNdIMlcRNdnQQ9cTnVkDsCqycfcZoJfdBGN3T5GvFjiA6cPD+Mq1nRGbQlMsyBeH2vyCK2Fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582084; c=relaxed/simple;
	bh=aIm8Ss8JajMFDpAwaUzFXIbnue6ZaISA0kkITYeBLXE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcG8EjsByMyOhqLzk3BHNOM9bPMkUc/Y73XvWOhDBehYm1uOyibAzYghtc6UyhnGp4oMqbQelDCi99NhcJNU77+BKSMSnCBFSbf5QG+0/2Z7FTsZVC6GzII/v6DSRBcwdajvjxA5R1rkZBHHAOuXR+NxJGUVE00NjIaBA7ifEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffrdUvGH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df04d3cd1so1070655b3a.2;
        Thu, 10 Oct 2024 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582082; x=1729186882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1rQOwMKiHT/cHy9N2CsneDTHV0YTsagRNHYedEBcjg=;
        b=ffrdUvGHIzh01JwZkktoUTjsC7Z6XXucW90zTup4wB4wlAx03xXE9G+eDlPIp0HotF
         S3s+OW1PczACp/Sbyi/0VZfYNVP3KnN1V+8boIzN6oe3y74YrL/mz8IS09MYQ8oUiz5t
         IvJTD8wRR25E/Yub4qHiTWWBNT+xesrTtfFr+Os6fAFFC6ABnY6sveIuU/NafAPXE7uk
         uVxtJ8EiLcdYgyypvIHw5xdjDUCS4gs+s+M8+IZZcns6A5D7NQMOUnj8Jrg7yoVvJ568
         CQhMsDBzfMe8kNIExnAa7JFvcFq7NrM1qMHKFpNPQHUSwb9mOBrKh/EFztI5z4Yc/h9N
         qdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582082; x=1729186882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1rQOwMKiHT/cHy9N2CsneDTHV0YTsagRNHYedEBcjg=;
        b=f4JjZgsslibp4o5hWSzIdOH4cfmrj72p5jsPuF4YKrOhYr8bj3JVHzDUcIeZrzDuXY
         61N0MTMia2l1pSB2OG2L/wBtWjF7O82DqkNaIIjtBRJj/4Sn+GdmgGy35Su/pznPs3En
         cKOE8USp9RpKQ2ng4t/ATsvuIiOV0rPAKRK95n2giSbXH/mYsp8yTgSzQSN9sjcsYWDY
         590vH8NNCBT85IP9aX58PnBf60Pn5UVMI++It52R+gaLQewmJdVpmZpmwOkbtfm1V9L3
         zI2Kz3rH8rXM3mEY2AjBviHuzVdCeV4B90Yw18admahz8AXno4708H7zpZTh2/CIvggG
         sIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0mpyIKL/NCZQFiFAiclsT9rJtpzbTShnJ++zMOQgq9i88onKd8kZMb46tGKz021FRD2UHD8U/HH2uWCCv@vger.kernel.org, AJvYcCU1OQoZUtbbEi6hQxL8ccXxEHX2FUooPexBlLVeT2xeDfHTawdGQcuQsuBENdaHj7Uhq7UOuH0/xR3F@vger.kernel.org, AJvYcCUDlPDEgXeTmQSe/0iudxy72yawEYyqNZejE2riR3VAIsHZrwVxo2cvg5CU15CZQad2kqFjB/ZdZz++1Q==@vger.kernel.org, AJvYcCV/TOKXJ4/UpYJk3RuVzdloUQz+kr7utp9gLsoIqhCqCy9m0qs05vGSKYpaTdhz0p2PQGK50Z15hwP3@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiXLk1v82TBL4saNoybF0tvgnrC5z6GpvfDN37WeYHE5ZnQV7
	uy4D6CCWNcd6ajmfnIUjXAMEEKXq5i/DP07wRrz4PzQsDWYD0XDx
X-Google-Smtp-Source: AGHT+IHNATlZ265TvmMhtLhq7HOxclwj7HJql/O6zYsPTgggNxactr61h0+rShQfZlcF6IwSy3pfXQ==
X-Received: by 2002:a05:6a00:1742:b0:71e:b8:1930 with SMTP id d2e1a72fcca58-71e1db8fc6emr11459656b3a.16.1728582081868;
        Thu, 10 Oct 2024 10:41:21 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:c165:c800:4280:d79b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b7a1sm1277157b3a.197.2024.10.10.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:41:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 10 Oct 2024 10:41:15 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/28] cxl/region: Add sparse DAX region support
Message-ID: <ZwgRu8GiBKJFFmWQ@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-16-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-16-c261ee6eeded@intel.com>

On Mon, Oct 07, 2024 at 06:16:22PM -0500, ira.weiny@intel.com wrote:
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
LGTM, and behaves as expected when tested with qemu setup.

Fan
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
> index 661dab99183f..b63ab622515f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -439,20 +439,20 @@ Description:
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
> index 0c62b4069ba0..5d6fe7ab0a78 100644
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
> index 23b4f266a83a..fefa592e9159 100644
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
> index 2ca6148d108c..34a6f447e75b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -496,6 +496,11 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> +	if (cxlr->mode == CXL_REGION_DC && val != 1) {
> +		dev_err(dev, "Interleaving and DCD not supported\n");
> +		return -EINVAL;
> +	}
> +
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -2176,6 +2181,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  	if (sysfs_streq(buf, "\n"))
>  		rc = detach_target(cxlr, pos);
>  	else {
> +		struct cxl_endpoint_decoder *cxled;
>  		struct device *dev;
>  
>  		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> @@ -2187,8 +2193,13 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
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
> @@ -2533,6 +2544,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_REGION_RAM:
>  	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2586,6 +2598,20 @@ static ssize_t create_ram_region_store(struct device *dev,
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
> 2.46.0
> 

-- 
Fan Ni

