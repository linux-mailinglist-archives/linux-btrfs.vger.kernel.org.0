Return-Path: <linux-btrfs+bounces-7329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC18957A53
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 02:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CBA2838A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CE4689;
	Tue, 20 Aug 2024 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irvS5suq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677C17FE;
	Tue, 20 Aug 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112370; cv=none; b=HDGo+rm+H9XxfykRedsuVl97wY0rNkRTuzO7VIEYqmZcRm0qBwU0XEE+BLWmVVDDWT05m2Q0WMuf2YG7Agv6vXjfMj/5V4Gi+x7nPMZ+7ez1JIAgYFJ7Eg+IqWjyw2aHeu8d/taOpO8w5cBXrKLDtJHW2cIufSFHDjk4PVNuhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112370; c=relaxed/simple;
	bh=ae2jZYFsL79DtzaGkyiLmOrjE8FIgYCcbAJr/nhRgPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPiIHEfMrL0rW5w1aY68hb1GKmd0RADgYTN+O48zRxlKqjZNcNxdqFv9COXtdyXikEkifALGS2qaI+XTJj7BoWP80xqKScJwazI1OPJY54M4cOLZLVtFMadoY40M4LWlSx4CO5vF9G2eN35U6M6kcijjvmryh+LvdAOODu0By+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irvS5suq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724112369; x=1755648369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ae2jZYFsL79DtzaGkyiLmOrjE8FIgYCcbAJr/nhRgPo=;
  b=irvS5suq3RHll3kEIOtSOu+Ec8F9Iq83ilR5U+T324tqUGpLtG2X8HTN
   wPnmXy53KUy+N7H4Pa4L3ItdSkZ69TxdGuTr7jUBKUdjZxGKh+Zs4Z8J+
   c0KDVRjJCFOcH2bt/S3DTDxuTrbJ1GaryXe+6FHwWcMy6EePSc21XGqOE
   ZSsytqU0U21L8H4vLEPz0krmNcVMc66FtnmXZuOI7v8tBnyWjjjBFA+C2
   QqXDCHxgaTPEaxfzdvyBPQuMjNjKjcmcJc0x6l19KBiiJS9ivBt6tuiJW
   UrUYeroplAHBmF02fLJkqBmCyUA7UiPtdO83xQntSntccKuF61FGTAYQR
   Q==;
