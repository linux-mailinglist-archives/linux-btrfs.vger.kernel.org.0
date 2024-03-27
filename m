Return-Path: <linux-btrfs+bounces-3677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675188EE4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919841F3B2AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93614F9D7;
	Wed, 27 Mar 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4eG/QOZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7041DDC5;
	Wed, 27 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564280; cv=none; b=pL7vMH3cg8BCASgYpjA4dknSDOadQs8+eX/edvBa18CwBgTeMas6E/fppbobqYNPMNGj/jUBc11vxq+PBMC6750FUb6euFCay7Yg2Tg/p9XfvgzJOATKlZz8/8nxM3viLEB+M/qRBGuZd7HDnGyV7eVvakvMSWMSoh1pzx8iVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564280; c=relaxed/simple;
	bh=JcUPt5RgQ19NpuIQiFGFT2ogF7Z7WiKV5z5KS169Opk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0vgd38IFxETABRoFC7Dp4VFaCwWAzpVClYJOwXPl4YoBGvCi+u8CravJ/kJH9JGAq8wV/6jiLgE/9PzEvj6sZ11Wftd5OEIg1W18dMDKzrvENz0c+dxXNCighOfTMe+KEEEQTep79mu/Nx9zusQloKPfjVaKp1XuhEQ/EoUK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4eG/QOZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711564278; x=1743100278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JcUPt5RgQ19NpuIQiFGFT2ogF7Z7WiKV5z5KS169Opk=;
  b=l4eG/QOZfqEEznrZmgNkUqvXe7JZqDzEsZgSEj9m/e6Nn0GGlWDy2oTO
   Gs9YdrbuLgwiGaE77rbDHHmCcBfeS0IsEYmtuwnPcBRhER8xrR8sli62p
   Ojoap6TmG3XQ9pUCiuQ1Oli0+/z27TQ9FnEAalPyvt8cbD+Rhk4Y3rZN8
   Ut/HOYT0H2XpDoL1i+SIrDYcWDUT9racbI7XtNCT5b2pMFlwJsXUBuOai
   FpdRt4ioAjuLw6RxUJrjGVzqOc/aYTMtg1oc01f5Fg72H6e1f7cTLmegI
   Rqgq70omNJFrQIo2qbujDyaOVatkxmoVMbo1TYr11qJVQn9ejOrZr/ysg
   A==;
X-CSE-ConnectionGUID: Bo1+jjYnRkK9h2n+vUphFg==
X-CSE-MsgGUID: yINO1bbvSiGBhV2VpkTYIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6905577"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6905577"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414603"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.56.222]) ([10.212.56.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:31:15 -0700
Message-ID: <c2aa9a19-a0ab-46c7-91fc-f3903142097b@intel.com>
Date: Wed, 27 Mar 2024 11:31:15 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
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
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/24 4:18 PM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case creation of a new
> region on top of the DC partition (region) is expected to expose those
> extents for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized read the device extent list.  For ease of review, this patch
> stops after reading the extent list and leaves realization of the region
> extents to a future patch.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1:
> [iweiny: remove extent list xarray]
> [iweiny: Update spec references to 3.1]
> [iweiny: use struct range in extents]
> [iweiny: remove all reference tracking and let regions track extents
> 	 through the extent devices.]
> [djbw/Jonathan/Fan: move extent tracking to endpoint decoders]
> ---
>  drivers/cxl/core/core.h   |   9 +++
>  drivers/cxl/core/mbox.c   | 192 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |  29 +++++++
>  drivers/cxl/cxlmem.h      |  49 ++++++++++++
>  4 files changed, 279 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 91abeffbe985..119b12362977 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -4,6 +4,8 @@
>  #ifndef __CXL_CORE_H__
>  #define __CXL_CORE_H__
>  
> +#include <cxlmem.h>
> +
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_pmu_type;
> @@ -28,6 +30,8 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +			  struct cxl_dc_extent *dc_extent);
>  #else
>  static inline int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  {
> @@ -43,6 +47,11 @@ static inline int cxl_region_init(void)
>  static inline void cxl_region_exit(void)
>  {
>  }
> +static inline int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +					struct cxl_dc_extent *dc_extent)
> +{
> +	return 0;
> +}
>  #define CXL_REGION_ATTR(x) NULL
>  #define CXL_REGION_TYPE(x) NULL
>  #define SET_CXL_REGION_ATTR(x)
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 58b31fa47b93..9e33a0976828 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -870,6 +870,53 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_validate_extent(struct cxl_memdev_state *mds,
> +			       struct cxl_dc_extent *dc_extent)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	uint64_t start, len;
u64


