Return-Path: <linux-btrfs+bounces-3923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8E898C2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C82E28426C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BE1C6A3;
	Thu,  4 Apr 2024 16:32:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869A18039;
	Thu,  4 Apr 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248368; cv=none; b=Yvd1HxkpSqAFPjl+9ys054ZSypuuEx9J3ZkyfGDUVC4EGW9ER4cxiDs7d2CO71l2bbmRgoyTplpYJEkvh4ABBPVl5YiWesa5EnuvVG/5Ih+MgvGx6sLzYuezwYxttW77mOj33+Z07YPr/RPrcCR3lxk0aiTiYoVObfrLz3Gujs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248368; c=relaxed/simple;
	bh=MJ9NyxJXfgw/jY7GJL3DIjKd1e32tMBgLGQGYcUDkdY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia5obPmE2QuyR3ZonM9XX7ar7fQI6frzbNsQ1vnr6SKmQS6yf4wYWvZUS9l5JgRGu/uqHD1pafkNImX6tZ4KX3ldaGywTcgEAkcTaFeLhcMvfkqCjN6d8PxMWCuiTTGDS8jl+VWnexQUFvsRa9g7mbXSxHskfyc6IY5Ao1vosxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9RvX0vCqz689lt;
	Fri,  5 Apr 2024 00:31:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B69EF140A86;
	Fri,  5 Apr 2024 00:32:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 17:32:42 +0100
Date: Thu, 4 Apr 2024 17:32:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
Message-ID: <20240404173241.00003a6f@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:19 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Once all extents of an interleave set are present a region must
> surface an extent to the region.
> 
> Without interleaving; endpoint decoder and region extents have a 1:1
> relationship.  Future support for IW > 1 will maintain a N:1
> relationship between the device extents and region extents.
> 
> Create a region extent device for every device extent found.  Release of
> the extent device triggers a response to the underlying hardware extent.
> 
> There is no strong use case to support the addition of extents which
> overlap previously accepted extent ranges.  Reject such new extents
> until such time as a good use case emerges.
> 
> Expose the necessary details of region extents by creating the following
> sysfs entries.
> 
> 	/sys/bus/cxl/devices/dax_regionX/extentY
> 	/sys/bus/cxl/devices/dax_regionX/extentY/offset
> 	/sys/bus/cxl/devices/dax_regionX/extentY/length
> 	/sys/bus/cxl/devices/dax_regionX/extentY/label

Docs?  The label in particular worries me a little as I'm not sure what
is in it.  If it's the tag one possible format is a uuid (not a coincidence
that it is the same length) and interpreting that as characters isn't
going to get us far.  I wonder if we have to treat it as a binary attr
given we have no idea what it is.

Otherwise a query inline that may well be answered in later patches.

> 
> The use of the extent devices by the DAX layer is deferred to later
> patches.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 



> +int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
> +			  struct range *hpa_range,
> +			  const char *label,
> +			  struct range *dpa_range,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	struct region_extent *reg_ext;
> +	struct device *dev;
> +	int rc, id;
> +
> +	id = ida_alloc(&cxl_extent_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return -ENOMEM;

Whilst it doesn't matter hugely, it's nice if the release does things
in opposite order of the creation. So perhaps move the ida_alloc
after kzalloc or reg_ext?

> +
> +	reg_ext = kzalloc(sizeof(*reg_ext), GFP_KERNEL);
> +	if (!reg_ext)
> +		return -ENOMEM;
> +
> +	reg_ext->hpa_range = *hpa_range;
> +	reg_ext->ed_ext.dpa_range = *dpa_range;
> +	reg_ext->ed_ext.cxled = cxled;
> +	snprintf(reg_ext->label, DAX_EXTENT_LABEL_LEN, "%s", label);
> +
> +	dev = &reg_ext->dev;
> +	device_initialize(dev);
> +	dev->id = id;
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr_dax->dev;
> +	dev->type = &region_extent_type;
> +	rc = dev_set_name(dev, "extent%d", dev->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(dev, "DAX region extent HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
> +	reg_ext);

Indent

> +
> +err:
> +	dev_err(&cxlr_dax->dev, "Failed to initialize DAX extent dev HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +
> +	put_device(dev);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9e33a0976828..6b00e717e42b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1020,6 +1020,32 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> +				    struct range *extent, int opcode)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t size;
> +
> +	struct cxl_mbox_dc_response *dc_res __free(kfree);
> +	size = struct_size(dc_res, extent_list, 1);
> +	dc_res = kzalloc(size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	dc_res->extent_list[0].dpa_start = cpu_to_le64(extent->start);
> +	memset(dc_res->extent_list[0].reserved, 0, 8);
> +	dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
> +	dc_res->extent_list_size = cpu_to_le32(1);

I guess this comes up later, but such a response means that if we are offered
multiple extents in an add with the more flag set then we always reject all
but the first one.

> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = size,
> +		.payload_in = dc_res,
> +	};
> +
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +}
> +
>  static struct cxl_memdev_state *
>  cxled_to_mds(struct cxl_endpoint_decoder *cxled)
>  {
> @@ -1029,6 +1055,23 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +void cxl_release_ed_extent(struct cxl_ed_extent *extent)
> +{
> +	struct cxl_endpoint_decoder *cxled = extent->cxled;
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	dev_dbg(dev, "Releasing DC extent DPA %#llx - %#llx\n",
> +		extent->dpa_range.start, extent->dpa_range.end);
> +
> +	rc = cxl_send_dc_cap_response(mds, &extent->dpa_range, CXL_MBOX_OP_RELEASE_DC);

Long line that doesn't really need to be.

> +	if (rc)
> +		dev_dbg(dev, "Failed to respond releasing extent DPA %#llx - %#llx; %d\n",
> +			extent->dpa_range.start, extent->dpa_range.end, rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_ed_extent, CXL);
> +
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3e563ab29afe..7635ff109578 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1450,11 +1450,81 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  	return 0;
>  }

>  static int cxl_region_attach_position(struct cxl_region *cxlr,
> @@ -2684,6 +2754,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  
>  	dev = &cxlr_dax->dev;
>  	cxlr_dax->cxlr = cxlr;
> +	cxlr->cxlr_dax = cxlr_dax;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
>  	device_set_pm_not_required(dev);
> @@ -2799,7 +2870,10 @@ static int cxl_region_read_extents(struct cxl_region *cxlr)
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> +	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  
> +	cxlr->cxlr_dax = NULL;
> +	cxlr_dax->cxlr = NULL;
>  	device_unregister(&cxlr_dax->dev);
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d585f5fdd3ae..5379ad7f5852 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h


> +/**
> + * struct region_extent - CXL DAX region extent
> + * @dev: device representing this extent
> + * @hpa_range: HPA range of this extent
> + * @label: label of the extent
> + * @ed_ext: Endpoint decoder extent which backs this extent
> + */
> +#define DAX_EXTENT_LABEL_LEN 64

Something called DAX_* doesn't belong in this header...
Either give a CXL_DAX_ prefix or move the definition if appropriate.