X-CSE-ConnectionGUID: Uqg13Cy6S5qU4mP6RSXTYQ==
X-CSE-MsgGUID: ZETEGOFkQaqEyTLzAR5yVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22269559"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22269559"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:06:08 -0700
X-CSE-ConnectionGUID: VaBMIX2LT0qE3c7ZyJTKHQ==
X-CSE-MsgGUID: xkIOu7HIR9208mV1q8CTaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="65354662"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.111.235]) ([10.125.111.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:06:06 -0700
Message-ID: <2e753a02-fc62-4b11-8a4c-e23ab1824d44@intel.com>
Date: Mon, 19 Aug 2024 17:06:05 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/25] cxl/region: Read existing extents on region
 creation
To: ira.weiny@intel.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-22-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Dynamic capacity device extents may be left in an accepted state on a
> device due to an unexpected host crash.  In this case it is expected
> that the creation of a new region on top of a DC partition can read
> those extents and surface them for continued use.
> 
> Once all endpoint decoders are part of a region and the region is being
> realized a read of the devices extent list can reveal these previously
> accepted extents.

Once all endpoint decoders are part of a region and the region is being
realized, a read of the 'devices extend list' can reveal these previously
accepted extents.

> 
> CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
> this purpose.  The call returns all the extents for all dynamic capacity
> partitions.  If the fabric manager is adding extents to any DCD
> partition, the extent list for the recovered region may change.  In this
> case the query must retry.  Upon retry the query could encounter extents
> which were accepted on a previous list query.  Adding such extents is
> ignored without error because they are entirely within a previous
> accepted extent.
> 
> The scan for existing extents races with the dax_cxl driver.  This is
> synchronized through the region device lock.  Extents which are found
> after the driver has loaded will surface through the normal notification
> path while extents seen prior to the driver are read during driver load.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [iweiny: Leverage the new add path from the event processing code such
> 	 that the adding and surfacing of extents flows through the same
> 	 code path for both event processing and existing extents.
> 	 While this does validate existing extents again on start up
> 	 this is an error recovery case / new boot scenario and should
> 	 not cause any major issues while making the code more
> 	 straight forward and maintainable.]
> 
> [iweiny: use %par]
> [iweiny: rebase]
> [iweiny: Move this patch later in the series such that the realization
>          of extents can go through the same path as an add event]
> [Fan: Issue a retry if the gen number changes]
> [djiang: s/uint64_t/u64/]
> [djiang: update function names]
> [Jørgen/djbw: read the generation and total count on first iteration of
>               the Get Extent List call]
> [djbw: s/cxl_mbox_get_dc_extent_in/cxl_mbox_get_extent_in/]
> [djbw: s/cxl_mbox_get_dc_extent_out/cxl_mbox_get_extent_out/]
> [djbw/iweiny: s/cxl_read_dc_extents/cxl_read_extent_list]
> ---
>  drivers/cxl/core/core.h   |   2 +
>  drivers/cxl/core/mbox.c   | 100 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |  12 ++++++
>  drivers/cxl/cxlmem.h      |  21 ++++++++++
>  4 files changed, 135 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 8dfc97b2e0a4..9e54064a6f48 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -21,6 +21,8 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
>  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>  }
>  
> +void cxl_read_extent_list(struct cxl_endpoint_decoder *cxled);
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f629ad7488ac..d43ac8eabf56 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1670,6 +1670,106 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +/* Return -EAGAIN if the extent list changes while reading */
> +static int __cxl_read_extent_list(struct cxl_endpoint_decoder *cxled)
> +{
> +	u32 current_index, total_read, total_expected, initial_gen_num;
> +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u32 max_extent_count;
> +	bool first = true;
> +
> +	struct cxl_mbox_get_extent_out *extents __free(kfree) =
> +				kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!extents)
> +		return -ENOMEM;
> +
> +	total_read = 0;
> +	current_index = 0;
> +	total_expected = 0;
> +	max_extent_count = (mds->payload_size - sizeof(*extents)) /
> +				sizeof(struct cxl_extent);
> +	do {
> +		struct cxl_mbox_get_extent_in get_extent;
> +		u32 nr_returned, current_total, current_gen_num;
> +		int rc;
> +
> +		get_extent = (struct cxl_mbox_get_extent_in) {
> +			.extent_cnt = max(max_extent_count,
> +					  total_expected - current_index),
> +			.start_extent_index = cpu_to_le32(current_index),
> +		};
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +			.payload_in = &get_extent,
> +			.size_in = sizeof(get_extent),
> +			.size_out = mds->payload_size,
> +			.payload_out = extents,
> +			.min_out = 1,
> +		};
> +
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		/* Save initial data */
> +		if (first) {
> +			total_expected = le32_to_cpu(extents->total_extent_count);
> +			initial_gen_num = le32_to_cpu(extents->generation_num);
> +			first = false;
> +		}
> +
> +		nr_returned = le32_to_cpu(extents->returned_extent_count);
> +		total_read += nr_returned;
> +		current_total = le32_to_cpu(extents->total_extent_count);
> +		current_gen_num = le32_to_cpu(extents->generation_num);
> +
> +		dev_dbg(dev, "Got extent list %d-%d of %d generation Num:%d\n",
> +			current_index, total_read - 1, current_total, current_gen_num);
> +
> +		if (current_gen_num != initial_gen_num || total_expected != current_total) {
> +			dev_dbg(dev, "Extent list change detected; gen %u != %u : cnt %u != %u\n",
> +				current_gen_num, initial_gen_num,
> +				total_expected, current_total);
> +			return -EAGAIN;
> +		}
> +
> +		for (int i = 0; i < nr_returned ; i++) {
> +			struct cxl_extent *extent = &extents->extent[i];
> +
> +			dev_dbg(dev, "Processing extent %d/%d\n",
> +				current_index + i, total_expected);
> +
> +			rc = validate_add_extent(mds, extent);
> +			if (rc)
> +				continue;
> +		}
> +
> +		current_index += nr_returned;
> +	} while (total_expected > total_read);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_read_extent_list() - Read existing extents
> + * @cxled: Endpoint decoder which is part of a region
> + *
> + * Issue the Get Dynamic Capacity Extent List command to the device
> + * and add existing extents if found.
> + */
> +void cxl_read_extent_list(struct cxl_endpoint_decoder *cxled)

cxl_process_extend_list()? It seems to do read+validate+add. 

> +{
> +	int retry = 10;

arbitrary retry number? maybe define it?

DJ

> +	int rc;
> +
> +	do {
> +		rc = __cxl_read_extent_list(cxled);
> +	} while (rc == -EAGAIN && retry--);
> +}
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8c9171f914fb..885fb3004784 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3190,6 +3190,15 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static void cxlr_add_existing_extents(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = 0; i < p->nr_targets; i++)
> +		cxl_read_extent_list(p->targets[i]);
> +}
> +
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> @@ -3227,6 +3236,9 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>  		dev_name(dev));
>  
> +	if (cxlr->mode == CXL_REGION_DC)
> +		cxlr_add_existing_extents(cxlr);
> +
>  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
>  					cxlr_dax);
>  err:
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3a40fe1f0be7..11c03637488d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -624,6 +624,27 @@ struct cxl_mbox_dc_response {
>  	} __packed extent_list[];
>  } __packed;
>  
> +/*
> + * Get Dynamic Capacity Extent List; Input Payload
> + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
> + */
> +struct cxl_mbox_get_extent_in {
> +	__le32 extent_cnt;
> +	__le32 start_extent_index;
> +} __packed;
> +
> +/*
> + * Get Dynamic Capacity Extent List; Output Payload
> + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
> + */
> +struct cxl_mbox_get_extent_out {
> +	__le32 returned_extent_count;
> +	__le32 total_extent_count;
> +	__le32 generation_num;
> +	u8 rsvd[4];
> +	struct cxl_extent extent[];
> +} __packed;
> +
>  struct cxl_mbox_get_supported_logs {
>  	__le16 entries;
>  	u8 rsvd[6];
> 

