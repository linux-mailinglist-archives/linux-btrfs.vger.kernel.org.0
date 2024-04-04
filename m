Return-Path: <linux-btrfs+bounces-3905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F289832A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425211C26E6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1170CC7;
	Thu,  4 Apr 2024 08:32:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B11E86F;
	Thu,  4 Apr 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219527; cv=none; b=YULN4lwKul3coda17ncNkDGGOm4phDyG9tXBtMLYfRMXZAnIG0whVwchVcqIBCt4qjEOISdJfP6+LydgzX1vDSvFZ/xS2d6mPA8ONABnMndTtkXHQbY7c43jEcPFTXIfSZVg2NhhZ/O6uOiXa0oZ3vFH+BhvNRmnaRnyfHTZTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219527; c=relaxed/simple;
	bh=JKS3gJuoyWRLgG5BfFc0HNP29RdT5bEYJ3j/de6iRMo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYLfftBREc7gKqZWL2OQtkV/4SqL6MGqDFHaBLgkf3I3ixqBdQqNbL3/4T0ZUqffqY/a5UcLI2IG+CvNUthJtXZC/L4+aRq/Fao6vLxSqMpZh+Uzsdqn4PdY4DutOT5J8B7V7t+7TQ4VV0xdp8uwOB4c9Gs1pxYF2wC0tRjbxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9FDx2Rwqz6GBcd;
	Thu,  4 Apr 2024 16:30:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 47FDA140C9C;
	Thu,  4 Apr 2024 16:32:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 09:31:59 +0100
Date: Thu, 4 Apr 2024 09:32:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] cxl/port: Add Dynamic Capacity mode support to
 endpoint decoders
Message-ID: <20240404093201.00004f33@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-6-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:09 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Endpoint decoders which are used to map Dynamic Capacity must be
> configured to point to the correct Dynamic Capacity (DC) Region.  The
> decoder mode currently represents the partition the decoder points to
> such as ram or pmem.
> 
> Expand the mode to include DC regions [partitions].
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: eliminate added gotos]
> [iweiny: Mark DC support for 6.10 kernel]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 +++++++++++----------
>  drivers/cxl/core/hdm.c                  | 19 +++++++++++++++++++
>  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..8b3efaf6563c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -316,23 +316,24 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, June 2024
> +KernelVersion:	v6.0, v6.10 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles the volatile/persistent partition boundary,

I love corners.  What happen if no persistent and decoder straddles
volatile / dc0?  Would only happen if the bios was having fun I think...

> +		and 'none' indicates the decoder is not actively decoding, or
> +		no DPA allocation policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 66b8419fd0c3..e22b6f4f7145 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -255,6 +255,14 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	if (mode < CXL_DECODER_DC0 || CXL_DECODER_DC7 < mode)
> +		return -EINVAL;
> +
> +	return mode - CXL_DECODER_DC0;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -411,6 +419,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> +	int rc;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> @@ -433,6 +442,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  			return -ENXIO;
>  		}
>  		break;
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> +		rc = dc_mode_to_region_index(mode);
> +		if (rc < 0)
> +			return rc;

Can't fail, so you could not bother checking..  Seems very unlikely
that function will gain other error cases in the future.

> +
> +		if (resource_size(&cxlds->dc_res[rc]) == 0) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			return -ENXIO;
> +		}
> +		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..80c0651794eb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -208,6 +208,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;

Fully agree with the comment that a string + enum table and search
is probably appropriate here.

>  	else
>  		return -EINVAL;
>  
> 


