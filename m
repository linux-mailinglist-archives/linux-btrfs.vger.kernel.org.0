Return-Path: <linux-btrfs+bounces-3558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480B88B2AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CED9B2C98A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311212D206;
	Mon, 25 Mar 2024 17:40:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8712D1E5;
	Mon, 25 Mar 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388411; cv=none; b=kKFNXHtC9bA5ZGPitEfpHFECGiTZ4B+jgZX/02KLQGw/75GpvE6651a7254+K5N790aA6xE+X+37xN0inSUopxNDx/EqsI4GQS/dIDscZFtV29oY9YgGcrrKnDUKyKv/43/kFm62AumHd3nznpm0jHO4Ty/qulkMuKgveBAuatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388411; c=relaxed/simple;
	bh=muWcDeeR+cvHVDewemOSirQT+6a2EHzRLYKO1kRBKWE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9uVNb1R/iSKsNE3oihrceqEz2HgZRgVigGDKbcqHJJ8cqoSctz7sdTAkgSY8PuMUwXYCmyr7aoNlVuUsHoKLLQzTv8u+2u99tupUZ3hbieR/U9nYJ7FqCwBBa5SliiAW7g7FVVnUOws0dYiiSPu/CbwqiRbaDzuCGdH1jF9kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3KtX0P3tz6K6Yd;
	Tue, 26 Mar 2024 01:39:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E71D1400DC;
	Tue, 26 Mar 2024 01:40:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 17:40:03 +0000
Date: Mon, 25 Mar 2024 17:40:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Message-ID: <20240325174002.00005dc6@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
	<20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 16:18:06 -0700
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
>=20
> Devices can optionally support Dynamic Capacity (DC).  These devices are
> known as Dynamic Capacity Devices (DCD).
>=20
> Implement the DC mailbox commands as specified in CXL 3.1 section
> 8.2.9.9.9 (opcodes 48XXh).  Read the DC configuration and store the DC
> region information in the device state.
>=20
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

A few minor things inline,

Jonathan

