Return-Path: <linux-btrfs+bounces-4070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEA89E04E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5476B2EA65
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844A13E05B;
	Tue,  9 Apr 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izuwsy8o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A0137C2A;
	Tue,  9 Apr 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679743; cv=none; b=WfU6A/s9490rbaAlMLuNN9GtIIyAqJCLhG3SexJjWw1VWzT3K3cjLIIYKmFvAQo2i8JlBBG4jYohVCg/NT+68nrJq0tsoENL/IugkRGVWUxn0kYtmMI7E+KIWjvtQybgExvRKQYUCl4iXlEVYxYRVfdFA3DCkSm8Pu06EtATJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679743; c=relaxed/simple;
	bh=JxIZLeYYKA5Iqp3UIL0+XuqsHCRG8TQtQnZnQZxVDrQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuO+hPHrv42iUYeGdSDBVYU3J1C5ATm4YmOP1OL2Be+25ZHnjeoRRuracCR2ccV1xvr0XnxPgXSdmWbn5BnjEXfduvFUFpCOPsHLa8PjEKXknUix5qUQ+tr0u8PSy0xOYZHFr0FaHzeEWfTp53PgQ97ZVdg1Jl/2Me+2MpgAyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izuwsy8o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3f6f03594so16487945ad.0;
        Tue, 09 Apr 2024 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679741; x=1713284541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tD47IJ6kQxTtIB88NMneMVe86ozyK03KRGipxA4mLDw=;
        b=izuwsy8obxhYNMUNfa1V9hTbc6eu0GOzCMmYlHxxRgOeEJbBQECdMrPiJxXwdMh4Fg
         xSWlaCKLjDDvobmLB3IS5RiqDQ4BM+75GpkOJpM7ljG+Itbp55Ikn+th4L+VqtTQnoJX
         nKv7Z/Y6TY+E4ddcEXb9xIRRrDX9Mdr5e0wTgFjvdrQc1p4Xql/3/wb2HhRg2/qyT8jy
         PzWlmz2JduZTsAiNNiVDkoQKUBql6WLKkdbO1KQJaUKBVavxC6o7Xn9+/PMUMlu5M+7h
         qSGc+JAv/lRAWe4PIfIY2zmDHQXTGNxMILfu34E8zSiZM6SHfmq8ga2W6jLeBTFgNjx5
         0kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679741; x=1713284541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD47IJ6kQxTtIB88NMneMVe86ozyK03KRGipxA4mLDw=;
        b=BiJ7x0xwlDdFZ0psTUqSmG98RQqNlQjoPqRQ7qmKBV1KBnBEzLJ4kKf791ZPxyulds
         Zqx1V4WtvWuU5UGU2QKcCOnhYbbhMZU/THEqZDZc6skKtxSceq2RwWtSZvFQ9qfTBTes
         2dw0XSUkuTltorXN9oT+OXc3NHR3CsH/492VHI4ZtPkvR3MKCutIuM7DptMjH6yCUz9c
         vqNzLNJTVr+RUSSCqWvCu7gDUuapnDZ+3Hu3/qZ3NGaH2XSm1fc05I8C3ddC8/z9lwYL
         xzLoEJT+EdcvsJkmvJ9qjXV9O4MF1uq3jnRr3r6mU5fsOr9E7LwtYrpgGeD7MawT359A
         0/yw==
X-Forwarded-Encrypted: i=1; AJvYcCVj3kXhgv4qRJJKebD+kLpBO/AiaEehMp4u0CWFp13PqXKdiV06Wi3yJO2VsTQ+UBvgBG/YBLiJ9YdOEn/Zar51sfQvl8Emafo4lm8Iaw/dJCvoKRXmAdDRI9kI7gUGPTCjni/fjL/591v79i2GEftco1qz6+TahHXIwyrLpGvewUzc1uU=
X-Gm-Message-State: AOJu0Yxkbds+k3E4yoPLc0nKkMt0xChuwgEsJWoDP/Nca6T/B8VKNTAg
	74dmAcVbz4l3ch4FDnzMuyl24UVz8J1vagyUMgcxh1f8eCMbAYfX
X-Google-Smtp-Source: AGHT+IEpvJvIGTSdUOXn55foN6dxhGocH7+e1yBuo1jkO0TWg0FAeahSCO2QqKfRiDXM8w0fA38H3g==
X-Received: by 2002:a17:902:d587:b0:1e4:9ad5:7522 with SMTP id k7-20020a170902d58700b001e49ad57522mr273599plh.21.1712679741025;
        Tue, 09 Apr 2024 09:22:21 -0700 (PDT)
Received: from debian ([2601:641:300:14de:df2a:d319:d307:86c9])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b001e2814e08b9sm9048820plh.32.2024.04.09.09.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:22:20 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 9 Apr 2024 09:22:00 -0700
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
Subject: Re: [PATCH 17/26] dax/region: Create extent resources on DAX region
 driver load
