Return-Path: <linux-btrfs+bounces-3675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E088ED0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEA9B24817
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5D152519;
	Wed, 27 Mar 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUzCy8V7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81930152198;
	Wed, 27 Mar 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561555; cv=none; b=bhWEgRIr3ciaC+X0onAdWP2QX7shBHpNCPB1E+R2+TwtX9fzIaYdlJWzOh2TcXFxH0ubb6YkLAnEFQUpKZRJ7WVBmCeU2kpODvfedReGtjYgB0KJgdXDFHzD6C+X8nW1zpaX65Mil6he5NzfX/4KNtOG4t99gv5IG4isWQEOxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561555; c=relaxed/simple;
	bh=PyM4tBeIlBZcFszC/mwoJM/zBCbQAhbrAosabqlntkA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOPrcUJyeiLSCzLOZYVVH4VvMSFpMht780bWEUTAYdlD2JR3kB48siXArLdvfUMIMntpCFDR74ShvvbPv69dgSSrTbWJ9Md3NqyxbZJWeaJWbksoa8kTXmaLvF1C9ZIdkLCX3B45H0itKPx2XU+29KZwwmIw1x4D6Oux1zbeR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUzCy8V7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c0098328so97155b3a.3;
        Wed, 27 Mar 2024 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711561553; x=1712166353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6r931QHjCHn5DkdRGStvnYt2CqY3FM3oMtWs+P/U4ls=;
        b=CUzCy8V7KnyXx/svOvUU5w2f+YoywvNHFxxxwTPUk0LVr3cFYCexTJmWYHCRT466L8
         RzRtOjM/13eqjK1I3GTZuBGzK1jGlZlFwMxuZazMoSMX9TLPrTkJkiezGRVMzSpG0xf2
         2Z8FVUJj6zZSHU7oGIe4dwpHLldinLIn4YmP4PbiBvShIzJmpuzufUpemhGyss+uGqlB
         G6/qX4yVw3CVTKgHKMMVeVxL0DP4NrnTKthE3U1ZSP02fu3gjuxfwtV3iFjExkBUH/qu
         /WrRI2yMDR3DMLA3v8c6FRxx587QmLiOj2Xq3ofoD3MNNZWy7N0wOo/zUFuEQb8XuMX3
         zO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711561553; x=1712166353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r931QHjCHn5DkdRGStvnYt2CqY3FM3oMtWs+P/U4ls=;
        b=qMY8Hk2c4KlGlWMw4XbBCkOTztPhxY+ASAIHAnpYOVwqMscQbn4xgKlUIDjc6Rhnft
         xBOzqJo0oRATGORdc/RlCggszMWFzh2efnl/Lr+c8joaf8OoPTILgFOHfQoJkW18G/wR
         kVL7Op2ZNW9ZTy+/5YV3Jg/MaZM7DJVXYIaKGI1OINa+spPlTpmpEsawgdVtzwIeNFwc
         cQJG6BbqQaqVXQ3oXgGZ9fY3j+iNRCj+gRRhlX0iMqQSlyMeS/9iDBwO4JXKxqL5YEyo
         kCrg+E+WF+/du17vPLXeUy+v5c5i60yi8pJvggwQcPhqdN33wIChYNMHNFnKJQ6TNFh/
         Hk/A==
X-Forwarded-Encrypted: i=1; AJvYcCW3iorVXncK1x6Fejry55Nxr46sGh3HnUgIl1FPJCavb749xJz0ZMj7Pvd0jHv7vF+IWtfHfPAx9VrTq5gqLU/voxuHnKdIu/WqcaHoJZsL2gtD+1MFib5V2ncRSL+h1YO9FrVWYuLn4UHwQ1Tl74k88F65VEWXwZlvOP6HdbeYy3rT2dQ=
X-Gm-Message-State: AOJu0YyOw0FZG5j11SvadqihdGpSsvnYB8XqGZrNRrUo5YzXte9xUpIS
	wkYedfpzRB3c+SCVk0GGY6mHbJG9DqEB3cLA6iVjReSnLk7deC/k
X-Google-Smtp-Source: AGHT+IHSVULoZGU4CfYEA6Wm42sbMT5XQvnrHmQhucXgMrc8+Fa/zySqlJSv4wn2CQaayOWxpD4BEQ==
X-Received: by 2002:a05:6a00:4b16:b0:6e6:8b59:1bad with SMTP id kq22-20020a056a004b1600b006e68b591badmr550591pfb.25.1711561552588;
        Wed, 27 Mar 2024 10:45:52 -0700 (PDT)
Received: from debian ([2601:641:300:14de:303a:e988:70bc:e778])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b006ea9108ec12sm8040187pff.115.2024.03.27.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:45:52 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 27 Mar 2024 10:45:49 -0700
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
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <ZgRbTfmoU3HZPfrf@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:17PM -0700, ira.weiny@intel.com wrote:
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
> +				struct cxl_dc_extent *extent)
> +{
> +	uint64_t start = le64_to_cpu(extent->start_dpa);
> +	uint64_t length = le64_to_cpu(extent->length);
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

Not sure about the behaviour here. From the cxl_dev_get_dc_extents
implementation below, if gen_num changed or the expected extent count
changed, it will return error. 
If I understand it correctly, if the above two values change, it means
the extent list has been updated due to extent add/release since last
time we read the extent list info (cxl_dev_get_dc_extent_cnt), do we
need to fail the operation or try again?

Fan

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
> -- 
> 2.44.0
> 

