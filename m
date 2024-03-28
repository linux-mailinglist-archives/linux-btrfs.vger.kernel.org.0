Return-Path: <linux-btrfs+bounces-3742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80948890C4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354FC2A867A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179D13AD1B;
	Thu, 28 Mar 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnoxggaM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DD6519D;
	Thu, 28 Mar 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660278; cv=none; b=Q1jD5E1n9PULAim6D5xRUILpAMkkFaSRr0wKbdmCG6JKxPIpqNPJfSA8SLvHIN6LCdtF81SzxfHBI7YsKwKMkKzuq40pOTXxfQQqLYZN5cg14+rvleE90UfyQVgKEK8G0XW6gTlA8g+Anl55HmDWJyxjjIWzNl0rYzSOt1bis+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660278; c=relaxed/simple;
	bh=lkZYwVy+sjuDEV04FV7Gg3b1dg27/moum9xuSHTkfOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSMF3yJ8rhxIBFN6Lij6XsTC6/0oEhh5OdBEl4lYEGdC2xYKUWSXqtDIKrPgSgU+neivFaN26dPvkYrMMWYXgHZBrXLmOQqS/VSAbjXbGKszPvSboO9gnaEFJTZCZ1z3E9pBtCZ087KZO8kYb5u2Fr9ruHQZEy7LJJOFu4SmPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnoxggaM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711660277; x=1743196277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lkZYwVy+sjuDEV04FV7Gg3b1dg27/moum9xuSHTkfOA=;
  b=YnoxggaMVY2g0iLDZPTuaTleGl2JnQMJpg9hIT0uZDRdZBchg21WS02a
   wSx1luU0Ho8KLkjDHt5kB8nCa93DDBzkIG0EJDkJeHp+cOgV0SpfJzPvv
   iU7cxbl1Ad4C1o4p8PPzYgFRE2YUWZy85r4S9OGAThe1dISxygQW7t542
   TO/M0CffhfVATq9lftFeul8oADVDuITdejahxBbBHEMcjidmKif5MCseE
   JJqX+9yBwOiyZp386AsIPbQHxmNUt8aEuXZhOmxcv0EtaZGbCyso29YLL
   lPhZgy4rg+FQN88uhre9KVnOtJN7vNfXjsZYyvKq717uP7WCia2ytuuar
   Q==;
X-CSE-ConnectionGUID: Bj7YAF47TouOQrs8xfpUXg==
X-CSE-MsgGUID: M7bmkVV/S0i6KdhzqLVDVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6737817"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6737817"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21446107"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.81.17]) ([10.212.81.17])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:11:14 -0700
Message-ID: <10a45890-422d-4956-bfe0-101eee23b323@intel.com>
Date: Thu, 28 Mar 2024 14:11:14 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/26] cxl/extent: Realize extent devices
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
 <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-16-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
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
> 
> The use of the extent devices by the DAX layer is deferred to later
> patches.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [iweiny: new patch]
> [iweiny: Rename 'dr_extent' to 'region_extent']
> ---
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/extent.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c   |  43 +++++++++++++++
>  drivers/cxl/core/region.c |  76 +++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |  37 +++++++++++++
>  tools/testing/cxl/Kbuild  |   1 +
>  6 files changed, 290 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..35c5c76bfcf1 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -14,5 +14,6 @@ cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
> +cxl_core-y += extent.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> new file mode 100644
> index 000000000000..487c220f1c3c
> --- /dev/null
> +++ b/drivers/cxl/core/extent.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxl.h>
> +
> +static DEFINE_IDA(cxl_extent_ida);

According to Documentation/core-api/idr.rst, IDR interface is deprecated and xarray usage is preferred.

> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)

Parameter alignment a bit off here? and some of the other functions as well.

> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%pa\n", &reg_ext->hpa_range.start);
> +}
> +static DEVICE_ATTR_RO(offset);
> +
> +static ssize_t length_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +	u64 length = range_len(&reg_ext->hpa_range);
> +
> +	return sysfs_emit(buf, "%pa\n", &length);
> +}
> +static DEVICE_ATTR_RO(length);
> +
> +static ssize_t label_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +
> +	return sysfs_emit(buf, "%s\n", reg_ext->label);
> +}
> +static DEVICE_ATTR_RO(label);
> +
> +static struct attribute *region_extent_attrs[] = {
> +	&dev_attr_offset.attr,
> +	&dev_attr_length.attr,
> +	&dev_attr_label.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group region_extent_attribute_group = {
> +	.attrs = region_extent_attrs,
> +};
> +
> +static const struct attribute_group *region_extent_attribute_groups[] = {
> +	&region_extent_attribute_group,
> +	NULL,
> +};
> +
> +static void region_extent_release(struct device *dev)
> +{
> +	struct region_extent *reg_ext = to_region_extent(dev);
> +
> +	cxl_release_ed_extent(&reg_ext->ed_ext);
> +	ida_free(&cxl_extent_ida, reg_ext->dev.id);
> +	kfree(reg_ext);
> +}
> +
> +static const struct device_type region_extent_type = {
> +	.name = "extent",
> +	.release = region_extent_release,
> +	.groups = region_extent_attribute_groups,
> +};
> +
> +bool is_region_extent(struct device *dev)
> +{
> +	return dev->type == &region_extent_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_region_extent, CXL);
> +
> +static void region_extent_unregister(void *ext)
> +{
> +	struct region_extent *reg_ext = ext;
> +
> +	dev_dbg(&reg_ext->dev, "DAX region rm extent HPA %#llx - %#llx\n",
> +		reg_ext->hpa_range.start, reg_ext->hpa_range.end);
> +	device_unregister(&reg_ext->dev);
> +}
> +
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

Not needed. kzalloc already zeroed.

DJ

> +	dc_res->extent_list[0].length = cpu_to_le64(range_len(extent));
> +	dc_res->extent_list_size = cpu_to_le32(1);
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
>  
> +static int extent_check_overlap(struct device *dev, void *arg)
> +{
> +	struct range *new_range = arg;
> +	struct region_extent *ext;
> +
> +	if (!is_region_extent(dev))
> +		return 0;
> +
> +	ext = to_region_extent(dev);
> +	return range_overlaps(&ext->hpa_range, new_range);
> +}
> +
> +static int extent_overlaps(struct cxl_dax_region *cxlr_dax,
> +			   struct range *hpa_range)
> +{
> +	struct device *dev __free(put_device) =
> +		device_find_child(&cxlr_dax->dev, hpa_range, extent_check_overlap);
> +
> +	if (dev)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  /* Callers are expected to ensure cxled has been attached to a region */
>  int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
>  			  struct cxl_dc_extent *dc_extent)
>  {
> -	return 0;
> +	struct cxl_region *cxlr = cxled->cxld.region;
> +	struct range ext_dpa_range, ext_hpa_range;
> +	struct device *dev = &cxlr->dev;
> +	resource_size_t dpa_offset, hpa;
> +
> +	/*
> +	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
> +	 * device extents and DAX region extents.  Future implementations
> +	 * should hold DC region extents here until the full dax region extent
> +	 * can be realized.
> +	 */
> +	if (cxlr->params.interleave_ways != 1) {
> +		dev_err(dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	ext_dpa_range = (struct range) {
> +		.start = le64_to_cpu(dc_extent->start_dpa),
> +		.end = le64_to_cpu(dc_extent->start_dpa) +
> +			le64_to_cpu(dc_extent->length) - 1,
> +	};
> +
> +	dev_dbg(dev, "Adding DC extent DPA %#llx - %#llx\n",
> +		ext_dpa_range.start, ext_dpa_range.end);
> +
> +	/*
> +	 * Without interleave...
> +	 * HPA offset == DPA offset
> +	 * ... but do the math anyway
> +	 */
> +	dpa_offset = ext_dpa_range.start - cxled->dpa_res->start;
> +	hpa = cxled->cxld.hpa_range.start + dpa_offset;
> +
> +	ext_hpa_range = (struct range) {
> +		.start = hpa - cxlr->cxlr_dax->hpa_range.start,
> +		.end = ext_hpa_range.start + range_len(&ext_dpa_range) - 1,
> +	};
> +
> +	if (extent_overlaps(cxlr->cxlr_dax, &ext_hpa_range))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "Realizing region extent at HPA %#llx - %#llx\n",
> +		ext_hpa_range.start, ext_hpa_range.end);
> +
> +	return dax_region_create_ext(cxlr->cxlr_dax, &ext_hpa_range,
> +				     (char *)dc_extent->tag,
> +				     &ext_dpa_range,
> +				     cxled);
>  }
>  
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
> @@ -564,6 +564,7 @@ struct cxl_region_params {
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> + * @cxlr_dax: (for DC regions) cached copy of CXL DAX bridge
>   * @flags: Region state flags
>   * @params: active + config params for the region
>   */
> @@ -574,6 +575,7 @@ struct cxl_region {
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_dax_region *cxlr_dax;
>  	unsigned long flags;
>  	struct cxl_region_params params;
>  };
> @@ -617,6 +619,41 @@ struct cxl_dax_region {
>  	struct range hpa_range;
>  };
>  
> +/**
> + * struct cxl_ed_extent - Extent within an endpoint decoder
> + * @dpa_range: DPA range this extent covers within the decoder
> + * @cxled: reference to the endpoint decoder
> + */
> +struct cxl_ed_extent {
> +	struct range dpa_range;
> +	struct cxl_endpoint_decoder *cxled;
> +};
> +void cxl_release_ed_extent(struct cxl_ed_extent *extent);
> +
> +/**
> + * struct region_extent - CXL DAX region extent
> + * @dev: device representing this extent
> + * @hpa_range: HPA range of this extent
> + * @label: label of the extent
> + * @ed_ext: Endpoint decoder extent which backs this extent
> + */
> +#define DAX_EXTENT_LABEL_LEN 64
> +struct region_extent {
> +	struct device dev;
> +	struct range hpa_range;
> +	char label[DAX_EXTENT_LABEL_LEN];
> +	struct cxl_ed_extent ed_ext;
> +};
> +
> +int dax_region_create_ext(struct cxl_dax_region *cxlr_dax,
> +			  struct range *hpa_range,
> +			  const char *label,
> +			  struct range *dpa_range,
> +			  struct cxl_endpoint_decoder *cxled);
> +
> +bool is_region_extent(struct device *dev);
> +#define to_region_extent(dev) container_of(dev, struct region_extent, dev)
> +
>  /**
>   * struct cxl_port - logical collection of upstream port devices and
>   *		     downstream port devices to construct a CXL memory
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 030b388800f0..dc0cc1d5e6a0 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -60,6 +60,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> +cxl_core-y += $(CXL_CORE_SRC)/extent.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-y += config_check.o
> 

