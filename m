Return-Path: <linux-btrfs+bounces-3557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD9888B1C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B99C61013
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6B130E45;
	Mon, 25 Mar 2024 16:20:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E56130AEB;
	Mon, 25 Mar 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383618; cv=none; b=IynGAPiytx5VrFipAVoydKUnCIzjZOt47yto0TsOMMF3cYkc7jL68ZR9MX0i4M4Fady7NHYUGYC0Jia4329nsDKFIzSdPO/AmnCm+Tt2/QPyDjX7plzSqVgx+uBA1GNBLkrFBvKsEiSThoh7WIhyidT9jLiVkBfZFjHm6jzi2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383618; c=relaxed/simple;
	bh=+PK36ygo6YUyNEKeoKEQ3VN30F5Uqb0EdLDEHLmace8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKl9YFSmcla7YFIJZmvw/XMwbJbLb85jDGwgh/h5wU6HY/p1BPZn9Fdd4DWBPYZ3MX3Wksj6/qE74rQ8hy1CA0yZy5ssrZ/GXf48wzRnocDTSfJxTVv3F0M1gPW7DPwWbJ4enclhwPdAxQzk9kLCAEuLsElZvCpgW98SxJJwZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3J2D1m9Rz6K9W0;
	Tue, 26 Mar 2024 00:15:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A8147140B2F;
	Tue, 26 Mar 2024 00:20:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 16:20:12 +0000
Date: Mon, 25 Mar 2024 16:20:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] cxl/core: Separate region mode from decoder mode
Message-ID: <20240325162010.000036cc@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-2-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:05 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Until now region modes and decoder modes were equivalent in that they
> were either PMEM or RAM.  With the upcoming addition of Dynamic Capacity
> regions (which will represent an array of device regions [better named
> partitions] the index of which could be different on different
> interleaved devices), the mode of an endpoint decoder and a region will
> no longer be equivalent.
> 
> Define a new region mode enumeration and adjust the code for it.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

I can't really remember the reasoning behind this split, but from a fresh
read it seems reasonable. Some trivial comments inline.

Jonathan

> 
> ---
> Changes for v1
> <none>
> ---
>  drivers/cxl/core/region.c | 77 +++++++++++++++++++++++++++++++++++------------
>  drivers/cxl/cxl.h         | 26 ++++++++++++++--
>  2 files changed, 81 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4c7fd2d5cccb..1723d17f121e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c


> @@ -2800,6 +2814,24 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static enum cxl_region_mode
> +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
> +	case CXL_DECODER_NONE:
> +		return CXL_REGION_NONE;
> +	case CXL_DECODER_RAM:
> +		return CXL_REGION_RAM;
> +	case CXL_DECODER_PMEM:
> +		return CXL_REGION_PMEM;
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return CXL_REGION_MIXED;
> +	}
> +

Dead code.

> +	return CXL_REGION_MIXED;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -2808,12 +2840,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> +	enum cxl_region_mode mode;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
>  	int rc;
>  
> +	if (cxled->mode == CXL_DECODER_DEAD)
> +		return ERR_PTR(-EINVAL);

Not a bad thing necessarily, but why do we now need this and didn't before?

> +
> +	mode = cxl_decoder_to_region_mode(cxled->mode);
>  	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, mode,
>  				       atomic_read(&cxlrd->region_id));
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..9a0cce1e6fca 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h


>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -511,7 +532,8 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Region mode which defines which endpoint decoder mode the region is
mode or potentially modes?

If region is mixed, I guess that means endpoint could be pmem or ram in theory?
Don't think anyone has implemented anything yet, but is the potential there?


> + *        compatible with


