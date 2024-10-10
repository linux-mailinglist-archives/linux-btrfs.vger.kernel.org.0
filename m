Return-Path: <linux-btrfs+bounces-8785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3599874D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD6C1C234A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC01C9B9D;
	Thu, 10 Oct 2024 13:14:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322441C6F76;
	Thu, 10 Oct 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566054; cv=none; b=h+K7AzDUvGhpWB7cUYtP3KmSGJ6Z5QnAN8Ji0yeawfqc7AWYG1jQgm9ToIo3WCJnV54H/PpgjQqTcxXvh4HPxULlw3Hd1pUq+qEHf2PiPX1P3JaWT27wdVr8srcirKes5BSRc79wN/F4kILFqYgiYqDcWkc4vToc8lC+uEz6n5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566054; c=relaxed/simple;
	bh=LaBI2ILpuauw7TkFsMIt96tmTH7xhPjg0He+nUpof5c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMiRJ/wjsAcRU8prPzIT/JumlymZ17orGAjCwVu7huq4/AvbtNZhNscxhxz6XcPxsd7MW9dVdvHOGVBNWpOjNm85y6YSmWGoDXst7mTQEq9JBxiqjmLsEnh7rv8/uZPds44Hf4XaWR1okpPOtWXC1zG/Vz/hw+DBWhrKoxMFouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPVZP2v7Qz6HJwb;
	Thu, 10 Oct 2024 21:13:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 12FFB140AE5;
	Thu, 10 Oct 2024 21:14:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 15:14:09 +0200
Date: Thu, 10 Oct 2024 14:14:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/28] cxl/port: Add endpoint decoder DC mode support
 to sysfs
Message-ID: <20241010141408.000022d8@Huawei.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-14-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<20241007-dcd-type2-upstream-v4-14-c261ee6eeded@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 07 Oct 2024 18:16:20 -0500
ira.weiny@intel.com wrote:

> From: Navneet Singh <navneet.singh@intel.com>
> 
> Endpoint decoder mode is used to represent the partition the decoder
> points to such as ram or pmem.
> 
> Expand the mode to allow a decoder to point to a specific DC partition
> (Region).
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

A few comments inline about ways that can make this a little tidier
and less fragile.


Jonathan

> 
> ---
> Changes:
> [iweiny: prevent creation of region on shareable DC partitions]
> [Fan: change mode range logic]
> [Fan: use !resource_size()]
> [djiang: use the static mode name string array in mode_store()]
> [Jonathan: remove rc check from mode to region index]
> [Jonathan: clarify decoder mode 'mixed']
> [djbw: drop cleanup patch and just follow the convention in cxl_dpa_set_mode()]
> [fan: make dcd resource size check similar to other partitions]
> [djbw, jonathan, fan: remove mode range check from dc_mode_to_region_index]
> [iweiny: push sysfs versions to 6.12]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 21 ++++++++++----------
>  drivers/cxl/core/hdm.c                  | 17 ++++++++++++++++
>  drivers/cxl/core/port.c                 | 10 +++++-----
>  drivers/cxl/cxl.h                       | 35 ++++++++++++++++++---------------
>  4 files changed, 52 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b865eefdb74c..661dab99183f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -361,23 +361,24 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, October 2024
> +KernelVersion:	v6.0, v6.12 (dcY)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory) range, or Dynamic Capacity (DC) range.
		memory) range, and Dynamic Capacity (DC) ranges.