> +
> +	start = le64_to_cpu(dc_extent->start_dpa);
> +	len = le64_to_cpu(dc_extent->length);
> +
> +	/* Extents must not cross region boundary's */
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		if (dcr->base <= start &&
> +		    (start + len) <= (dcr->base + dcr->decode_len)) {

Can range_contains() be used here as well?

> +			dev_dbg(dev, "DC extent DPA %#llx - %#llx (DCR:%d:%#llx)\n",
> +				start, start + len - 1, i, start - dcr->base);
> +			return 0;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %#llx - %#llx is not in any DC region\n",
> +			    start, start + len - 1);
> +	return -EINVAL;
> +}
> +
> +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,

cxl_dc_extent_in_endpoint_decoder() is more readable

> +				struct cxl_dc_extent *extent)
> +{
> +	uint64_t start = le64_to_cpu(extent->start_dpa);
> +	uint64_t length = le64_to_cpu(extent->length);
u64


> +	struct range ext_range = (struct range){
> +		.start = start,
> +		.end = start + length - 1,
> +	};
> +	struct range ed_range = (struct range) {
> +		.start = cxled->dpa_res->start,
> +		.end = cxled->dpa_res->end,
> +	};
> +
> +	dev_dbg(&cxled->cxld.dev, "Checking ED (%pr) for extent DPA:%#llx LEN:%#llx\n",
> +		cxled->dpa_res, start, length);
> +
> +	return range_contains(&ed_range, &ext_range);
> +}
> +
>  void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -973,6 +1020,15 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static struct cxl_memdev_state *
> +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}
> +
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -1406,6 +1462,142 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,

cxl_dev_get_dc_extent_generation()? or spell out count

DJ

