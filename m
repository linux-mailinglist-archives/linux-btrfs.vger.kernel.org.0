Return-Path: <linux-btrfs+bounces-3920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BAB898BC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FCC1C22851
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472312C819;
	Thu,  4 Apr 2024 16:04:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13B12AAD1;
	Thu,  4 Apr 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246676; cv=none; b=DfOfgJkHkSbdGbSy683EtkeLUF1mYt9AFEneRnLuh70oyiUuC1CUXJdI+MMP6BxHgDhJrAFt+QfxfKUUGX7A8f7fzZsihPnoB5RJQJzzs2P9NinPWdGO5E3GH9Oe9fsBN50uYN50rUcMxOKZuxk/Nwo6dUcqJWacWBfY2UsKhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246676; c=relaxed/simple;
	bh=0LQNpNf3RQ8YeS3e0cvnSiYysJO91XApeqbIUrs+VtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGitsJfh+FJlGtRTRK4e7I5UFVc6Yk4YfFEMUE1I8iqiJdzjuxhzQw6pRtwxwMKCTDbC9uprmRTjRXFuLQo4qYbEfHryPcAY7d0TPwuRt2Q7QDP9PNXwtSyedTZQAwMx61AB+zxhMnQwiYyL2OHKmuMSmdJnpy1Hx0Ublo4Q6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9RC31XFxz6K6j4;
	Thu,  4 Apr 2024 23:59:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A06D1400D4;
	Fri,  5 Apr 2024 00:04:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 17:04:22 +0100
Date: Thu, 4 Apr 2024 17:04:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] cxl/region: Read existing extents on region
 creation
Message-ID: <20240404170421.0000440f@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-14-b7b00d623625@intel.com>
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

On Sun, 24 Mar 2024 16:18:17 -0700
ira.weiny@intel.com wrote:

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

A few things inline.

J
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

Why 1?

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

Why 1?

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

A blank line here

> +			if (!cxl_dc_extent_in_ed(cxled, &dc_extents->extent[i]))
> +				continue;
and here would make this more readable I think.

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

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0d7b09a49dcf..3e563ab29afe 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

>  
> +static int cxl_region_read_extents(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		int rc;
Maybe worth giving up early if we see nr_targets > 1?

If nothing else it saves people trying to figure out what happens if we
reboot into an older kernel that doesn't support interleave (from one
that does)

> +
> +		rc = cxl_read_dc_extents(p->targets[i]);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 01bee6eedff3..8f2d8944d334 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

> +/*
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51

Throw a table name or section name into the reference so people
can find it in CXL rNext.

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
> + * Get Dynamic Capacity Extent List; Output Payload
> + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
> + */
> +struct cxl_mbox_get_dc_extent_out {
> +	__le32 ret_extent_cnt;
> +	__le32 total_extent_cnt;
> +	__le32 extent_list_num;

Naming isn't that clear given generation bit missing.

> +	u8 rsvd[4];
> +	struct cxl_dc_extent extent[];
> +} __packed;
> +