(doesn't work with preceding text otherwise)

> The 'mode'
> +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> +		'none'. The 'mixed' indication is for error cases when a
> +		decoder straddles partition boundaries, and 'none' indicates
> +		the decoder is not actively decoding, or no DPA allocation
> +		policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> +		the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8c7f941eaba1..b368babb55d9 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -551,6 +551,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -578,6 +579,22 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		goto out;
>  	}
>  
> +	if (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7) {
> +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +		rc = dc_mode_to_region_index(mode);
> +		if (!resource_size(&cxlds->dc_res[rc])) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			rc = -ENXIO;
> +			goto out;
Probably worth adding a precursor patch that uses guard(rwsem_write) on
the cxl_dpa_rwsem
Allows for early returns simplifying existing code and this.


> +		}
> +		if (mds->dc_region[rc].shareable) {
> +			dev_err(dev, "DC region %d is shareable\n", rc);
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode = mode;
>  	rc = 0;
>  out:
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 85b912c11f04..23b4f266a83a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -205,11 +205,11 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  	enum cxl_decoder_mode mode;
>  	ssize_t rc;
>  
> -	if (sysfs_streq(buf, "pmem"))
> -		mode = CXL_DECODER_PMEM;
> -	else if (sysfs_streq(buf, "ram"))
> -		mode = CXL_DECODER_RAM;
> -	else
> +	for (mode = CXL_DECODER_RAM; mode < CXL_DECODER_MIXED; mode++)
> +		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
> +			break;
> +
Loop over them all then do what you have here but explicit matches
to reject the ones that can't be set.
Add a MODE_COUNT to the end of the options.

	for (mode = 0; mode < CXL_DECODER_MODE_COUNT; mode++)
		if (sysfs_streq(buf, cxl_decoder_mode_names[mode]))
			break;

	if (mode == CXL_DECODER_MODE_COUNT)
		return -EINVAL;

	if (mode == CXL_DECODER_NONE)
		return -EINVAL;

	/* Not yet supported */
	if (mode == CXL_DECODER_MIXED)
		return -EINVAL;
...

> +	if (mode >= CXL_DECODER_MIXED)
>  		return -EINVAL;
>  
>  	rc = cxl_dpa_set_mode(cxled, mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8b7099c38a40..cbaacbe0f36d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -365,6 +365,9 @@ struct cxl_decoder {
>  /*
>   * CXL_DECODER_DEAD prevents endpoints from being reattached to regions
>   * while cxld_unregister() is running
> + *
> + * NOTE: CXL_DECODER_RAM must be second and CXL_DECODER_MIXED must be last.
This is a bit ugly. I'd change the logic a bit to avoid it.
The list of things we don't support is short so just check for them.
See above.

> + *	 See mode_store()
>   */
>  enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
> @@ -382,25 +385,25 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_DEAD,
>  };
>  
> +static const char * const cxl_decoder_mode_names[] = {
> +	[CXL_DECODER_NONE] = "none",
> +	[CXL_DECODER_RAM] = "ram",
> +	[CXL_DECODER_PMEM] = "pmem",
> +	[CXL_DECODER_DC0] = "dc0",
> +	[CXL_DECODER_DC1] = "dc1",
> +	[CXL_DECODER_DC2] = "dc2",
> +	[CXL_DECODER_DC3] = "dc3",
> +	[CXL_DECODER_DC4] = "dc4",
> +	[CXL_DECODER_DC5] = "dc5",
> +	[CXL_DECODER_DC6] = "dc6",
> +	[CXL_DECODER_DC7] = "dc7",
> +	[CXL_DECODER_MIXED] = "mixed",
> +};
> +
>  static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  {
> -	static const char * const names[] = {
> -		[CXL_DECODER_NONE] = "none",
> -		[CXL_DECODER_RAM] = "ram",
> -		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_DC0] = "dc0",
> -		[CXL_DECODER_DC1] = "dc1",
> -		[CXL_DECODER_DC2] = "dc2",
> -		[CXL_DECODER_DC3] = "dc3",
> -		[CXL_DECODER_DC4] = "dc4",
> -		[CXL_DECODER_DC5] = "dc5",
> -		[CXL_DECODER_DC6] = "dc6",
> -		[CXL_DECODER_DC7] = "dc7",
> -		[CXL_DECODER_MIXED] = "mixed",
> -	};
> -
>  	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> -		return names[mode];
> +		return cxl_decoder_mode_names[mode];
>  	return "mixed";
>  }
>  
> 