Message-ID: <ZhVrKGHbR032FxS1@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-17-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:20PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> DAX regions mapping dynamic capacity partitions introduce a requirement
> for the memory backing the region to come and go as required.  This
> results in a DAX region with sparse areas of memory backing.  To track
> the sparseness of the region, DAX extent objects need to track
> sub-resource information as a new layer between the DAX region resource
> and DAX device range resources.
> 
> Recall that DCD extents may be accepted when a region is first created.
> Extend this support on region driver load.  Scan existing extents and
> create DAX extent resources as a first step to DAX extent realization.
> 
> The lifetime of a DAX extent is tricky to manage because the extent life
> may end in one of two ways.  First, the device may request the extent be
> released.  Second, the region may release the extent when it is
> destroyed without hardware involvement.  Support extent release without
> hardware involvement first.  Subsequent patches will provide for
> hardware to request extent removal.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Trivial comments inline.
> ---
> Changes for v1
> [iweiny: remove xarrays]
> [iweiny: remove as much of extra reference stuff as possible]
> [iweiny: Move extent resource handling to core DAX code]
> ---
>  drivers/dax/bus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/cxl.c         | 43 ++++++++++++++++++++++++++++++++++--
>  drivers/dax/dax-private.h | 12 +++++++++++
>  3 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 903566aff5eb..4d5ed7ab6537 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -186,6 +186,61 @@ static bool is_sparse(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
>  }
>  
> +static int dax_region_add_resource(struct dax_region *dax_region,
> +				   struct dax_extent *dax_ext,
> +				   resource_size_t start,
> +				   resource_size_t length)
> +{
> +	struct resource *ext_res;
> +
> +	dev_dbg(dax_region->dev, "DAX region resource %pr\n", &dax_region->res);
> +	ext_res = __request_region(&dax_region->res, start, length, "extent", 0);
> +	if (!ext_res) {
> +		dev_err(dax_region->dev, "Failed to add region s:%pa l:%pa\n",
> +			&start, &length);
> +		return -ENOSPC;
> +	}
> +
> +	dax_ext->region = dax_region;
> +	dax_ext->res = ext_res;
> +	dev_dbg(dax_region->dev, "Extent add resource %pr\n", ext_res);
> +
> +	return 0;
> +}
> +
> +static void dax_region_release_extent(void *ext)
> +{
> +	struct dax_extent *dax_ext = ext;
> +	struct dax_region *dax_region = dax_ext->region;
> +
> +	dev_dbg(dax_region->dev, "Extent release resource %pr\n", dax_ext->res);
> +	if (dax_ext->res)
> +		__release_region(&dax_region->res, dax_ext->res->start,
> +				 resource_size(dax_ext->res));
> +
> +	kfree(dax_ext);
> +}
> +
> +int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
> +			  resource_size_t start, resource_size_t length)
> +{
> +	int rc;
> +
> +	struct dax_extent *dax_ext __free(kfree) = kzalloc(sizeof(*dax_ext),
> +							   GFP_KERNEL);
> +	if (!dax_ext)
> +		return -ENOMEM;
> +
> +	guard(rwsem_write)(&dax_region_rwsem);
> +	rc = dax_region_add_resource(dax_region, dax_ext, start, length);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(ext_dev, dax_region_release_extent,
> +					no_free_ptr(dax_ext));
> +}
> +EXPORT_SYMBOL_GPL(dax_region_add_extent);
> +
>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 415d03fbf9b6..70bdc7a878ab 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -5,6 +5,42 @@
>  
>  #include "../cxl/cxl.h"
>  #include "bus.h"
> +#include "dax-private.h"
> +
> +static int __cxl_dax_region_add_extent(struct dax_region *dax_region,
> +				       struct region_extent *reg_ext)
> +{
> +	struct device *ext_dev = &reg_ext->dev;
> +	resource_size_t start, length;
> +
> +	dev_dbg(dax_region->dev, "Adding extent HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	start = dax_region->res.start + reg_ext->hpa_range.start;
> +	length = reg_ext->hpa_range.end - reg_ext->hpa_range.start + 1;
use range_len() instead?

Fan

> +
> +	return dax_region_add_extent(dax_region, ext_dev, start, length);
> +}
> +
> +static int cxl_dax_region_add_extent(struct device *dev, void *data)
> +{
> +	struct dax_region *dax_region = data;
> +	struct region_extent *reg_ext;
> +
> +	if (!is_region_extent(dev))
> +		return 0;
> +
> +	reg_ext = to_region_extent(dev);
> +
> +	return __cxl_dax_region_add_extent(dax_region, reg_ext);
> +}
> +
> +static void cxl_dax_region_add_extents(struct cxl_dax_region *cxlr_dax,
> +				      struct dax_region *dax_region)
> +{
> +	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
> +	device_for_each_child(&cxlr_dax->dev, dax_region, cxl_dax_region_add_extent);
> +}
>  
>  static int cxl_dax_region_probe(struct device *dev)
>  {
> @@ -29,9 +65,12 @@ static int cxl_dax_region_probe(struct device *dev)
>  		return -ENOMEM;
>  
>  	dev_size = range_len(&cxlr_dax->hpa_range);
> -	/* Add empty seed dax device */
> -	if (cxlr->mode == CXL_REGION_DC)
> +	if (cxlr->mode == CXL_REGION_DC) {
> +		/* NOTE: Depends on dax_region being set in driver data */
> +		cxl_dax_region_add_extents(cxlr_dax, dax_region);
> +		/* Add empty seed dax device */
>  		dev_size = 0;
> +	}
>  
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 446617b73aea..c6319c6567fb 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -16,6 +16,18 @@ struct inode *dax_inode(struct dax_device *dax_dev);
>  int dax_bus_init(void);
>  void dax_bus_exit(void);
>  
> +/**
> + * struct dax_extent - For sparse regions; an active extent
> + * @region: dax_region this resources is in
> + * @res: resource this extent covers
> + */
> +struct dax_extent {
> +	struct dax_region *region;
> +	struct resource *res;
> +};
> +int dax_region_add_extent(struct dax_region *dax_region, struct device *ext_dev,
> +			  resource_size_t start, resource_size_t length);
> +
>  /**
>   * struct dax_region - mapping infrastructure for dax devices
>   * @id: kernel-wide unique region for a memory range
> 
> -- 
> 2.44.0
> 