>=20
> ---
> Changes for v1
> [J=F8rgen: ensure CXL 2.0 device support by removing dc_event_log_size]
> [iweiny/J=F8rgen: use get DC config command to signal DCD support]
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
>  drivers/cxl/core/mbox.c | 184 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  drivers/cxl/cxlmem.h    |  49 +++++++++++++
>  drivers/cxl/pci.c       |   4 ++
>  3 files changed, 236 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ed4131c6f50b..14e8a7528a8b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1123,7 +1123,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state =
*mds)
>  	if (rc < 0)
>  		return rc;
> =20
> -	mds->total_bytes =3D
> +	mds->static_cap =3D
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>  	mds->volatile_only_bytes =3D
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1230,6 +1230,175 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u1=
6 cmd)
>  	return rc;
>  }
> =20
> +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, u8 inde=
x,
> +				   struct cxl_dc_region_config *region_config)
> +{
> +	struct cxl_dc_region_info *dcr =3D &mds->dc_region[index];
> +	struct device *dev =3D mds->cxlds.dev;
> +
> +	dcr->base =3D le64_to_cpu(region_config->region_base);
> +	dcr->decode_len =3D le64_to_cpu(region_config->region_decode_length);
> +	dcr->decode_len *=3D CXL_CAPACITY_MULTIPLIER;
> +	dcr->len =3D le64_to_cpu(region_config->region_length);
> +	dcr->blk_size =3D le64_to_cpu(region_config->region_block_size);
> +	dcr->dsmad_handle =3D le32_to_cpu(region_config->region_dsmad_handle);
> +	dcr->flags =3D region_config->flags;
> +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> +
> +	/* Check regions are in increasing DPA order */
> +	if (index > 0) {
> +		struct cxl_dc_region_info *prev_dcr =3D &mds->dc_region[index - 1];
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

Odd choice of line wrap.  I'd drag index onto the line below.

> +			dcr->base, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (dcr->decode_len =3D=3D 0 || dcr->len =3D=3D 0 || dcr->decode_len < =
dcr->len ||
> +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +		dev_err(dev, "DC region %d invalid length; decode %#llx len %#llx blk =
size %#llx\n",
> +			index, dcr->decode_len, dcr->len, dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	if (dcr->blk_size =3D=3D 0 || dcr->blk_size % 0x40 ||

Hmm. I thought we had a define for CXL 'cacheline' size, but can't find it =
now.
If not we should add one (and find a better name than that).

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
> +static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_regi=
on,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc =3D (struct cxl_mbox_get_dc_con=
fig_in) {
> +		.region_count =3D CXL_MAX_DC_REGION,
> +		.start_region_index =3D start_region,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd =3D (struct cxl_mbox_cmd) {
> +		.opcode =3D CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in =3D &get_dc,
> +		.size_in =3D sizeof(get_dc),
> +		.size_out =3D dc_resp_size,
> +		.payload_out =3D dc_resp,
> +		.min_out =3D 1,
> +	};
> +	struct device *dev =3D mds->cxlds.dev;
> +	int rc;
> +
> +	rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc =3D dc_resp->avail_region_count - start_region;
> +
> +	/*
> +	 * The number of regions in the payload may have been truncated due to
> +	 * payload_size limits; if so adjust the returned count to match.
> +	 */
> +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> +		rc =3D CXL_REGIONS_RETURNED(mbox_cmd.size_out);

Why not always return this?  If there was space, doesn't it equal
the value set above anyway?

> +
> +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count=
);
> +
> +	return rc;
> +}

> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + *					 information from the device.
> + * @mds: The memory device state
> + *
> + * Read Dynamic Capacity information from the device and populate the st=
ate
> + * structures for later use.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	size_t dc_resp_size =3D mds->payload_size;
> +	struct device *dev =3D mds->cxlds.dev;
> +	u8 start_region, i;
> +	int rc =3D 0;

Is this used before being set?

> +
> +	for (i =3D 0; i < CXL_MAX_DC_REGION; i++)
> +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!cxl_dcd_supported(mds)) {
> +		dev_dbg(dev, "DCD not supported\n");
> +		return 0;
> +	}
> +
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =3D
> +					kvmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_region =3D 0;
> +	do {
> +		int j;
> +
> +		rc =3D cxl_get_dc_config(mds, start_region, dc_resp, dc_resp_size);
> +		if (rc < 0) {
> +			dev_dbg(dev, "Failed to get DC config: %d\n", rc);
> +			return rc;
> +		}
> +
> +		mds->nr_dc_region +=3D rc;
> +
> +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +				mds->nr_dc_region);
> +			return -EINVAL;
> +		}
> +
> +		for (i =3D start_region, j =3D 0; i < mds->nr_dc_region; i++, j++) {
> +			rc =3D cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> +			if (rc) {
> +				dev_dbg(dev, "Failed to save region info: %d\n", rc);
> +				return rc;
> +			}
> +		}
> +
> +		start_region =3D mds->nr_dc_region;
> +
> +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> +
> +	mds->dynamic_cap =3D
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);



> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79a67cff9143..4624cf612c1e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver d=
ata
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
>   * @next_persistent_bytes: persistent capacity change pending device res=
et

Looks like we have some ordering issues ram_perf and pmem_perf (at least)
that we should fix up as a precursor. I sent a reply to the QoS patch
that added these.

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
Trivial but this is an unrelated change and shouldn't be in this patch.

>  	u64 total_bytes;
> +	u64 static_cap;
> +	u64 dynamic_cap;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -506,6 +528,9 @@ struct cxl_memdev_state {
>  	struct cxl_dpa_perf ram_perf;
>  	struct cxl_dpa_perf pmem_perf;
> =20
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;

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

Can we make that 8 self documenting?
offsetof(struct cxl_dc_region_config, region) perhaps?

> +


