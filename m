Return-Path: <linux-btrfs+bounces-3576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4C88B562
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282791F61E91
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC09F839F3;
	Mon, 25 Mar 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFjIxhBH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BA81207;
	Mon, 25 Mar 2024 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409772; cv=none; b=cL/wun/eF60kP7wHMKqgoeQa1qu7CpLGxESTGtfre+j7TouSa83SNcOduigmMcicaJ3VN58pCfqFM7SZTVVMkqNvpNOLxL7S5MlYszlIlQX8WwgIjhYD6fxmP/zUWZkNRGgip6HxPIK9fO1koyqyEhJQAQ1AHDxSITu4S/fKR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409772; c=relaxed/simple;
	bh=uPUkNLV/u0Z4vl4d8BqSOQlPW0LXKX6Jfu+b/CoNIBw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohCKjDraDwy4+RxhxYOYvB3OpRTmi+wSFYzuF3EgXw+e14KRK9GqLRk4itzp5A6LPTo6sngpDC+dbl7d7WS2Znt0yxw2BIH/pE0q4RJQu9RD008lkPOiXOcJAiuocbX5TdxXS+Pc2sP3JJJzg0oOFedDoabUwq5r5/5HJ4zgniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFjIxhBH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso3165771b3a.3;
        Mon, 25 Mar 2024 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711409769; x=1712014569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvOhLHdolcZX7ooomi49K05KPQGgRORmmQyKQLnYsLk=;
        b=hFjIxhBH8lLVkjaRMo4vdnHZzoJLjXJXq8PLbl6zJJRFU+S16X1te9AEKDFmW/f4Jz
         6uwMmG+9gq1Nt5ArHsjOiOHsvoeIhac0nfe6Fkwgcxe6MSJiydduC465RZ7roEhKyCoK
         Y+cbUZ56jGUQCCBhoGmcWWmPHUtqFZkMfvDKAFkdNbFwZIKKQBZxLOGHPlEVz+sJbJIX
         KRY0EMz3HA016EviLpvyNXO97W+eGGLF3Xc0sYXs+uPtmS7Hs9yxLLfpD6q8KgvyhJM0
         Ad/44GzQ+JZdWBPabkW6dXlr5+Gvot8gmFMT+7LfjlOi9+GnN1t/g8FcOcS35FYrs1aj
         oDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711409769; x=1712014569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvOhLHdolcZX7ooomi49K05KPQGgRORmmQyKQLnYsLk=;
        b=Zn3qKh9pgyLazfQNpi9n2h6fIdHroxGuj7JWJgd73NaFEdFqQMEcWwcIZfkFg7gs6f
         4pSCZYdcCEzlNzdS/bzbC7KhVjV6aUMqHc/iIDL4uXCyFlFXd1NK9DMw40vGoezFhBkQ
         S3LnRXAyYCIOkRMD7PsvAcrdysfLyEjrAu38SxrXJoExAoABDigCFMxgFqikacXSWIZN
         aWGBx9FvcHxGvcBf9czlHBSt62Q3MjOZPtRuAPHSh7HJ72yolh8DYNL3hpFVLWHoVjyb
         4gNaq1jVY1WjuQui6RjhDCsS6SJ5NquM3txARcm2rVeQJERuRPe86Bu7z02on3yT7CZf
         sNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdK0udGO4D3ybpldv/jaNQ0nqw6oB165aiYJLEQeqXtgEMlgNNgneQQg01Lxs//3lKBhb1LIitP/jDN9k9Wt2e1LX3W0vJZwLjdXOKp31g10YVWA7twZArV0knerhZS3MokMQ/yeu369V1DLTGZDz7OF706e/sQ/ZJ+X0EJaoOKro9XMQ=
X-Gm-Message-State: AOJu0YzPmVdm9+W5Gflji1zqUS5M8ZcTa86bpczGOyHjbECy+HQQDnJI
	n0VCqjjtb8nFHAoihPFErHumge2ZlyTEYXKCac8wELgri3xEXQnPKxEnQJH5
X-Google-Smtp-Source: AGHT+IEuZh4fA8XI1E8RnkULHhwZe5STtqjfz1aDKTuvM/2CD67HlX0B/b+iRlh9g0h73z+xv1a6+w==
X-Received: by 2002:a05:6a00:2ea2:b0:6e6:270a:9303 with SMTP id fd34-20020a056a002ea200b006e6270a9303mr8274496pfb.32.1711409769393;
        Mon, 25 Mar 2024 16:36:09 -0700 (PDT)