> +				     unsigned int *extent_gen_num)
> +{
> +	struct cxl_mbox_get_dc_extent_in get_dc_extent;
> +	struct cxl_mbox_get_dc_extent_out dc_extents;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	unsigned int count;
> +	int rc;
> +
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> +		.extent_cnt = cpu_to_le32(0),
> +		.start_extent_index = cpu_to_le32(0),
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = sizeof(dc_extents),
> +		.payload_out = &dc_extents,
> +		.min_out = 1,
> +	};
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> +
> +	return count;
> +}
> +
> +static int cxl_dev_get_dc_extents(struct cxl_endpoint_decoder *cxled,
> +				  unsigned int start_gen_num,
> +				  unsigned int exp_cnt)
> +{
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	unsigned int start_index, total_read;
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	struct cxl_mbox_get_dc_extent_out *dc_extents __free(kfree) =
> +				kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc_extents)
> +		return -ENOMEM;
> +
> +	total_read = 0;
> +	start_index = 0;
> +	do {
> +		unsigned int nr_ext, total_extent_cnt, gen_num;
> +		struct cxl_mbox_get_dc_extent_in get_dc_extent;
> +		int rc;
> +
> +		get_dc_extent = (struct cxl_mbox_get_dc_extent_in) {
> +			.extent_cnt = cpu_to_le32(exp_cnt - start_index),
> +			.start_extent_index = cpu_to_le32(start_index),
> +		};
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +			.payload_in = &get_dc_extent,
> +			.size_in = sizeof(get_dc_extent),
> +			.size_out = mds->payload_size,
> +			.payload_out = dc_extents,
> +			.min_out = 1,
> +		};
> +
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
> +		total_read += nr_ext;
> +		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +		gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +
> +		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> +			total_extent_cnt, gen_num);
> +
> +		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> +			dev_err(dev, "Possible incomplete extent list; gen %u != %u : cnt %u != %u\n",
> +				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> +			return -EIO;
> +		}
> +
> +		for (int i = 0; i < nr_ext ; i++) {
> +			dev_dbg(dev, "Processing extent %d/%d\n",
> +				start_index + i, exp_cnt);
> +			rc = cxl_validate_extent(mds, &dc_extents->extent[i]);
> +			if (rc)
> +				continue;
> +			if (!cxl_dc_extent_in_ed(cxled, &dc_extents->extent[i]))
> +				continue;
> +			rc = cxl_ed_add_one_extent(cxled, &dc_extents->extent[i]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		start_index += nr_ext;
> +	} while (exp_cnt > total_read);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_read_dc_extents() - Read any existing extents
> + * @cxled: Endpoint decoder which is part of a region
> + *
> + * Issue the Get Dynamic Capacity Extent List command to the device
> + * and add any existing extents found which belong to this decoder.
> + *
> + * Return: 0 if command was executed successfully, -ERRNO on error.
> + */
> +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	unsigned int extent_gen_num;
> +	int rc;
> +
> +	if (!cxl_dcd_supported(mds)) {
> +		dev_dbg(dev, "DCD unsupported\n");
> +		return 0;
> +	}
> +
> +	rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> +	dev_dbg(mds->cxlds.dev, "Extent count: %d Generation Num: %d\n",
> +		rc, extent_gen_num);
> +	if (rc <= 0) /* 0 == no records found */
> +		return rc;
> +
> +	return cxl_dev_get_dc_extents(cxled, extent_gen_num, rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_read_dc_extents, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0d7b09a49dcf..3e563ab29afe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1450,6 +1450,13 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +/* Callers are expected to ensure cxled has been attached to a region */
> +int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +			  struct cxl_dc_extent *dc_extent)
> +{
> +	return 0;
> +}
> +
>  static int cxl_region_attach_position(struct cxl_region *cxlr,
>  				      struct cxl_root_decoder *cxlrd,
>  				      struct cxl_endpoint_decoder *cxled,
> @@ -2773,6 +2780,22 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_read_extents(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		int rc;
> +
> +		rc = cxl_read_dc_extents(p->targets[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> @@ -2807,6 +2830,12 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> +	if (cxlr->mode == CXL_REGION_DC) {
> +		rc = cxl_region_read_extents(cxlr);
> +		if (rc)
> +			goto err;
> +	}
> +
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>  					cxlr_dax);
>  err:
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 01bee6eedff3..8f2d8944d334 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -604,6 +604,54 @@ enum cxl_opcode {
>  	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
>  		  0x40, 0x3d, 0x86)
>  
> +/*
> + * Add Dynamic Capacity Response
> + * CXL rev 3.1 section 8.2.9.9.9.3; Table 8-168 & Table 8-169
> + */
> +struct cxl_mbox_dc_response {
> +	__le32 extent_list_size;
> +	u8 flags;
> +	u8 reserved[3];
> +	struct updated_extent_list {
> +		__le64 dpa_start;
> +		__le64 length;
> +		u8 reserved[8];
> +	} __packed extent_list[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
> + */
> +#define CXL_DC_EXTENT_TAG_LEN 0x10
> +struct cxl_dc_extent {
> +	__le64 start_dpa;
> +	__le64 length;
> +	u8 tag[CXL_DC_EXTENT_TAG_LEN];
> +	__le16 shared_extn_seq;
> +	u8 reserved[6];
> +} __packed;
> +
> +/*
> + * Get Dynamic Capacity Extent List; Input Payload
> + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
> + */
> +struct cxl_mbox_get_dc_extent_in {
> +	__le32 extent_cnt;
> +	__le32 start_extent_index;
> +} __packed;
> +
> +/*
> + * Get Dynamic Capacity Extent List; Output Payload
> + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
> + */
> +struct cxl_mbox_get_dc_extent_out {
> +	__le32 ret_extent_cnt;
> +	__le32 total_extent_cnt;
> +	__le32 extent_list_num;
> +	u8 rsvd[4];
> +	struct cxl_dc_extent extent[];
> +} __packed;
> +
>  struct cxl_mbox_get_supported_logs {
>  	__le16 entries;
>  	u8 rsvd[6];
> @@ -879,6 +927,7 @@ int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
> +int cxl_read_dc_extents(struct cxl_endpoint_decoder *cxled);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> 

