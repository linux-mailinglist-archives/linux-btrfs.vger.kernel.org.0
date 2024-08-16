Return-Path: <linux-btrfs+bounces-7287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D68F9552A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EB728408A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D51C57B5;
	Fri, 16 Aug 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2AEspeS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5658ABC;
	Fri, 16 Aug 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844753; cv=none; b=OE15KwGf0vi+oYZo/WTml767sV8QvZTGP4j58JgPP0VL1agkKykJB8VIG7lpQS7A6n7G1EodXheuJhMMV053+VffTaUejX2ceFQyb6hPb4dtYL63xQyDfoCfNpKKRjjLhEDIL8cWORy3xsZ+A3nAKcgh7LgvYR5b00SybAAhlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844753; c=relaxed/simple;
	bh=eulYYu/Wi1QcAJonTbbkmz+noeuMiHInLrH+jRMS2Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOsKs4u/gv5tSBN48T/nNkdyA8ICvMOpIAt3L0Uly+CNuzzNucGKayNh0iu9athF/EzawICzWt9lquRbJadxMWQnEhBSOu878MIgf+x5G2pfH7To6pwgaEpo9mQLJhMoTmmlRCfU2GhPLxdmGfdYyFCzdXkIXMIn8d9PNdx/cHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2AEspeS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844751; x=1755380751;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eulYYu/Wi1QcAJonTbbkmz+noeuMiHInLrH+jRMS2Ko=;
  b=k2AEspeStJFIiTEC91/eeZ8PozMMZz9bgVxat9AboPNYj1MjPYuLIvS9
   IkwVagrd4f7FAjBgnjTwg8Yp1BMxEX3VsllkgfeTpBX6QJF+8tLaPmrie
   dihfdh7ahjhDBh0M5eI8uC5/x1v72Wq80tAr4zcaKamg05313urDfrn45
   RC3QxTkkKdgJqyKiQEElE6usfhKYGbxWmdtKP7yrjsZpzRnyFNbGTf0so
   NEXCmimc155YlVQpPqLGCIqEEnrpWiHQcuXckRhDeCnk/qIWpQtSGthFx
   77xzJ39LzRNWrKcPPA/n8RO0FD0wl3KuQ90kwpGGP0cv1s9RyNO6xRDgA
   Q==;