Received: from debian ([2601:641:300:14de:dbc3:c81c:2ddb:208c])
        by smtp.gmail.com with ESMTPSA id k188-20020a6284c5000000b006e6b9a963a5sm4905837pfd.131.2024.03.25.16.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:36:09 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 25 Mar 2024 16:36:03 -0700
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
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Message-ID: <ZgIKY27PVnlGce_m@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:06PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Devices can optionally support Dynamic Capacity (DC).  These devices are
> known as Dynamic Capacity Devices (DCD).
> 
> Implement the DC mailbox commands as specified in CXL 3.1 section
> 8.2.9.9.9 (opcodes 48XXh).  Read the DC configuration and store the DC
> region information in the device state.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v1
> [Jørgen: ensure CXL 2.0 device support by removing dc_event_log_size]
> [iweiny/Jørgen: use get DC config command to signal DCD support]
> [djiang: fix subject]
> [Fan: add additional region configuration checks]
> [Jonathan/djiang: split out region mode changes]
> [Jonathan: fix up comments/kdoc]
> [Jonathan: s/cxl_get_dc_id/cxl_get_dc_config/]
> [Jonathan: use __free() in identify call]
> [Jonathan: remove unneeded formatting changes]
> [Jonathan: s/cxl_mbox_dynamic_capacity/cxl_mbox_get_dc_config_out/]
> [Jonathan: s/cxl_mbox_get_dc_config/cxl_mbox_get_dc_config_in/]
> [iweiny: remove type2 work dependancy/rebase on master]
> [iweiny: fix 0day build issues]
> ---
>  drivers/cxl/core/mbox.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h    |  49 +++++++++++++
>  drivers/cxl/pci.c       |   4 ++
>  3 files changed, 236 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ed4131c6f50b..14e8a7528a8b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1123,7 +1123,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  	if (rc < 0)
>  		return rc;
>  
> -	mds->total_bytes =
> +	mds->static_cap =
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>  	mds->volatile_only_bytes =
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1230,6 +1230,175 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
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
> +		dev_err(dev, "DC region %d invalid base %#llx blk size %#llx\n", index,
> +			dcr->base, dcr->blk_size);
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
> +	if (dcr->blk_size == 0 || dcr->blk_size % 0x40 ||
> +	    !is_power_of_2(dcr->blk_size)) {
> +		dev_err(dev, "DC region %d invalid block size; %#llx\n",
> +			index, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev,
> +		"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
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
> +	rc = dc_resp->avail_region_count - start_region;
> +
> +	/*
> +	 * The number of regions in the payload may have been truncated due to
> +	 * payload_size limits; if so adjust the returned count to match.
> +	 */
> +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> +		rc = CXL_REGIONS_RETURNED(mbox_cmd.size_out);
> +
> +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count);
> +
> +	return rc;
> +}
> +
> +static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
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
> +	int rc = 0;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!cxl_dcd_supported(mds)) {
> +		dev_dbg(dev, "DCD not supported\n");
> +		return 0;
> +	}
> +
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> +					kvmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_region = 0;
> +	do {
> +		int j;
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
> +	mds->dynamic_cap =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> @@ -1260,8 +1429,12 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = cxlds->dev;
> +	size_t untenanted_mem;
>  	int rc;
>  
> +	untenanted_mem = mds->dc_region[0].base - mds->static_cap;
> +	mds->total_bytes = mds->static_cap + untenanted_mem + mds->dynamic_cap;
> +
>  	if (!cxlds->media_ready) {
>  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>  		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> @@ -1271,6 +1444,15 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
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
> index 79a67cff9143..4624cf612c1e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -402,6 +402,7 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> +#define CXL_MAX_DC_REGION 8
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range - range for DPA address
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
> +#define CXL_DC_REGION_STRLEN 8
> +struct cxl_dc_region_info {
> +	u64 base;
> +	u64 decode_len;
> +	u64 len;
> +	u64 blk_size;
> +	u32 dsmad_handle;
> +	u8 flags;
> +	u8 name[CXL_DC_REGION_STRLEN];
> +};
> +
>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>   *
> @@ -467,6 +482,8 @@ struct cxl_dev_state {
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
>   * @total_bytes: sum of all possible capacities
> + * @static_cap: Sum of static RAM and PMEM capacities
> + * @dynamic_cap: Complete DPA range occupied by DC regions
>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
>   * @partition_align_bytes: alignment size for partition-able capacity
> @@ -474,6 +491,8 @@ struct cxl_dev_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -494,7 +513,10 @@ struct cxl_memdev_state {
>  	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>  	u64 total_bytes;
> +	u64 static_cap;
> +	u64 dynamic_cap;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -506,6 +528,9 @@ struct cxl_memdev_state {
>  	struct cxl_dpa_perf ram_perf;
>  	struct cxl_dpa_perf pmem_perf;
>  
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
> @@ -705,6 +730,29 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_get_dc_config_in {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> +#define CXL_REGIONS_RETURNED(size_out) \
> +	((size_out - 8) / sizeof(struct cxl_dc_region_config))

Although the result may be unchanged, but in cxl spec r3.1, there are four
fields after the region configuration structure.

Fan

> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -828,6 +876,7 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..216881455364 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -874,6 +874,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_create_range_info(mds);
>  	if (rc)
>  		return rc;
> 
> -- 
> 2.44.0
> 