X-CSE-ConnectionGUID: 2z9gfuiAR366FuYMan32yA==
X-CSE-MsgGUID: jcdklCwhQdu3bVnXZ7z7YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="13062067"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="13062067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:45:50 -0700
X-CSE-ConnectionGUID: lUXkx+GQS+W8tfzsGOogsg==
X-CSE-MsgGUID: T6VcFqVYQOGKzh6qR+u+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="82996139"
Received: from unknown (HELO [10.125.111.71]) ([10.125.111.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:45:48 -0700
Message-ID: <1ce9afe3-6f24-4471-8a10-5f4ea503e685@intel.com>
Date: Fri, 16 Aug 2024 14:45:47 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/25] cxl/mem: Read dynamic capacity configuration
 from the device
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
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
 "Li, Ming" <ming4.li@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-6-7c9b96cba6d7@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-6-7c9b96cba6d7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/16/24 7:44 AM, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Devices which optionally support Dynamic Capacity (DC) are configured
> via mailbox commands.  CXL 3.1 requires the host to issue the Get DC
> Configuration command in order to properly configure DCDs.  Without the
> Get DC Configuration command DCD can't be supported.
> 
> Implement the DC mailbox commands as specified in CXL 3.1 section
> 8.2.9.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information.  Disable DCD if DCD is not supported.  Leverage the Get DC
> Configuration command supported bit to indicate if DCD support.
> 
> Linux has no use for the trailing fields of the Get Dynamic Capacity
> Configuration Output Payload (Total number of supported extents, number
> of available extents, total number of supported tags, and number of
> available tags).  Avoid defining those fields to use the more useful
> dynamic C array.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [Li, Ming: Fix bug in total_bytes calculation]
> [iweiny: update commit message]
> [Jonathan: fix formatting]
> [Jonathan: Define block line size]
> [Jonathan/Fan: use regions returned field instead of macro in get config]
> [Jørgen: Rename memdev state range variables]
> [Jonathan: adjust use of rc in cxl_dev_dynamic_capacity_identify()]
> [Jonathan: white space cleanup]
> [fan: make a comment about the trailing configuration output fields]
> ---
>  drivers/cxl/core/mbox.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h    |  64 +++++++++++++++++-
>  drivers/cxl/pci.c       |   4 ++
>  3 files changed, 237 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8eb196858abe..68c26c4be91a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1157,7 +1157,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  	if (rc < 0)
>  		return rc;
>  
> -	mds->total_bytes =
> +	mds->static_bytes =
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>  	mds->volatile_only_bytes =
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1264,6 +1264,159 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return rc;
>  }
>  
> +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, u8 index,
> +				   struct cxl_dc_region_config *region_config)
> +{
> +	struct cxl_dc_region_info *dcr = &mds->dc_region[index];
> +	struct device *dev = mds->cxlds.dev;
> +
> +	dcr->base = le64_to_cpu(region_config->region_base);
> +	dcr->decode_len = le64_to_cpu(region_config->region_decode_length);
> +	dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> +	dcr->len = le64_to_cpu(region_config->region_length);
> +	dcr->blk_size = le64_to_cpu(region_config->region_block_size);
> +	dcr->dsmad_handle = le32_to_cpu(region_config->region_dsmad_handle);
> +	dcr->flags = region_config->flags;
> +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> +
> +	/* Check regions are in increasing DPA order */
> +	if (index > 0) {
> +		struct cxl_dc_region_info *prev_dcr = &mds->dc_region[index - 1];
> +
> +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> +			dev_err(dev,
> +				"DPA ordering violation for DC region %d and %d\n",
> +				index - 1, index);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!IS_ALIGNED(dcr->base, SZ_256M) ||
> +	    !IS_ALIGNED(dcr->base, dcr->blk_size)) {
> +		dev_err(dev, "DC region %d invalid base %#llx blk size %#llx\n",
> +			index, dcr->base, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (dcr->decode_len == 0 || dcr->len == 0 || dcr->decode_len < dcr->len ||
> +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +		dev_err(dev, "DC region %d invalid length; decode %#llx len %#llx blk size %#llx\n",
> +			index, dcr->decode_len, dcr->len, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (dcr->blk_size == 0 || dcr->blk_size % CXL_DCD_BLOCK_LINE_SIZE ||
> +	    !is_power_of_2(dcr->blk_size)) {
> +		dev_err(dev, "DC region %d invalid block size; %#llx\n",
> +			index, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev,
> +		"DC region %s base %#llx length %#llx block size %#llx\n",
> +		dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of regions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.region_count = CXL_MAX_DC_REGION,
> +		.start_region_index = start_region,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		.min_out = 1,
> +	};
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	dev_dbg(dev, "Read %d/%d DC regions\n",
> +		dc_resp->regions_returned, dc_resp->avail_region_count);
> +	return dc_resp->regions_returned;
> +}
> +
> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + *					 information from the device.
> + * @mds: The memory device state
> + *
> + * Read Dynamic Capacity information from the device and populate the state
> + * structures for later use.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	size_t dc_resp_size = mds->payload_size;
> +	struct device *dev = mds->cxlds.dev;
> +	u8 start_region, i;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> +
> +	if (!cxl_dcd_supported(mds)) {
> +		dev_dbg(dev, "DCD not supported\n");
> +		return 0;
> +	}

This should happen before you pre-format the name string? I would assume that if DCD is not supported then the dcd name sysfs attribs would be not be visible?

> +
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> +					kvmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_region = 0;
> +	do {
> +		int rc, j;
> +
> +		rc = cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
> +		if (rc < 0) {
> +			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
> +			return rc;
> +		}
> +
> +		mds->nr_dc_region += rc;
> +
> +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +				mds->nr_dc_region);
> +			return -EINVAL;
> +		}
> +
> +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {

This should be 'j < mds->nr_dc_region'? Otherwise if your start region say is '3' and you have '2' DC regions, you never enter the loop. Or does that not happen? I also wonder if you need to check if 'start_region + mds->nr_dc_region > CXL_MAX_DC_REGION'.

> +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> +			if (rc) {
> +				dev_dbg(dev, "Failed to save region info: %d\n", rc);
> +				return rc;
> +			}
> +		}
> +
> +		start_region = mds->nr_dc_region;
> +
> +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> +
> +	mds->dynamic_bytes =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic range: %#llx\n", mds->dynamic_bytes);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> @@ -1294,8 +1447,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = cxlds->dev;
> +	size_t untenanted_mem;
>  	int rc;
>  
> +	mds->total_bytes = mds->static_bytes;
> +	if (mds->nr_dc_region) {
> +		untenanted_mem = mds->dc_region[0].base - mds->static_bytes;
> +		mds->total_bytes += untenanted_mem + mds->dynamic_bytes;
> +	}
> +
>  	if (!cxlds->media_ready) {
>  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>  		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> @@ -1305,6 +1465,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  
>  	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>  
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (mds->partition_align_bytes == 0) {
>  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
>  				 mds->volatile_only_bytes, "ram");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f2f8b567e0e7..b4eb8164d05d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -402,6 +402,7 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> +#define CXL_MAX_DC_REGION 8
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> @@ -431,6 +432,8 @@ struct cxl_dpa_perf {
>   * @dpa_res: Overall DPA resource tree for the device
>   * @pmem_res: Active Persistent memory capacity configuration
>   * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> + *          region
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   */
> @@ -445,10 +448,22 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct resource pmem_res;
>  	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>  	u64 serial;
>  	enum cxl_devtype type;
>  };
>  
> +#define CXL_DC_REGION_STRLEN > +struct cxl_dc_region_info {
> +	u64 base;
> +	u64 decode_len;
> +	u64 len;
> +	u64 blk_size;
> +	u32 dsmad_handle;
> +	u8 flags;
> +	u8 name[CXL_DC_REGION_STRLEN];
> +};

Does this need kdoc comments?


> +
>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>   *
> @@ -466,7 +481,9 @@ struct cxl_dev_state {
>   * @dcd_cmds: List of DCD commands implemented by memory device
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> - * @total_bytes: sum of all possible capacities
> + * @total_bytes: length of all possible capacities
> + * @static_bytes: length of possible static RAM and PMEM partitions
> + * @dynamic_bytes: length of possible DC partitions (DC Regions)

Did this get added to the wrong struct comment header? 'cxl_dev_state' instead of 'cxl_memdev_state'?
>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
>   * @partition_align_bytes: alignment size for partition-able capacity
> @@ -476,6 +493,8 @@ struct cxl_dev_state {
>   * @next_persistent_bytes: persistent capacity change pending device reset
>   * @ram_perf: performance data entry matched to RAM partition
>   * @pmem_perf: performance data entry matched to PMEM partition
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
Did this get added to the wrong struct comment header? 'cxl_dev_state' instead of 'cxl_memdev_state'?

DJ

>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -496,6 +515,8 @@ struct cxl_memdev_state {
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	u64 total_bytes;
> +	u64 static_bytes;
> +	u64 dynamic_bytes;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -507,6 +528,9 @@ struct cxl_memdev_state {
>  	struct cxl_dpa_perf ram_perf;
>  	struct cxl_dpa_perf pmem_perf;
>  
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
> @@ -709,6 +733,32 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* See CXL 3.1 Table 8-163 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_region_count;
> +	u8 regions_returned;
> +	u8 rsvd[6];
> +	/* See CXL 3.1 Table 8-165 */
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +	/* Trailing fields unused */
> +} __packed;
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -832,6 +882,7 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> @@ -845,6 +896,17 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a60cd66263e..f7f03599bc83 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -874,6 +874,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		cxl_disable_dcd(mds);
> +
>  	rc = cxl_mem_create_range_info(mds);
>  	if (rc)
>  		return rc;
> 

